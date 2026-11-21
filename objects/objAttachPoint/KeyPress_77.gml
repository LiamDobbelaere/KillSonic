if (instance_exists(objBossRoom)) exit;
if (!selected) exit;

motorspeed++;

if (motorspeed > 16) {
    motorspeed = 0;
    angle = targetangle;
}

