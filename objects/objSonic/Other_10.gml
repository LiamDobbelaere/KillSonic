/// @description Ring loss

if (flash) exit;
if (dead) exit;   // already dead: no more ring loss / death
// after Eggman is beaten the characters can't be hurt any more
if (instance_exists(objEggBase01) && objEggBase01.bhealth <= 0) exit;

if (rings > 0) {
    vsp = -12;
    hsp = -12;
    grounded = false;   // don't play the jump sound for the knockback hop
    audio_play_sound(sndRingLoss, 1, false);
    rings = 0;
    flash = true;
    grounded_since_flash = false;
    
    alarm_0_t = 3;
    alarm_0_f = false;
} else {
    if (!dead) {
        audio_play_sound(sndSonicDie, 1, false);
        dead = true;
        
        alarm_1_t = 3;
        alarm_1_f = false;   
    }
}

