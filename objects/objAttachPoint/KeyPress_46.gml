if (workshop_dialog_open()) exit;   // typing a save name / picking a save
if (instance_exists(objBossRoom)) exit;
if (selected && attachment != noone) {
    with (attachment) {
        instance_destroy();
    }
}


