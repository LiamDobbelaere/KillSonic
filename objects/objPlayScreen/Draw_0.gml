var hover = point_in_rectangle(mouse_x, mouse_y, btn_x - btn_w / 2, btn_y - btn_h / 2, btn_x + btn_w / 2, btn_y + btn_h / 2);

draw_set_alpha(1);
draw_set_color(c_black);
draw_rectangle(0, 0, room_width, room_height, false);

draw_set_font(global.font_outline);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_set_color(c_yellow);
draw_text_transformed(room_width / 2, btn_y - 160, "Kill Sonic - Eggman boss builder", 3, 3, 0);

draw_set_color(hover ? make_color_rgb(64, 96, 224) : make_color_rgb(32, 64, 192));
draw_rectangle(btn_x - btn_w / 2, btn_y - btn_h / 2, btn_x + btn_w / 2, btn_y + btn_h / 2, false);
draw_set_color(c_white);
draw_rectangle(btn_x - btn_w / 2, btn_y - btn_h / 2, btn_x + btn_w / 2, btn_y + btn_h / 2, true);
draw_text_transformed(btn_x, btn_y, "PLAY", 4, 4, 0);
