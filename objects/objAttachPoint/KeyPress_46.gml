if (instance_exists(objBossRoom)) exit;
if (selected && attachment != noone) {
    with (attachment) {
        instance_destroy();
    }
}


