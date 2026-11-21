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

// Show the selected point's direction. The point is the source of truth;
// only a click on this button (Mouse_7) or the R key changes it.
if (sel_attachpoint != noone) {
    my_sub = (sel_attachpoint.motordirection == 1) ? 0 : 1;
    tooltip_text = (my_sub == 0) ? "Motor is forward" : "Motor is reverse";
}

if (!mouse_check_button(mb_left)) armed = false;
