//Do movement if scared
if (scared and canBeScared)
{
	//how much time has passed, as a proportion of total time alloted
	var t = (timeToMove - alarm_get(0)) / timeToMove;
	x = quadInOut(t, initialX, xChange, 1);
}

//Swim Up
if(alarm_get(2) < 0)
{
	//if you hit the surface on the last movement, stop
	if(hitSurface)
	{
		changeToGasper();
	}
	initY = y;
	initX = x;
	xDist = choose(-5, 5);
	yDist = 80;
	if (yDist > (y - floatLevel + 10))
	{
		yDist = y - floatLevel + 10;
		hitSurface = true;
	}

//the time it takes the person to move to the desired point (in frames)
	 mt = room_speed * (distance_to_point(x+xDist, y+yDist)/SWIM_SPEED);
	alarm_set(2, mt);
}

//scare
if(distance_to_object(global.MouseController) < global.scareDistance)
{
	if(!scared and canBeScared)
		scare();
}

if (scared)
{
	//how much time has passed, as a proportion of total time alloted
	var t = (timeToMove - alarm_get(0)) / timeToMove;
	x = quadInOut(t, initialX, xChange, 1);
}

if(!audio_is_playing(_heart_getting_faster_32424))
{
	audio_play_sound(_heart_getting_faster_32424,2,true)
}

//health loss
if (Health > global.MIN_HEALTH)
{
	Health -= global.HEALTH_LOSS_RATE * 2;
}
else
{
	instance_create_depth(x,y,depth,PersonDrowning)
	audio_stop_sound(_heart_getting_faster_32424)
	instance_destroy()
}

//how much time has passed, as a proportion of total time alloted
var t = (mt - alarm_get(2)) / mt;
if(mt > 0)
{
	if(!scared)
	{
		x = quadInOut(t, initX, xDist, 1);
	}
	else
		initX = x;
	y = quadInOut(t, initY, yDist, -1);
}

//shake
shakeAmount = 1 - ((Health-global.MIN_HEALTH) / (maxHealth - global.MIN_HEALTH));
x += choose(shakeAmount, -shakeAmount);
y += choose(shakeAmount, -shakeAmount);




