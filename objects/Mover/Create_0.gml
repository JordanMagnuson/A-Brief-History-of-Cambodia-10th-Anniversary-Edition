/// @description Insert description here
// You can write your code in this editor


function moveTo(startx, starty, travelTime)
{
		//convert to path functions instead of move towards point, currently
		//will not stop as the jerk function stops calling this function before it can
		//reach the else statement
		show_debug_message(distance_to_point(startx,starty))
		if(distance_to_point(startx,starty) > travelTime)
		{
			move_towards_point(startx,starty,travelTime)
		}
		else
		{
			show_debug_message("destroyed mover")
			instance_destroy()
			speed = 0;
		}
		
}