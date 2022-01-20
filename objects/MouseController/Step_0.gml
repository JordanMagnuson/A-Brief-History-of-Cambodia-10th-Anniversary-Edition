

if(instance_exists(MouseController))
{
	window_set_cursor(cr_none);
	x = mouse_x;
	y = mouse_y;
	alarm[1] = room_speed * 1; //this is for 1 second, may need to be adjusted
}

//update status

if(jerking)
{
	x = x+jerkX;
	y = y + jerkY;
}
else
{
	x = mouse_x;
	y = mouse_y;
}

var overlapPerson = instance_place(x,y,person_obj);

if(overlapPerson != noone && mouse_check_button(mb_left))
{
	//play audio
	instance_create_depth(overlapPerson.x,overlapPerson.y,1,personGrabbed);
	instance_destroy(overlapPerson);
}
else if( mouse_check_button_released(mb_left))
{
	if(jerking)
	{
		stopJerking();	
	}
	if(speed > 0)
	{
		speed = 0;	
	}
	
	if(global.personGrabbed != noone)
	{
		
		if(y <= global.personGrabbed.floatLevel)
		{
			var temp = instance_create_depth(global.personGrabbed.x,global.personGrabbed.y,global.personGrabbed.depth,personFalling)
			temp.image_angle = global.personGrabbed.image_angle;
			temp.Health = global.personGrabbed.Health;
			temp.maxHealth = global.personGrabbed.maxHealth;
		}
		else
		{
			var swimmer = instance_create_depth(global.personGrabbed.x,global.personGrabbed.y,global.personGrabbed.depth,personSwimming);
			swimmer.image_angle = global.personGrabbed.image_angle;
			swimmer.Health = global.personGrabbed.Health;
			swimmer.maxHealth = global.personGrabbed.maxHealth;
		}
		instance_destroy(global.personGrabbed);
		global.personGrabbed = noone;
	}
}

//sprite change
if(global.personGrabbed != noone)
{
	sprite_index = 1; // closed hand sprite
	if (y > global.personGrabbed.floatLevel + global.FLOAT_LEVEL_VARIATION && lastY < global.personGrabbed.floatLevel + global.FLOAT_LEVEL_VARIATION)
	{
		//audio play for plunge sound	
	}
}
else if(overlapPerson != noone)
{
	sprite_index = 0; //open hand sprite
}
else
{
		sprite_index = 0; // two if statements check for this may not be needed
}

if (global.personGrabbed && global.personGrabbed.y > global.personGrabbed.floatLevel + global.FLOAT_LEVEL_VARIATION)
{
	if(!jerking && !preparingToJerk)
	{
		if (global.personGrabbed.Health < global.personGrabbed.maxHealth * 0.9)
		{
			jerkAway();
		}
		else if (global.personGrabbed.Health > global.MIN_HEALTH)
		{
			preparingToJerk = true;
			alarm[1] = room_speed * 2;
		}
	}
}
else if(jerking)
{
	stopJerking();	
}

if (global.personGrabbed && y > global.personGrabbed.floatLevel + global.FLOAT_LEVEL_VARIATION)
{
	image_alpha = global.UNDERWATER_ALPHA;
}
else if (y > global.WATER_LINE + global.FLOAT_LEVEL_VARIATION)
{
	image_alpha = global.UNDERWATER_ALPHA;
}
else
{
	image_alpha = 1;	
}

lastY = y;