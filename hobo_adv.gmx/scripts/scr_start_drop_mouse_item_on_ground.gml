#define scr_start_drop_mouse_item_on_ground
///scr_drop_mouse_item_on_ground()

//delete all other destinations
with (obj_player_destination) instance_destroy();
    
//create new destination
dest=instance_create(mouse_x,mouse_y,obj_player_destination)
dest.arrival_action=true;
dest.arrival_action_script=scr_finish_drop_mouse_item_on_ground;

#define scr_finish_drop_mouse_item_on_ground
///scr_finish_drop_mouse_item_on_ground()


//drop item on ground
itm=instance_create(x,y,global.items[global.mouse_item,6]);
itm.qty=global.mouse_item_qty;


//clear mouse item
global.item_on_mouse = false;
global.mouse_item = -1;
global.mouse_item_qty = 0;
