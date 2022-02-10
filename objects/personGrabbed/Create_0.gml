/// @description Insert description here
// You can write your code in this editor
event_inherited();

fading = false;
dead = false;
angle = 0;
maxHealth = 100;

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
		//show_debug_message(string(Health))
		if(Health > global.MIN_HEALTH)
		{
			Health -= global.HEALTH_LOSS_RATE;	
		}
		
		if(Health > 52)
		{
			if(audio_is_playing(_heartbeat_32424) || audio_sound_get_gain(_heartbeat_32424) == 0)
			{
				var vol = clamp(Health,global.MIN_HEALTH,global.BASE_HEALTH)
				audio_play_sound(_heartbeat_32424,2,true)
				audio_sound_gain(_heartbeat_32424,1,6 * room_speed)
				audio_play_sound(_drowning,2,true)
				audio_sound_gain(_drowning,1,6 * room_speed)
			}
			
		}
		else if (Health > global.MIN_HEALTH && !fading)
		{
			fading = true;
			audio_stop_sound(_heartbeat_32424)
			audio_stop_sound(_drowning)
			audio_play_sound(_heartbeat_single,2,false)
		}
		else if (Health < global.MIN_HEALTH && !dead)
		{
			dead = true;
			Health = global.MIN_HEALTH - 1;
		}
	}
	else if(audio_is_playing(_heartbeat_32424)
	{
		audio_sound_gain(_heart_getting_faster_32424,0,1 * room_speed)	
		audio_stop_sound(_drowning)
	}
	
	
	//call person update	
}

function removed()
{
	//cancel heartbeet sound
	//cancel drowning sound
	//call person.remove function
	audio_stop_sound(_drowning)
	audio_stop_sound(_heartbeat_32424)
	instance_destroy();
}