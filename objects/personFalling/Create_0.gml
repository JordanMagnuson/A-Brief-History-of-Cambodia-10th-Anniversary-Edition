//Run Parent create code
event_inherited();

V_MAX = 100;
a = .1;			//accel	in air
aWater = .15;	//deccel in water
v = 0;			// velocity
hitWater = false;
angleDir = irandom(1);
if(angleDir < 1)
	angleDir = -1;



function changeToSwimmer()
{
	instance_create_depth(x, y, depth, personFloating);	//TODO: Replace with personSwimming when completed
	instance_destroy(self);			
}