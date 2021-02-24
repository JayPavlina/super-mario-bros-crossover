package com.smbc.projectiles
{
	import com.explodingRabbit.cross.gameplay.statusEffects.StatusProperty;
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.characters.Character;
	import com.smbc.interfaces.ICustomTimer;
	import com.smbc.main.LevObj;
	
	import flash.events.TimerEvent;
	
	public class HammerWeapon extends Projectile
	{
		private static const FL_ABOVE:String = "above",
			FL_SIDE:String = "side";
		private static const DAMAGE_AMOUNT:int = int.MAX_VALUE / 4;
		private var owner:Character;
		private var destroyTimer:CustomTimer = new CustomTimer(10000,1);
		private var changeFrame:Boolean;
		
		public function HammerWeapon(source:LevObj)
		{	
			super(source, SOURCE_TYPE_PLAYER);
			owner = source as Character;
			x = owner.nx;
			y = owner.ny;
			destroyOffScreen = false;
			addProperty( new StatusProperty(PR_PASSTHROUGH_ALWAYS) );
			addProperty( new StatusProperty(PR_PIERCE_AGG, 11) );
			_damageAmt = DAMAGE_AMOUNT;
			addTmr(destroyTimer);
			destroyTimer.addEventListener(TimerEvent.TIMER_COMPLETE, destroyTimerHandler, false, 0, true);
			destroyTimer.start();
			defyGrav = true;
//			stopAnim = true;
		}
		
		protected function destroyTimerHandler(event:TimerEvent):void
		{
			removeTmr(destroyTimer);
			destroyTimer.stop();
			destroyTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, destroyTimerHandler);
			destroyTimer = null;
			destroy();
			
		}
		
		override protected function removeListeners():void
		{
			super.removeListeners();
			if (destroyTimer != null)
				destroyTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, destroyTimerHandler);
		}
		
		public function update():void
		{
			if (changeFrame)
			{
				if (currentLabel == FL_ABOVE)
					gotoAndStop(FL_SIDE);
				else
					gotoAndStop(FL_ABOVE);
				changeFrame = false;
			}
			scaleX = owner.scaleX;
			if (currentLabel ==	FL_ABOVE)
			{
				x = owner.nx;
				y = owner.hTop;
			}
			else if (currentLabel == FL_SIDE)
			{
				if (owner.scaleX > 0)
					x = owner.hRht;
				else
					x = owner.hLft;	
				y = owner.hBot - TILE_SIZE/2;
			}
		}
		
		override public function animate(ct:ICustomTimer):Boolean
		{
			changeFrame = true;
			return false;
		}
	}
}