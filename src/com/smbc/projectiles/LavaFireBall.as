package com.smbc.projectiles
{
	
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.data.AnimationTimers;
	
	import flash.events.TimerEvent;
	import flash.geom.Point;
	
//	[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="LavaFireBall")]
	public class LavaFireBall extends Projectile
	{
		private var waitTmrDurMin:int = 750;
		private var waitTmrDurMax:int = 2000;
		private var waitTmr:CustomTimer;
		private var restingYPos:Number;
		private var rise:Boolean;
		private static const FL_START:String = "lavaFireBall-start";
		private static const FL_END:String = "lavaFireBall-end";
		public function LavaFireBall():void
		{ 
			super(null,SOURCE_TYPE_ENEMY);
			defyGrav = true;
			destroyOffScreen = false;
			stopAnim = false;
			waitTmr = new CustomTimer(waitTmrDurMin,1);
			addTmr(waitTmr);
			waitTmr.addEventListener(TimerEvent.TIMER_COMPLETE,waitTmrLsr);
			waitTmr.start();
			sy = 700;
			gravity = 800;
			vyMaxPsv = 400;
			restingYPos = GLOB_STG_BOT + height*.5;
			mainAnimTmr = AnimationTimers.ANIM_SLOW_TMR;
//			hitTestTypesDct.addItem(HT_ENEMY);
//			addHitTestableItem(HT_PROJECTILE_CHARACTER);
		}
		override public function initiate():void
		{
			y = restingYPos;
			super.initiate();
		}
		override public function rearm():void
		{
			super.rearm();
			y = restingYPos;
			ny = y;
			vy = 0;
			scaleY = 1;
			rise = false;
			defyGrav = true;
			resetWaitTmr();
		}
		override protected function updateStats():void 
		{
			super.updateStats();
			if (vy > 0)
			{
//				gotoAndStop("fall");
				scaleY = -1;
				rise = false;
			}
			else
			{
//				gotoAndStop("rise");
				scaleY = 1;
			}
			if (hTop > GLOB_STG_BOT)
			{
				if (!waitTmr.running && !rise)
				{
					ny = restingYPos;
					vy = 0;
					defyGrav = true;
					resetWaitTmr();
				}
			}
		}
		private function waitTmrLsr(e:TimerEvent):void
		{
			rise = true;
			scaleY = 1;
			defyGrav = false;
			vy = -sy;
		}
		private function resetWaitTmr():void
		{
			waitTmr.reset();
			waitTmr.delay = Math.random()*(waitTmrDurMax - waitTmrDurMin) + waitTmrDurMin;
			waitTmr.start();
		}
		override public function checkFrame():void
		{
//			if (currentFrame == convFrameToInt(FL_END) + 1)
//				gotoAndStop(FL_START);
			if (previousFrameLabelIs(FL_END) )
				gotoAndStop(FL_START);
		}
		override protected function removeListeners():void
		{
			super.removeListeners();
			if (waitTmr && waitTmr.hasEventListener(TimerEvent.TIMER_COMPLETE)) waitTmr.removeEventListener(TimerEvent.TIMER_COMPLETE,waitTmrLsr);
		}
		override protected function reattachLsrs():void
		{
			super.reattachLsrs();
			if (waitTmr && !waitTmr.hasEventListener(TimerEvent.TIMER_COMPLETE)) waitTmr.addEventListener(TimerEvent.TIMER_COMPLETE,waitTmrLsr);
		}
	}
}