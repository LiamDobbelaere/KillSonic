var ring = instance_nearest(x, y, objRing);

if (ring != noone && rings <= 0) {
    if (x > ring.x) ai_move_left()
    else ai_move_right()
    
    eggnav_state_running = "COLLECT RINGS"
}
