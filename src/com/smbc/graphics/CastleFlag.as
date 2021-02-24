package com.smbc.graphics
{
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.data.AnimationTimers;
	import com.smbc.events.CustomEvents;
	import com.smbc.main.SimpleAnimatedObject;
	
	import flash.display.Sprite;
	import flash.events.Event;

	public class CastleFlag extends SimpleAnimatedObject
	{
		private static const MAIN_ANIM_TMR:CustomTimer = AnimationTimers.ANIM_SLOWEST_TMR;
		private static const FL_END:String = "end";
		private static const FL_START:String = "start";
		public function CastleFlag()
		{
			super();
			stopAnim = false;
			mainAnimTmr = MAIN_ANIM_TMR;
			EVENT_MNGR.addEventListener( CustomEvents.LEVEL_SET_INDEXES, levelSetIndexesHandler, false, 0, true);
		}
		
		protected function levelSetIndexesHandler(event:Event):void
		{
			if (parent)
				parent.setChildIndex(this,1);
		}
		
		override protected function addedToStageHandler(e:Event):void
		{
			super.addedToStageHandler(e);
			level.addToLevelNow(this);
		}
		
		
		override public function checkFrame():void
		{
			if (currentLabel == FL_END)
				gotoAndStop(FL_START);
		}
		
	}
}