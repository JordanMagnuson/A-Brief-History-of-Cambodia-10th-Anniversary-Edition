/// @description Insert description here
// You can write your code in this editor
if (started && audio_sound_get_track_position(currentSound) >= fadeOutPosition && !startedFade)
	{
		fadeSound();
	}