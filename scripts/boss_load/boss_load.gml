/// @description boss_load(name)
/// @param name
function boss_load(argument0) {
	// Read and validate the file BEFORE touching the current boss, so a
	// missing or broken save never wipes what the player has built.
	if (!file_exists(argument0)) exit;

	var file = file_text_open_read(argument0);
	if (file < 0) exit;
	var text = file_text_read_string(file);
	file_text_close(file);

	var map = json_decode(text);
	if (map < 0 || !ds_exists(map, ds_type_map)) exit;

	var list = ds_map_find_value(map, "boss");
	if (is_undefined(list) || !ds_exists(list, ds_type_list)) {
		ds_map_destroy(map);
		exit;
	}

	with (objComponent) {
	    instance_destroy();
	}
	with (objAttachPoint) {
	    selected = false;
	}

	//Go through all the attachment points of the boss object
	var n = min(ds_list_size(list), array_length(objEggBase01.attachments));
	for (var i = 0; i < n; i++) {
	    var attachpoint = ds_list_find_value(list, i);
	    var ap = objEggBase01.attachments[i];
	    ap.attachment = noone;
	    if (is_undefined(attachpoint) || !ds_exists(attachpoint, ds_type_map)) continue;

	    ap.motorspeed = attachment_map_num(attachpoint, "motorspeed", 0);
	    ap.motordirection = attachment_map_num(attachpoint, "motordirection", 1);
	    ap.targetangle = attachment_map_num(attachpoint, "angle", 0);
	    ap.angle = ap.targetangle;

	    if (ds_map_exists(attachpoint, "attachment")) {
	        var obj = asset_get_index(ds_map_find_value(attachpoint, "attachment"));
	        if (obj < 0 || !object_exists(obj)) continue;
	        var at = instance_create(0, 0, obj);
	        ap.attachment = at;

	        if (ds_map_exists(attachpoint, "attachment_sub")) {
	            attachment_load(at, ds_map_find_value(attachpoint, "attachment_sub"))
	        }
	    }
	}

	ds_map_destroy(map);
}
