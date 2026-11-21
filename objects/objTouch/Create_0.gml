/// @description Touch controls (phones / tablets only)
// Created by rmGlobals only when global.touch_mode is true, so none of this
// runs on desktop. Everything uses 1024x768 room coordinates: the canvas is
// scaled, but mouse_x / device_mouse_x() stay in room space.

// Draw in front of everything, including the save/load dialogs (depth -9999999)
depth = -10000000;

last_bw = -1;
last_bh = -1;
portrait = false;

// Rectangles: [x1, y1, x2, y2] in room coordinates
r_rotl   = [16,  664, 112, 760];   // TURN +5 (= mouse wheel up)
r_rotr   = [128, 664, 224, 760];   // TURN -5 (= mouse wheel down)
r_add    = [256, 664, 400, 760];   // ADD  (= right click on the selected point)
r_del    = [432, 664, 560, 760];   // DEL  (= Delete key)
r_spin   = [720, 664, 864, 760];   // SPIN, hold (= hold Space)
r_part   = [870, 536, 1014, 680];  // the part box -> opens the parts palette
r_slider = [670, 136, 994, 176];   // motor speed slider track (kept clear of the buttons above and below)

// Parts palette: 3x3 grid, x 112..528, y 200..616
pal_x = 112;
pal_y = 200;
pal_cell = 128;
pal_gap = 16;

// On-screen keyboard for naming saves
kb_rows = ["1234567890", "QWERTYUIOP", "ASDFGHJKL", "ZXCVBNM"];
kb_x = 32;
kb_y = 432;
kb_w = 96;
kb_h = 80;
r_kb_del = [kb_x + 9 * kb_w, kb_y + 2 * kb_h, kb_x + 10 * kb_w, kb_y + 3 * kb_h];   // row 3, slot 10
r_kb_ok  = [kb_x + 7 * kb_w, kb_y + 3 * kb_h, kb_x + 10 * kb_w, kb_y + 4 * kb_h];   // row 4, slots 8-10
r_sv_cancel = [16, 160, 240, 256];

// Load dialog
r_ld_prev   = [32, 320, 192, 448];
r_ld_next   = [832, 320, 992, 448];
r_ld_load   = [352, 480, 672, 576];
r_ld_cancel = [352, 600, 672, 696];

// Boss fight
// Top LEFT on purpose: the workshop's GO button sits top right, and the finger
// lifting after the room change would trigger GO and restart the fight.
r_exit = [16, 16, 112, 112];
// Pad hit zones (bigger than the drawn pads)
z1 = { l: [0, 448, 200, 768],   r: [200, 448, 416, 768], j: [704, 448, 1024, 768] };   // one human
zA = { l: [0, 544, 136, 768],   r: [136, 544, 272, 768], j: [352, 544, 512, 768] };    // P1 (Sonic), two humans
zB = { l: [752, 544, 888, 768], r: [888, 544, 1024, 768], j: [512, 544, 672, 768] };   // P2 (Tails), two humans

// Workshop buttons that handle taps natively (they get bigger hit areas in Room Start)
ui_objs = [objWSave, objWLoad, objWSonAI, objWTailsAI, objWCharSel, objWEnvSel, objWGo, objWMotorDir];

palette_open = false;
dragging = false;
drag_mx = 0;
drag_my = 0;
rot_dir = 0;
rot_t = 0;
spin_held = false;
save_was_open = false;
jump1_prev = false;
jump2_prev = false;
exit_prev = false;
exit_armed_t = 0;
pads = 0;
sel_cache = noone;
hold_ctl = array_create(5, 0);   // per finger: which hold control its press started on

// --- helpers ---

inr = function(r, xx, yy) {
	return point_in_rectangle(xx, yy, r[0], r[1], r[2], r[3]);
};

// Is any finger (touch devices 0..4) currently down inside r?
held = function(r) {
	for (var d = 0; d < 5; d++) {
		if (device_mouse_check_button(d, mb_left)
		&& point_in_rectangle(device_mouse_x(d), device_mouse_y(d), r[0], r[1], r[2], r[3])) {
			return true;
		}
	}
	return false;
};

// Like held(), but only counts fingers whose press started on this control
held_from = function(r, ctl) {
	for (var d = 0; d < 5; d++) {
		if (hold_ctl[d] == ctl && device_mouse_check_button(d, mb_left)
		&& point_in_rectangle(device_mouse_x(d), device_mouse_y(d), r[0], r[1], r[2], r[3])) {
			return true;
		}
	}
	return false;
};

// Stop a SPIN motor preview (unless the motor slider is being dragged)
release_spin = function() {
	if (spin_held) {
		if (!(instance_exists(objMotorSlider) && objMotorSlider.sliding)) global.enablemotors = false;
		spin_held = false;
	}
	for (var d = 0; d < 5; d++) hold_ctl[d] = 0;
};

// Is a visible, natively tappable workshop object under (xx, yy)?
on_native = function(xx, yy) {
	var hit = instance_position(xx, yy, objAttachPoint);
	if (hit != noone && hit.visible) return true;
	for (var i = 0; i < array_length(ui_objs); i++) {
		hit = instance_position(xx, yy, ui_objs[i]);
		if (hit != noone && hit.visible) return true;
	}
	return false;
};

// Fit the 4:3 canvas inside the browser window / itch.io iframe
fit_canvas = function() {
	var bw = browser_width;
	var bh = browser_height;
	if (bw == last_bw && bh == last_bh) return;
	last_bw = bw;
	last_bh = bh;
	var s = min(bw / 1024, bh / 768);
	window_set_size(max(1, floor(1024 * s)), max(1, floor(768 * s)));
	window_center();
	portrait = (bh > bw);
};

// Draw a touch button. The outline font has no "." or "/" glyphs, so labels
// stick to letters, digits and spaces.
draw_btn = function(r, label, enabled, lit) {
	draw_set_alpha(enabled ? 0.45 : 0.2);
	draw_set_color(lit ? c_yellow : c_black);
	draw_roundrect(r[0], r[1], r[2], r[3], false);
	draw_set_alpha(enabled ? 1 : 0.4);
	draw_set_color(c_white);
	draw_roundrect(r[0], r[1], r[2], r[3], true);
	if (label != "") {
		draw_set_font(global.font_outline);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_text_transformed((r[0] + r[2]) / 2, (r[1] + r[3]) / 2, label, 3, 3, 0);
	}
	draw_set_alpha(1);
};

// Filled arrow triangle pointing left (dir = -1) or right (dir = 1), centred in r
draw_tri_arrow = function(r, dir, size) {
	var cx = (r[0] + r[2]) / 2;
	var cy = (r[1] + r[3]) / 2;
	draw_set_color(c_white);
	// tip on the 'dir' side, flat base on the other side
	draw_triangle(cx + size * dir, cy, cx - size * dir, cy - size, cx - size * dir, cy + size, false);
};

fit_canvas();
