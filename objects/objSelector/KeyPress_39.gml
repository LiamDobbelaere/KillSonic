if (workshop_dialog_open()) exit;   // typing a save name / picking a save
if (++current_option >= array_length_1d(options)) current_option = 0;

