window_set_cursor(cr_none)

// Rmove start button clickable (which starts the game in fullscreen mode in HTML5).
if (variable_global_exists("start_button") && clickable_exists(global.start_button)) {
	clickable_delete(global.start_button);
}