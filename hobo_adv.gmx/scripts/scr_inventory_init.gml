//init inventory array
global.inventory = ds_grid_create(global.max_inventory,2); 
for (var i=0; i<global.max_inventory; i+=1) {
    global.inventory[i,0] = -1;
    global.inventory[i,1] = 0;
}

//init item database
scr_inventory_item_db_init()

