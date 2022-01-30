// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ResetGlobals(){
	
	global.scareDistance = 20;
	global.scareDistanceAfter = 80;
	global.t = 0;							// Time elapsed since start of game
	global.peopleKilled = 0;
	global.startedShaking = false;
	global.shakeAmount = 0.3;		
	global.returningToMenu = false;
		
			// Global entities	
	global.mouseController = noone;
	global.floatController = noone;
	global.personGrabbed = noone;
	global.bloodOverlay = noone;
	global.ambientController = noone;
	global.gameEndController = noone;			

}