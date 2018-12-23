closest_hazard = ai_closest_hazard()
hazard_jump = false;
hazard_dodge = false;

var d = 0;

if (closest_hazard != noone) {
    d = point_distance(closest_hazard.x, closest_hazard.y, x, y);
    
    if (d < 200) {
        
    hazard_above = closest_hazard.y > y;
    hazard_below = closest_hazard.y < y;
    
    hazard_jump = hazard_below; 
    
    /*if (!grounded && vsp > 0 && hazard_jump) {
      
    } */
        if (hazard_jump) { 
            if (x > closest_hazard.x) {
                ai_move_right() 
            } else {
                ai_move_left()
            }
            eggnav_state_running = "AVOID HAZARD"        
        }
    }
}

if (closest_hazard != noone && !hazard_jump && d < 200) {
    key_jump = false;
    eggnav_state_jumping = object_get_name(closest_hazard.object_index) + " DON'T JUMP"
} else {
    key_jump = ai_is_eggman_above() || hazard_jump;
    
    if (ai_is_eggman_above()) {
        eggnav_state_jumping = "ATTACK EGGMAN ABOVE"
    }
    
    if (hazard_jump) {
        eggnav_state_jumping = "DODGE " + object_get_name(closest_hazard.object_index)
    }
    
}

ai_dodge_laserhits()
ai_dodge_lasers()

