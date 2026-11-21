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

// Web build: show a PLAY button first so the browser unlocks audio.
if (os_browser != browser_not_a_browser) {
	instance_create_depth(0, 0, 0, objPlayScreen);
} else {
	room_goto_next();
}