global.enablemotors = false;
global.spawner_rings = 0;
global.play_against_flag = 0;
global.sonic_ai_flag = 1;
global.tails_ai_flag = 1;

global.floor_sprite = sprChemicalPlantBlock;

global.save_files = ds_list_create();
reload_saves();

global.font_outline = font_add_sprite(sprFontSonic, ord("*"), true, 1);

global.environment = 0;

// Touch / mobile support. These globals exist on every platform because
// objSonic and objAttachPoint read them; on desktop they simply stay false.
// iPadOS Safari (desktop user agent) is also reported as os_ios by the runtime.
global.touch_mode  = (os_browser != browser_not_a_browser) && (os_type == os_android || os_type == os_ios);
global.touch_block = false;
global.touch_swallow = false;   // objTouch owns the current finger-0 gesture
global.touch_p1_left = false; global.touch_p1_right = false; global.touch_p1_jump = false;
global.touch_p2_left = false; global.touch_p2_right = false; global.touch_p2_jump = false;

// Web build: show a PLAY button first so the browser unlocks audio.
if (os_browser != browser_not_a_browser) {
	if (global.touch_mode) instance_create_depth(0, 0, -200000, objTouch);
	instance_create_depth(0, 0, 0, objPlayScreen);
} else {
	room_goto_next();
}