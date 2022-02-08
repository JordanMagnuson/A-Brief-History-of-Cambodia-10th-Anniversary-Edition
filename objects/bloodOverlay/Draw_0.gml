draw_set_alpha(currentAlpha);
draw_set_color(c_red);
draw_rectangle(0, 0, room_width, room_height, false);


//reset draw alpha EACH STEP
draw_set_alpha(1);
