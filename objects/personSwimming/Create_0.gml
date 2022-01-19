//Run Parent create code
event_inherited();

SWIM_SPEED = 70;

hitSurface = false;
canBeScared = false;
alarm_set(1, room_speed);

image_alpha = global.UNDERWATER_ALPHA;

function changeToFloater()
{
	s = instance_create_depth(x, y, depth, personFloating);
	s.image_angle = image_angle;
	instance_destroy(self);			
}
