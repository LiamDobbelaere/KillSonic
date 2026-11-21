if (music_pending && audio_system_is_available()) {
	music_pending = false;
	if (!audio_is_playing(sndWorkshop)) {
		audio_play_sound(sndWorkshop, 1, true);
	}
}
