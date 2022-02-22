/// @description Insert description here
// You can write your code in this editor
FadeTo(10,c_black)
ResetGlobals()
gameending = false;
var temp = instance_create_depth(mouse_x,mouse_y,-1,MouseController)	
temp.added()


instance_create_depth(x,y,depth,WaveController)
alarm[0] = room_speed * 1;
alarm[1] = room_speed * 2;
alarm[2] = room_speed * 3;
instance_create_depth(x,y,depth,floatcontroller);

// Camera
instance_create_depth(0,0, -1, oCamera);



function placePeople()
{
	var phaseDelay = 0;
	var xPosArray = array_create(8)
	for (var i = 1; i <= 8; i++)
{ 
	array_push(xPosArray, random_range(0,1) * room_width);
}	
	array_sort(xPosArray,false)
for (var xPos = 0; xPos < 8; xPos++)
{ 
	var yPos = global.WATER_LINE + random_range(0,1) * global.FLOAT_LEVEL_VARIATION;
	phaseDelay = xPos / global.PHASE_DELAY_DIVIDER;
	
	var p = instance_create_depth(xPosArray[xPos],yPos,depth,personFloating);
	p.floatDelay = (phaseDelay * room_speed)*room_speed;
				
}			
			
}


placePeople()

global.ambientController = instance_create_depth(x,y,depth,AmbientController)
global.bloodOverlay = instance_create_depth(x,y,depth,bloodOverlay)