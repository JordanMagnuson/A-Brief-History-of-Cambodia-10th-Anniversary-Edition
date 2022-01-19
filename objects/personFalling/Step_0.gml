// Change to Swimmer
if (hitWater && v <= 0)
{
	changeToSwimmer();
}

// Fall
if (y <= floatLevel)
{
	if (v < V_MAX)
		v += a;
	else if (v > V_MAX)
		v = V_MAX;
					
	// Image angle
	image_angle += 1 * angleDir;
}
// Hit water
else 
{
	if (!hitWater)
	{
		hitWater = true;
		//sndSplashUp.play();
		//sndSplashDown.play();
		image_alpha = global.UNDERWATER_ALPHA;
	}
		v -= aWater;
}
y += v;