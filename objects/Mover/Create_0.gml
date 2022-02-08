/// @description Insert description here
// You can write your code in this editor

movingpath = noone;

xdestination = noone;
ydestination = noone;

function startmoving(xplot, yplot, duration)
{
	var temp = distance_to_point(xplot,yplot) / duration * room_speed
	xdestination = xplot
	ydestination = yplot
	move_towards_point(xplot,yplot,temp)
	alarm[0] = duration * room_speed
}