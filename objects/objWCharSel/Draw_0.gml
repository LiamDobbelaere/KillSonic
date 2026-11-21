if (!pressing) {
    draw_set_color(c_black);
    draw_rectangle(x + 4, y + 4, x + 4 + 64, y + 4 + 64, false);
    draw_sprite(sprite_index, my_sub, x, y);
    if (hovering) draw_sprite(sprShimmer, shim_i, x, y);
} else {
    draw_sprite(sprite_index, my_sub, x + 4, y + 4);
    if (hovering) draw_sprite(sprShimmer, shim_i, x + 4, y + 4);
}

if (hovering) {
    draw_set_font(global.font_outline);
    draw_set_halign(fa_left);
    draw_set_color(c_white);

    var offset = 4;
    if (mouse_x + 4 + string_width(string_hash_to_newline(tooltip_text))*2 > room_width) {
        draw_set_halign(fa_right);
        offset *= -1;
    } else {
        draw_set_halign(fa_left);
    }
    
    draw_set_color(c_white);
    draw_text_transformed(mouse_x + offset, mouse_y + 4, string_hash_to_newline(tooltip_text), 2, 2, 0);
}

