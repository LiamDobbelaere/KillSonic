/// @description Alarms

alarm_0_t -= global.dt;
if (alarm_0_t <= 0 && !alarm_0_f) {    
    flash = false;

    alarm_0_f = true;
}

alarm_1_t -= global.dt;
if (alarm_1_t <= 0 && !alarm_1_f) {    
    if (bhealth <= 0) {
        instance_create(x + random_range(-64, 64), y + random_range(-64, 64), objExplosion);
        audio_play_sound(sndEggDefeat, 1, false);
    }
    alarm_1_f = true;
    
    //Reset the alarm
    alarm_1_t = 0.166;
    alarm_1_f = false;
}

image_speed = 30 * global.dt;

if (!boss_sequence) {
    if (workshop_dialog_open()) {
        // W/A/S/D are letters of the save name, not Eggman movement
    } else {
    if (x > 0 && keyboard_check_direct(ord("A"))) x -= 150 * global.dt;
    if (x < room_width && keyboard_check_direct(ord("D"))) x += 150 * global.dt;
    if (y > 0 && keyboard_check_direct(ord("W"))) y -= 150 * global.dt;
    if (y < room_height && keyboard_check_direct(ord("S"))) y += 150 * global.dt;
    }
} else {
    if (y < room_height /2) {
        y+= 300 * global.dt;
    } else {
        if (boss_sequence_dir == -1) {    
            if (x < 100) {
                boss_sequence_dir = 1;
            }
        }
        
        if (boss_sequence_dir == 1) {    
            if (x > room_width - 100) {
                boss_sequence_dir = -1;
            }
        }
        
        x += (150 * global.dt) * boss_sequence_dir;
    }
}

if (flash) {
    if (flash_bit) sprite_index = sprEggBase01;
    else sprite_index = sprEggBase01Hit;

    flash_t += global.dt;
    if (flash_t > 0.025) {
        flash_bit = !flash_bit;
        flash_t = 0;
    }    
} else {
    sprite_index = sprEggBase01
}

/*for (var i = 0; i < array_length_1d(attachments); i++) {
    attachments[i].x = x + attachments[i].xoffset;
    attachments[i].y = y + attachments[i].yoffset;
}*/

/* */
/*  */
