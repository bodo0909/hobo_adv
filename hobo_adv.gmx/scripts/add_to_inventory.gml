var A=argument0;
var num2add = argument1;

//if stackable check for open stack
if (global.items[A,2]) {
    for (var i=0; i<global.max_inventory; i+=1) {
        //does the current slot have the same items?
        if (global.inventory[i,0] == A && global.inventory[i,1] < global.items[A,3]) {
            //fit as many as you can in that slot
            if (num2add <= global.items[A,3] - global.inventory[i,1]) {
                global.inventory[i,1] += num2add;
                num2add = 0;
                break;
            } else {
                num2add -= global.items[A,3] - global.inventory[i,1]; 
                global.inventory[i,1] = global.items[A,3];
            }
        }
    }
}

// look for open slot(s)
if (num2add>0) {
    for (var i=0; i<global.max_inventory; i+=1) {
        if (global.inventory[i,0] == -1) {
            //if stackable
            if (global.items[A,2]) { 
                //fit as many as you can in that slot
                if (num2add <= global.items[A,3]) {
                    global.inventory[i,0] = A;
                    global.inventory[i,1] = num2add;
                    num2add = 0;
                    break;
                } else {
                    global.inventory[i,0] = A;
                    num2add -= global.items[A,3]; 
                    global.inventory[i,1] = global.items[A,3];
                }
            //if not stackable
            } else if (num2add == 1){
                global.inventory[i,0] = A;
                global.inventory[i,1] = 1;
                num2add -= 1;
                break;
            } else {
                global.inventory[i,0] = A;
                global.inventory[i,1] = 1;
                num2add -= 1;
            }
        }
    }
}
