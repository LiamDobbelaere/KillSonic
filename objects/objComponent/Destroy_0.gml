if (attachments != noone) {
    for (var i = 0; i < array_length_1d(attachments); i++) {    
        if (attachments[i].attachment != noone) {
            with (attachments[i].attachment) {
                instance_destroy();
            }
        }
        attachments[i].attachment = noone;
        
        with (attachments[i]) instance_destroy();
    }
}

