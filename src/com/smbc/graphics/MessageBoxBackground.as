package com.smbc.graphics
{
	import com.smbc.main.SkinObj;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;

	[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="MessageBoxBackground")]
	public final class MessageBoxBackground extends SkinObj
	{
		public static const FL_TOP_LEFT:String = "topLft";
		public static const FL_TOP_MID:String = "topMid";
		public static const FL_TOP_RIGHT:String = "topRht";
		public static const FL_MID_LEFT:String = "midLft";
		public static const FL_MID_MID:String = "midMid";
		public static const FL_MID_RIGHT:String = "midRht";
		public static const FL_BOT_LEFT:String = "botLft";
		public static const FL_BOT_MID:String = "botMid";
		public static const FL_BOT_RIGHT:String = "botRht";
		
		public function MessageBoxBackground(frameLabel:String)
		{
			super();
			gotoAndStop(frameLabel); 
		}
		
	}
}