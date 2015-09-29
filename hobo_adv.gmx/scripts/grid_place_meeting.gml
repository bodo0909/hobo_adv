// grid_place_meeting(x, y)

var xx = argument[0];
var yy = argument[1];

// Remember our position

var xp = x;
var yp = y;

// Update the position for the bbox calculations

x = xx;
y = yy;
 
// Check for x meeting

var x_meeting = (obj_level1.grid[# bbox_right div CELL_WIDTH, bbox_top div CELL_HEIGHT] != FLOOR) || 
                (obj_level1.grid[# bbox_left div CELL_WIDTH, bbox_top div CELL_HEIGHT] != FLOOR);

// Check for y meeting
                
var y_meeting = (obj_level1.grid[# bbox_right div CELL_WIDTH, bbox_bottom div CELL_HEIGHT] != FLOOR) ||
                (obj_level1.grid[# bbox_left div CELL_WIDTH, bbox_bottom div CELL_HEIGHT] != FLOOR);

var center_meeting = obj_level1.grid[# xx div CELL_WIDTH, yy div CELL_HEIGHT] != FLOOR;
                
// Move back

x = xp;
y = yp;

// Return either true or false

return x_meeting || y_meeting || center_meeting;
                  
