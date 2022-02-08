//Float up and down
var ty = ((FLOAT_DURATION*room_speed) - alarm_get(0)) / (FLOAT_DURATION * room_speed);
y = quadInOut(ty, initY, GASP_FLOAT_DISTANCE, upDown);



//Do breathing
var t = (bDuration * room_speed - alarm_get(2)) / (bDuration * room_speed);
var scale = quadInOut(t, 1 - (bDir * bScale), 2*bScale, bDir);

image_xscale = scale;
image_yscale = scale;


//healing
if(Health < 100)
{
	Health += global.HEALTH_GAIN_RATE;
}
else if (!healthyAgain)
{
	healthyAgain = true;
	Health = maxHealth;
	alarm_set(1, getFloaterDelay() * room_speed);
}
if(image_angle != 90)
{
	if (image_angle > 90)
		image_angle -= 1;
	else
		image_angle += 1;
}

