// Only save valid file names; keep the dialog open if the name is empty
var name = save_name_clean(keyboard_string);
if (name == "") exit;

if (boss_save(name)) instance_destroy();
