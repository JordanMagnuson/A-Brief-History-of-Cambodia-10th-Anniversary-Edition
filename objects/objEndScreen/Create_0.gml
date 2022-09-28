THING_NAME = "notgame";
CLICK_URL = "https://www.necessarygames.com/my-games/brief-history-cambodia?utm_source=in_game_link&utm_medium=html5_game&utm_campaign=brief_history_of_cambodia_game#disqus_thread";

function resize_end_screen() {
	var w = browser_width;
	var h = browser_height;
	last_browser_width = browser_width;
	last_browser_height = browser_height;

	// find screen pixel dimensions.
	// See browser_hdpi extension https://yellowafterlife.itch.io/gamemaker-html5-hdpi-support
	global.pixel_ratio = 1;
	global.browser_width_hdpi = w * global.pixel_ratio;
	global.browser_height_hdpi = h * global.pixel_ratio;
	show_debug_message("global.pixel_ratio: " + string(global.pixel_ratio));
	show_debug_message("global.browser_width_hdpi: " + string(global.browser_width_hdpi));
	show_debug_message("global.browser_height_hdpi: " + string(global.browser_height_hdpi));

	surface_width = global.browser_width_hdpi; //display_get_width();
	surface_height = global.browser_height_hdpi; //display_get_height();
	global.aspect_ratio = surface_width / surface_height;
	window_set_size(global.browser_width_hdpi, global.browser_height_hdpi);
	display_set_gui_size(global.browser_width_hdpi, global.browser_height_hdpi);

	// resize application_surface, if needed
	if (application_surface_is_enabled()) {
	    surface_resize(application_surface, global.browser_width_hdpi, global.browser_height_hdpi);
	}

	// set canvas size to page pixel size. Uncomment if using browser_hdpi extension.
	// browser_stretch_canvas(w, h);

	// Set GUI scale depending on window size.
	if (global.browser_height_hdpi < 300) {
		global.gui_scale = 1;
	}
	else if (global.browser_width_hdpi < 300 || global.browser_height_hdpi < 400) {
		global.gui_scale = 1.25;
	}
	else if (global.browser_width_hdpi < 600 || global.browser_height_hdpi < 550) {
		global.gui_scale = 1.5;
	}
	else if (global.browser_width_hdpi < 950 || global.browser_height_hdpi < 900) {
		global.gui_scale = 2;
	}
	else if (global.browser_width_hdpi < 1200 || global.browser_height_hdpi < 1200) {
		global.gui_scale = 3;
	}
	else {
		global.gui_scale = 4;
	}

	// Remove start button, because we will need to re-create it now that the screen has changed.
	if (os_browser != browser_not_a_browser) {
		if (follow_link && clickable_exists(follow_link)) {
			clickable_delete(follow_link);
			follow_link = 0;
		}
	}
	spr_follow_link = 0;

	//show_debug_message("browser_width: " + string(browser_width));
	//show_debug_message("browser_height: " + string(browser_height));
	//show_debug_message("global.aspect_ratio: " + string(global.aspect_ratio));
	//show_debug_message("global.gui_scale:" + string(global.gui_scale));	
}

x = 0;
y = 0;

// Fade in constants/variables.
show_thanks_txt = false;
thanks_txt_alpha = 0;
thanks_txt_fade_start = 0.1;
thanks_txt_fade_time = 7;
alarm[0] = thanks_txt_fade_start * room_speed;

show_follow_txt = false;
follow_txt_alpha = 0;
follow_txt_fade_start = 8;
follow_txt_fade_time = 7;
alarm[1] = follow_txt_fade_start * room_speed;

show_quit_txt = false;
quit_txt_alpha = 0;
quit_txt_fade_start = 12;
quit_txt_fade_time = 7;
alarm[2] = quit_txt_fade_start * room_speed;

allow_quit = false;
spr_follow_link = 0;
resize_end_screen();