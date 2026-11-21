draw_set_font(global.font_outline);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_black);
draw_set_alpha(0.7);
draw_rectangle(0, 0, room_width, room_height, false);
draw_set_color(c_yellow);
draw_set_alpha(1);
draw_text_transformed(room_width / 2, room_height / 2 - 64, global.touch_mode ? "SELECT A SAVE" : "USE ARROWS TO SELECT SAVE", 4, 4, 0);
draw_set_color(c_white);

if (current < ds_list_size(global.save_files) && current >= 0) {
    draw_text_transformed(room_width / 2, room_height / 2, save_name_display(ds_list_find_value(global.save_files, current)), 4, 4, 0);
}




