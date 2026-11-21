if (!instance_exists(objEggBase01))
    instance_create(room_width / 2, room_height / 2, objEggBase01);
    
with (objEggBase01) {
    x = room_width / 2;
    y = room_height / 2;
}
    
// Browsers block audio until the player clicks/presses a key, so the music
// is started from the Step event as soon as the audio system is available.
music_pending = true;
global.enablemotors = false;



