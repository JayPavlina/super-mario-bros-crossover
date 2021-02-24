package com.smbc.graphics
{
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.data.AnimationTimers;
	import com.smbc.enums.ScrollingIndicatorDirection;
	import com.smbc.level.Level;
	import com.smbc.main.SkinObj;
	
	import flash.events.TimerEvent;
	
	public class ScrollingIndicator extends SkinObj
	{
		public static const MAX_WIDTH:int = 18; // from mask in Flash
		public static const MAX_HEIGHT:int = 16;
		
		private static const FL_DOWN_START:String = "downStart",
			FL_DOWN_END:String = "downEnd",
			FL_UP_START:String = "upStart",
			FL_UP_END:String = "upEnd";
			
		private var direction:ScrollingIndicatorDirection;
		private var animTmr:CustomTimer = new CustomTimer(AnimationTimers.DEL_SLOWEST);
		
		public function ScrollingIndicator(direction:ScrollingIndicatorDirection)
		{	
			super();
			this.direction = direction;
			if (Level.levelInstance)
				Level.levelInstance.ALWAYS_ANIM_DCT.addItem(this);
			mainAnimTmr = animTmr;
			animTmr.addEventListener(TimerEvent.TIMER,animTmrHandler,false,0,true);
			animTmr.start();
			stopAnim = false;
			if (direction == ScrollingIndicatorDirection.Down)
				gotoAndStop(FL_DOWN_START);
			else if (direction == ScrollingIndicatorDirection.Up)
				gotoAndStop(FL_UP_START);
		}
		
		protected function animTmrHandler(event:TimerEvent):void
		{
			animate(animTmr);
			checkFrame();
		}
		
		override public function checkFrame():void
		{
			if ( direction == ScrollingIndicatorDirection.Down && previousFrameLabelIs(FL_DOWN_END) )
				gotoAndStop(FL_DOWN_START);
			else if ( direction == ScrollingIndicatorDirection.Up && previousFrameLabelIs(FL_UP_END) )
				gotoAndStop(FL_UP_START);
		}
		
		override public function cleanUp():void
		{
			animTmr.removeEventListener(TimerEvent.TIMER,animTmrHandler);
			super.cleanUp();
//			if (Level.levelInstance)
//				Level.levelInstance.ALWAYS_ANIM_DCT.removeItem(this);
		}
	}
}