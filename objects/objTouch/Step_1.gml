/// @description Begin Step: read touch input
// Begin Step runs before the keyboard, mouse and Step events, so objSonic and
// objAttachPoint see this frame's touch values.

fit_canvas();

global.touch_block = false;
global.touch_p1_left = false; global.touch_p1_right = false; global.touch_p1_jump = false;
global.touch_p2_left = false; global.touch_p2_right = false; global.touch_p2_jump = false;

var mx = device_mouse_x(0);
var my = device_mouse_y(0);
var tap = device_mouse_check_button_pressed(0, mb_left);

// Gesture ownership: once objTouch takes a finger's press, the workshop buttons
// and PLAY ignore that press AND its release (guards in their Mouse events).
// Without this, lifting a finger after e.g. an Eggman drag over GO starts the fight.
if (!device_mouse_check_button(0, mb_left) && !device_mouse_check_button_released(0, mb_left)) {
	global.touch_swallow = false;
}

// Hold controls (TURN / SPIN) only respond to a finger that STARTED on them,
// not one that slides onto them during a drag. Forget lifted fingers here;
// new presses are latched in the editor section below.
for (var d = 0; d < 5; d++) {
	if (!device_mouse_check_button(d, mb_left)) hold_ctl[d] = 0;
}

if (portrait) {
	// "Rotate your device" overlay is up: ignore input
	global.touch_block = true;
	if (tap) global.touch_swallow = true;
	dragging = false;
	release_spin();
	exit;
}

