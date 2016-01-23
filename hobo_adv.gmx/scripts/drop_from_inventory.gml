var slot=argument0

if (slot <=global.max_inventory) {
    var A = global.inventory[slot,0];
    var count = global.inventory[slot,1];
    global.inventory[slot,0] = -1;
    global.inventory[slot,1] = 0;
}
