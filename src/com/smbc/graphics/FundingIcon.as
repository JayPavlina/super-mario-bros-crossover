package com.smbc.graphics
{
	import com.smbc.main.SkinObj;
	
	public class FundingIcon extends SkinObj
	{
		public static const FL_FULL:String = "full",
			FL_HALF:String = "half",
			FL_EMPTY:String = "empty",
			ROLL_OVER:String = "RollOver";
		
		private var type:String;
		
		public function FundingIcon(frameLabel:String)
		{
			super();
			type = frameLabel;
			stopAnim = true;
			mouseOut();
		}
		
		public function mouseIn():void
		{
			gotoAndStop(type + ROLL_OVER);
		}
		
		public function mouseOut():void
		{
			gotoAndStop(type);
		}
	}
}