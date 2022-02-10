image_angle = 90; //needs to be set for future angle changes

var temp = depth;
depth = 1;
depth = round(temp);

floatLevel = global.WATER_LINE + random_range(0,1) * global.FLOAT_LEVEL_VARIATION;

bDir = 1;
Health = 100;
maxHealth = 100;
scale = 1; //this value may not be needeed

minY = noone; //null values
maxY = noone;

terrified = false;



scared = false;	//	Boolean for scared
initialX = -1;	//	the initial x value when scared
xChange = -1;	//	the amount the instance is going to move
timeToMove = -1;//	the amound of frames it will take to move

function scare()
{
	show_debug_message("scared");
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


function quadInOut(t, initialVal, change, dir)
{
	if(t <= .5)
		return initialVal + dir * change * (t * t * 2);	// Quadratic movement per FlashPunk
	else
		return initialVal + dir * change * (1 - (t-1) * (t-1) * 2);	// Quadratic movement per FlashPunk
}