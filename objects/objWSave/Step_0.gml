shim += global.dt;

if (shim > 0.05) {
    shim_i += 1;
    if (shim_i > 22) shim_i = 0
    shim = 0;
}

if (hovering) depth = -100000;
else depth = -2000;

