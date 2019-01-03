with (objComponent) {
    instance_destroy();
}

var map = json_decode(clipboard_get_text());
var list = ds_map_find_value(map, "boss");

//Go through all the attachment points of the boss object
for (var i = 0; i < ds_list_size(list); i++) {
    var attachpoint = ds_list_find_value(list, i);

    objEggBase01.attachments[i].motorspeed = ds_map_find_value(attachpoint, "motorspeed")
    objEggBase01.attachments[i].motordirection = ds_map_find_value(attachpoint, "motordirection")
    objEggBase01.attachments[i].targetangle = ds_map_find_value(attachpoint, "angle")
    
    if (ds_map_exists(attachpoint, "attachment")) {
        var at = instance_create(0, 0, asset_get_index(ds_map_find_value(attachpoint, "attachment")));
        objEggBase01.attachments[i].attachment = at;
        
        if (ds_map_exists(attachpoint, "attachment_sub")) {
            attachment_load(at, ds_map_find_value(attachpoint, "attachment_sub"))
        }
    }    
}

ds_map_destroy(map);

