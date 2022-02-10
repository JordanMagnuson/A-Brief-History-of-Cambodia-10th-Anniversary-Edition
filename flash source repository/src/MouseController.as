package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import flash.ui.Mouse;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.tweens.motion.LinearMotion;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Ease;
	
	/**
	 * ...
	 * @author ...
	 */
	public class MouseController extends Entity
	{
		public static const MIN_JERK_DIST:Number = 0;
		public static const MAX_JERK_DIST:Number = 15;
		
		public static const WATER_LINE:Number = Global.WATER_LINE + Global.FLOAT_LEVEL_VARIATION;
		
		public var handOpen:Image = new Image(Assets.HAND_CURSOR_OPEN);
		public var handClosed:Image = new Image(Assets.HAND_CURSOR_CLOSED);
		public var handOpenMask:Pixelmask = new Pixelmask(Assets.HAND_CURSOR_OPEN);
		
		public static var sndGrab:Sfx = new Sfx(Assets.SND_GRAB);
		public static var sndSplashUp:Sfx = new Sfx(Assets.SND_SPLASH_UP);
		public static var sndSplashDown:Sfx = new Sfx(Assets.SND_SPLASH_DOWN);
		public static var sndPlunge:Sfx = new Sfx(Assets.SND_WATER_PLUNGE);
		
		public static var preparingToJerk:Boolean = false;
		public static var jerking:Boolean = false;
		public static var jerkDuration:Number = 0.08;
		public static var jerkRadius:Number;
		public static var jerkAlarm:Alarm;
		public static var mover:LinearMotion;
		public static var lastY:Number = 0;
		
		public function MouseController() 
		{
			handOpen.centerOO();
			handClosed.centerOO();
			handOpenMask.x = -handOpen.width / 2;
			handOpenMask.y = -handOpen.height / 2;
			type = 'mouse_controller';
			layer = -1000;	
			
			setHitbox(16, 16, 8, 8);	
		}
		
		override public function added():void
		{
			Mouse.hide();
			x = FP.world.mouseX;
			y = FP.world.mouseY;
			
			jerkAlarm = new Alarm(1, jerkAway);	
			addTween(jerkAlarm);
		}	
		
		public function jerkAway():void
		{		
			preparingToJerk = false; 
			jerking = true;
			
			if (!Global.personGrabbed)
			{
				stopJerking();
				return;
			}
			
			if (Global.personGrabbed.health <= Global.MIN_HEALTH)
			{
				stopJerking();
				return;
			}
			
			// Release Bubble
			if (FP.random * jerkRadius > 2.5)
			{
				releaseBubble();
			}
			
			//if (Global.personGrabbed.health > Global.MIN_HEALTH)
			//{
				//jerkRadius = 100000 / Math.pow(Global.personGrabbed.health / 10, 5);
			//}
			if (Global.personGrabbed.health > Global.FADE_HEALTH)
			{
				jerkRadius = 100000 / Math.pow(Global.personGrabbed.health / 10, 5);
			}
			else
			{
				jerkRadius -= 4;	// 1.8
				
			}
			if (Math.abs(jerkRadius) > MAX_JERK_DIST)
				jerkRadius = MAX_JERK_DIST;			
			//trace('jerkRadius: ' + jerkRadius);
			var jerkX:Number = FP.random * jerkRadius * FP.choose(1, -1);
			var jerkY:Number = Math.sqrt(jerkRadius * jerkRadius - jerkX * jerkX) * -1;	// Always jerk upwards
			mover = new LinearMotion(jerkBack);
			addTween(mover);
			mover.setMotion(x, y, x + jerkX, y + jerkY, jerkDuration, Ease.bounceInOut);
		}
		
		public function jerkBack():void
		{
			preparingToJerk = false;
			jerking = true;
			
			mover = new LinearMotion(jerkAway);
			addTween(mover);
			mover.setMotion(x, y, FP.world.mouseX, FP.world.mouseY, jerkDuration, Ease.bounceInOut);			
			//if (jerkDuration > 0.05) 
			//{
				//jerkDuration -= 0.05;
			//}
			//if (jerkDuration < 0.05)
				//jerkDuration = 0.05;
		}
		
		public function stopJerking():void
		{				
			//trace('stop jerking');
			if (mover)
				mover.cancel();
			jerkAlarm.cancel();
			//FP.world.mouseX = x;
			//FP.world.mouseY = y;
			jerking = false;			
			preparingToJerk = false;
		}
		
		override public function update():void
		{
			// Position
			if (jerking && mover)
			{
				//trace('mover.x: ' + mover.x);
				x = mover.x;
				y = mover.y;
			}
			else 
			{
				x = FP.world.mouseX;
				y = FP.world.mouseY;
			}

			var overlapPerson:Person = collide('person', x, y) as Person;
			
			// Input
			if (overlapPerson && Input.mousePressed)
			{
				sndGrab.play(0.5);
				FP.world.add(Global.personGrabbed = new PersonGrabbed(overlapPerson.x, overlapPerson.y, overlapPerson.image.angle, overlapPerson.health, overlapPerson.maxHealth));
				overlapPerson.destroy();
			}	
			else if (Input.mouseReleased)
			{
				if (jerking)
					stopJerking();

				if (mover)
					mover.cancel();					
				
				if (Global.personGrabbed)
				{
					// Fall
					if (y <= Global.personGrabbed.floatLevel)
					{
						FP.world.add(new PersonFalling(Global.personGrabbed.x, Global.personGrabbed.y, Global.personGrabbed.image.angle, Global.personGrabbed.health, Global.personGrabbed.maxHealth));
					}
					// Swim
					else
					{
						var swimmer:PersonSwimming;
						FP.world.add(swimmer = new PersonSwimming(Global.personGrabbed.x, Global.personGrabbed.y, Global.personGrabbed.image.angle, Global.personGrabbed.health, Global.personGrabbed.maxHealth));
						swimmer.sndHeartbeat = Global.personGrabbed.sndHeartbeat;
					}
					Global.personGrabbed.destroy();
					Global.personGrabbed = null;
				}
			}
			
			// Icon
			if (Global.personGrabbed)
			{
				graphic = handClosed;
				//handClosed.alpha = 1;
				//handClosed.alpha = 0.5;
				
				// Plunge sound
				if (y > Global.personGrabbed.floatLevel + Global.FLOAT_LEVEL_VARIATION && lastY < Global.personGrabbed.floatLevel + Global.FLOAT_LEVEL_VARIATION)
				{
					trace('plunge');
					sndPlunge.play();
					sndSplashDown.play();
					sndSplashUp.play();
				}				
			}				
			else if (overlapPerson)
			{
				graphic = handOpen;
				//mask = handOpenMask;
				//handOpen.alpha = 1;
				//overlapPerson.image.color = Colors.BLOOD_RED;
			}
			else
			{
				graphic = handOpen;
				//mask = handOpenMask;
				//handOpen.alpha = 0.5;
			}
			
			// Jerking
			if (Global.personGrabbed && Global.personGrabbed.y > Global.personGrabbed.floatLevel + Global.FLOAT_LEVEL_VARIATION)
			{
				if (!jerking && !preparingToJerk)
				{
					if (Global.personGrabbed.health < Global.personGrabbed.maxHealth * 0.9)
					{
						//trace('start jerking');
						jerkAway();
					}
					else if (Global.personGrabbed.health > Global.MIN_HEALTH) 
					{
						trace('preparing to jerk');
						preparingToJerk = true;
						jerkAlarm = new Alarm(2, jerkAway);
						addTween(jerkAlarm);
						jerkAlarm.start();
						//jerkAway();						
					}
				}		
			}
			else if (jerking)
			{
				stopJerking();
			}
			
			if (Global.personGrabbed && y > Global.personGrabbed.floatLevel + Global.FLOAT_LEVEL_VARIATION)
			{
				(graphic as Image).alpha = Global.UNDERWATER_ALPHA;
			}
			else if (y > Global.WATER_LINE + Global.FLOAT_LEVEL_VARIATION)
			{
				(graphic as Image).alpha = Global.UNDERWATER_ALPHA;
			}
			else
			{
				(graphic as Image).alpha = 1;
			}
			
			// Last y
			lastY = y;
			
			super.update();
		}	
		
		public function releaseBubble():void
		{
			var xLoc:Number = x + FP.random * width * FP.choose(1, -1);
			var yLoc:Number = y - height - FP.random * height;
			FP.world.add(new Bubble(xLoc, yLoc));		
		}		
		
	}
}