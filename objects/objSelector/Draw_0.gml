// Selected part preview in a box, bottom right (as in version 2).
var box_size = 128;
var box_x1 = room_width - 18 - box_size;
var box_y1 = 544;
var box_x2 = box_x1 + box_size;
var box_y2 = box_y1 + box_size;

draw_set_alpha(0.4);
draw_set_color(c_gray);
draw_rectangle(box_x1, box_y1, box_x2, box_y2, false);
draw_set_alpha(0.8);
draw_set_color(c_ltgray);
draw_rectangle(box_x1, box_y1, box_x2, box_y2, true);
draw_set_alpha(1);

// Centre the sprite's full image in the box, respecting its origin
var spr = sprite_index;
var draw_x = (box_x1 + box_x2) / 2 - sprite_get_width(spr) / 2 + sprite_get_xoffset(spr);
var draw_y = (box_y1 + box_y2) / 2 - sprite_get_height(spr) / 2 + sprite_get_yoffset(spr);
draw_sprite(spr, -1, draw_x, draw_y);
