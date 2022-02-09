/// @description Insert description here
// You can write your code in this editor
	
	
if(keyboard_check(vk_escape))
{
	
	audio_stop_all()
	
	gameending = true;
	var ending = instance_find(GameController,0)
	ending.gameOver = true
}


if(!gameending)
{
	if audio_system_is_available()
	    {
	    if audio_is_paused(_pcaeldries_tide_23454)
	        {
	        audio_resume_sound(_pcaeldries_tide_23454)
	        }
	    else
	        {
	        if !audio_is_playing(_pcaeldries_tide_23454)
	            {
				audio_play_sound(_pcaeldries_tide_23454, 1, true);
	            }
	        }
	   }
}