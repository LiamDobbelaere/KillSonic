if (global.touch_mode && global.touch_swallow) exit;   // finger is owned by objTouch (touch only)
if (point_in_rectangle(mouse_x, mouse_y, btn_x - btn_w / 2, btn_y - btn_h / 2, btn_x + btn_w / 2, btn_y + btn_h / 2)) {
	room_goto_next();
}
