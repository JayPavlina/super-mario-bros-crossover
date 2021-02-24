package com.smbc.graphics
{
	import com.explodingRabbit.display.CustomMovieClip;
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.data.AnimationTimers;
	import com.smbc.level.Level;
	import com.smbc.main.SkinObj;
	
	import flash.display.Sprite;
	import flash.events.TimerEvent;

	public final class MushroomSelector extends SkinObj
	{
		public const BOTTOM_MARGIN:int = 16;
		private var animTmr:CustomTimer = new CustomTimer(AnimationTimers.DEL_SLOW);
		
		public function MushroomSelector()
		{
			super();
			stopAnim = false;
			mainAnimTmr = animTmr;
			animTmr.addEventListener(TimerEvent.TIMER,animTmrHandler,false,0,true);
			animTmr.start();
		}
		
		protected function animTmrHandler(event:TimerEvent):void
		{
			animate(animTmr);
			checkFrame();
		}
		
		override public function cleanUp():void
		{
			animTmr.removeEventListener(TimerEvent.TIMER,animTmrHandler);
			super.cleanUp();
			if (Level.levelInstance)
				Level.levelInstance.ALWAYS_ANIM_DCT.removeItem(this);
		}
		
	}
}