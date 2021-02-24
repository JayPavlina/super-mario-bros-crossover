package com.smbc.displayInterface
{
	import com.smbc.characters.Sophia;
	import com.smbc.level.LevelForeground;
	import com.smbc.main.SkinObj;
	
	import flash.display.MovieClip;
	
//	[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="SophiaHoverBar")]
	public class SophiaHoverBar extends SkinObj
	{
		private static const FRAME_OFS:int = 1;
		private static const X_POS:int = 30;
		private static const Y_POS:int = 100;
		private var sophia:Sophia;
		public function SophiaHoverBar(sophia:Sophia)
		{
			super();
			this.sophia = sophia;
			x = X_POS;
			y = Y_POS;
			stop();
			LevelForeground.instance.addChild(this);
		}
		public function updateDisplay(hoverRemaining:int):void
		{
			gotoAndStop(hoverRemaining + FRAME_OFS);
		}
	}
}