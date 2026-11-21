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

if (sliding) {
    x = clamp(xstart + (mouse_x - xstart), xstart, xstart + maxdist)
    value = round(((x - xstart) / maxdist) * maxvalue);
    if (sel_attachpoint != noone) sel_attachpoint.motorspeed = value;
} else if (sel_attachpoint != noone) {
    // e.g. the M key or a load changed the speed: move the knob to match
    x = xstart + (sel_attachpoint.motorspeed / maxvalue) * maxdist;
}

value = round(((x - xstart) / maxdist) * maxvalue);    

