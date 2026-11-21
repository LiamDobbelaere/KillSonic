/// @description End Step: touch replacements for mouse hover
if (room == rmWorkshop) {
	// Touch has no hover, so show the part preview on the SELECTED attachment
	// point instead (overrides the mouse enter/leave state; Draw runs after this).
	with (objAttachPoint) hovering = selected;

	// Top-row button tooltips/shimmer: only while a finger is on the button,
	// instead of sticking around after the finger has lifted.
	var down = device_mouse_check_button(0, mb_left);
	var fx = device_mouse_x(0);
	var fy = device_mouse_y(0);
	for (var i = 0; i < array_length(ui_objs); i++) {
		with (ui_objs[i]) {
			hovering = down && position_meeting(fx, fy, id);
		}
	}
}
