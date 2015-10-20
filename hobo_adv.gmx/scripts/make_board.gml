//make_board()

randomize();

//--------------------------
//  Adjustable Parameters
//--------------------------

var road_size=3;
var block_size=9;

var size_test_board_x=25;//41;
var size_test_board_y=25;//41;

var road_density_factor=0.57;

var block_group_s=4;
var block_group_m=14;
var block_group_l=46;

var alley_fill_factor=1.5;
var park_fill_factor=5;

//--------------------
//  CREATE THE ROOM
//--------------------

// create test board
test_board=ds_grid_create(size_test_board_x,size_test_board_y);

//loop until we generate a good map
var good_map=false;
while (!good_map) {

    //the board starts with 1 (impassable) as boarder and 0 (to be filled) in the center
    ds_grid_clear(test_board,BOUNDARY);
    ds_grid_set_region(test_board,1,1,size_test_board_x-2, size_test_board_y-2,EMPTY);
    
    //create road map with random walk
    var num_steps=size_test_board_x*size_test_board_y*road_density_factor;
    do_random_walk(test_board, size_test_board_x, size_test_board_y, 1, 1, 1, 2, num_steps, ROAD, EMPTY);
    
    //do zoning
    var small_alleys=0;
    var small_parks=0;
    var big_alleys=0;
    var big_parks=0;
    // loop over all blocks
    for (var xx=2; xx<size_test_board_x-2; xx+=2) {
        for (var yy=2; yy<size_test_board_y-2; yy+=2) {
            // if the block is empty
            if (test_board[# xx,yy]==EMPTY) {
            
                //see how big the block group is
                fill_size=1;
                fill_recursively(test_board,xx,yy,EMPTY,VOID);
                var num_blocks = fill_size;
                
                //decide which type it should be depending on size
                var zone_type;
                if (num_blocks<=block_group_s) {
                    zone_type=BUILDING_ZONE;
                } else if (num_blocks<block_group_m) {
                    if (random(1)<0.25) {
                        zone_type=BUILDING_ZONE;
                    } else {
                        zone_type=ALLEY_ZONE;
                        small_alleys++;
                    }
                } else if (num_blocks<block_group_l) {
                    if (random(1)<0.7) {
                        zone_type=ALLEY_ZONE;
                        big_alleys++;
                    } else {
                        zone_type=PARK_ZONE;
                        small_parks++;
                    }
                } else { 
                    zone_type=PARK_ZONE;
                    big_parks++;
                }
                fill_recursively(test_board,xx,yy,VOID,zone_type);
            }
        }
    }
    
    //check for a well rounded board
    if (small_alleys>0 && small_parks>0 && big_alleys>0 && big_parks>0 ) {
        good_map=true;
    }

}

//now that we have a good map, scale it to real size
//create board
size_board_x=((size_test_board_x-2) div 2)*(block_size+road_size)+ ((size_test_board_x-2) mod 2)*road_size+2;
size_board_y=((size_test_board_y-2) div 2)*(block_size+road_size)+ ((size_test_board_y-2) mod 2)*road_size+2;
board=ds_grid_create(size_board_x,size_board_y);
ds_grid_clear(board,BOUNDARY);
ds_grid_set_region(board,1,1,size_board_x-2, size_board_y-2,EMPTY);
//scale it
for (var i=1; i<size_test_board_x-1; i++) {
    for (var j=1; j<size_test_board_y-1; j++) {
        var lx=1+((i-1) div 2)*(road_size+block_size); 
        var ly=1+((j-1) div 2)*(road_size+block_size); 
        var sx, sy, lx, ly;
        if ( (i mod 2) !=0 ) {
            sx=road_size;
        } else {
            sx=block_size;
            lx=lx+road_size;
        }
        if ( (j mod 2) !=0 ) {
            sy=road_size;
        } else {
            sy=block_size;
            ly=ly+road_size;
        }
        ds_grid_set_region(board,lx,ly,lx+sx-1,ly+sy-1,test_board[# i,j]);
    }
}

//finally, lets make some alleyways and walkable park areas
for (var i=road_size+((block_size+1) div 2); i<size_board_x; i+=block_size+road_size) {
    for (var j=road_size+((block_size+1) div 2); j<size_board_y; j+=block_size+road_size) {
        switch (board[# i,j]) {
            case ALLEY_ZONE:
                do_random_walk(board,size_board_x,size_board_y,i,j, 1,(block_size-1) div 2, block_size*alley_fill_factor,ALLEY_WALK,ALLEY_ZONE);
                break;
            case PARK_ZONE:
                do_random_walk(board,size_board_x,size_board_y,i,j,1,1, block_size*block_size*park_fill_factor,PARK_WALK,PARK_ZONE);
                break;
        }
    }
}







//--------------------
//  DISPLAY THE ROOM
//--------------------

// make room the correct size
room_width = CELL_WIDTH *size_board_x;
room_height = CELL_HEIGHT * size_board_y;

// Draw basic floors using the grid
for (var yy = 0; yy < size_board_y; yy++)
{
    for (var xx = 0; xx < size_board_x; xx++)
    {       
        switch(board[# xx, yy]) {
            case EMPTY:
                tile_add(bg_empty, 0, 0, CELL_WIDTH, CELL_HEIGHT, xx*CELL_WIDTH, yy*CELL_HEIGHT, 0);
                break;
            case BOUNDARY:
                tile_add(bg_boundary, 0, 0, CELL_WIDTH, CELL_HEIGHT, xx*CELL_WIDTH, yy*CELL_HEIGHT, 0);
                instance_create(xx*CELL_WIDTH, yy*CELL_HEIGHT, obj_solid_bg);
                break;
            //case ROAD:
            //    tile_add(bg_road, 0, 0, CELL_WIDTH, CELL_HEIGHT, xx*CELL_WIDTH, yy*CELL_HEIGHT, 0);
            //    break;
            case BUILDING_ZONE:
                tile_add(bg_building_zone, 0, 0, CELL_WIDTH, CELL_HEIGHT, xx*CELL_WIDTH, yy*CELL_HEIGHT, 0);
                instance_create(xx*CELL_WIDTH, yy*CELL_HEIGHT, obj_solid_bg);
                break;
            case ALLEY_ZONE:
                tile_add(bg_alley_zone, 0, 0, CELL_WIDTH, CELL_HEIGHT, xx*CELL_WIDTH, yy*CELL_HEIGHT, 0);
                instance_create(xx*CELL_WIDTH, yy*CELL_HEIGHT, obj_solid_bg);
                break;
            case PARK_ZONE:
                tile_add(bg_park_zone, 0, 0, CELL_WIDTH, CELL_HEIGHT, xx*CELL_WIDTH, yy*CELL_HEIGHT, 0);
                instance_create(xx*CELL_WIDTH, yy*CELL_HEIGHT, obj_solid_bg);
                break;
            case ALLEY_WALK:
                tile_add(bg_alley_walk, 0, 0, CELL_WIDTH, CELL_HEIGHT, xx*CELL_WIDTH, yy*CELL_HEIGHT, 0);
                break;
            case PARK_WALK:
                tile_add(bg_park_walk, 0, 0, CELL_WIDTH, CELL_HEIGHT, xx*CELL_WIDTH, yy*CELL_HEIGHT, 0);
                break;
        }
 
    }
}


// Get tile size
var tw = CELL_WIDTH/2;
var th = CELL_HEIGHT/2;
// Add the tiles
for (var yy = 0; yy < size_board_y*2; yy++)
{
    for (var xx = 0; xx < size_board_x*2; xx++)
    {
        if (board[# xx div 2, yy div 2] == ROAD)
        {
            
            
            // Get the tile x and y position
            var tx = xx*tw;
            var ty = yy*th;
            
            // Checks
            var center = board[# xx div 2, yy div 2];
            var right = board[# (xx+1) div 2, yy div 2];
            var left = board[# (xx-1) div 2, yy div 2];
            var top = board[# xx div 2, (yy-1) div 2];
            var bottom = board[# xx div 2, (yy+1) div 2];
            
            var top_right = board[# (xx+1) div 2, (yy-1) div 2];
            var top_left = board[# (xx-1) div 2, (yy-1) div 2];
            var bottom_right = board[# (xx+1) div 2, (yy+1) div 2]; 
            var bottom_left = board[# (xx-1) div 2, (yy+1) div 2];
            
            if (center == ROAD) {
                if (right==BUILDING_ZONE) {
                    if (bottom==BUILDING_ZONE) {
                        tile_add(bg_road_tile, tw*2, th*0, tw, th, tx, ty, 0);
                    } else if (top==BUILDING_ZONE) {
                        tile_add(bg_road_tile, tw*2, th*1, tw, th, tx, ty, 0);
                    } else {
                        tile_add(bg_road_tile, tw*4, th*0, tw, th, tx, ty, 0);
                    }
                }
                
                if (left==BUILDING_ZONE) {
                    if (bottom==BUILDING_ZONE) {
                        tile_add(bg_road_tile, tw*3, th*0, tw, th, tx, ty, 0);
                    } else if (top==BUILDING_ZONE) {
                        tile_add(bg_road_tile, tw*3, th*1, tw, th, tx, ty, 0);
                    } else {
                        tile_add(bg_road_tile, tw*5, th*1, tw, th, tx, ty, 0);
                    }
                }

                if (left!=BUILDING_ZONE && right!=BUILDING_ZONE) {                
                    if (top==BUILDING_ZONE) {
                        tile_add(bg_road_tile, tw*4, th*1, tw, th, tx, ty, 0);
                    } else if (bottom==BUILDING_ZONE) {
                        tile_add(bg_road_tile, tw*5, th*0, tw, th, tx, ty, 0);
                    } else {
                        if (bottom_left==BUILDING_ZONE) {
                            tile_add(bg_road_tile, tw*1, th*0, tw, th, tx, ty, 0);
                        } else if (bottom_right==BUILDING_ZONE) {
                            tile_add(bg_road_tile, tw*0, th*0, tw, th, tx, ty, 0);
                        } else if (top_left==BUILDING_ZONE) {
                            tile_add(bg_road_tile, tw*1, th*1, tw, th, tx, ty, 0);
                        } else if (top_right==BUILDING_ZONE) {
                            tile_add(bg_road_tile, tw*0, th*1, tw, th, tx, ty, 0);
                        } else 
                        tile_add(bg_road_tile, tw*6, th*0, tw, th, tx, ty, 0);
                    }
                }
            }
        }
    }
}

