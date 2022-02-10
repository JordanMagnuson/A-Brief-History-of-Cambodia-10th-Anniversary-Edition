package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.tweens.misc.AngleTween;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.tweens.motion.LinearMotion;
	import net.flashpunk.tweens.motion.Motion;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Ease;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class PersonFloating extends Person
	{
		public static const MIN_FLOAT_X:Number = 0;			
		public static const MAX_FLOAT_X:Number = 40;	// 20	
		public static const MIN_FLOAT_Y:Number = 10;		
		public static const MAX_FLOAT_Y:Number = 60;
		public static const HANG_TIME:Number = 0; 	// Time at top of wave, before floating back down
		//public const FLOAT_SPEED:Number = 14;
		public static const FLOAT_DURATION:Number = 3;	// Used INSTEAD of FLOAT_SPEED, depending on which you want to be constant
		
		public static const HEALTHY_BREATH_DURATION:Number = 3;		// 3
		public static const HEALTHY_BREATH_SCALE:Number = 0.1;		// 0.1
		public static const BREATH_SCALE_CHANGE:Number = 0.01;
		public static const BREATH_DURATION_CHANGE:Number = 0.1;		
		
		public static const MIN_ANGLE_CHANGE:Number = 0;
		public static const MAX_ANGLE_CHANGE:Number = 30;
		
		public var floatXDirection:Number;
		public var floatX:Number;
		public var floatY:Number;
		public var angleChange:Number;
		public var breathDuration:Number = 3;
		public var breathScale:Number = 0.1;		
		
		public var mover:LinearMotion;
		public var angleChanger:AngleTween;
		public var scaleChanger:NumTween;
	
		public var phaseDelay:Number;
		
		public var unterrifyAlarm:Alarm;
		public var resetBreath:Boolean = false;
		
		public function PersonFloating(x:Number = 0, y:Number = 0, phaseDelay:Number = 0) 
		{
			super(x, y);
			//type = 'person_floating';
			this.phaseDelay = phaseDelay;
			
			this.maxY = y + 10;
			this.minY = y - MAX_FLOAT_Y - 10;		
		}
		
		override public function added():void
		{
			FP.alarm(FP.random * breathDuration, breatheIn);
			if (phaseDelay > 0) 
			{
				FP.alarm(phaseDelay, floatUp);
			}
			else 
			{
				floatUp();
			}
		}
		
		override public function update():void
		{	
			// Scare
			if (Global.peopleKilled >= Global.DEAD_BEFORE_SCARE && FP.distance(x, y, Global.mouseController.x, Global.mouseController.y) < Global.scareDistance)
			{
				if (!scared) 
					scare();
				if (!terrified)
					terrify();
			}
			// Unterrify
			else if (terrified)
			{
				switch (Global.peopleKilled)
				{
					case 0:
						unterrifyAlarm = new Alarm(5, unterrify);
						break;
					case 1:
						unterrifyAlarm = new Alarm(8, unterrify);
						break;			
					case 2:
						unterrifyAlarm = new Alarm(12, unterrify);
						break;	
					case 3:
						unterrifyAlarm = new Alarm(15, unterrify);
						break;	
					case 4:
						unterrifyAlarm = new Alarm(20, unterrify);
						break;							
					case 5:
					case 6:
					case 7:						
						// Never unterrify
						//unterrifyAlarm = new Alarm(20, unterrify);
						break;								
					default:
						unterrifyAlarm = new Alarm(30, unterrify);
						break;											
				}
				addTween(unterrifyAlarm, true);	
				terrified = false;
			}
			
			// TODO: This right here is messed up
			if (!scared && Global.peopleKilled >= Global.DEAD_BEFORE_ALWAYS_SACRED)			
			{
				trace('forced scare');
				scare();
			}
			
			// Position
			if (mover && scaredMover && scared)
			{
				x = scaredMover.x;
				y = mover.y;
			}			
			else if (mover) 
			{
				x = mover.x;
				y = mover.y;
			}
			x += FP.choose(shakeAmount, -shakeAmount);
			y += FP.choose(shakeAmount, -shakeAmount);				
			
			// Angle
			if (angleChanger) 
			{
				image.angle = angleChanger.angle;
			}
			
			// Scale
			if (scaleChanger) 
			{
				image.scale = scaleChanger.value;
			}			
			super.update();
		}
		
		public function terrify():void
		{
			trace('terrify');
			if (unterrifyAlarm) unterrifyAlarm.cancel();
			terrified = true;
			shaking = true;
			shakeAmount = FP.scaleClamp(Global.peopleKilled, 0, Global.NUMBER_OF_PEOPLE, 0, 1);
			resetBreath = false;
			breathScale = 0.3;
			breathDuration = 0.5;				
			if (scaleChanger) scaleChanger.cancel();
			if (breathDirection == 1) breatheIn();
			else breatheOut();		
		}
		
		public function delayedTerrify(delay:Number = 0):void
		{
			if (delay == 0)
			{
				terrify();	
			}
			else
			{
				FP.alarm(delay, terrify);
			}			
		}
		
		public function unterrify():void
		{
			trace('unterrify');
			//breathScale = HEALTHY_BREATH_SCALE;
			//breathDuration = HEALTHY_BREATH_DURATION;		
			resetBreath = true;
			shaking = false;
		}
		
		override public function scaredMoverCallback():void
		{
			trace('scared mover callback');
			if (FP.distance(x, y, Global.mouseController.x, Global.mouseController.y) < Global.scareDistanceAfter)
			{
				scare();
			}
			else
			{		
				if (mover) mover.cancel();
				scared = false;
				//mover.x = x;
				if (y > floatLevel)
					floatUp();
				else
					floatDown();
				//scared = false;
			}
		}
		
		public function breatheIn():void
		{
			//trace('breathe in');
			breathDirection = 1;
			scaleChanger = new NumTween(breatheOut);
			addTween(scaleChanger);
			scaleChanger.tween(image.scale, 1 + breathScale, breathDuration, Ease.quadInOut);	
		}
		
		public function breatheOut():void
		{			
			//trace('breathe out');
			breathDirection = -1;
			scaleChanger = new NumTween(breatheIn);
			addTween(scaleChanger);
			scaleChanger.tween(image.scale, 1 - breathScale, breathDuration, Ease.quadInOut);	
			
			if (resetBreath)
			{
				if (breathScale > HEALTHY_BREATH_SCALE)
					breathScale -= BREATH_SCALE_CHANGE;
				else	
					breathScale = HEALTHY_BREATH_SCALE;
				if (breathDuration < HEALTHY_BREATH_DURATION)
					breathDuration += BREATH_DURATION_CHANGE;	
				else
					breathDuration = HEALTHY_BREATH_DURATION;
				
				// Reset shaking as well
				if (shakeAmount > 0)
					shakeAmount -= 0.05;
				else
					shakeAmount = 0;
			}
		}		
		
		public function floatUp():void
		{
			scared = false;
			
			floatXDirection = FP.choose(-1, 1);
			floatX = MIN_FLOAT_X + FP.random * (MAX_FLOAT_X - MIN_FLOAT_X);
			floatX = floatX * floatXDirection;
			if (x + 2 * floatX < 0 || x + 2 * floatX > FP.width)
			{
				floatXDirection *= -1;
				floatX *= -1;
			}
			floatY = -1 * (MIN_FLOAT_Y + FP.random * (MAX_FLOAT_Y - MIN_FLOAT_Y));
			if (y + floatY < minY)
			{
				trace('too high');
				floatY = y - minY;
			}
			//var duration:Number = floatY / FLOAT_SPEED;
			var duration:Number = FLOAT_DURATION + floatX / Global.PHASE_DELAY_DIVIDER;
			mover = new LinearMotion(floatUpCallback);
			addTween(mover);
			mover.setMotion(x, y, x + floatX, y + floatY, duration, Ease.quadInOut);
			
			//scaredMover = new LinearMotion(floatUpCallback);
			//addTween(scaredMover);
			//scaredMover.setMotion(x, y, x + floatX * 3, y + floatY, duration, Ease.quadInOut);
			
			//trace('floatX: ' + floatX);
			//trace('duration: ' + duration);			
			
			// Angle tween
			angleChange = MIN_ANGLE_CHANGE + FP.random * (MAX_ANGLE_CHANGE - MIN_ANGLE_CHANGE);
			angleChange *= -floatXDirection;
			angleChanger = new AngleTween();
			addTween(angleChanger);
			angleChanger.tween(image.angle, angleChange, duration, Ease.quadInOut);
		}
		
		public function floatDown():void
		{
			scared = false;
			
			//var duration:Number = floatY / FLOAT_SPEED;
			if (floatY < 0) floatY *= -1;
			if (y + floatY > maxY)
			{
				trace('too low');
				floatY = maxY - y;
			}
			var duration:Number = FLOAT_DURATION + floatX / Global.PHASE_DELAY_DIVIDER;
			mover = new LinearMotion(floatDownCallback);
			addTween(mover);
			mover.setMotion(x, y, x + floatX, y + floatY, duration, Ease.quadInOut);	
			
			//scaredMover = new LinearMotion(floatDownCallback);
			//addTween(scaredMover);
			//scaredMover.setMotion(x, y, x + floatX * 3, y + floatY, duration, Ease.quadInOut);			
			
			// Angle tween
			angleChanger = new AngleTween();
			addTween(angleChanger);
			angleChanger.tween(image.angle, -angleChange, duration, Ease.quadInOut);			
		}
		
		public function floatUpCallback():void
		{
			if (HANG_TIME > 0)
			{
				FP.alarm(HANG_TIME, floatDown);
			}
			else 
			{
				floatDown();
			}
		}
		
		public function floatDownCallback():void
		{
			if (HANG_TIME > 0)
			{
				FP.alarm(HANG_TIME, floatUp);
			}
			else 
			{
				floatUp();
			}			
		}		
		
	}

}