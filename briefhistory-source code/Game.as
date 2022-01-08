package briefhistory  
{
	import flash.utils.Dictionary;
	import kindnessofstrangers.Menu;
	import menu.CambodiaLanding;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import punk.transition.Transition;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class Game extends World
	{
		public static var sndWaves:Sfx = new Sfx(Assets.SND_WAVES);
		
		public function Game() 
		{
			resetGlobals();
		}
		
		public function resetGlobals():void
		{
			// Global variables
			Global.scareDistance = 20;
			Global.scareDistanceAfter = 80;
			Global.t = 0;							// Time elapsed since start of game
			Global.peopleKilled = 0;
			Global.startedShaking = false;
			Global.shakeAmount = 0.3;		
			Global.returningToMenu = false;
		
			// Global entities	
			Global.mouseController = null;
			Global.floatController = null;
			Global.personGrabbed = null;
			Global.bloodOverlay = null;
			Global.ambientController = null;
			Global.gameEndController = null;			
		}
		
		override public function begin():void
		{
			// Fade In
			add(new FadeIn(Colors.BLACK, 10, 5));
			
			// Background
			add(new Background);
			
			// Mouse controller
			add(Global.mouseController = new MouseController);
			
			// Waves
			addWaveController();
			FP.alarm(1, addWaveController);
			FP.alarm(2, addWaveController);
			FP.alarm(3, addWaveController);
			add(Global.floatController = new FloatController);
			
			// Place people
			placePeople();
			
			// Sound
			sndWaves.loop();
			add(Global.ambientController = new AmbientController);
			
			// Blood overlay
			add(Global.bloodOverlay = new BloodOverlay);
		}
		
		override public function update():void
		{
			//Global.t += FP.elapsed;
			
			// Return to menu
			if (Input.pressed(SuperGlobal.RETURN_KEY)) 
			{
				// Clear tweens (eg fading sounds, FP.alarm, etc.)
				FP.tweener.clearTweens();
				
				// Stop all sounds
				for each (var sfx:Sfx in SuperGlobal.soundsPlaying) {
					trace('another sound');
					if (sfx != null) sfx.stop();
				}
				
				// Empty sound tracker
				SuperGlobal.soundsPlaying = new Dictionary();
				
				// Return
				Transition.to(CambodiaLanding, new menu.Global.TRANS_OUT(menu.Global.TRANS_OUT_OPTIONS), new menu.Global.TRANS_IN(menu.Global.TRANS_IN_OPTIONS)); 	
			}		
			
			// Game end
			//if (typeCount('person') <= 0 && !Global.gameEndController)
			//{
				//trace('game over starting');
				//add(Global.gameEndController = new GameEndController);
			//}			
			
			super.update();
		}
		
		public function placePeople():void
		{
			var phaseDelay:Number = 0;
			var xPosArray:Array = new Array();
			for (var i:Number = 1; i <= Global.NUMBER_OF_PEOPLE; i++)
			{ 
				xPosArray.push(FP.random * FP.width);
			}	
			xPosArray.sort();
			for each (var xPos:Number in xPosArray)
			{ 
				var yPos:Number = Global.WATER_LINE + FP.random * Global.FLOAT_LEVEL_VARIATION;
				phaseDelay = xPos / Global.PHASE_DELAY_DIVIDER;
				trace('game add personFloating');
				add(new PersonFloating(xPos, yPos, phaseDelay));
				
			}			
			
		}
		
		public function addWaveController():void
		{
			add(new WaveController);
		}
		
	}

}