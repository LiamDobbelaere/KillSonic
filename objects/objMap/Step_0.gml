if (keyboard_check_pressed(vk_right)) {
    current_node++;
    if (current_node >= max_nodes) current_node = 0;
}

if (keyboard_check_pressed(vk_left)) {
    current_node--;
    if (current_node < 0) current_node = max_nodes - 1;
}

