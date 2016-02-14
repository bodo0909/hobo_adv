///subtract_one_from_inv(slot)

var s=argument0;

global.inventory[s,1] -= 1;
if global.inventory[s,1] <=0 {
    global.inventory[s,0] = -1;
}
