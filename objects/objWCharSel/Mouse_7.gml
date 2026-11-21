if (global.touch_mode && global.touch_swallow) exit;   // finger is owned by objTouch (touch only)
if (!visible || !armed) exit;   // only a press that started on this button
armed = false;
my_sub++;
if (my_sub > 2) my_sub = 0;


