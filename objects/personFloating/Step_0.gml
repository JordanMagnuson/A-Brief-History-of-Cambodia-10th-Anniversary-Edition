//Run Parent Step code
event_inherited();

//Do breathing
var t = (bDuration * room_speed - alarm_get(2)) / (bDuration * room_speed);
var scale = quadInOut(t, 1 - (bDir * bScale), 2*bScale, bDir);

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

//Breathing when terrified TODO: implement breath scale changes
if(terrified)
{
	bScale = .25;
	bDuration = .5;
}
else
{
	bScale = .1;
	bDuration = 3;
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
	x = quadInOut(t, initialX, xChange, 1);
}

var ty = ((FLOAT_DURATION*room_speed) - alarm_get(3)) / (FLOAT_DURATION * room_speed);
var tx = ((FLOAT_DURATION*room_speed*2) - alarm_get(4)) / (FLOAT_DURATION * room_speed*2);
x = quadInOut(tx, initX, floatX, 1);
y = quadInOut(ty, initY, floatY, 1);