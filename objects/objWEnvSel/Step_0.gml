shim += global.dt;

if (shim > 0.05) {
    shim_i += 1;
    if (shim_i > 22) shim_i = 0
    shim = 0;
}

switch (my_sub) {
    case 0:
        tooltip_text = "Emerald Hill"
        break;
    case 1: 
        tooltip_text = "Chemical Plant"
        break;
    case 2: 
        tooltip_text = "Mystic Cave"
        break;
    case 3: 
        tooltip_text = "Oil Ocean"
        break;  
}

if (hovering) depth = -100000;
else depth = -2000;

global.environment = my_sub;


if (!mouse_check_button(mb_left)) armed = false;
