/// @description Insert description here
// You can write your code in this editor

FADE_IN_DURATION = 10;
started = false;
currentSound = noone;
newSound = noone;

function start()
{
	started = true;
	playSound();
}

function fadeOut(duration = 10)
{
	audio_sound_gain(currentSound,0,duration*1000);				
}
		
function playSpecificSound(sound)
{
	show_debug_message("playSpecificSound: " + string(sound));
	
	//if (alarm[0] != -1) alarm[0] = -1;
	if (currentSound != noone && audio_is_playing(currentSound)) {
		show_debug_message("currentSound " + string(currentSound) + " is playing. Fading out first.");
		//audio_stop_sound(currentSound);
		fadeOut();	
		//audio_stop_all();
	}
	currentSound = sound;
	audio_play_sound(currentSound,10,false);
	audio_sound_gain(currentSound,0,0)
	audio_sound_gain(currentSound,1,FADE_IN_DURATION * 1000)
}

function playSound()
{
	show_debug_message("playSound() called");
	if (global.peopleKilled >= global.NUMBER_OF_PEOPLE)
		return;
	
	do
	{
		randomize();
		newSound = choose(_hell_01,_hell_02,_hell_03_);
	}	until(newSound != currentSound);
	
	show_debug_message("playSound() randomly chooses:" + string(newSound));
	
	playSpecificSound(newSound);
	
	// Queue next sound.
	alarm[1] = (audio_sound_length(newSound) - FADE_IN_DURATION) * room_speed;
	var timer = (audio_sound_length(newSound) - FADE_IN_DURATION) * room_speed;
	show_debug_message("Setting alarm[1] to " + string(timer));
}

// LEGACY: no longer used.
//function fadeSpecificSound()
//{		
//	lastSound = currentSound;
//	startedFade = true;
//	audio_sound_gain(currentSound,0,FADE_IN_DURATION  * room_speed)	
//}

// LEGACY: no longer used.
//function fadeSound()
//{
//	lastSound = currentSound;
//	startedFade = true;
//	audio_sound_gain(currentSound,0,FADE_IN_DURATION  * room_speed)
//	alarm[1] = room_speed * FADE_IN_DURATION;
//}