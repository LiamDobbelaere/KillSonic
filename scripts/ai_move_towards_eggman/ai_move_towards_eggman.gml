function ai_move_towards_eggman() {
	eggnav_state_running = "MOVE TOWARDS EGGMAN"

	if (x > objEggBase01.x) ai_move_left();
	else ai_move_right();




}
