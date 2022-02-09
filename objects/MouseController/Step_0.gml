


var overlapPerson = noone;

//update status
window_set_cursor(cr_none);
x = mouse_x;
	y = mouse_y;

if(jerking)
{
	//x = Movement.x
	//y = Movement.y
	//draw_self()
	
}
else
{
	x = mouse_x;
	y = mouse_y;
	
}

if(mouse_check_button_pressed(mb_left))
{
	overlapPerson = instance_place(x,y, person_obj);



	if(overlapPerson != noone )
	{
		sprite_index = hand_closed;
		//play audio
		global.personGrabbed = instance_create_depth(overlapPerson.x,overlapPerson.y,1,personGrabbed);
		//show_debug_message("object grabbed destroyed")
		//show_debug_message(string(global.personGrabbed.y) + "compared to: " + string(global.personGrabbed.floatLevel + global.FLOAT_LEVEL_VARIATION))
		global.personGrabbed.y = y;
		global.personGrabbed.x = x;
		global.personGrabbed.Health = overlapPerson.Health;
		instance_destroy(overlapPerson);
	}
}
else if( mouse_check_button_released(mb_left))
{
	
	if(jerking)
	{
		show_debug_message("stopped")
		stopJerking();	
		show_debug_message(string(preparingToJerk))
		show_debug_message(string(jerking))
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
		show_debug_message("object grabbed destroyed")
		instance_destroy(global.personGrabbed);
		global.personGrabbed = noone;
	}
}

//sprite change
if(global.personGrabbed != noone)
{
	//sprite_index = 1; // closed hand sprite
	if (y > global.personGrabbed.floatLevel + global.FLOAT_LEVEL_VARIATION && lastY < global.personGrabbed.floatLevel + global.FLOAT_LEVEL_VARIATION)
	{
		//audio play for plunge sound	
	}
}
else if(overlapPerson != noone)
{
	sprite_index = mouse_hand;
}
else
{
	sprite_index = mouse_hand;
}



if (global.personGrabbed != noone && global.personGrabbed.y > (global.personGrabbed.floatLevel + global.FLOAT_LEVEL_VARIATION))
{
	show_debug_message(string(global.personGrabbed.Health))
	//show_debug_message(string(preparingToJerk))
	//show_debug_message(string(jerking))
	
	if(!jerking && !preparingToJerk)
	{
		
		if (global.personGrabbed.Health < global.personGrabbed.maxHealth * 0.9)
		{
			show_debug_message("jerking away")
			jerkAway();
		}
		else if (global.personGrabbed.Health > global.MIN_HEALTH)
		{
			preparingToJerk = true;
			alarm[1] = room_speed * 2;
			//jerkAway()
		}
	}
}
else if(jerking)
{
	show_debug_message("stopped")
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
