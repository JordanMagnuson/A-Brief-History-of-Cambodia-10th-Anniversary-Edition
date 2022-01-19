//Do movement if scared
if (scared and canBeScared)
{
	//how much time has passed, as a proportion of total time alloted
	var t = (timeToMove - alarm_get(0)) / timeToMove;
	
	if(t <= .5)
		x = initialX + xChange * (t * t * 2);	// Quadratic movement per FlashPunk
	else
		x = initialX + xChange * (1 - (t-1) * (t-1) * 2);	// Quadratic movement per FlashPunk
}

//Swim Up
if(alarm_get(2) <= 0)
{
	//if you hit the surface on the last movement, stop
	if(hitSurface)
	{
		changeToFloater();
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
if(t > .5)
{
	y = initY - yDist * (1 - (t-1) * (t-1) * 2);	// Quadratic movement per FlashPunk
	x = initX + xDist * (1 - (t-1) * (t-1) * 2);
}
else
{
	y = initY - yDist * (t * t * 2);	// Quadratic movement per FlashPunk
	x = initX + xDist * (t * t * 2);
}

