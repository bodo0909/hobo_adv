///scr_eat_food(number_of_meals)

var meals_till_full = 5;

global.player_energy = clamp(global.player_energy + argument0/meals_till_full*100, 0,100);
