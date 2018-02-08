///point_angle(pivotx, pivoty, originalx, originaly, angle)
var pivotx = argument0;
var pivoty = argument1;
var originalx = argument2;
var originaly = argument3;
var angle = argument4;

var tdist = point_distance(pivotx, pivoty, originalx, originaly);
var tdir = point_direction(pivotx, pivoty, originalx, originaly) + angle;
var result;

result[0] = pivotx + lengthdir_x(tdist, tdir);
result[1] = pivoty + lengthdir_y(tdist, tdir);

return result;

