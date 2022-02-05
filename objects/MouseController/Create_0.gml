/// @description Insert description here
// You can write your code in this editor


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
	releaseBubble()
	
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
	
	if(random_range(0,1) * jerkRadius > 2.5)
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
	//Movement = instance_create_depth(x,y,depth,mover)
	//Movement.startmoving(x+jerkX,y+jerkY,jerkDuration)
	//alarm[3] = room_speed * jerkDuration
	//draw_sprite_ext(sprite_index,image_index,x+jerkX,y+jerkY,image_xscale,image_yscale,0,c_white,1)
	//needs more testing
}

function jerkBack()
{
	preparingToJerk = false;
	jerking = true;	
	move_towards_point(mouse_x,mouse_y,jerkDuration);
	Movement = noone;
	//begin moving jerkaway
}

function stopJerking()
{
	//cancel moving	
	alarm[1] = -1; //end alarm
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