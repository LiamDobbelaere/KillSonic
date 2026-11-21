if (global.touch_mode && global.touch_swallow) exit;   // finger is owned by objTouch (touch only)
if (!instance_exists(objSaveInput) && !instance_exists(objLoadSelection)) instance_create(0, 0, objLoadSelection);


