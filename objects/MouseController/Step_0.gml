

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
			
	}
}