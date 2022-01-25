/// @description Insert description here
// You can write your code in this editor
event_inherited();

fading = false;
dead = false;
angle = 0;
maxHealth = 100;
Health = 100;

x = 0;
y = 0;
health = 100;
visible = false;

//audio for sndDrowning

function added()
{
	//add drowning audio	
}


function update()
{
	if(global.returningToMenu)
		return;
		
	x = mouse_x;
	y = mouse_y;
	
	if( y > floatLevel + global.FLOAT_LEVEL_VARIATION)
	{
		if(Health > global.MIN_HEALTH)
		{
			Health -= global.HEALTH_LOSS_RATE;	
		}
		
		if(Health > 52)
		{
			//if statement for playing heartbeet sounds	
			
		}
		else if (Health > global.MIN_HEALTH && !fading)
		{
			fading = true;
			//audio for stopping heartbeat sound	
		}
		else if (Health < global.MIN_HEALTH && !dead)
		{
			dead = true;
			Health = global.MIN_HEALTH - 1;
		}
	}
	// else if heartbeat sound is playing then fade heartbeet away and stop drowning sound
	
	
	//call person update	
}

function removed()
{
	//cancel heartbeet sound
	//cancel drowning sound
	//call person.remove function
	instance_destroy();
}