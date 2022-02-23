/// @description Insert description here
// You can write your code in this editor
depth = 0;


MIN_JERK_DIST = 0;
MAX_JERK_DIST = 15;


WATER_LINE = global.WATER_LINE + global.FLOAT_LEVEL_VARIATION;

//handopen sprite index 0
//handclosed sprite index 1
//handopemask sprite

//sound effects go here


Movement = noone
preparingToJerk = false;
jerking = false;
jerkDuration = 0.08;
jerkRadius = noone;
alarm[1] = room_speed;
alarm[0] = room_speed;
lastY = 0;
jerkX = noone;
jerkY = noone;


//constructor will be taken care of in sprite settings

function added()
{
		alarm[1] = room_speed * 1
	
}


function jerkAway()
{
	show_debug_message("jerk function")
	preparingToJerk = false;
	jerking = true;
	
	if(!global.personGrabbed)
	{
			//stopJerking();
			return;
	}
	if(global.personGrabbed.Health <= global.MIN_HEALTH)
	{
		//stopJerking();
		return;
	}
	
	if(irandom_range(0,1) * jerkRadius > 2.5)
	{
		show_debug_message("bubbles")
		releaseBubble()
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
	
	var len = sqrt((jerkX * jerkX + jerkY * jerkY));
	move_towards_point(x+jerkX,y+jerkY, len/(jerkDuration * room_speed))
	alarm[3] = room_speed * jerkDuration
	
}

function jerkBack()
{
	preparingToJerk = false;
	jerking = true;
	var len = sqrt((jerkX * jerkX + jerkY * jerkY));
	move_towards_point(mouse_x,mouse_y, len/(jerkDuration * room_speed))
	alarm[4] = room_speed * jerkDuration
	//begin moving jerkaway
}

function stopJerking()
{
	//cancel moving	
	alarm[3] = -1
	alarm[4] = -1
	alarm[1] = -1; //end alarm
	instance_destroy(Movement)
	Movement = noone;
	jerking = false;			
	preparingToJerk = false;
	
	//speed = 0; //stop movement speed of object
	
}

function releaseBubble()
{
	var xLoc = x + random_range(0,1) * sprite_width * choose(1,-1);
	var yLoc = y - sprite_height - random_range(0,1) * sprite_height;
	instance_create_depth(xLoc,yLoc,depth,bubbles)
	
}

jerkAway()