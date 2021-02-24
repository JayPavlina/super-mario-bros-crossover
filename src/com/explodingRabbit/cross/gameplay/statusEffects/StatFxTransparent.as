package com.explodingRabbit.cross.gameplay.statusEffects
{
	import com.smbc.main.LevObj;
	import com.smbc.utils.GameLoopTimer;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	
	public class StatFxTransparent extends StatusEffect
	{
		private var intervalTmr:GameLoopTimer;
		private var durTmr:GameLoopTimer;
		private var interval:int;
		private var duration:int;
		private var alpha:Number;
		
		public function StatFxTransparent(target:LevObj, alpha:Number, duration:int, interval:int = 0)
		{
			super(TYPE_TRANSPARENT, target);
			this.interval = interval;
			this.duration = duration;
			this.alpha = alpha;
		}
		override public function clone(newTarget:LevObj,attacker:LevObj = null):StatusEffect
		{
			return new StatFxTransparent(newTarget, alpha, duration, interval);
		}
		override public function apply():void
		{
			super.apply();
			durTmr = new GameLoopTimer(duration,1);
			_target.addTmr(durTmr);
			durTmr.addEventListener(TimerEvent.TIMER_COMPLETE,durTmrHandler,false,0,true);
			durTmr.start();
			if (interval)
			{
				intervalTmr = new GameLoopTimer(interval);
				_target.addTmr(intervalTmr);
				intervalTmr.addEventListener(TimerEvent.TIMER,intervalTmrHandler,false,0,true);
				intervalTmr.start();
			}
			else
				_target.alpha = alpha;
		}
		
		protected function durTmrHandler(event:Event):void
		{
			destroy();	
		}
		
		protected function intervalTmrHandler(event:Event):void
		{
			var targetAlpha:Number = _target.alpha;
			if (targetAlpha == 1)
				_target.alpha = alpha;
			else
				_target.alpha = 1;
		}		
		override public function destroy():void
		{
			super.destroy();
			_target.alpha = 1;
			if (intervalTmr)
			{
				intervalTmr.stop();
				_target.removeTmr(intervalTmr);
				intervalTmr.removeEventListener(TimerEvent.TIMER,intervalTmrHandler);
				intervalTmr = null;
			}
			if (durTmr)
			{
				durTmr.stop();
				_target.removeTmr(durTmr);
				durTmr.removeEventListener(TimerEvent.TIMER_COMPLETE,durTmrHandler);
				durTmr = null;
			}
		}
	}
}