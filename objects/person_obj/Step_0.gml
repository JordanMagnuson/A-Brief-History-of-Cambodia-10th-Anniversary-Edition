/// @description Insert description here
// You can write your code in this editor



if(x < 0)
{
	x = 0;
}
if (x > oCamera.view_width) 
{
	x = oCamera.view_width;	
}

if(object_index != PersonDrowning and GameController.gameOver == false && global.peopleKilled >= global.NUMBER_OF_PEOPLE - 1 && distance_to_object(global.MouseController) < global.scareDistance)
{
	show_debug_message("parant object triggered")
	instance_create_depth(x,y,depth,PersonDrowning) 

	instance_destroy();
}