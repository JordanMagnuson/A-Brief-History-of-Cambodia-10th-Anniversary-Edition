//Run Parent create code
event_inherited();


mt = -1;


SWIM_SPEED = 70;

hitSurface = false;
scared = false;
timeToMove = -1;
initialX = -1;
canBeScared = false;

alarm_set(1, room_speed);	//Delay before Person can be scared
image_alpha = global.UNDERWATER_ALPHA;


//Function to change swimmer to floater upon reaching surface
function changeToGasper()
{
	s = instance_create_depth(x, y, depth, personGasping);
	s.image_angle = image_angle;
	s.Health = Health
	s.maxHealth = maxHealth
	//slash up sound
	audio_play_sound(_robinhood76_01260_water_swimming_splashing_1_edited_fading, 1, false);
	
	instance_destroy(self);			
}

