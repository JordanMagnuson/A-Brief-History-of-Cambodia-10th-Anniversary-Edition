targetAlpha = 0;
currentAlpha = 0;
DURATION = 2;

function updateAlpha()
{
	targetAlpha = power(global.peopleKilled, .7)/10;
	//ensure the target alpha never goes over expected
	if(targetAlpha > .46)
	{
		targetAlpha = .46;
	}
}