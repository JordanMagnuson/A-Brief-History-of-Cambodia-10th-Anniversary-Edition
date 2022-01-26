//Run Parent Step code
event_inherited();

//Do breathing
bStep += bDuration;
if(bStep > room_speed)
{
	bStep = 0;
}
var t = bStep/room_speed;
var scale = 1 + bScale * cos(pi * bDuration * t);
		
image_xscale = scale;
image_yscale = scale;

//New Person Has been killed
if(deadSoFar < global.peopleKilled and distance_to_object(global.MouseController) < global.scareDistance or keyboard_check_pressed(vk_space))
{
	deadSoFar = global.peopleKilled;
	//Terrify Person, set unterrify alarm
	switch(global.peopleKilled)
	{
		case 0:
			alarm_set(1, 5 * room_speed);
			break;
		case 1:
			alarm_set(1, 8 * room_speed);
			break;
		case 2:
			alarm_set(1, 12 * room_speed);
			break;
		case 3:
			alarm_set(1, 15 * room_speed);
			break;
		case 4:
			alarm_set(1, 20 * room_speed);
			break;
		//Never unterrify
		default:
			break;
	}
	terrify();
	scare();
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

if(shaking)
{
	x += choose(shakeAmount, -shakeAmount);
	y += choose(shakeAmount, -shakeAmount);
}

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