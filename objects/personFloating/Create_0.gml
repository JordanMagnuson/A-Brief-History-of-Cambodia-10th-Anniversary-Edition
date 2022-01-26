//Run Parent create code
event_inherited();

//Breathing-related vars
bScale = .15;	//inhale/exhale scale limits
bDuration = .5;	//time in seconds for breath to take
bDir = 1;		// breathe in or out
bStep = 0;		//timestep
alarm_set(2, bDuration * room_speed);

//terrify-related vars
shaking = false;
shakeAmount = global.shakeAmount;

deadSoFar = 0;



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
