package com.explodingRabbit.cross.gameplay.statusEffects
{
	import com.explodingRabbit.cross.data.EffectReasons;
	import com.smbc.level.Level;
	import com.smbc.main.LevObj;
	import com.smbc.utils.GameLoopTimer;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	
	public class StatFxStop extends StatusEffect
	{
		private var timer:GameLoopTimer;
		private var _duration:int;
		private var vxStart:Number;
		private var vyStart:Number;
		private var stopAnimation:Boolean;
		/**
		 * 
		 * @param target - target of status effect
		 * @param duration - amount of time to stop, infinite if left blank
		 * 
		 */		
		public function StatFxStop(target:LevObj, duration:int = 0, stopAnimation:Boolean = true)
		{
			super(TYPE_STOP, target);
			this._duration = duration;
			this.stopAnimation = stopAnimation;
			if (duration)
				timer = new GameLoopTimer(duration,1);
		}
		
		override public function clone(newTarget:LevObj,attacker:LevObj = null):StatusEffect
		{
			return new StatFxStop(newTarget,_duration,stopAnimation);
		}
		
		
		override public function apply():void
		{
			super.apply();
			if (stopAnimation)
				_target.addReasonOvRd(LevObj.NAME_STOP_ANIM,true, TYPE_STOP);
			_target.addReasonOvRd(LevObj.NAME_STOP_UPDATE,true, TYPE_STOP);
			_target.addReasonOvRd(LevObj.NAME_STOP_TIMERS,true, TYPE_STOP);
			var flashFx:StatusEffect = _target.getStatusEffect(TYPE_FLASH);
			if (flashFx)
				_target.removeStatusEffect(TYPE_FLASH);
			vxStart = _target.vx;
			vyStart = _target.vy;
//			_target.vx = 0;
//			_target.vy = 0;
			if (timer)
			{
				_target.addTmr(timer);
				timer.addEventListener(TimerEvent.TIMER_COMPLETE,timerHandler,false,0,true);
				timer.start();
			}
		}
		override public function checkIfReplaceWithSameType(effect:StatusEffect):Boolean
		{
			if (timeRemaining >= StatFxStop(effect).timeRemaining)
				return false;
			destroy();
			return true;
		}
		
		protected function timerHandler(event:Event):void
		{
			trace("destroy stop"+timer.delay);
			destroy();
		}
		
		override public function destroy():void
		{
			super.destroy();
			if (timer)
			{
				timer.stop();
				_target.removeTmr(timer);
				timer.removeEventListener(TimerEvent.TIMER_COMPLETE,timerHandler);
				timer = null;
			}
			if (stopAnimation)
				_target.removeReasonOvRd(LevObj.NAME_STOP_ANIM,true, TYPE_STOP);
			_target.removeReasonOvRd(LevObj.NAME_STOP_UPDATE,true, TYPE_STOP);
			_target.removeReasonOvRd(LevObj.NAME_STOP_TIMERS,true, TYPE_STOP);
//			_target.vx = vxStart;
//			_target.vy = vyStart;
		}
		
		public function get timeRemaining():int
		{
			if (!timer)
				return int.MAX_VALUE;
			return timer.delay - timer.timePassed;
		}
		
		
	}
}