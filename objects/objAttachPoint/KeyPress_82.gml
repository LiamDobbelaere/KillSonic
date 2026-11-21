if (workshop_dialog_open()) exit;   // typing a save name / picking a save
if (instance_exists(objBossRoom)) exit;
if (!selected) exit;

motordirection *= -1;

