// Draw blood overlay.
draw_set_alpha(currentAlpha);
draw_set_color($0303a7);
draw_rectangle(0, 0, room_width, room_height, false);

// Draw the fade-to-black gradient.
draw_set_alpha(1);
draw_sprite_ext(sprGradient, 0, 0, 0, 1, 1, 0, c_white, 1);

// Fill the rest of the screen black.
draw_set_color(c_black);
draw_rectangle(0, room_height, oCamera.view_width, oCamera.view_height, false);

// Reset draw alpha and color.
draw_set_alpha(1);
draw_set_color(c_white);