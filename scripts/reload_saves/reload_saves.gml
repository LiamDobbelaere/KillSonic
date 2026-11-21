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
	// Names that differ only in case count as the same save: Windows treats
	// "boss1" and "BOSS1" as one file. On HTML5 (case-sensitive storage) an
	// older lowercase save may exist; point its entry at the file just written
	// so the new save is the one that gets listed and loaded (= overwrite).
	var found = false;
	for (var j = 0; j < ds_list_size(global.save_files); j++) {
		if (string_upper(global.save_files[| j]) == string_upper(filename)) {
			if (global.save_files[| j] == filename) exit;   // already listed exactly
			global.save_files[| j] = filename;
			found = true;
			break;
		}
	}
	if (!found) ds_list_add(global.save_files, filename);

	if (os_browser != browser_not_a_browser) {
		var f = file_text_open_write(SAVE_INDEX_FILE);
		for (var i = 0; i < ds_list_size(global.save_files); i++) {
			file_text_write_string(f, global.save_files[| i]);
			file_text_writeln(f);
		}
		file_text_close(f);
	}
}

/// Cleans a typed save name so it is a valid file name on every platform:
/// keeps A-Z, 0-9, space, _ and -, uppercases it (the font only has capitals
/// and Windows file names ignore case), trims it and caps it at 20 characters.
function save_name_clean(raw) {
	var out = "";
	var src = string_upper(raw);
	for (var i = 1; i <= string_length(src); i++) {
		var c = string_char_at(src, i);
		if ((c >= "A" && c <= "Z") || (c >= "0" && c <= "9") || c == " " || c == "_" || c == "-") {
			out += c;
		}
	}
	// trim spaces
	while (string_length(out) > 0 && string_char_at(out, 1) == " ") out = string_delete(out, 1, 1);
	while (string_length(out) > 0 && string_char_at(out, string_length(out)) == " ") out = string_delete(out, string_length(out), 1);
	if (string_length(out) > 20) out = string_copy(out, 1, 20);
	return out;
}

/// Save name for display (no ".boss" extension: the font has no "." glyph)
function save_name_display(filename) {
	var n = filename;
	var l = string_length(n);
	if (l > 5 && string_lower(string_copy(n, l - 4, 5)) == ".boss") n = string_copy(n, 1, l - 5);
	return n;
}

/// Is there already a save with this name (any letter case)?
function save_name_taken(filename) {
	for (var j = 0; j < ds_list_size(global.save_files); j++) {
		if (string_upper(global.save_files[| j]) == string_upper(filename)) return true;
	}
	return file_exists(filename);
}

/// True while the save or load dialog is open (blocks workshop hotkeys)
function workshop_dialog_open() {
	return instance_exists(objSaveInput) || instance_exists(objLoadSelection);
}
