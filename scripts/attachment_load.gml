///attachment_load(parentobj, list)
var parentobj = argument0;
var attachment_list = argument1;

//Go through all the attachment points of the boss object
for (var i = 0; i < ds_list_size(attachment_list); i++) {
    var attachpoint = ds_list_find_value(attachment_list, i);
    
    parentobj.attachments[i].motorspeed = ds_map_find_value(attachpoint, "motorspeed")
    parentobj.attachments[i].motordirection = ds_map_find_value(attachpoint, "motordirection")
    parentobj.attachments[i].targetangle = ds_map_find_value(attachpoint, "angle")

    
    if (ds_map_exists(attachpoint, "attachment")) {
        var at = instance_create(0, 0, asset_get_index(ds_map_find_value(attachpoint, "attachment")));
        parentobj.attachments[i].attachment = at;
        
        if (ds_map_exists(attachpoint, "attachment_sub")) {
            attachment_load(at, ds_map_find_value(attachpoint, "attachment_sub"))
        }
    }    
}
