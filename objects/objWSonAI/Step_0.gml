shim += global.dt;

if (shim > 0.05) {
    shim_i += 1;
    if (shim_i > 22) shim_i = 0
    shim = 0;
}

switch (my_sub) {
    case 0:
        tooltip_text = "Human plays sonic"
        break;
    case 1: 
        tooltip_text = "Computer plays sonic"
        break;
}

if (hovering) depth = -100000;
else depth = -2000;

global.sonic_ai_flag = my_sub;
visible = global.play_against_flag != 1


if (!mouse_check_button(mb_left)) armed = false;
