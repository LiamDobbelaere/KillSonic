draw_set_alpha(1);
draw_set_font(global.font_outline);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_set_color(c_white);
if (selected) {
    draw_set_color(c_yellow);
}

draw_text_transformed(x, y, string_hash_to_newline(name), 2, 2, 0);


