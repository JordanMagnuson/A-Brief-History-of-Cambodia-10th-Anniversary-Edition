targetAlpha = 0;
currentAlpha = 0;
DURATION = 2;

function updateAlpha()
{
	targetAlpha = power(global.peopleKilled, .7)/10;
}