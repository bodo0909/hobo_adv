///scr_walk_using_energy()

var frame_rate = 30;    //frame rate
var max_player_speed = 400;  //px per second speed
var min_player_speed = 200;   //px per second

var walking_efficiency = 1.0; //higher efficiency means longer walking distances
var max_walking_dist = 100000; //distance that can be moved on full energy


//quadatic interp between max and min
var xx = (100-global.player_energy)*(100-global.player_energy)*0.0001;

var move_dist = (min_player_speed*xx + max_player_speed*(1-xx))/frame_rate;


var e_inc = -1.0/walking_efficiency*move_dist/max_walking_dist*100;
global.player_energy = clamp(global.player_energy+e_inc,0,100);


return move_dist
