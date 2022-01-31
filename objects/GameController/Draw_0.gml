if(draw)
{
	draw_sprite(game_start_spr, 0, 0, 0);
	draw_sprite(click_to_continue, 0, 400, 400);
}
else
{
	//set fadein alpha
	 a = alarm_get(0) / (room_speed * 10);
	 if(a > 0)
	 {
		 //draw black screen
		draw_set_color(c_black);
		draw_set_alpha(a);
		draw_rectangle(0, 0, 800, 600, false);
	 }
	 //reset draw alpha EACH STEP
	 draw_set_alpha(1);
}