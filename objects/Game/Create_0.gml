/// @description Insert description here
// You can write your code in this editor



FadeTo(10,c_black)
ResetGlobals()

var temp = instance_create_depth(mouse_x,mouse_y,depth,MouseController)	
temp.added()


instance_create_depth(x,y,depth,WaveController)
alarm[0] = room_speed * 1;
alarm[1] = room_speed * 2;
alarm[2] = room_speed * 3;
instance_create_depth(x,y,depth,FloatController);


placePeople()



function placePeople()
{
	var phaseDelay = 0;
	var xPosArray = array_create(global.NUMBER_OF_PEOPLE)
	for (var i = 1; i <= global.NUMBER_OF_PEOPLE; i++)
{ 
	array_push(xPosArray, random_range(0,1) * room_width);
}	
	array_sort(xPosArray,false)
for (var xPos = 0; xPos <= xPosArray.length; xPos++)
{ 
	var yPos = global.WATER_LINE + random_range(0,1) * global.FLOAT_LEVEL_VARIATION;
	phaseDelay = xPos / global.PHASE_DELAY_DIVIDER;
	
	instance_create_depth(xPosArray[xPos],yPos,depth,personFloating)
				
}			
			
}

