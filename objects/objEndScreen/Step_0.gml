if (last_browser_width != browser_width || last_browser_height != browser_height) {
	resize_end_screen();
}

if (show_thanks_txt && thanks_txt_alpha < 1)
	thanks_txt_alpha += 1/(thanks_txt_fade_time*room_speed);
	
if (show_follow_txt && follow_txt_alpha < 1)
	follow_txt_alpha += 1/(follow_txt_fade_time*room_speed);	
	
if (show_quit_txt && quit_txt_alpha < 1)
	quit_txt_alpha += 1/(quit_txt_fade_time*room_speed);	
	

// HTML5 clickable (for follow link).
if (os_browser != browser_not_a_browser && spr_follow_link && show_follow_txt) {
	// Note that because of a bug in clickable_add, the clickable that is generated is sometimes larger than the sprite.
	// This means that if we're adding fullscreen clickable, we get ugly scroll bars in the browser window.
	// To combat this, when we package the game we need to add "overflow: hidden" to the body tag in index.html.	
	if (!follow_link || !clickable_exists(follow_link)) {
		window_set_cursor(cr_handpoint);
		//var url = "https://www.necessarygames.com/my-games-link";
		follow_link = clickable_add(0, 0, sprite_get_tpe(spr_follow_link, 0), CLICK_URL, "_blank", "");
	}	
}

if (allow_quit) {	
	if (keyboard_key_press(vk_anykey) || mouse_check_button_pressed(mb_any)) {
		if (os_browser == browser_not_a_browser) {
			game_end();
		}
	}
}