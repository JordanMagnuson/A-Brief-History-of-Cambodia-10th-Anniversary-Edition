/// @description fade alarm
alarm_set(0, fadeDuration);

//if faded out is complete
if(dir == -1)
{
	instance_destroy();
}

dir = -1;