if (room == rmWorkshop) {
	// ---- Save dialog (objSaveInput): on-screen keyboard
	var save_open = instance_exists(objSaveInput);
	if (save_open && !save_was_open) {
		keyboard_string = "BOSS" + string(ds_list_size(global.save_files) + 1);
	}
	save_was_open = save_open;

	// Any overlay open: stop a SPIN preview (desktop's Space release would do this),
	// otherwise a save made now would store the spun angles.
	if (save_open || instance_exists(objLoadSelection) || palette_open) release_spin();

	// Hidden buttons get no hit area (HTML5 mouse events ignore visibility)
	for (var i = 0; i < array_length(ui_objs); i++) {
		with (ui_objs[i]) {
			var sc = visible ? 1.5 : 0;
			image_xscale = sc;
			image_yscale = sc;
		}
	}

	if (save_open) {
		global.touch_block = true;
		dragging = false;
		palette_open = false;
		if (tap) {
			global.touch_swallow = true;
			if (inr(r_sv_cancel, mx, my)) {
				with (objSaveInput) event_perform(ev_keypress, vk_escape);
			} else if (inr(r_kb_ok, mx, my)) {
				if (keyboard_string != "") with (objSaveInput) event_perform(ev_keypress, vk_enter);
			} else if (inr(r_kb_del, mx, my)) {
				keyboard_string = string_delete(keyboard_string, string_length(keyboard_string), 1);
			} else {
				for (var r = 0; r < array_length(kb_rows); r++) {
					var row = kb_rows[r];
					for (var i = 0; i < string_length(row); i++) {
						var x1 = kb_x + i * kb_w;
						var y1 = kb_y + r * kb_h;
						if (point_in_rectangle(mx, my, x1, y1, x1 + kb_w - 1, y1 + kb_h - 1)
						&& string_length(keyboard_string) < 16) {
							keyboard_string += string_char_at(row, i + 1);
						}
					}
				}
			}
		}
		exit;
	}

	// ---- Load dialog (objLoadSelection)
	if (instance_exists(objLoadSelection)) {
		global.touch_block = true;
		dragging = false;
		palette_open = false;
		if (tap) {
			global.touch_swallow = true;
			var k = -1;
			if (inr(r_ld_prev, mx, my)) k = vk_left;
			else if (inr(r_ld_next, mx, my)) k = vk_right;
			else if (inr(r_ld_load, mx, my)) k = vk_enter;      // KeyPress_13 already guards an empty list
			else if (inr(r_ld_cancel, mx, my)) k = vk_escape;
			if (k != -1) with (objLoadSelection) event_perform(ev_keypress, k);
		}
		exit;
	}

	// ---- Parts palette
	if (palette_open) {
		global.touch_block = true;
		if (tap) global.touch_swallow = true;
		if (tap && instance_exists(objSelector)) {
			for (var i = 0; i < array_length(objSelector.options); i++) {
				var cx = pal_x + (i mod 3) * (pal_cell + pal_gap);
				var cy = pal_y + (i div 3) * (pal_cell + pal_gap);
				if (point_in_rectangle(mx, my, cx, cy, cx + pal_cell, cy + pal_cell)) objSelector.current_option = i;
			}
			palette_open = false;   // any tap closes it
		}
		exit;
	}

	// ---- Editor
	var sel = noone;
	with (objAttachPoint) if (selected) sel = id;
	sel_cache = sel;

	var slider_sliding = instance_exists(objMotorSlider) && objMotorSlider.sliding;

	// Latch which hold control each new finger started on (1 = TURN left, -1 = TURN right, 2 = SPIN)
	for (var d = 0; d < 5; d++) {
		if (device_mouse_check_button_pressed(d, mb_left)) {
			var px = device_mouse_x(d);
			var py = device_mouse_y(d);
			hold_ctl[d] = inr(r_rotl, px, py) ? 1 : (inr(r_rotr, px, py) ? -1 : (inr(r_spin, px, py) ? 2 : 0));
		}
	}

	// SPIN (hold) = hold Space to preview motors
	var sp = held_from(r_spin, 2);
	if (sp) global.enablemotors = true;
	else if (spin_held && !slider_sliding) global.enablemotors = false;
	spin_held = sp;

	// TURN (hold to repeat): fire on press, then every 0.08s after 0.35s
	var rd = held_from(r_rotl, 1) ? 1 : (held_from(r_rotr, -1) ? -1 : 0);
	if (rd != 0 && sel != noone) {
		var fire = false;
		if (rd != rot_dir) {
			fire = true;
			rot_t = -0.35;
		} else {
			rot_t += global.dt;
			if (rot_t >= 0.08) {
				fire = true;
				rot_t = 0;
			}
		}
		if (fire) with (sel) {
			// same as objAttachPoint Mouse_60 / Mouse_61
			angle += 5 * rd;
			targetangle = angle;
		}
	}
	rot_dir = rd;

	// Single-finger press, in priority order
	var on_button = false;
	for (var i = 0; i < array_length(ui_objs); i++) {
		var hb = instance_position(mx, my, ui_objs[i]);
		if (hb != noone && hb.visible) on_button = true;
	}

	if (tap && on_button) {
		// A visible workshop button handles this tap natively; just make sure
		// an attachment point underneath it doesn't toggle as well.
		global.touch_block = true;
	} else if (tap) {
		if (inr(r_rotl, mx, my) || inr(r_rotr, mx, my) || inr(r_spin, mx, my)) {
			global.touch_block = true;
		} else if (inr(r_add, mx, my)) {
			global.touch_block = true;
			if (sel != noone) with (sel) event_perform(ev_mouse, ev_right_press);
		} else if (inr(r_del, mx, my)) {
			global.touch_block = true;
			if (sel != noone) with (sel) event_perform(ev_keypress, vk_delete);
		} else if (inr(r_part, mx, my)) {
			global.touch_block = true;
			palette_open = true;
		} else if (instance_exists(objMotorSlider) && objMotorSlider.visible && inr(r_slider, mx, my)) {
			global.touch_block = true;
			// sliding = true; its Step follows mouse_x and its Global Left Released ends it
			with (objMotorSlider) event_perform(ev_mouse, ev_left_press);
		} else if (!on_native(mx, my)) {
			// Taps right on an attach point or button are handled by their own events.
			var n = instance_nearest(mx, my, objAttachPoint);
			if (n != noone && point_distance(mx, my, n.x, n.y) <= 48) {
				with (n) event_perform(ev_mouse, ev_left_press);   // tap near a point selects it
			} else {
				dragging = true;   // empty space: drag to move Eggman (replaces W/A/S/D)
				drag_mx = mx;
				drag_my = my;
			}
		}
		// objTouch owns this finger now. Set AFTER the slider's event_perform
		// above, because objMotorSlider's Mouse_4 is guarded by this flag.
		global.touch_swallow = true;
	}

	if (dragging) {
		if (device_mouse_check_button(0, mb_left)) {
			var dx = mx - drag_mx;
			var dy = my - drag_my;
			with (objEggBase01) {
				if (!boss_sequence) {
					x = clamp(x + dx, 160, 864);
					y = clamp(y + dy, 200, 560);
				}
			}
			drag_mx = mx;
			drag_my = my;
		} else {
			dragging = false;
		}
	}
}
else if (room == rmBoss) {
	if (tap) global.touch_swallow = true;

	// Which characters does a human control? (mirrors objSonic's key blocks)
	var f = global.play_against_flag;
	var p1 = (f == 0 && global.sonic_ai_flag == 0) || (f == 1 && global.tails_ai_flag == 0) || (f == 2 && global.sonic_ai_flag == 0);
	var p2 = (f == 2 && global.tails_ai_flag == 0);
	pads = (p1 && p2) ? 2 : ((p1 || p2) ? 1 : 0);

	if (pads == 1) {
		var L = held(z1.l);
		var R = held(z1.r);
		var J = held(z1.j);
		var JE = J && !jump1_prev;
		jump1_prev = J;
		if (p1) {
			global.touch_p1_left = L; global.touch_p1_right = R; global.touch_p1_jump = JE;
		} else {
			global.touch_p2_left = L; global.touch_p2_right = R; global.touch_p2_jump = JE;
		}
	} else if (pads == 2) {
		var JA = held(zA.j);
		var JB = held(zB.j);
		global.touch_p1_left = held(zA.l);
		global.touch_p1_right = held(zA.r);
		global.touch_p1_jump = JA && !jump1_prev;
		jump1_prev = JA;
		global.touch_p2_left = held(zB.l);
		global.touch_p2_right = held(zB.r);
		global.touch_p2_jump = JB && !jump2_prev;
		jump2_prev = JB;
	}

	// EXIT: two taps within 2 seconds (= Enter). Needed because the fight
	// never leaves the boss room on its own if every character dies.
	if (exit_armed_t > 0) exit_armed_t -= global.dt;
	var e = held(r_exit);
	if (e && !exit_prev) {
		if (exit_armed_t > 0) {
			exit_armed_t = 0;
			with (objBossRoom) event_user(0);
		} else {
			exit_armed_t = 2;
		}
	}
	exit_prev = e;
}
