// fill_recursively(b, xx, yy, mt, fill_val)
var b = argument[0];
var xx = argument[1];
var yy = argument[2];
var mt = argument[3];
var fill_val = argument[4];

ds_grid_set(b,xx,yy,fill_val);

var l=false;
var r=false;
var u=false;
var d=false;

if (b[# xx-1, yy]==mt) {
    l=true;
    ds_grid_set(b,xx-1,yy,fill_val);
    fill_size++;
}
if (b[# xx+1, yy]==mt) {
    r=true;
    ds_grid_set(b,xx+1,yy,fill_val);
    fill_size++;
}
if (b[# xx, yy-1]==mt) {
    u=true;
    ds_grid_set(b,xx,yy-1,fill_val);
    fill_size++;
}
if (b[# xx, yy+1]==mt) {
    d=true;
    ds_grid_set(b,xx,yy+1,fill_val);
    fill_size++;
}

if (l) fill_recursively(b,xx-1,yy,mt,fill_val)
if (r) fill_recursively(b,xx+1,yy,mt,fill_val)
if (u) fill_recursively(b,xx,yy-1,mt,fill_val)
if (d) fill_recursively(b,xx,yy+1,mt,fill_val)
