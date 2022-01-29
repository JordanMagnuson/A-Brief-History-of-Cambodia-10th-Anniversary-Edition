/// @description Insert description here
// You can write your code in this editor
event_inherited()


if (distance_to_object(MouseController) < global.scareDistance && !scared)
{
		scare();
}	

x += choose(shakeAmount, -shakeAmount);
y += choose(shakeAmount, -shakeAmount);

if (Health < maxHealth)
{
	Health += global.HEALTH_GAIN_RATE;
}
else if (!healthyAgain)
{
healthyAgain = true;
Health = maxHealth;
var floatDelay = getFloaterDelay();
alarm[0] = room_speed * floatDelay
}