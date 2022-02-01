xVar = room_width/2;
yVar = 20;
currentWave = noone;
lastWave = noone;

function newWave(alarm)
{
	if(currentWave != noone)
	{
		lastWave = currentWave;
	}
	xPos = random(1) * (2 * xVar);
	yPos = global.WATER_LINE - yVar + random(1) * (2 * yVar);
	currentWave = instance_create_depth(xPos, yPos,depth, wave_obj);
	
	alarm_set(alarm, currentWave.fadeDuration);
}



newWave(0);
newWave(1);
newWave(2);
