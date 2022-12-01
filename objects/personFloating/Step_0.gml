//Run Parent Step code
event_inherited();

//Do breathing
var t = (bDuration * room_speed - alarm_get(2)) / (bDuration * room_speed);
var scale = quadInOut(t, 1 - (bDir * bScale), 2*bScale, bDir);

image_xscale = scale;
image_yscale = scale;

//New Person Has been killed or terrified, can be scared by hand
if(global.peopleKilled >= global.DEAD_BEFORE_SCARE && distance_to_object(global.MouseController) < global.scareDistance)
{
	if(!terrified)
		terrify();
	if(!scared)
		scare();
}
else if(terrified and alarm_get(1) < 0)
{
	//show_debug_message("alarm to unterrify");
	//alarm_set(1, 1 * room_speed);
	
	//Set unterrify alarm
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
		case 5:
		case 6:
		case 7:
			//Never unterrify
			break;			
		default:
			alarm_set(1, 30 * room_speed);
			break;
	}
}

//Breathing when terrified
if(terrified)
{
	bScale = .3;
	bDuration = .5;
}

if(!scared and global.peopleKilled >= global.DEAD_BEFORE_ALWAYS_SACRED)
{
	scare();
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
	
	//reset floating vars
	initX = x;
	initY = y;
	floatX = 0;
	floatY = 0;
}
else if(floatDelay < 0)
{
	var ty = ((FLOAT_DURATION*room_speed) - alarm_get(3)) / (FLOAT_DURATION * room_speed);
	var tx = ((FLOAT_DURATION*room_speed*2) - alarm_get(4)) / (FLOAT_DURATION * room_speed*2);
	x = quadInOut(tx, initX, floatX, 1);
	y = quadInOut(ty, initY, floatY, 1);
	

	
	var ta = ((angleDur * room_speed) - (alarm_get(6) + alarm_get(7) + 1)) / (angleDur * room_speed);
	image_angle = quadInOut(ta, startAngle, angleChange, angleDir);
}
else
{
	//float Delay On Spawn
	floatDelay -= 1;
	if(floatDelay < 0)
	{
		floatXcalc();
	}
}

