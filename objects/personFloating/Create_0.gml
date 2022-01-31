//Run Parent create code
event_inherited();

//Breathing-related vars
bScale = .15;	//inhale/exhale scale limits
bDuration = .5;	//time in seconds for breath to take
bDir = 1;		// breathe in or out
alarm_set(2, bDuration * room_speed);

//terrify-related vars
shaking = false;
shakeAmount = global.shakeAmount;
deadSoFar = 0;	//total amount of killed person objects

//floating-related vars
MIN_ANGLE_CHANGE = 0;
MAX_ANGLE_CHANGE = 30;
MIN_FLOAT_X = 0;
MAX_FLOAT_X = 40;
MIN_FLOAT_Y = 10;
MAX_FLOAT_Y = 60;
FLOAT_DURATION = 3;
floatYDir = 1;
floatXDir = 0;
floatX = 0;
floatY = 0;
initX = 0;
initY = 0;
angleChange = 0;
maxY = y + 10;
minY = y - MAX_FLOAT_Y - 10;



function terrify()
{
		show_debug_message("terrified");
		terrified = true;
		shaking = true;
		shakeAmount = global.peopleKilled / global.NUMBER_OF_PEOPLE;
		bScale = 0.3;
		bDuration = 0.5;	
}

function unterrify()
{
	shaking = false;
	terrified = false;
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
	show_debug_message(floatY);
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
		show_debug_message(floatXDir);
	}
	
	floatYcalc();
	initX = x;
	initY = y;
	alarm_set(3, FLOAT_DURATION * room_speed);
	alarm_set(4, FLOAT_DURATION * room_speed * 2);
}

floatXcalc();

