package com.smbc.graphics
{
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.data.AnimationTimers;
	import com.smbc.interfaces.IAnimated;
	import com.smbc.interfaces.ICustomTimer;
	import com.smbc.level.Level;
	import com.smbc.main.SkinObj;
	
	import flash.events.TimerEvent;
	
	public class PortraitSelector extends SkinObj
	{
		public static const FL_NORMAL_START:String = "normalStart";
		public static const FL_NORMAL_END:String = "normalEnd";
		public static const FL_REVIVE_START:String = "reviveStart";
		public static const FL_REVIVE_END:String = "reviveEnd";
		public static const FL_FRAME:String = "frame";
		public static const FL_HUD_FRAME:String = "hudFrame";
		public static const CLASS_NAME:String = "PortraitSelector";
		private var animTmr:CustomTimer = new CustomTimer(AnimationTimers.DEL_SLOWEST);
		
		public function PortraitSelector()
		{
			super();
			stopAnim = false;
//			mainAnimTmr = AnimationTimers.ANIM_SLOWEST_TMR;
			mainAnimTmr = animTmr;
			animTmr.addEventListener(TimerEvent.TIMER,animTmrHandler,false,0,true);
			animTmr.start();
//			ACTIVE_ANIM_TMRS_DCT.addItem(mainAnimTmr);
//			Level.levelInstance.ALWAYS_ANIM_DCT.addItem(this);
			//_animated = true;
		}
		
		protected function animTmrHandler(event:TimerEvent):void
		{
			animate(animTmr);
			checkFrame();
		}
		
		public function destroy():void
		{
			animTmr.removeEventListener(TimerEvent.TIMER,animTmrHandler);
//			Level.levelInstance.ALWAYS_ANIM_DCT.removeItem(this);
		}
		override public function checkFrame():void
		{
			var cl:String = currentLabel;
			if (cl == FL_NORMAL_END)
				gotoAndStop(FL_NORMAL_START);
			else if (cl == FL_REVIVE_END)
				gotoAndStop(FL_REVIVE_START);
		}
	}
}