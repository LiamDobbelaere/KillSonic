// On touch devices objTouch draws its own toolbar here; the keyboard/mouse help doesn't apply.
if (global.touch_mode) exit;

draw_set_font(global.font_outline);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(1);
draw_set_color(c_white);

// Editor controls in two columns, bottom left (as in version 2).
// Note: the outline font has no glyphs for "/" or ".", so avoid them here.
var controls = [
	["Change part",             "Left and right arrow keys"],
	["Select attachment point", "Left click the attachment point"],
	["Attach part",             "Right click attachment point"],
	["Change att point angle",  "Scroll over attachment point"],
	["Preview motors",          "Hold space"],
	["Move Eggman",             "W A S D"],
];

var line_h = 8;
var text_x = 8;
var text_y = 604;

var col2_x = 0;
for (var i = 0; i < array_length(controls); i++) {
	col2_x = max(col2_x, string_width(controls[i][0]));
}
col2_x += text_x + 24;

draw_text(text_x, text_y, "EDITOR CONTROLS");
for (var i = 0; i < array_length(controls); i++) {
	var row_y = text_y + (i + 1) * line_h;
	draw_text(text_x, row_y, controls[i][0]);
	draw_text(col2_x, row_y, controls[i][1]);
}
