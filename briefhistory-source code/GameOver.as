package briefhistory  
{
	import flash.utils.Dictionary;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import punk.transition.Transition;
	import menu.CambodiaLanding;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GameOver extends World
	{
		
		public function GameOver() 
		{
			
		}
		
		override public function begin():void
		{
			add(new Curtain( -FP.width / 1.5, 0));
			add(new Entity(0, 0, new Image(Assets.END_SCREEN)));
			trace('now in game over');
		}		
		
		override public function update():void
		{
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
			
			super.update();
		}
		
	}

}