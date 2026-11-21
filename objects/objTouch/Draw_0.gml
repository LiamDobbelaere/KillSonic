/// @description Draw touch UI (room coordinates, on top of everything)

if (room == rmWorkshop) {
	if (instance_exists(objSaveInput)) {
		// objSaveInput already draws the dim overlay, the title and the typed name
		for (var r = 0; r < array_length(kb_rows); r++) {
			var row = kb_rows[r];
			for (var i = 0; i < string_length(row); i++) {
				var x1 = kb_x + i * kb_w + 4;
				var y1 = kb_y + r * kb_h + 4;
				draw_btn([x1, y1, x1 + kb_w - 8, y1 + kb_h - 8], string_char_at(row, i + 1), true, false);
			}
		}
		draw_btn(r_kb_del, "DEL", true, false);
		draw_btn(r_kb_ok, "OK", keyboard_string != "", false);
		draw_btn(r_sv_cancel, "CANCEL", true, false);
	}
	else if (instance_exists(objLoadSelection)) {
		draw_btn(r_ld_prev, "", true, false);
		draw_tri_arrow(r_ld_prev, -1, 36);
		draw_btn(r_ld_next, "", true, false);
		draw_tri_arrow(r_ld_next, 1, 36);
		draw_btn(r_ld_load, "LOAD", ds_list_size(global.save_files) > 0, false);
		draw_btn(r_ld_cancel, "CANCEL", true, false);
	}
	else if (palette_open) {
		draw_set_alpha(0.7);
		draw_set_color(c_black);
		draw_rectangle(0, 0, room_width, room_height, false);
		draw_set_alpha(1);

		if (instance_exists(objSelector)) {
			for (var i = 0; i < array_length(objSelector.options_sprites); i++) {
				var cx = pal_x + (i mod 3) * (pal_cell + pal_gap);
				var cy = pal_y + (i div 3) * (pal_cell + pal_gap);
				var cell = [cx, cy, cx + pal_cell, cy + pal_cell];
				var is_cur = (i == objSelector.current_option);
				draw_btn(cell, "", true, is_cur);

				// Centre the whole sprite image in the cell, respecting its origin
				var spr = objSelector.options_sprites[i];
				var sc = 0.8;
				var sx = cx + pal_cell / 2 - (sprite_get_width(spr) / 2 - sprite_get_xoffset(spr)) * sc;
				var sy = cy + pal_cell / 2 - (sprite_get_height(spr) / 2 - sprite_get_yoffset(spr)) * sc;
				draw_sprite_ext(spr, 0, sx, sy, sc, sc, 0, c_white, 1);

				if (is_cur) {
					draw_set_color(c_yellow);
					draw_rectangle(cx + 2, cy + 2, cx + pal_cell - 2, cy + pal_cell - 2, true);
				}
			}
		}

		draw_set_font(global.font_outline);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_set_color(c_white);
		draw_text_transformed(pal_x + (3 * pal_cell + 2 * pal_gap) / 2, pal_y - 40, "PICK A PART", 3, 3, 0);
	}
	else {
		// Editor toolbar
		var sel = sel_cache;
		if (!instance_exists(sel)) sel = noone;
		var has_sel = (sel != noone);

		draw_btn(r_rotl, "", has_sel, has_sel && rot_dir == 1);
		draw_tri_arrow(r_rotl, -1, 24);
		draw_btn(r_rotr, "", has_sel, has_sel && rot_dir == -1);
		draw_tri_arrow(r_rotr, 1, 24);
		draw_btn(r_add, "ADD", has_sel && sel.attachment == noone, false);
		draw_btn(r_del, "DEL", has_sel && sel.attachment != noone, false);
		draw_btn(r_spin, "SPIN", true, spin_held);

		draw_set_font(global.font_outline);
		draw_set_valign(fa_middle);
		draw_set_color(c_white);

		draw_set_halign(fa_center);
		draw_text_transformed((r_rotl[0] + r_rotr[2]) / 2, r_rotl[1] - 16, "TURN", 2, 2, 0);
		draw_text_transformed((r_part[0] + r_part[2]) / 2, r_part[1] - 10, "PARTS", 2, 2, 0);

		// Hint / status text above the toolbar (scale 3 so it's readable on a phone)
		draw_set_halign(fa_left);
		if (has_sel) {
			draw_text_transformed(16, 608, "ANGLE " + string(round(sel.angle)) + "   SPEED " + string(sel.motorspeed), 3, 3, 0);
		} else {
			draw_text_transformed(16, 580, "TAP A POINT TO EDIT IT", 3, 3, 0);
			draw_text_transformed(16, 608, "DRAG EMPTY SPACE TO MOVE EGGMAN", 3, 3, 0);
		}
	}
}
else if (room == rmBoss) {
	if (pads == 1) {
		var pl = [24, 584, 184, 744];
		var pr = [216, 584, 376, 744];
		var pj = [848, 584, 1008, 744];
		draw_btn(pl, "", true, held(z1.l));
		draw_tri_arrow(pl, -1, 40);
		draw_btn(pr, "", true, held(z1.r));
		draw_tri_arrow(pr, 1, 40);
		draw_btn(pj, "JUMP", true, held(z1.j));
	} else if (pads == 2) {
		// Pads of 120px centred in each zone
		var zones = [zA, zB];
		var names = ["P1", "P2"];
		for (var p = 0; p < 2; p++) {
			var z = zones[p];
			var keys = [z.l, z.r, z.j];
			for (var k = 0; k < 3; k++) {
				var zr = keys[k];
				var cx = (zr[0] + zr[2]) / 2;
				var cy = (zr[1] + zr[3]) / 2;
				var pad = [cx - 60, cy - 60, cx + 60, cy + 60];
				draw_btn(pad, (k == 2) ? "JUMP" : "", true, held(zr));
				if (k == 0) draw_tri_arrow(pad, -1, 30);
				if (k == 1) draw_tri_arrow(pad, 1, 30);
			}
			draw_set_font(global.font_outline);
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_set_color(c_white);
			// label centred above this player's cluster
			var zmin = min(z.l[0], z.r[0], z.j[0]);
			var zmax = max(z.l[2], z.r[2], z.j[2]);
			draw_text_transformed((zmin + zmax) / 2, z.l[1] - 8, names[p], 2, 2, 0);
		}
	}

	draw_btn(r_exit, "", true, exit_armed_t > 0);
	draw_set_font(global.font_outline);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(c_white);
	draw_text_transformed((r_exit[0] + r_exit[2]) / 2, (r_exit[1] + r_exit[3]) / 2, "EXIT", 2, 2, 0);
	if (exit_armed_t > 0) {
		draw_set_halign(fa_left);
		draw_text_transformed(r_exit[0], r_exit[3] + 16, "TAP AGAIN TO EXIT", 2, 2, 0);
	}
}

if (portrait) {
	draw_set_alpha(1);
	draw_set_color(c_black);
	draw_rectangle(0, 0, room_width, room_height, false);
	draw_set_font(global.font_outline);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_color(c_white);
	draw_text_transformed(room_width / 2, room_height / 2, "ROTATE YOUR DEVICE", 4, 4, 0);
}

// Leave draw state as other objects expect it
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
