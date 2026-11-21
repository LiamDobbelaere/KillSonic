if (global.touch_mode && global.touch_swallow) exit;   // finger is owned by objTouch (touch only)
my_sub++;
if (my_sub > 1) my_sub = 0;

audio_stop_sound(sndWorkshop);
global.enablemotors = true;
global.spawner_rings = 0;
room_goto(rmBoss);

