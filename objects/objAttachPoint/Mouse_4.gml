if (instance_exists(objBossRoom)) exit;
if (global.touch_mode && global.touch_block) exit;   // tap landed on a touch control / dialog / palette

if (motordirection == 1) {
    objWMotorDir.my_sub = 0
} else {
    objWMotorDir.my_sub = 1
}

objMotorSlider.x = objMotorSlider.xstart + (motorspeed / 16 * 256)

if (!selected) {
    with (objAttachPoint) { selected  = false; }
    selected = true;
} else { 
    with (objAttachPoint) { selected  = false; }
}


