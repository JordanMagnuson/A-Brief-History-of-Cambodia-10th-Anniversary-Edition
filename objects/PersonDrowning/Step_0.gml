/// @description Insert description here
// You can write your code in this editor
event_inherited()

if (drowning)
{
	if (y > room_height + sprite_height)
	{	
		show_debug_message("drowner deleted")
		destroy()
	}
					
	if (v < V_MAX)
		v += a;
	else if (v > V_MAX)
		v = V_MAX;
					
		y += v;
		Health -= v / 10;
		image_angle += 0.1 * angleDirection;
}