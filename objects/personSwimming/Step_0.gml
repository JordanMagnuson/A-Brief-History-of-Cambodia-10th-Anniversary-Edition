//Do movement if scared
if (scared and canBeScared)
{
	//how much time has passed, as a proportion of total time alloted
	var t = (timeToMove - alarm_get(0)) / timeToMove;
	x = quadInOut(t, initialX, xChange, 1);
}

//Swim Up
if(alarm_get(2) <= 0)
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

//how much time has passed, as a proportion of total time alloted
var t = (mt - alarm_get(2)) / mt;

x = quadInOut(t, initX, xDist, 1);
y = quadInOut(t, initY, yDist, -1);


if (Health > global.MIN_HEALTH)
{
	Health -= global.HEALTH_LOSS_RATE * 2;
}
else
{
	instance_create_depth(x,y,depth,PersonDrowning)
	//sndHeartbeat.stop();
	instance_destroy()
}
