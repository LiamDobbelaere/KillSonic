if (instance_exists(objBossRoom)) exit;

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


