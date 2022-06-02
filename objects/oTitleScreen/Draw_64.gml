//draw_sprite(sStartScreen,0,0,0);

// Turn global linear interpolation (anti-aliasing) off for pixel-font text.
gpu_set_texfilter(false);

var h1_size = 4;
var h2_size = 3;
var h3_size = 2;

// Debug.
//if (global.DEBUG) {
//	draw_sprite(sprDebug, 0, 64, 64);
//	draw_sprite(sprDebug, 0, surface_width - 64, 64);
//	draw_sprite(sprDebug, 0, surface_width- 64, surface_height - 64);
//	draw_sprite(sprDebug, 0, 64, surface_height - 64);
//}

// Set up text drawing.
draw_set_color(c_white);
draw_set_font(fnt04b03);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_alpha(1); 

vs = surface_height / 32;

// Title
xx = surface_width/2;
yy = surface_height/4;
if (global.browser_width_hdpi < 1000)
	var title = "A BRIEF HISTORY\nOF CAMBODIA";
else
	var title = "A BRIEF HISTORY OF CAMBODIA";
string_h = global.gui_scale * h1_size * string_height(title);	
draw_text_transformed(xx, yy, title, h1_size * global.gui_scale, h1_size * global.gui_scale, 0);

// By line
//draw_set_font(fntVerdana);
yy += string_h + vs;
if (global.browser_width_hdpi < 750)
	var byline = "A " + string(THING_NAME) + "\nby Jordan Magnuson";
else
	var byline = "A " + string(THING_NAME) + " by Jordan Magnuson";
draw_text_transformed(xx, yy, byline, h3_size * global.gui_scale, h3_size * global.gui_scale, 0);

// By line 2
yy += 24*global.gui_scale;
var byline2 = "Phnom Penh, 2011";
draw_text_transformed(xx, yy, byline2, h3_size * global.gui_scale, h3_size * global.gui_scale, 0);

// Instructions
yy += 32*global.gui_scale;
draw_set_color(c_white);
if (global.browser_width_hdpi < 600)
	var instructions = "";
else
	var instructions = "";
draw_text_transformed(xx, yy, instructions, h3_size * global.gui_scale, h3_size * global.gui_scale, 0);
draw_set_color(c_white);

// Start button
if (!spr_start_button) {
	//sScreen = sprite_create_from_surface(application_surface,0,0,surface_width,surface_height,false,false,0,0);
	
	// Create start button sprite from surface.
	surf_start_button = surface_create(surface_width, surface_height);
	//sw = surface_get_width(surf_start_button);
	//sh = surface_get_height(surf_start_button);	
	surface_set_target(surf_start_button);
	yy += 64*global.gui_scale;
	start_text = "CLICK TO START";
	if (global.is_touch_device) {
		start_text = "TOUCH TO START";
	}
	draw_set_color(c_white);
	draw_text_transformed(xx, yy, start_text, global.gui_scale*h2_size, global.gui_scale*h2_size, 0);	
	draw_set_color(c_white);
	string_w = global.gui_scale*h2_size * string_width(start_text);
	string_h = global.gui_scale*h2_size * string_height(start_text);	
	yy += string_h;
	draw_text_transformed(xx, yy, "(FULLSCREEN)", global.gui_scale*h3_size, global.gui_scale*h3_size, 0);	
	
	// Use draw_rectangle to create border around text.
	//draw_set_color(c_yellow);
	//draw_rectangle(0,0,sw,sh,true);
	//draw_rectangle(1,1,sw-1,sh-1,true);
	//draw_rectangle(2,2,sw-2,sh-2,true);	
	spr_start_button = sprite_create_from_surface(surf_start_button,0,0,surface_width,surface_height,false,false,0,0);
	surface_reset_target();
	surface_free(surf_start_button);
}

draw_sprite(spr_start_button,0,0,0);

// Turn global linear interpolation (anti-aliasing) back on.
//gpu_set_texfilter(true);
draw_set_halign(fa_left);