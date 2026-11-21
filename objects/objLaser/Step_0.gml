/// @description Alarms

alarm_0_t -= global.dt;
if (alarm_0_t <= 0 && !alarm_0_f) {
    if (global.enablemotors) {
        var beam = instance_create(x, y, objLaserBeam);
        beam.direction = image_angle;
        beam.visible = true;
        audio_play_sound(sndLaser, 1, false);
    }

    alarm_0_f = true;
    
    alarm_0_t = 1;
    alarm_0_f = false;
}

