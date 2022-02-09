/// @description Insert description here
// You can write your code in this editor
	
	
if(keyboard_check(vk_escape))
{
	
	audio_stop_all()
	
	FadeTo(10,c_black)
	alarm[3] = room_speed * 10;
}


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