/// @description Insert description here
// You can write your code in this editor
if(state == 0)
{
	timer++;
	
		if(timer >= duration)
		{
			
			state = 1;	
		}
}
else if(state == 1)
{
		timer--;
	if(timer <= 0)
	{
		instance_destroy();
	}
}

alpha = timer / duration;