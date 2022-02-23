/// @description Insert description here
// You can write your code in this editor


FADE_IN_DURATION = 10;
FADE_IN_DURATION = FADE_IN_DURATION * delta_time
fadeOutPosition = noone;

started = false;
startedFade = false;
currentSound = noone;
lastSound = noone;

 function start()
{
	//started = true;
	playSound();
}

function fadeOut( duration = 10)
{
	
	audio_sound_gain(currentSound,0,duration * room_speed)				
}
		
function playSpecificSound(sound)
{
	if (alarm[0] != -1) alarm[0] = -1;
	if (currentSound != noone && audio_is_playing(currentSound))audio_stop_sound(currentSound);			
			
	currentSound = sound;
	fadeOutPosition = audio_sound_length(currentSound);
	fadeOutPosition = fadeOutPosition - FADE_IN_DURATION;
	audio_play_sound(currentSound,10,true)
	audio_sound_gain(currentSound,0,0)
	audio_sound_gain(currentSound,1,FADE_IN_DURATION  * room_speed)
			
			// Set fade out
	var fadeTime = audio_sound_length(currentSound) - FADE_IN_DURATION;
	alarm[0] = fadeTime * room_speed
}

function fadeSpecificSound()
{		
			
	lastSound = currentSound;
	startedFade = true;
	audio_sound_gain(currentSound,0,FADE_IN_DURATION  * room_speed)	
}


function playSound()
{
if (global.peopleKilled >= global.NUMBER_OF_PEOPLE)
	return;
				
if (alarm[0] != -1) alarm[0] = -1;
if (currentSound != noone && audio_is_playing(currentSound))audio_stop_sound(currentSound);			

startedFade = false;

do
{
	randomize()
	currentSound = choose(_hell_01,_hell_02,_hell_03_)
}	until(audio_is_playing(lastSound) != currentSound)
	
	fadeOutPosition = audio_sound_length(currentSound);
	fadeOutPosition = fadeOutPosition ;
	audio_play_sound(currentSound,10,true)
	audio_sound_gain(currentSound,0,0)
	audio_sound_gain(currentSound,1,FADE_IN_DURATION  * room_speed)
}



function fadeSound()
{
	
	lastSound = currentSound;
	startedFade = true;
	audio_sound_gain(currentSound,0,FADE_IN_DURATION  * room_speed)
	alarm[1] = room_speed * FADE_IN_DURATION;
}