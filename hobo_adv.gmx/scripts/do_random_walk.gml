//do_random_walk(b, size_x, size_y, loc_x, loc_y, stamp_size, run_dist, num_steps, stamp_val, write_over_val)
var b = argument[0];
var size_x = argument[1];
var size_y = argument[2];
var loc_x = argument[3];
var loc_y = argument[4];
var stamp_size = argument[5];
var run_dist = argument[6];
var num_steps = argument[7];
var stamp_val = argument[8];
var write_over_val = argument[9];

//declare some local vars
var dx, dy, tmp_x, tmp_y;
var do_movement;

// pick a random starting direction
var move_dir=irandom(3);

//do a certain mumber of random steps
for (var i = 0; i < num_steps; i++) {

    //randomly change direction
    if ( random(1)<0.6 ) { 
        move_dir=irandom(3);
    }
    switch (move_dir) {
        case 0: //up
            dx=0;
            dy=-1;
            break;
        case 1: // right
            dx=1;
            dy=0;
            break;
        case 2: // down
            dx=0;
            dy=1;
            break;
        case 3: //left
            dx=-1;
            dy=0;
            break;
    }
    
    //check to see if movement is valid
    do_movement=true;
    tmp_x=loc_x;
    tmp_y=loc_y;
    for (var j=0; j<run_dist; j++) {
        tmp_x=tmp_x+stamp_size*dx;
        tmp_y=tmp_y+stamp_size*dy;
        //check to see if move goes outside grid
        if  ( tmp_x<0 || tmp_x>size_x-stamp_size || tmp_y<0 || tmp_y>size_y-stamp_size ) {
            do_movement=false;
        } else {
            //check to see if the whole move overlaps only allowed values
            for ( var xx=tmp_x; xx<tmp_x+stamp_size; xx++) {
                for ( var yy=tmp_y; yy<tmp_y+stamp_size; yy++) {
                    if (b[# xx, yy]!=write_over_val && b[# xx, yy]!=stamp_val ) {
                        do_movement=false;
                    }
                }
            }
        }
    }
    
    // if it is valid then make the move
    if (do_movement) {
        for (var j=0; j<run_dist; j++) {
            loc_x=loc_x+stamp_size*dx;
            loc_y=loc_y+stamp_size*dy;
            loc_x=clamp(loc_x,0,size_x-1);
            loc_y=clamp(loc_y,0,size_y-1);
            for ( var xx=loc_x; xx<loc_x+stamp_size; xx++) {
                for ( var yy=loc_y; yy<loc_y+stamp_size; yy++) {
                    ds_grid_set(b,xx,yy,stamp_val);
                }
            }
        }
    }    
}


