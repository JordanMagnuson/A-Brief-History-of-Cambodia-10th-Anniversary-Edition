event_inherited(); 

GASP_FLOAT_DISTANCE  = 10;

upDown = -1;
initY = y;
		
MIN_FLOAT_X  = 0;			
MAX_FLOAT_X  = 0;	// 20	
MIN_FLOAT_Y  = GASP_FLOAT_DISTANCE;		
MAX_FLOAT_Y  = GASP_FLOAT_DISTANCE;
FLOAT_DURATION  = 1;	// Used INSTEAD of FLOAT_SPEED, depending on which you want to be constant

alarm_set(0, FLOAT_DURATION * room_speed);
		
MIN_ANGLE_CHANGE  = 0;
MAX_ANGLE_CHANGE  = 0;


bDuration = 0.5;
bScale = 0.3;
bDir = 1;
alarm_set(2, bDuration * room_speed);

shakeAmount = global.shakeAmount;

healthyAgain = false;

//sound

alarm[0] = room_speed;

Health = 100;
maxHealth = 100;

function playGaspingSound()
{
	//audio for gasping	
}

function getFloaterDelay()
{
	var phaseDelay = 0;
	if(instance_exists(personFloating))
	{
		var p = instance_find(personFloating, 0);
		var percent = p.x / (p.x + real(p.floatX));
		
		//p is to the left
		if(p.x < x)
		{
			if(p.floatYDir < 0)
			{
				phaseDelay = (x - p.x) / global.PHASE_DELAY_DIVIDER + (1 - percent) * 3 + 3;
			}
			else
			{
				phaseDelay = (x - p.x) / global.PHASE_DELAY_DIVIDER + (1 - percent) * 3;
			}
		}
		//p is to the right
		else
		{
			phaseDelay = (1 - percent) * 3 + 4 - (p.x - x) / global.PHASE_DELAY_DIVIDER;
			while (phaseDelay < 0)
			{
				phaseDelay += 4;
				show_debug_message("adding 4 seconds");
			}
		}
	}
	return phaseDelay + 12; // == phase delay + 4*personFloating.float_duration
}

function changeToFloater()
{
	floater = instance_create_depth(x, y, depth, personFloating);
	floater.bDuration = bDuration;
	floater.bScale = bScale;
	floater.image_xscale = image_xscale;
	floater.image_yscale = image_yscale;
	floater.terrify();
	floater.shakeAmount = shakeAmount;
	floater.Health = Health;
	floater.maxHealth = maxHealth
	show_debug_message("personGasping to personFloating");
	instance_destroy(self);
}


alarm_set(1, getFloaterDelay() * room_speed);