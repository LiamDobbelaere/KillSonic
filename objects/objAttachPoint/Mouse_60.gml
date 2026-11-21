if (workshop_dialog_open()) exit;   // typing a save name / picking a save
if (instance_exists(objBossRoom)) exit;
if (!hovering) exit;

//if (selected) {
    angle+=5;
    targetangle = angle;
//}

