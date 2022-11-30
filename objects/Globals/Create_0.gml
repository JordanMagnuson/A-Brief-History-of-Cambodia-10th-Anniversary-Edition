/// @description Init Global Variables
// You can write your code in this editor



// Constants
global.WATER_LINE = 100;
global.FLOAT_LEVEL_VARIATION = 40;
global.NUMBER_OF_PEOPLE = 8;
global.PHASE_DELAY_DIVIDER = 200;
global.UNDERWATER_ALPHA = 0.4;

global.enteredalarm = 0;

//global.PERSON_WIDTH = 10;		//Replaced with
//global.PERSON_HEIGHT = 10;	//10 by 10 sprite

global.BASE_HEALTH = 100;
global.HEALTH_VARIATION = 25;
global.MIN_HEALTH = 50;
global.FADE_HEALTH = 60;
global.HEALTH_LOSS_RATE = 0.06 * (30/room_speed);	// Should be room_speed dependent; original set for 30 FPS.
global.HEALTH_GAIN_RATE = 0.12 * (30/room_speed);

global.BREATH_SCALE_MIN = 0.8;
global.BREATH_SCALE_MAX = 1.2;

global.MIN_SCARED_MOVE = 40;
global.MAX_SCARED_MOVE = 80;
global.SCARE_MOVE_SPEED = 100;
global.DEAD_BEFORE_SCARE = 1;
global.DEAD_BEFORE_ALWAYS_SACRED = 5;

// Global variables
global.scareDistance = 20;
global.scareDistanceAfter = 80;
global.t = 0;
global.peopleKilled = 0;
global.startedShaking = false;
global.shakeAmount = 0.3;
global.returningToMenu = false;

// Global entities - these will display as values until objs are created
global.MouseController = MouseController;
//global.floatController = FloatController;
global.personGrabbed = noone;
//global.bloodOverlay = bloodOverlay;
//global.ambientController = AmbientController;
//global.gameEndController = GameEndController;