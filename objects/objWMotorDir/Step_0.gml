var sel_attachpoint = noone;
//Find selected attachment point
var a_num = instance_number(objAttachPoint);
for (var i = 0; i < a_num; i++) {
    var attachpoint = instance_find(objAttachPoint, i);
    
    if (attachpoint.selected) {
        sel_attachpoint = attachpoint;
    }
}

visible = sel_attachpoint != noone;

shim += global.dt;

if (shim > 0.05) {
    shim_i += 1;
    if (shim_i > 22) shim_i = 0
    shim = 0;
}

if (hovering) depth = -100000;
else depth = -2000;

if (sel_attachpoint != noone) {
    switch (my_sub) {
        case 0:
            sel_attachpoint.motordirection = 1
            tooltip_text = "Motor is forward"
            break;
        case 1: 
            sel_attachpoint.motordirection = -1
            tooltip_text = "Motor is reverse"
            break;
    }
}

