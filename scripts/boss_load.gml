///boss_load(name)

with (objComponent) {
    instance_destroy();
}

var file = file_text_open_read(argument0);

var map = json_decode(file_text_read_string(file));
var list = ds_map_find_value(map, "boss");

file_text_close(file);

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

