/// @description Alarms

alarm_0_t -= global.dt;
if (alarm_0_t <= 0 && !alarm_0_f) {
    flash = false;

    alarm_0_f = true;
}

alarm_1_t -= global.dt;
if (alarm_1_t <= 0 && !alarm_1_f) {
    ///Stage clear - only once every character (Sonic and Tails) is dead
    var all_dead = true;
    with (objSonic) {
        if (!dead) all_dead = false;
    }

    if (all_dead) {
        audio_stop_sound(sndBossBattle);
        audio_play_sound(sndStageClear, 1, false);
    }

    alarm_1_f = true;
}

alarm_2_t -= global.dt;
if (alarm_2_t <= 0 && !alarm_2_f) {
    with (objBossRoom) {
        event_user(0);
    }

    alarm_2_f = true;
}

///Character skin setter
if (!fire_once) {
    tails = false;

    if (global.play_against_flag == 1) {
        tails = true;
    } else if (global.play_against_flag == 2) {
        var i = instance_create(x, y, objSonic);
        i.tails = true;
        i.fire_once = true;
    }

    fire_once = true;
}

if (tails) {
    sprite_walk = sprTailsWalk
    sprite_run = sprTailsRun
    sprite_jump = sprTailsJump
    sprite_hurt = sprTailsHurt
    sprite_die = sprTailsDie
} else {
    sprite_walk = sprSonicWalk
    sprite_run = sprSonicRun
    sprite_jump = sprSonicJump
    sprite_hurt = sprSonicHurt
    sprite_die = sprSonicDie
}

///Alive code

if (!dead) {
    //EGG-NAV Sonic AI code
    key_left = 0;
    key_right = 0;
    key_jump = 0;
    
    if (global.sonic_ai_flag == 1 && !tails || global.tails_ai_flag == 1 && tails) ai_think()
    
    if (!grounded_since_flash) {
        key_left = 0;
        key_right = 0;
        key_jump = 0;
    }
    
    if (global.sonic_ai_flag == 0 && !tails || global.tails_ai_flag == 0 && tails) {
        if (tails && global.play_against_flag == 2) {
            // Q or A for left so both AZERTY and QWERTY work.
            // vk_shift instead of vk_lshift: HTML5 can't tell left/right shift apart.
            // global.touch_p* are set by objTouch's on-screen pads (always false on desktop).
            key_left = -(keyboard_check(ord("Q")) || keyboard_check(ord("A")) || global.touch_p2_left);
            key_right = (keyboard_check(ord("D")) || global.touch_p2_right);
            key_jump = (keyboard_check_pressed(vk_shift) || global.touch_p2_jump);
        } else {
            key_left = -(keyboard_check(vk_left) || global.touch_p1_left);
            key_right = (keyboard_check(vk_right) || global.touch_p1_right);
            key_jump = (keyboard_check_pressed(vk_space) || global.touch_p1_jump);
        }
    }
    
    move = key_left + key_right;
    
    if (grounded)
    hsp = lerp(hsp, move * movespeed, 1.8 * global.dt) - 30*0.5*global.dt; //0.06 for 30fps
    else
    hsp = lerp(hsp, move * movespeed, 6 * global.dt) - 30*0.5*global.dt; //0.2 for 30fps
    
    if (vsp < 10) vsp += (30 * grav) * global.dt;
    
    if (place_meeting(x, y + 1, objWall)) {
        vsp = key_jump * -jumpspeed;
        
        grounded_since_flash = true;
        grounded = true;
    } else {
        if (grounded && vsp < 0) {
            audio_play_sound(sndSonicJump, 1, false);
        }    
    
        grounded = false;
    }
    
    // Step size must never be 0: on HTML5 delta_time can be 0 for a frame,
    // which made these loops run forever and freeze the game.
    var col_step = max(30 * global.dt, 0.5);

    if (place_meeting(x + hsp, y, objWall)) {
        var guard = 0;
        while (hsp != 0 && !place_meeting(x + sign(hsp), y, objWall) && guard++ < 1000) {
            x += col_step * sign(hsp);
        }
        
        hsp = 0;
    }
    
    x += (30 * hsp) * global.dt;
    x = clamp(x, 10, room_width - 10);
    
    if (place_meeting(x, y + vsp, objWall)) {
        var guard_v = 0;
        while (vsp != 0 && !place_meeting(x, y + sign(vsp), objWall) && guard_v++ < 1000) {
            y += col_step * sign(vsp);
        }
        
        vsp = 0;
    }
    
    if (place_meeting(x, y + vsp, objEggBase01)) {
        if (!objEggBase01.flash && grounded_since_flash) {
            objEggBase01.bhealth--;
            
            if (objEggBase01.bhealth == 0) {
                alarm_2_t = 4;
                alarm_2_f = false;
            }
            
            audio_play_sound(sndBossHit, 1, false);
            vsp *= -1;
            with (objEggBase01) {
                event_user(1);
            }
        }
    }
    
    y += (30 * vsp) * global.dt;
    
    if (!grounded) {
        if (flash && !grounded_since_flash) {
            sprite_index = sprite_hurt;
        } else {
            sprite_index = sprite_jump;
        }
        image_speed = 30 * global.dt;
    }
    else if (hsp > 4) {
        sprite_index = sprite_run;
        image_speed = 30 * global.dt;
    } else {
        sprite_index = sprite_walk;
        image_speed = (30 * (0.2 + abs(hsp) / movespeed)) * global.dt;
    }
    
    image_speed *= sign(hsp);
    
    if (flash) {
        visible = !visible;
    } else {
        visible = true;
    }
}

///Dead code

if (dead) {
    sprite_index = sprite_die;
    vsp += (30 * grav) * global.dt;
    y += (30 * vsp) * global.dt;  
}

