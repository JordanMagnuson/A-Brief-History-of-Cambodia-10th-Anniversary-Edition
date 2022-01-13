//Do movement if scared
if (scared)
{
	//how much time has passed, as a proportion of total time alloted
	var t = (timeToMove - alarm_get(0)) / timeToMove;
	
	if(t <= .5)
		x = initialX + xChange * (t * t * 2);	// Quadratic movement per FlashPunk
	else
		x = initialX + xChange * (1 - (t-1) * (t-1) * 2);	// Quadratic movement per FlashPunk
}

//Do breathing if floating
if(floating)
{
	bStep += bDuration;
	if(bStep > room_speed)
	{
		bStep = 0;
	}
	var t = bStep/room_speed;
	var scale = 1 + bScale * cos(pi * bDuration * t);
		
	image_xscale = scale;
	image_yscale = scale;
}

//Breathing when terrified
if(terrified)
{
	bScale = .25;
	bDuration = 1.5;
}
else
{
	bScale = .15;
	bDuration = .5;
}