package com.smbc.utils
{
	import com.smbc.interfaces.ICustomTimer;
	import com.smbc.level.Level;
	
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;

	public class GameLoopTimer extends EventDispatcher implements ICustomTimer
	{
		public var timePassed:Number = 0;
		public var totalTimePassed:Number;
		private var _running:Boolean;
		private var _delay:Number;
		private const LEVEL:Level = Level.levelInstance;
		public var numTotalCycles:int; // num times the timer will run
		private var _currentCount:int; // num times the timer has run
		
		public function GameLoopTimer(timerInterval:Number,_numTotalCycles:int = 0)
		{
			if (!LEVEL)
				throw new Error("You can only use GameLoopTimers within a level.");
			delay = timerInterval;
			numTotalCycles = _numTotalCycles;
			LEVEL.GAME_LOOP_TMRS_DCT.addItem(this);
		}
		public function update():void
		{
			var dtPassed:Number = LEVEL.dt*1000;
			timePassed += dtPassed;
			totalTimePassed = timePassed;
			if (timePassed >= delay)
			{
				_currentCount++;
				if (numTotalCycles == 0 || currentCount < numTotalCycles)
				{
					timePassed -= delay;
					dispatchEvent(new TimerEvent(TimerEvent.TIMER));
					
				}
				else
				{
					pause();
					dispatchEvent(new TimerEvent(TimerEvent.TIMER));
					dispatchEvent(new TimerEvent(TimerEvent.TIMER_COMPLETE));
				}
			}
		}
		public function start():void
		{
			_running = true;
			timePassed = 0;
			_currentCount = 0;
		}
		public function resume():void
		{
			_running = true;
		}
		public function pause():void
		{
			_running = false;
		}
		public function stop():void
		{
			_running = false;
			timePassed = 0;
			totalTimePassed = 0;
			_currentCount = 0;
		}
		public function get running():Boolean
		{
			return _running;
		}

		public function destroy():void
		{
			LEVEL.GAME_LOOP_TMRS_DCT.removeItem(this);	
		}

		public function get currentCount():int
		{
			return _currentCount;
		}

		public function get delay():Number
		{
			return _delay;
		}

		public function set delay(value:Number):void
		{
			_delay = value;
		}


	}
}