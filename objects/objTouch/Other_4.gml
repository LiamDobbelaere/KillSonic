/// @description Room Start: reset touch state
palette_open = false;
dragging = false;
rot_dir = 0;
spin_held = false;
save_was_open = false;
exit_armed_t = 0;
exit_prev = false;
jump1_prev = false;
jump2_prev = false;

hold_ctl = array_create(5, 0);

// The workshop buttons get 1.5x hit areas in Begin Step (0 while hidden).
// Their Draw events use draw_sprite(sprite_index, my_sub, x, y), so they look
// exactly the same; all have origin (0,0) and sit >= 96px apart, so the
// enlarged masks never overlap.
