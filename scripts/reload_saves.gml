ds_list_empty(global.save_files);

file = file_find_first(working_directory + "*.boss", 0);

while (file != '')
{
    ds_list_add(global.save_files, file);
    show_debug_message('Adding -'+ file +'- to character_array');
    file = file_find_next();
}
