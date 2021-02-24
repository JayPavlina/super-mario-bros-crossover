package com.explodingRabbit.cross.gameplay.statusEffects
{
	import com.smbc.main.LevObj;
	import com.smbc.utils.GameLoopTimer;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	
	public class StatFxFlash extends StatusEffect
	{
		private var intervalTmr:GameLoopTimer;
		private var durTmr:GameLoopTimer;
		private var interval:int;
		private var duration:int;
		
		public function StatFxFlash(target:LevObj, interval:int, duration:int = 0)
		{
			super(TYPE_FLASH, target);
			this.interval = interval;
			this.duration = duration;
				
		}
		override public function clone(newTarget:LevObj,attacker:LevObj = null):StatusEffect
		{
			return new StatFxFlash(newTarget, interval, duration);
		}
		override public function apply():void
		{
			super.apply();
			_target.setUpCommonPalettes();
			_target.resetFlashCtr();		
			_target.flash();
			if (interval)
			{
				intervalTmr = new GameLoopTimer(interval);
				_target.addTmr(intervalTmr);
				intervalTmr.addEventListener(TimerEvent.TIMER,intervalTmrHandler,false,0,true);
				intervalTmr.start();
			}
			if (duration)
			{
				durTmr = new GameLoopTimer(duration,1);
				_target.addTmr(durTmr);
				durTmr.addEventListener(TimerEvent.TIMER_COMPLETE,durTmrHandler,false,0,true);
				durTmr.start();
			}
		}
		
		protected function durTmrHandler(event:Event):void
		{
			destroy();	
		}
		
		protected function intervalTmrHandler(event:Event):void
		{
			_target.flash();
		}		
		override public function destroy():void
		{
			super.destroy();
			_target.resetColor();
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