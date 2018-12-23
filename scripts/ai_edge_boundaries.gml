if (x > 300 && !edge_boundary_right_crossed) {
    edge_boundary_right_crossed = true;
    edge_boundary_left_crossed = false;
}

if (x < 100 && !edge_boundary_left_crossed) {
    edge_boundary_left_crossed = true;
    edge_boundary_right_crossed = false;    
}
