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
	for (var i = 1; i <= global.NUMBER_OF_PEOPLE; i++)
	{ 
		var xPos = random(1) * room_width;
		var yPos = global.WATER_LINE + random(1) * global.FLOAT_LEVEL_VARIATION;
		var phaseDelay = xPos / global.PHASE_DELAY_DIVIDER;
	
		var p = instance_create_depth(xPos,yPos,depth,personFloating);
		p.floatDelay = phaseDelay * room_speed;
	}			
}


placePeople();

global.ambientController = instance_create_depth(x,y,depth,AmbientController)
global.bloodOverlay = instance_create_depth(x,y,depth,bloodOverlay)