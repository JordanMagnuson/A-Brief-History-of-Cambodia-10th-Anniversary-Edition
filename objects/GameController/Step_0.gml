//Continue on click
if(mouse_check_button_pressed(mb_left) and draw)
{
	//set image offscreen just in case
	x = room_width;
	draw = false;
	alarm_set(0, room_speed * 10);
}


if(gameOver and alarm_get(0) < 0 and !gameEnded)
{
	x = 0;
	draw = false;
	gameEnded = true;
	alarm_set(0, room_speed * 10);
}