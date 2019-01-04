///boss_save(name)
var name = argument0;

var map = ds_map_create();
var list = ds_list_create();
ds_map_add_list(map, "boss", list);

//Go through all the attachment points of the boss object
for (var i = 0; i < array_length_1d(objEggBase01.attachments); i++) {
    ds_list_add(list, attachment_save(objEggBase01.attachments[i]));
    ds_list_mark_as_map(list, i);
}

var file = file_text_open_write(name + ".boss");
file_text_write_string(file, json_encode(map));
file_text_close(file);

ds_map_destroy(map);
