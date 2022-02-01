/// @description Insert description here
// You can write your code in this editor

movingpath = noone;


function startmoving(xplot, yplot, duration)
{
	movingpath = path_add()
	var Speed = distance_to_point(xplot,yplot) / room_speed * duration;
	path_add_point(movingpath,x,y,100)
	path_add_point(movingpath,xplot,yplot,100)
	path_start(movingpath,room_speed,path_action_reverse,true)
	
	
}