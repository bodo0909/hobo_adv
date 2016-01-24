slot = argument0
//if slot is not empty
if (global.inventory[slot,0] !=-1) {
    //give item to mouse
    global.item_on_mouse = true;
    global.mouse_item = global.inventory[slot,0];
    global.mouse_item_qty = global.inventory[slot,1];
    //and remove from inventory
    global.inventory[slot,0] = -1;
    global.inventory[slot,1] = 0;
}
