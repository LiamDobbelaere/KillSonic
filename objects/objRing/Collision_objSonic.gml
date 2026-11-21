if (other.dead) exit;   // dead characters don't collect rings
with (other) {
    rings++;
}

audio_play_sound(sndRing, 1, false);
instance_destroy();


