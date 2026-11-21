if (workshop_dialog_open()) exit;   // typing a save name / picking a save
if (instance_exists(objBossRoom)) exit;
if (/*!selected ||*/ attachment != noone) exit;

attachment = instance_create(x, y, asset_get_index(objSelector.options[objSelector.current_option]));
//attachment.parent = parent;
attachment.angle = angle;

/* */
/*  */
