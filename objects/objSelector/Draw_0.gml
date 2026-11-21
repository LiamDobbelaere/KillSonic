var spr = sprite_index;
var ox = sprite_get_xoffset(spr);
var oy = sprite_get_yoffset(spr);
var w = sprite_get_width(spr);
var h = sprite_get_height(spr);

draw_sprite(sprite_index, -1, x, y);

/*
draw_set_color(c_black);
draw_set_alpha(0.7);
draw_rectangle_color(x - sprite_get_xoffset(spr),  
y - sprite_get_yoffset(spr),  
x + sprite_get_width(spr) - sprite_get_xoffset(spr),
y + sprite_get_height(spr) - sprite_get_yoffset(spr),
c_black, c_gray, c_black, c_gray, false);

draw_self();

draw_set_color(c_gray);
draw_set_alpha(0.7);
draw_rectangle(x - sprite_get_xoffset(spr),  
y - sprite_get_yoffset(spr),  
x + sprite_get_width(spr) - sprite_get_xoffset(spr),
y + sprite_get_height(spr) - sprite_get_yoffset(spr),
true);

draw_set_color(c_black);
draw_set_alpha(1);
*/
//draw_sprite(spr, 0, x, y);

/* */
/*  */
