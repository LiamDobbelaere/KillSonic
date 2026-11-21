draw_set_font(global.font_outline);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_text_transformed(8, 8, 
string_hash_to_newline(@"EDITOR CONTROLS
Change part - Left/Right arrow keys
Show attachment points - Hold Left CONTROL
Select attachment point - Left click the attachment point
Attach part - Right click selected attachment point
Change att. point angle - Scroll over selected attachment point
Preview motors - Hold SPACE
Move Eggman - W/A/S/D
"), 1, 1, 0);

if (ds_list_size(global.save_files) > 0) {
	draw_text(room_width / 2, room_height / 2, string_hash_to_newline(ds_list_find_value(global.save_files, 0)));
}

