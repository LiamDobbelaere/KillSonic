image_angle = direction;
speed = -750 * global.dt;


// Beams that never hit the ground: remove once well outside the room
// (large margin: Eggman enters from above and lasers can sit off-screen)
if (x < -512 || x > room_width + 512 || y < -512 || y > room_height + 512) instance_destroy();
