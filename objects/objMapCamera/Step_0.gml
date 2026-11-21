for (var i = 0; i < instance_number(objMapNode); i++) {
    var inst = instance_find(objMapNode, i);
    if (inst.selected) {
        target = inst; 
    }
}

if (target != noone) {
    x = lerp(x, target.x, 30 * 0.3 * global.dt);
    y = lerp(y, target.y, 30 * 0.3 * global.dt);
}

