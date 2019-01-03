///attachment_save(attachment_instance)
var attachment_instance = argument0;
var attachment_data = ds_map_create();

ds_map_add(attachment_data, "angle", argument0.angle);
ds_map_add(attachment_data, "motorspeed", argument0.motorspeed);
ds_map_add(attachment_data, "motordirection", argument0.motordirection);

if (argument0.attachment != noone) {
    ds_map_add(attachment_data, "attachment", object_get_name(argument0.attachment.object_index));
    var att = argument0.attachment;
    
    if (att.attachments != noone) {
        var att_list = ds_list_create();
        ds_map_add_list(attachment_data, "attachment_sub", att_list);
        
        //Go through all the attachment points of the attached object
        for (var i = 0; i < array_length_1d(att.attachments); i++) {
            ds_list_add(att_list, attachment_save(att.attachments[i]));
            ds_list_mark_as_map(att_list, i);
        }
    }
}

return attachment_data;
