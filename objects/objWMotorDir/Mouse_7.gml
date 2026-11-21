if (global.touch_mode && global.touch_swallow) exit;   // finger is owned by objTouch (touch only)
if (!visible || !armed) exit;   // only a press that started on this button
armed = false;
my_sub++;
if (my_sub > 1) my_sub = 0;
with (objAttachPoint) if (selected) motordirection = (other.my_sub == 0) ? 1 : -1;


