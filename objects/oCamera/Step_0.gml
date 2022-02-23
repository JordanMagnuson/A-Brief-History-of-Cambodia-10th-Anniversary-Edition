// Provide automatic responsive fullscreen scaling for HTML5 target. 
// See https://www.yoyogames.com/blog/67/scaling-for-html5
if (last_browser_width != browser_width || last_browser_height != browser_height) {
	show_debug_message("window size change");
	last_browser_width = browser_width;
	last_browser_height = browser_height;	
	canvas_fullscreen(browser_width, browser_height);
}

// Unfollow, if follow object is destroyed.
if (!instance_exists(follow)) {
	follow = noone;
}

// Follow the follow object.
if (follow != noone) {
	x_to = follow.x;
	y_to = follow.y;
	
	// Option: follow "ahead" of the player--keep player at 1/4 view eight.
	// y_to = follow.y - view_height/4;
}

// Move towards x_to, y_to with easing.
// Note that this easing isn't perfect, and creates some jitter depending ont he value of camera_movement_lag.
// Might be better to replace all of this with a smoothstep implementation.
// See https://www.gmlscripts.com/script/smoothstep
// Or maybe even use GameMaker's built-in camera follow.
// See https://maddestudiosgames.com/gms2-meet-the-camera-system/#p3
x_mov = (x_to - x) / camera_movement_lag;
y_mov = (y_to - y) / camera_movement_lag;

if (abs(x_mov) < camera_movement_precision)
	x_mov = 0;
if (abs(y_mov) < camera_movement_precision)
	y_mov = 0;
	
//show_debug_message("x_mov: " + string(x_mov));
x += (floor(x_mov / camera_movement_precision)) * camera_movement_precision;
y += (floor(y_mov / camera_movement_precision)) * camera_movement_precision;

// Clamp to room bounds.
if (x < view_width / 2) {
	x = view_width / 2;
}
else if (x > room_width - view_width / 2) {
	x = room_width - view_width / 2;
}
if (y < view_height / 2) {
	y = view_height / 2;	
}
else if (y > room_height - view_height / 2) {
	y = room_height - view_height / 2;
}

// Move the camera to new position.
camera_set_view_pos(view_camera[target_view], x - view_width / 2, y - view_height / 2);