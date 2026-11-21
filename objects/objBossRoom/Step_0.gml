/// @description Alarms

alarm_0_t -= global.dt;
if (alarm_0_t <= 0 && !alarm_0_f) {
    instance_create(room_width, room_height - background_get_height(__background_get( e__BG.Index, 2 )) - 32, objRingLine);

    alarm_0_f = true;
    
    alarm_0_t = 3;
    alarm_0_f = false;
}

__background_set( e__BG.HSpeed, 0, -30 * global.dt );
__background_set( e__BG.HSpeed, 1, -60 * global.dt );
__background_set( e__BG.HSpeed, 2, -240 * global.dt );

