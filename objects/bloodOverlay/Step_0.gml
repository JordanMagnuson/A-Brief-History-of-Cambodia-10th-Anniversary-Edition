if(targetAlpha > currentAlpha)
{
	currentAlpha += 1/(DURATION * room_speed * 10);
	show_debug_message(currentAlpha);
}
