///scr_outline_when_hovered()

var border_width = 2

//highlight border on a sprite when mouse hovers over
//comment out the two d3d_fog lines to make black outline instead of white
if position_meeting(mouse_x,mouse_y,self) {
    d3d_set_fog(true,c_white,0,0);
    draw_sprite_ext(sprite_index,image_index,x-border_width,y,
                    image_xscale,image_yscale,image_angle,c_black,image_alpha)
    draw_sprite_ext(sprite_index,image_index,x+border_width,y,image_xscale,
                    image_yscale,image_angle,c_white,image_alpha)
    draw_sprite_ext(sprite_index,image_index,x,y-border_width,image_xscale,
                    image_yscale,image_angle,c_white,image_alpha)
    draw_sprite_ext(sprite_index,image_index,x,y+border_width,image_xscale,
                    image_yscale,image_angle,c_white,image_alpha)
    draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,
                    image_yscale,image_angle,image_blend,image_alpha)
    d3d_set_fog(false,c_black,0,0);
}
