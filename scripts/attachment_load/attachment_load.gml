/// @description attachment_load(parentobj, list)
/// @param parentobj
/// @param  list
function attachment_load(argument0, argument1) {
	var parentobj = argument0;
	var attachment_list = argument1;

	if (!is_array(parentobj.attachments)) exit;
	if (is_undefined(attachment_list) || !ds_exists(attachment_list, ds_type_list)) exit;

	//Go through all the attachment points of the attached part
	var n = min(ds_list_size(attachment_list), array_length(parentobj.attachments));
	for (var i = 0; i < n; i++) {
	    var attachpoint = ds_list_find_value(attachment_list, i);
	    if (is_undefined(attachpoint) || !ds_exists(attachpoint, ds_type_map)) continue;
	    var ap = parentobj.attachments[i];

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
}

/// Number from a save map, or a default if the key is missing / not a number
function attachment_map_num(map, key, def) {
	var v = ds_map_find_value(map, key);
	if (is_undefined(v) || !is_numeric(v)) return def;
	return v;
}
