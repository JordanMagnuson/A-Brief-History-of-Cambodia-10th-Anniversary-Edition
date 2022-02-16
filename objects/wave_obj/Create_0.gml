fadeDuration = room_speed * 3;
image_speed = 0;

//select a wave
image_index = choose(0, 1, 2);
image_alpha = 0;

//Set fade in alarm
dir = 1;
alarm_set(0, fadeDuration);


function quadInOut(t, initialVal, change, dir)
{
	if(t <= .5)
		return initialVal + dir * change * (t * t * 2);	// Quadratic movement per FlashPunk
	else
		return initialVal + dir * change * (1 - (t-1) * (t-1) * 2);	// Quadratic movement per FlashPunk
}