with (objEggBase01) {
    boss_sequence = false;
    bhealth = 5;
}
audio_stop_sound(sndBossBattle);
audio_stop_sound(sndStageClear);   // don't carry fight audio into the workshop
audio_stop_sound(sndEggDefeat);
room_goto(rmWorkshop);

