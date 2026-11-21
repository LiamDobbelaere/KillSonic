shim += global.dt;

if (shim > 0.05) {
    shim_i += 1;
    if (shim_i > 22) shim_i = 0
    shim = 0;
}

switch (my_sub) {
    case 0:
        tooltip_text = "Play against sonic"
        break;
    case 1: 
        tooltip_text = "Play against tails"
        break;
    case 2: 
        tooltip_text = "Play against#sonic and tails"
        break;
}

if (hovering) depth = -100000;
else depth = -2000;

global.play_against_flag = my_sub;

