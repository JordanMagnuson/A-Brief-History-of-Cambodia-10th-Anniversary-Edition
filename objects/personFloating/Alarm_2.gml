/// @description Breathe alarm

//if breathing out is finished, and breath needs to be reset
if(resetBreath and bDir < 0)
{
	bScaleChange();
}

//switch breathe direction
bDir = -bDir;

alarm_set(2, bDuration * room_speed);
