if (global.touch_mode && global.touch_swallow) exit;   // finger is owned by objTouch (touch only)
if (!visible) exit;   // hidden buttons ignore clicks
armed = true;
pressing = true;

