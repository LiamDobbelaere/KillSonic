///create_attachment(xoffset, yoffset, parent)
var xoffset = argument0;
var yoffset = argument1;
var parent = argument2;

var a = instance_create(x + xoffset, y + yoffset, objAttachPoint);
a.xoffset = xoffset;
a.yoffset = yoffset;
a.parent = parent;

return a;
