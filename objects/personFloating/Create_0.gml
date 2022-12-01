//Run Parent create code
event_inherited();

//Breathing-related vars
HEALTHY_BREATH_SCALE = .1;
HEALTHY_BREATH_DURATION = 3;
BREATH_SCALE_CHANGE = .01;
BREATH_DURATION_CHANGE = .1;
resetBreath = false;
bScale = .15;	//inhale/exhale scale limits
bDuration = 3;	//time in seconds for breath to take
bDir = 1;		// breathe in or out
alarm_set(2, bDuration * room_speed);

//terrify-related vars
shaking = false;
shakeAmount = global.shakeAmount;

//floating-related vars
MIN_ANGLE_CHANGE = 0;
MAX_ANGLE_CHANGE = 30;
MIN_FLOAT_X = 0;
MAX_FLOAT_X = 40;
MIN_FLOAT_Y = 10;
MAX_FLOAT_Y = 60;
FLOAT_DURATION = 3;
floatDelay = 0;
floatYDir = 1;
floatXDir = 0;
floatX = 0;
floatY = 0;
initX = 0;
initY = 0;
maxY = y + 10;
minY = y - MAX_FLOAT_Y - 10;



//Initialize Angle Changes
startAngle = image_angle;
angleChange = MIN_ANGLE_CHANGE + random(1) * (MAX_ANGLE_CHANGE - MIN_ANGLE_CHANGE);
angleDur = FLOAT_DURATION + floatX / 50;
angleDir = 1;
show_debug_message(angleDur)
alarm_set(6, angleDur * room_speed);



function terrify()
{
		show_debug_message("terrified");
		image_xscale = 1;
		image_yscale = 1;
		terrified = true;
		shaking = true;
		shakeAmount = global.peopleKilled / global.NUMBER_OF_PEOPLE;
		bScale = 0.3;
		bDuration = 0.5;
		alarm_set(2, bDuration * room_speed);
}

function unterrify()
{
	shaking = false;
	terrified = false;
	resetBreath = true;
}


function delayedTerrify(delay)
{
if (delay == 0)
{
	terrify();	
}
else
{
	alarm[5] = room_speed * delay
}			
}


function floatYcalc()
{	
	//Select a y-value to "float" to
	floatY = -floatYDir * (MIN_FLOAT_Y + random(1) * (MAX_FLOAT_Y - MIN_FLOAT_Y));
	if (y + floatY < minY)
	{
		//too high
		floatY = y - minY;
	}
	else if (y + floatY > maxY)
	{
		//too low
		floatY = maxY - y;
	}
	initY = y;
}

function floatXcalc()
{
	//Select an x-value to "float" to
	floatXDir = choose(-1, 1);
	floatX = MIN_FLOAT_X + random(1) * (MAX_FLOAT_X - MIN_FLOAT_X);
	floatX = floatX * floatXDir;
	var	limitCheck = x + 2 * floatX;
	if(limitCheck < 0 or limitCheck > room_width)
	{
		floatXDir = -floatXDir;
		floatX = -floatX;
	}
	
	floatYcalc();
	initX = x;
	initY = y;
	alarm_set(3, FLOAT_DURATION * room_speed);
	alarm_set(4, FLOAT_DURATION * room_speed * 2);
}

function bScaleChange()
{
	if (bScale > HEALTHY_BREATH_SCALE)
		bScale -= BREATH_SCALE_CHANGE;
	else	
		bScale = HEALTHY_BREATH_SCALE;
		
	if (bDuration < HEALTHY_BREATH_DURATION)
		bDuration += BREATH_DURATION_CHANGE;	
	else
		bDuration = HEALTHY_BREATH_DURATION;
				
	// Reset shaking as well
	if (shakeAmount > 0)
		shakeAmount -= 0.05;
	else
		shakeAmount = 0;
}


