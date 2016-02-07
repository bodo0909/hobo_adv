///scr_move_to_dest_w_notification(instance_to_notify)

//delete all other destinations
with (obj_player_destination) instance_destroy();
    
//create new destination
dest=instance_create(mouse_x,mouse_y,obj_player_destination)
dest.notification=true;
dest.instance_to_notify=argument0;
