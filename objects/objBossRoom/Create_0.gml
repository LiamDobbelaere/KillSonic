with (objEggBase01) {
    x = room_width / 2;
    y = -200;
    event_user(0);
}

audio_play_sound(sndBossBattle, 1, true);

alarm_0_t = 3;
alarm_0_f = false;



// A fight always starts with motors running (a slider release can clear it)
global.enablemotors = true;

// Seconds since the "Eggman wins" jingle started; -1 = not ending
end_t = -1;
