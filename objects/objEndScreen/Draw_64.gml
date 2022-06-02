//draw_sprite(sStartScreen,0,0,0);

// Turn global linear interpolation (anti-aliasing) off for pixel-font text.
gpu_set_texfilter(false);

// Set up text drawing.
draw_set_color(c_white);
draw_set_font(fnt04b03);
fnt_scale = 2;
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_alpha(thanks_txt_alpha); 

vs = floor(surface_height / 10);

// Title
xx = surface_width/2;
yy = surface_height/3;

var title = "Thanks for playing.";
string_h = global.gui_scale * fnt_scale * string_height(title);	
draw_text_transformed(xx, yy, title, global.gui_scale*fnt_scale, global.gui_scale*fnt_scale, 0);
draw_set_alpha(1);

// Follow link
if (!spr_follow_link) {
	// Create start button sprite from surface.
	surf = surface_create(surface_width, surface_height);
	surface_set_target(surf);
	yy = surface_height * 2/3;

	var instructions = "Click ";
	if (global.is_touch_device) {
		instructions = "Touch ";
	}	
	//if (global.aspect_ratio < 1 || global.browser_width_hdpi < 900)	{
	//	instructions += "the screen to explore \nmore of my games.";
	//}
	//else {
	//	instructions += "the screen to explore more of my games.";
	//}
	if (global.aspect_ratio < 1 || global.browser_width_hdpi < 900)	{
		instructions += "the screen to leave a \ncomment about this " + string(THING_NAME) + ".";
	}
	else {
		instructions += "the screen to leave a \ncomment about this " + string(THING_NAME) + ".";
	}	
	
	
	draw_text_transformed(xx, yy, instructions, global.gui_scale*fnt_scale, global.gui_scale*fnt_scale, 0);
	//var string_w = global.gui_scale * string_width(instructions);
	follow_txt_h = global.gui_scale * fnt_scale * string_height(instructions);	
	quit_txt_yy = yy + follow_txt_h;
	// Use draw_rectangle to create border around text.
	//draw_rectangle(xx - string_w/2, yy - string_h/2, xx + string_w/2, yy + string_h/2,true);
	draw_set_color(c_green);
	//draw_rectangle(0, 0, browser_width, surface_height,true);	
	spr_follow_link = sprite_create_from_surface(surf,0,0,surface_width,surface_height,false,false,0,0);
	surface_reset_target();
	surface_free(surf);
}

draw_sprite_ext(spr_follow_link,0,0,0,1,1,0,c_white,follow_txt_alpha);


// Quit text.
quit_txt = "";
yy += follow_txt_h;
draw_set_alpha(quit_txt_alpha); 
if (global.aspect_ratio < 1 || global.browser_width_hdpi < 900)	{
	if (!global.is_touch_device) {
		if (os_browser != browser_not_a_browser) {
			quit_txt += "\n\nOr close your \nbrowser to quit."
		}
		else {
			quit_txt += "\n\nOr press Esc to quit."
		}
	}
}
else {
	if (!global.is_touch_device) {
		if (os_browser != browser_not_a_browser) {
			quit_txt += "\n\nOr close your browser to quit."
		}
		else {
			quit_txt += "\n\nOr press Esc to quit."
		}
	}
}	
draw_text_transformed(xx, quit_txt_yy, quit_txt, global.gui_scale*fnt_scale, global.gui_scale*fnt_scale, 0);
draw_set_alpha(1);




// Turn global linear interpolation (anti-aliasing) back on.
gpu_set_texfilter(true);