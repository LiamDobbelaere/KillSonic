draw_self();

if (selected) {
    var str = string(angle) + "deg, motor:" + string(motorspeed * motordirection)
    
    draw_set_font(fntText);
    draw_set_color(c_black);
    draw_text(x - 31, y - 31, string_hash_to_newline(str));
    draw_text(x - 33, y - 33, string_hash_to_newline(str));
    draw_set_color(c_yellow);
    draw_text(x - 32, y - 32, string_hash_to_newline(str));
}

if (hovering && attachment == noone) {
    draw_sprite_ext(objSelector.options_sprites[objSelector.current_option], 0, x, y, 1, 1,  parent.angle + angle, c_white, 0.5);
}

