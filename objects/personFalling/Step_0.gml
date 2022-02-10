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
		audio_play_sound(_robinhood76_01260_water_swimming_splashing_1_edited_fading,2,false)
		audio_play_sound(_splash_down_,2,false);
		image_alpha = global.UNDERWATER_ALPHA;
	}
		v -= aWater;
}
y += v;