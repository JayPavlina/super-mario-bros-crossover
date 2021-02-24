package com.explodingRabbit.cross.gameplay.statusEffects
{
	import com.explodingRabbit.cross.data.EffectReasons;
	import com.smbc.level.Level;
	import com.smbc.main.LevObj;
	import com.smbc.utils.GameLoopTimer;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	
	public class StatFxInvulnerable extends StatusEffect
	{
		private var timer:GameLoopTimer;
		private var duration:int;
		/**
		 * 
		 * @param target - target of status effect
		 * @param duration - amount of time to stop, infinite if left blank
		 * 
		 */		
		public function StatFxInvulnerable(target:LevObj, duration:int = 0)
		{
			super(TYPE_INVULNERABLE, target);
			this.duration = duration;
		}
		
		override public function clone(newTarget:LevObj,attacker:LevObj = null):StatusEffect
		{
			return new StatFxInvulnerable(newTarget,duration);
		}
		
		
		override public function apply():void
		{
			super.apply();
			if (duration)
			{
				timer = new GameLoopTimer(duration,1);
				_target.addTmr(timer);
				timer.addEventListener(TimerEvent.TIMER_COMPLETE,timerHandler,false,0,true);
				timer.start();
			}
		}
		override public function checkIfReplaceWithSameType(effect:StatusEffect):Boolean
		{
			if (timeRemaining >= StatFxInvulnerable(effect).timeRemaining)
				return false;
			destroy();
			return true;
		}
		
		protected function timerHandler(event:Event):void
		{
			destroy();
		}
		
		override public function destroy():void
		{
			super.destroy();
			trace("remove invulnerable");
			if (timer)
			{
				timer.stop();
				_target.removeTmr(timer);
				timer.removeEventListener(TimerEvent.TIMER_COMPLETE,timerHandler);
				timer = null;
			}
		}
		
		public function get timeRemaining():int
		{
			if (!timer)
				return int.MAX_VALUE;
			return timer.delay - timer.timePassed;
		}
		
		
	}
}