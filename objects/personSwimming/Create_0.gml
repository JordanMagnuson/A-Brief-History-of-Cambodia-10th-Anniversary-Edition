//Run Parent create code
event_inherited();


mt = -1;


SWIM_SPEED = 70;

hitSurface = false;
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
	instance_destroy(self);			
}
