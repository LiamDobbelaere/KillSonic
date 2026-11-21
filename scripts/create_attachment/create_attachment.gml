/// @description create_attachment(xoffset, yoffset, parent)
/// @param xoffset
/// @param  yoffset
/// @param  parent
function create_attachment(argument0, argument1, argument2) {
	var xoffset = argument0;
	var yoffset = argument1;
	var parent = argument2;

	var a = instance_create(x + xoffset, y + yoffset, objAttachPoint);
	a.xoffset = xoffset;
	a.yoffset = yoffset;
	a.parent = parent;

	return a;



}
