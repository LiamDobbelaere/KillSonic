draw_set_font(global.font_outline);
draw_set_halign(fa_left);
draw_set_color(c_white);
draw_text_transformed(xstart - 16 - 2, y - 32 - 4, string_hash_to_newline("Motor speed"), 2, 2, 0)


draw_set_color(make_color_rgb(132, 132, 132))
draw_rectangle(xstart - 16 - 2, y - 16 - 2, xstart + maxdist + 16 + 2, y + 16 + 2, false);
draw_set_color(make_color_rgb(231, 231, 231))
//Top
draw_line(xstart - 16 - 2 - 1, y - 16 - 2, xstart + maxdist + 16 + 2, y - 16 - 2);
draw_line(xstart - 16 - 2 - 1, y - 16 - 2 + 1, xstart + maxdist + 16 + 2, y - 16 - 2 + 1);
//Left
draw_line(xstart - 16 - 2, y - 16 - 2, xstart - 16 - 2, y + 16 + 2);
draw_line(xstart - 16 - 2 + 1, y - 16 - 2, xstart - 16 - 2 + 1, y + 16 + 2);
draw_set_color(make_color_rgb(99, 99, 99))
//Right
draw_line(xstart + maxdist + 16 + 2, y - 16 - 2, xstart + maxdist + 16 + 2, y + 16 + 2);
draw_line(xstart + maxdist + 16 + 2 - 1, y - 16 - 2, xstart + maxdist + 16 + 2 - 1, y + 16 + 2);
//Bottom
draw_line(xstart - 16 - 2, y + 16 + 2, xstart + maxdist + 16 + 2, y + 16 + 2);
draw_line(xstart - 16 - 2, y + 16 + 2 - 1, xstart + maxdist + 16 + 2, y + 16 + 2 - 1);
draw_set_color(c_white);
draw_line(xstart, y, xstart + maxdist, y);
draw_set_color(make_color_rgb(32, 64, 192));
draw_line(xstart, y, x, y);
draw_line(xstart, y + 1, x, y + 1);

draw_self();

draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_transformed(x + 2, y, string_hash_to_newline(string(value)), 2, 2, 0);


