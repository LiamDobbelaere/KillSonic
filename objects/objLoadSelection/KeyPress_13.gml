if (current < ds_list_size(global.save_files) && current >= 0) {
    boss_load(ds_list_find_value(global.save_files, current));
    
    instance_destroy();
}


