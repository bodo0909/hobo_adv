///scr_time_increment()

//--tuning variables--
var frame_rate = 30;   //used to scale steps to seconds

var resting_energy_efficiency = 1.0;
var max_resting_time = 1000; //the number of resting seconds supported by mayimum enery

var sobering_efficiency = 1.0;
var max_buzz_time = 600; //the number of seconds player stays buzzed from maximum booze

var mood_sensitivity = 1.0;
var max_mood_time = 600; //number of seconds at max mood rate to achieve 100pts
var max_withdrawl_time = 2000;  //number of seconds to subtract 100 mood pts when maximally addicted

var addiction_kicking_efficiency = 1.0;
var addiction_resilience = 100000; //seconds required to heal full addiction;


//--decrease energy--
//this is for resting energy usage
energy_inc = -100/resting_energy_efficiency/max_resting_time/frame_rate;
global.player_energy = clamp(global.player_energy+energy_inc,0,100)


//--decrease buzz--
buzz_inc = -100*sobering_efficiency/max_buzz_time/frame_rate;
global.player_buzz = clamp(global.player_buzz+buzz_inc,0,100);


//--adjust mood--
var mood_curve;
if (global.player_buzz<global.player_addiction) {
    mood_curve = (global.player_buzz - global.player_addiction)/max_withdrawl_time
} else {
    mood_curve = (global.player_buzz - global.player_addiction)/max_mood_time
}
mood_inc = mood_sensitivity*mood_curve/frame_rate;
global.player_mood = clamp(global.player_mood+mood_inc,0,100);


//--decrease addiction--
addiction_inc = addiction_kicking_efficiency*100/addiction_resilience/frame_rate;
global.player_addiction = clamp(global.player_addiction-addiction_inc,0,100);






