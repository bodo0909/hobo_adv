slot=argument0;

//if slot is empty
if (global.inventory[slot,0] == -1) {
    //put item in inventory
    global.inventory[slot,0] = global.mouse_item;
    global.inventory[slot,1] = global.mouse_item_qty;
    //and remove from mouse
    global.item_on_mouse = false;
    global.mouse_item = -1;
    global.mouse_item_qty = 0;

//if slot has similar items 
} else if (global.inventory[slot,0] == global.mouse_item) {
    //and if item is stackable
    if (global.items[global.mouse_item,2]) {
        //add as much as you can to stack
        if (global.inventory[slot,1] + global.mouse_item_qty <= global.items[global.mouse_item,3]) {
            global.inventory[slot,1] += global.mouse_item_qty;
            global.item_on_mouse = false;
            global.mouse_item = -1;
            global.mouse_item_qty = 0;
        } else {
            global.mouse_item_qty = global.mouse_item_qty + global.inventory[slot,1] - global.items[global.mouse_item,3];
            global.inventory[slot,1] = global.items[global.mouse_item,3];
        }   
    }  

//if the slot is different
} else {
    //swap the items
    var tmp1 = global.mouse_item;
    var tmp2 = global.mouse_item_qty;
    global.mouse_item = global.inventory[slot,0];
    global.mouse_item_qty = global.inventory[slot,1];
    global.inventory[slot,0] = tmp1;
    global.inventory[slot,1] = tmp2;
}
