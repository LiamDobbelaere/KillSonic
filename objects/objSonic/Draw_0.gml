draw_self();

draw_set_alpha(1);
draw_set_font(global.font_outline);
draw_set_halign(fa_left);
draw_set_color(c_aqua);
draw_text_transformed(8, 8, string_hash_to_newline("SONICS EGG-NAV 2"), 4, 4, 0);
draw_set_color(c_lime);
draw_text_transformed(8, 64, string_hash_to_newline(eggnav_state_running), 4, 4, 0);
draw_set_color(c_yellow);
draw_text_transformed(8, 128, string_hash_to_newline(eggnav_state_jumping), 4, 4, 0);


