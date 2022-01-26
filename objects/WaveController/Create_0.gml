xVar = room_width/2;
yVar = 20;
currentWave = noone;
lastWave = noone;

function newWave()
{
	if(currentWave != noone)
	{
		lastWave = currentWave;
	}
	xPos = xVar - xVar + random(1) * (2 * xVar);
	yPos = global.WATER_LINE - yVar + random(1) * (2 * yVar);
	currentWave = instance_create_layer(xPos, yPos, layer, wave_obj);
	
	alarm_set(0, wave_obj.fadeDuration);
}


newWave();
