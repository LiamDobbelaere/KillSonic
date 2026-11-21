#macro SAVE_INDEX_FILE "saves.index"

function reload_saves() {
	ds_list_empty(global.save_files);

	if (os_browser != browser_not_a_browser) {
		// HTML5: file_find_first/next are not supported. Saves live in the
		// browser's localStorage, so we keep our own list of save names.
		if (file_exists(SAVE_INDEX_FILE)) {
			var f = file_text_open_read(SAVE_INDEX_FILE);
			while (!file_text_eof(f)) {
				var line = file_text_read_string(f);
				file_text_readln(f);
				if (line != "" && file_exists(line) && ds_list_find_index(global.save_files, line) == -1) {
					ds_list_add(global.save_files, line);
				}
			}
			file_text_close(f);
		}
		exit;
	}

	file = file_find_first(working_directory + "*.boss", 0);

	while (file != "")
	{
	    ds_list_add(global.save_files, file);
	    show_debug_message("Adding -"+ file +"- to character_array");
	    file = file_find_next();
	}
	file_find_close();
}

/// Adds a save file name to the in-memory list and, on HTML5, to the index file.
function save_index_add(filename) {
	if (ds_list_find_index(global.save_files, filename) != -1) exit;
	ds_list_add(global.save_files, filename);

	if (os_browser != browser_not_a_browser) {
		var f = file_text_open_write(SAVE_INDEX_FILE);
		for (var i = 0; i < ds_list_size(global.save_files); i++) {
			file_text_write_string(f, global.save_files[| i]);
			file_text_writeln(f);
		}
		file_text_close(f);
	}
}
