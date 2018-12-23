var laser = instance_nearest(x, y, objLaserHit)

if (laser != noone) {
    var d = point_distance(x, y, laser.x, laser.y);
    
    if (d < 200) {
        /*if (ai_vulnerable()) {
            if (x < laser.x && !ai_close_to_left_edge()) ai_move_left()
            else ai_move_right()
        } else {*/
            if (x < laser.x && ai_close_to_left_edge()) ai_move_right()
            else ai_move_left()
            eggnav_state_running = "DODGE LASER HITS"
        
        
        if (d < 200) {
            key_jump = true
            eggnave_state_jumping = "DODGE LASER HITS"    
        }
    }
}
