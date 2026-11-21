var r = point_angle(parent.x, parent.y, parent.x + xoffset, parent.y + yoffset, parent.angle);

x = r[0];
y = r[1];

if (!instance_exists(attachment)) attachment = noone;

if (attachment != noone) {
    attachment.x = x;
    attachment.y = y;
    attachment.image_angle =  parent.angle + angle;
    attachment.angle = parent.angle + angle;
}

if (global.enablemotors)
    angle += (motorspeed * 30 * global.dt) * (motordirection * -1);
else angle = targetangle;

if (angle < 0) angle += 360;
angle = angle % 360;
image_angle = angle;

visible = !instance_exists(objBossRoom)// && (keyboard_check_direct(vk_lcontrol) || selected);

// GMS1's image_single does nothing in GMS2 (the sprite animated every frame)
image_speed = 0;
image_index = selected ? 1 : 0;

