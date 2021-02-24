package com.smbc.utils
{
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.characters.Character;
	import com.smbc.level.Level;
	import com.smbc.level.TitleLevel;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class CharacterSequencer
	{
		private static const IND_DELAY:int = 0;
		private static const IND_FUNCTION:int = 1;
		private var seqTmr:GameLoopTimer;
		private var seqArr:Array;
		private var stringChar:Character;
		private var curFunction:Function;
		private var recordChar:Character;
		
		public function CharacterSequencer()
		{
			
		}
		
		public function startNewSequence(sequenceArr:Array,char:Character = null):void
		{
			seqArr = sequenceArr.concat();
			seqTmr = new GameLoopTimer(1,1);
			seqTmr.addEventListener(TimerEvent.TIMER_COMPLETE,seqTmrHandler);
			if ( !(seqArr[0][IND_FUNCTION] is Function) ) // if not function, convert it
				stringChar = char;
			nextEvent();
//			trace("char.x: "+char.x+" char.y: "+char.y);
		}
		private function convStrToFct(char:Character):void
		{
			for each (var arr:Array in seqArr)
			{
				var str:String = arr[IND_FUNCTION];
				arr[IND_FUNCTION] = char[str]; 
			}
		}
		private function nextEvent():void
		{
			var arr:Array = seqArr[0];
			seqTmr.delay = arr[IND_DELAY];
			if (!stringChar)
				curFunction = arr[IND_FUNCTION];
			else
				curFunction = stringChar[String(arr[IND_FUNCTION])];
			seqTmr.start();
			if (seqTmr.delay == 0)
				seqTmrHandler(new TimerEvent(TimerEvent.TIMER_COMPLETE));
		}
		private function seqTmrHandler(event:TimerEvent):void
		{
			curFunction();
			seqTmr.stop();
			seqArr.shift();
			if (seqArr.length)
				nextEvent();
			else
				endSequence();
		}
		private function endSequence():void
		{
			seqTmr.removeEventListener(TimerEvent.TIMER_COMPLETE,seqTmrHandler);
			seqTmr = null;
			seqArr = null;
			curFunction = null;
			var tl:TitleLevel = TitleLevel.instance;
			if (tl && stringChar != tl.player)
				stringChar.destroy();
			stringChar = null;
		}
		public function recordStart(char:Character, startOnFirstPress:Boolean = true):void
		{
			trace("record start x: "+char.x+" y: "+char.y);
			recordChar = char;
			seqArr = [];
			if (seqTmr)
				endSequence();
			seqTmr = new GameLoopTimer(int.MAX_VALUE);
			if (!startOnFirstPress)
				seqTmr.start();
			else
				seqTmr.totalTimePassed = 1;
			char.recordSeq = this;	
		}
		public function addEvent(fctName:String):void
		{
			var arr:Array = [];
			arr[IND_DELAY] = seqTmr.totalTimePassed;
			arr[IND_FUNCTION] = fctName;
			seqArr.push(arr);
			seqTmr.stop();
			seqTmr.start();
		}
		public function recordEnd():void
		{
			trace("record end");
			trace(this);
			recordChar = null;
			seqArr = null;
			endSequence();
		}
		
		public function toString():String
		{
			var n:int = seqArr.length;
			var str:String = "";
			for (var i:int = 0; i < n; i++) 
			{
				str += "[";
				var arr:Array = seqArr[i];
				str += arr[IND_DELAY].toString();
				str += ",\"";
				str += arr[IND_FUNCTION];
				str += "\"], ";
			}
			return str;
		}
		
		
	}
}