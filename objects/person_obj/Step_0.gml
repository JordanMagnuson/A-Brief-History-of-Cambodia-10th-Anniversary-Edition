/// @description Insert description here
// You can write your code in this editor


if(x < 0)
{
	x = 0;
}
if (x > room_width) 
{
	x = room_width;	
}

if(global.peopleKilled >= global.NUMBER_OF_PEOPLE - 1 && distance_to_object(global.MouseController) < global.scareDistance)
{
	//var drown = instance_create_depth(x,y,depth,PersonDrowning) add person drowning object
	//drown.angle = image_angle;
	//drown.Health = Health;
	//drown.maxHealth = maxHealth;
	//drown.scale = scale;
	instance_destroy();
}