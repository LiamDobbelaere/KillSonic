eggnav_state_running = "IDLE"
eggnav_state_jumping = "IDLE"

//Lower priority actions are higher up
ai_edge_boundaries();

if (ai_vulnerable()) ai_avoid_eggman()
else ai_move_towards_eggman();

ai_collect_rings();

ai_dodge_hazards();

