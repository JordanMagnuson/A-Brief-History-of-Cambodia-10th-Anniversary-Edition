/// @description Insert description here
// You can write your code in this editor
event_inherited()

V_MAX = 0.5;
MIN_BUBBLES = 2;
MAX_BUBBLES = 4;

 drowning = false;
 
angleDirection = choose(-1,1)

a = 0.001;
v = 0

bubblesToRelease = MIN_BUBBLES + irandom(MAX_BUBBLES - MIN_BUBBLES + 1);

bubblesReleased = 0

image_alpha = global.UNDERWATER_ALPHA

function playSound()
{
	audio_play_sound(_gabemiller74_breathofdeath,2,false)
}



function startDrowning()
{
	drowning = true;
	global.peopleKilled += 1;
	alarm[0] = room_speed * 1.5;
	alarm[1] = room_speed * 1.5
	global.bloodOverlay.updateAlpha();	
	
	global.scareDistance = global.peopleKilled * 20;		
	global.scareDistanceAfter = global.scareDistance * 4;
	alarm[2] = room_speed * 2
			
	// Ambient sounds
	if (global.peopleKilled == 1 && !audio_is_playing(_hell_01))
	{
		global.ambientController.playSpecificSound(_hell_01);
	}	
	else if (global.peopleKilled == 2 && !!audio_is_playing(_hell_02))
	{
		global.ambientController.playSpecificSound(_hell_02);
	}		
	else if (global.peopleKilled == 3 && !audio_is_playing(_hell_03_))
		{
			global.ambientController.playSpecificSound(_hell_03_);
		}	
		else if (global.peopleKilled >= 4 && !global.ambientController.started)
		{
			global.ambientController.start();
		}					
}


function terrifyEveryone()
{
	var personList = array_create(instance_number(personFloating))

	for(var i = 0; i < instance_number(personFloating);i++)
	{
		personList[i] = instance_find(personFloating,i)	
	}

	// Finally, we can loop through the array and call each Enemy's die() function.
	for(var p = 0; p < array_length(personList);p++)
	{
		var temp = personList[p]
		temp.delayedTerrify(random_range(0,1))
	}
}


 function destroy()
{
	// Stop sounds
	//if (drowningFader) drowningFader.cancel();
	//if (sndDrowning.playing) sndDrowning.stop();
			
	// Game end
	//if (true)
	if ( instance_number(person_obj) && global.peopleKilled >= global.NUMBER_OF_PEOPLE && !global.gameEndController)
	{
		instance_create_depth(5,5,depth,GameController)
	}
	instance_destroy()
			
}


function playDrowningSound()
{
			audio_play_sound(_drowning,2,false);
			audio_sound_gain(_drowning,0,6  * room_speed);
		
}


function releaseBubble()
{
	if (bubblesReleased < bubblesToRelease)
	{
		var xLoc = x + random_range(0,1) * sprite_width / 2 * choose(1, -1);
		var yLoc = y - sprite_height - random_range(0,1) * sprite_height;
		instance_create_depth(xLoc,yLoc,depth,bubbles)	
		alarm[0] = room_speed * 2
		bubblesReleased += 1;
	}
}
		
alarm[3] = room_speed * .5
alarm[4] = room_speed * 1;