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