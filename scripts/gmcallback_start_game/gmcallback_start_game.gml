function gmcallback_start_game() {
	// Calls the ToggleFullScreen javascript function defined by the ToggleFullScreen extension.
	// This will only work in direct response to a user click, so needs to be called via
	// the clickable_add() GML function. See oStartScreen.
	// Note that this must be a global script function, and must use the reserved name "gmcallback_NAME".
	// See https://forum.yoyogames.com/index.php?threads/html5-button-to-switch-to-fullscreen.18436/post-446787
	toggleFullscreen();
	room_goto_next();
}