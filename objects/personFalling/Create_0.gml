//Run Parent create code
event_inherited();

V_MAX = 100;
a = .1;			//accel	in air
aWater = .15;	//deccel in water
v = 0;			// velocity
hitWater = false;
angleDir = choose(-1, 1);


//Function for changing to swimmer when person hits the water
function changeToSwimmer()
{
	s = instance_create_depth(x, y, depth, personSwimming);
	s.image_angle = image_angle;
	instance_destroy(self);			
}