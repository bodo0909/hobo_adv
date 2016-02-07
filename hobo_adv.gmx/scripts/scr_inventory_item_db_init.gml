/*---------------*\
|--Item Database--|
\*---------------*/
global.items = ds_grid_create(2,6); 

//Test Item One//
global.items[0,0] = "Booze"                       //Name
global.items[0,1] = "King cobra 40"               //Desc
global.items[0,2] = true                          //Stackable
global.items[0,3] = 6                             //max stack size
global.items[0,4] = spr_beer_inv                  //sprite
global.items[0,5] = scr_start_drop_mouse_item_on_ground //script on empty space click
global.items[0,6] = obj_beer_drop                 //Dropped object
 
//Test Item Two//
global.items[1,0] = "Pocket Taco"                      //Name
global.items[1,1] = "Tex-mex in a convenient location" //Desc
global.items[1,2] = true                               //Stackable
global.items[1,3] = 3                                  //max stack size
global.items[1,4] = spr_taco_inv                       //sprite
global.items[1,5] = scr_start_drop_mouse_item_on_ground      //script on empty space click
global.items[1,6] = obj_taco_drop                   //dropped object

