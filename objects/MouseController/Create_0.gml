/// @description Insert description here
// You can write your code in this editor


MIN_JERK_DIST = 0;
MAX_JERK_DIST = 15;


WATER_LINE = global.WATER_LINE + global.FLOAT_LEVEL_VARIATION;

//handopen sprite index 0
//handclosed sprite index 1
//handopemask sprite

//sound effects go here



preparingToJerk = false;
jerking = false;
jerkDuration = 0.08;
jerkRadius = noone;
jerkAlarm = alarm[1];
lastY = 0;
jerkX = noone;
jerkY = noone;


//constructor will be taken care of in sprite settings

function jerkAway()
{
	preparingToJerk = false;
	jerking = true;
	
	if(!global.personGrabbed)
	{
			//stopJerking();
			return;
	}
	if(global.personGrabbed.Health <= Global.MIN_HEALTH)
	{
		//stopJerking();
		return;
	}
	
	if(random_range(0,1) * jerkRadius > 2.5)
	{
		//releasebubble	
	}
	
	if(global.personGrabbed.Health > global.FADE_HEALTH)
	{
		jerkRadius = 100000 / power(global.personGrabbed.Health / 10, 5); 	
	}
	else
	{
		jerkRadius -= 4;	//1.8 ?
	}
	if( abs(jerkRadius) > MAX_JERK_DIST)
	{
		jerkRadius = MAX_JERK_DIST;	
	}
	jerkX = random_range(0,1) * jerkRadius * choose(-1,1);
	jerkY = sqrt(jerkRadius * jerkRadius - jerkX * jerkX) * -1;
	//mover
	//begin moving
	move_towards_point(x + jerkX, y + jerkY,jerkDuration); //this might work as a translation of flash punk linear motion
	//needs more testing
}

function jerkBack()
{
	preparingToJerk = false;
	jerking = true;	
	move_towards_point(mouse_x,mouse_y,jerkDuration);
	
	//begin moving jerkaway
}

function stopJerking()
{
	//cancel moving	
	alarm[1] = -1; //end alarm
	jerking = false;			
	preparingToJerk = false;
	speed = 0; //stop movement speed of object
	
}

function releaseBubble()
{
	var xLoc = x + random_range(0,1) * sprite_width * choose(1,-1);
	var yLoc = y - sprite_height - random_range(0,1) * sprite_height;
	//add new bubble (object not yet created
	
}