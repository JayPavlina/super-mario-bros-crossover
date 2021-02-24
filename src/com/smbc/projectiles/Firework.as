package com.smbc.projectiles
{
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.data.AnimationTimers;
	import com.smbc.data.ScoreValue;
	import com.smbc.data.SoundNames;
	
	import flash.events.TimerEvent;
	
	public class Firework extends Projectile
	{
		private const NEXT_FIREWORK_TMR:CustomTimer = new CustomTimer(400,1);
		public function Firework(xPos:Number,yPos:Number)
		{
			super(null,SOURCE_TYPE_NEUTRAL);
			defyGrav = true;
			stopAnim = false;
			stopHit = true;
			stopUpdate = true;
			accurateAnimTmr = new CustomTimer(AnimationTimers.DEL_VERY_SLOW);
			this.x = xPos;
			this.y = yPos;
			gotoAndStop("start");
			SND_MNGR.playSound(SoundNames.SFX_GAME_CANON);
			NEXT_FIREWORK_TMR.addEventListener(TimerEvent.TIMER_COMPLETE,destroyTmrHandler,false,0,true);
			addTmr(NEXT_FIREWORK_TMR);
			NEXT_FIREWORK_TMR.start();
			EVENT_MNGR.addPoints(ScoreValue.FIREWORK);
		}
		private function destroyTmrHandler(event:TimerEvent):void
		{
			NEXT_FIREWORK_TMR.reset();
			destroy();
		}
		override public function checkFrame():void
		{
			currentLabel;
			if (currentLabel == "end")
			{
				stopAnim = true;
				visible = false;
			}
		}
		override public function cleanUp():void
		{
			super.cleanUp();
			level.launchNextFirework();
		}
		override protected function removeListeners():void
		{
			super.removeListeners();
			NEXT_FIREWORK_TMR.removeEventListener(TimerEvent.TIMER_COMPLETE,destroyTmrHandler);
		}
		override protected function reattachLsrs():void
		{
			super.reattachLsrs();
			NEXT_FIREWORK_TMR.addEventListener(TimerEvent.TIMER_COMPLETE,destroyTmrHandler,false,0,true);
		}
		
	}
}