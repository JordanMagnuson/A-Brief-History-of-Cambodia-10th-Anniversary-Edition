//Continue on click
//Fade In
if(mouse_check_button_pressed(mb_left) and draw)
{
	//set image offscreen just in case
	x = room_width;
	draw = false;
	alarm_set(0, room_speed * 10);
}

//Fade Out
if(gameOver and alarm_get(0) < 0 and !gameEnded)
{
	x = 0;
	draw = false;
	gameEnded = true;
	alarm_set(0, room_speed * 10);
}

//Swap rooms and fade in
if(gameOver and alarm_get(0) < 0 and gameEnded and room != room_last)
{
	alarm_set(0, room_speed * 10)
	room_goto_next();
}