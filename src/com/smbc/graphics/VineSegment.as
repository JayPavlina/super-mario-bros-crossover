package com.smbc.graphics
{
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.data.AnimationTimers;
	import com.smbc.events.CustomEvents;
	import com.smbc.main.SkinObj;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;

	[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="VineSegment")]
	public class VineSegment extends SkinObj
	{
//		private const MAIN_ANIM_TMR:CustomTimer = AnimationTimers.ANIM_MODERATE_TMR;
		
		public function VineSegment(color:String)
		{
			super();
//			gotoAndStop(color);
//			stopAnim = false;
//			mainAnimTmr = MAIN_ANIM_TMR;
		}
	}
}