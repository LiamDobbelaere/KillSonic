draw_set_font(global.font_outline);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_black);
draw_set_alpha(0.7);
draw_rectangle(0, 0, room_width, room_height, false);
draw_set_color(c_yellow);
draw_set_alpha(1);
draw_text_transformed(room_width / 2, room_height / 2 - 64, string_hash_to_newline("Name your creation"), 4, 4, 0);
draw_set_color(c_white);
draw_text_transformed(room_width / 2, room_height / 2, string_hash_to_newline(keyboard_string), 4, 4, 0);



