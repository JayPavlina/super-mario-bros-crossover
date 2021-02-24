package com.smbc.displayInterface
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="SophiaMissileCount")]
	public class SophiaMissileCount extends Sprite
	{
		// both digits are already on the stage
		public var firstDigit:MovieClip;
		public var secondDigit:MovieClip;
		private static const FRAME_OFS:int = 1;
		public static const Y_OFS:int = 14;
		public function SophiaMissileCount()
		{
			super();
			firstDigit.stop();
			secondDigit.stop();
		}
		public function updateDisplay(num:int):void
		{
			var str:String = num.toString();
			if (str.length < 2)
				str = "0" + str;
			var firstNum:int = int(str.charAt(0));
			var secondNum:int = int(str.charAt(1));
			firstDigit.gotoAndStop(firstNum + FRAME_OFS);
			secondDigit.gotoAndStop(secondNum + FRAME_OFS);
		}
	}
}