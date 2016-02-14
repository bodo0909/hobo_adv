///scr_drink_alcohol(number_of_drinks)

var initial_tolerance = 3;
var maximum_tolerance = 20;
var addiction_robustness = 20; //(# drinks to addiction)

//loop over drinks
for (var i=0; i<argument0; i=i+1) {

    //--increases buzz--
    //linear scaling of tolerance based on addiction
    var buzz_value = 100/initial_tolerance - global.player_addiction*(1/initial_tolerance - 1/maximum_tolerance);
    global.player_buzz = clamp(global.player_buzz + buzz_value,0,100);
    
    //--increases mood--
    // maybe??
    
    //--increases addiction--
    //constant increase in addiction based on # drinks
    var addiction_value = 100/addiction_robustness;
    global.player_addiction = clamp(global.player_addiction + addiction_value,0,100);
}
