
floatLevel = global.WATER_LINE + random_range(0,1) * global.FLOAT_LEVEL_VARIATION;



terrified = false;

//Breathing-related vars
floating = true;
bScale = .15;	//inhale/exhale limits
bDuration = .5;	//breathes per second
bStep = 0;		//timestep

// Params: none
// Returns: none
// Description: moves instance away from player
scared = false;	//	Boolean for scared
initialX = -1;	//	the initial x value when scared
xChange = -1;	//	the amount the instance is going to move
timeToMove = -1;//	the amound of frames it will take to move
function scare()
{
	show_debug_message(string(id) + ": scared");
	//Make person scared
	scared = true;
	
	//calculate the distance the person will move
	xChange = global.MIN_SCARED_MOVE + random(1) * (global.MAX_SCARED_MOVE - global.MIN_SCARED_MOVE);
	
	//move to the left if mouse it to the right
	if(x < global.MouseController.x)
	{
		xChange *= -1;
	}
	//swap directions if moving would make instance leave room
	if((x + xChange > room_width) or (x + xChange < 0))
	{
		xChange *= -1;
	}
	
	//the time it takes the person to move to the desired point (in frames)
	timeToMove = room_speed * (distance_to_point(x + xChange, y)/global.SCARE_MOVE_SPEED);
	initialX = x;
	
	//set alarm to unscare when done
	alarm_set(0, timeToMove);
	
}