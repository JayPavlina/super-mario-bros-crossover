package com.smbc.enemies
{
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.data.AnimationTimers;
	import com.smbc.data.HealthValue;
	import com.smbc.data.ScoreValue;
	import com.smbc.ground.Ground;
	import com.smbc.ground.SpringRed;
	import com.smbc.utils.GameLoopTimer;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class Fly extends Enemy
	{
		
		private var jumpTimer:CustomTimer = new CustomTimer(150,1);
		
		private static const WALK_SPEED_MULTIPLIER:Number = 1.25; //.75;
		private static const FRICTION_X:Number = .1;
		private static const VERTICAL_JUMP_POWER:int = 240; //80;
		private static const GRAVITY:int = 560;
		
		private static const FL_FLY_START:String = "flyStart";
		private static const FL_FLY_END:String = "flyEnd";
		private static const FL_STAND:String = "stand";
		
		private var jumpStartY:Number;
		private var jumpedThisFrame:Boolean;
		private var HORIZONTAL_MOVEMENT_SPEED:int = 240;
		
		public function Fly(itemText:String)
		{
			super();
			mainAnimTmr = AnimationTimers.ANIM_MIN_FAST_TMR;
		}
		
		override protected function overwriteInitialStats():void
		{
			super.overwriteInitialStats();
			_health = HealthValue.FLY;
			scoreAttack = ScoreValue.FLY_ATTACK;
			scoreBelow = ScoreValue.FLY_BELOW;
			scoreStar = ScoreValue.FLY_STAR;
			scoreStomp = ScoreValue.FLY_STOMP;
		}
		
		override public function setStats():void
		{
			super.setStats();
			stompable = false;
			addTmr(jumpTimer);
			jumpTimer.addEventListener(TimerEvent.TIMER_COMPLETE, jumpTimerHandler, false, 0, true);
			scaleX = -1;
			if (onGround)
				landOnGround();
			gravity = GRAVITY;
			vxMin = 1;
			
		}
		
		override protected function updateStats():void 
		{
			super.updateStats();
			if (!onGround && ny > jumpStartY)
				vx *= Math.pow(FRICTION_X,dt);
			if (onGround && !jumpTimer.running)
				landOnGround();
		}
		
		
		protected function jumpTimerHandler(event:TimerEvent):void
		{
			if (onGround)
				jump();
		}
		
//		private function resetJumpTimer():void
//		{
//			
//		}
		
		override public function rearm():void
		{
			super.rearm();
			if (onGround)
				landOnGround();
		}
		
		private function jump():void
		{
			scaleX = (player.nx >= nx) ? 1 : -1;
			vx = defaultWalkSpeed * WALK_SPEED_MULTIPLIER * scaleX;
			vy = -VERTICAL_JUMP_POWER;
			setPlayFrame(FL_FLY_START);
			jumpStartY = ny;
			jumpTimer.stop();
			onGround = false;
		}
		
		private function landOnGround():void
		{
			vx = 0;
			jumpTimer.reset();
			jumpTimer.start();
			setStopFrame(FL_STAND);
		}
		
		override public function checkFrame():void
		{
			super.checkFrame();
			var cfl:String = currentLabel;
			var cf:int = currentFrame;
			if (!onGround && cf == getLabNum(FL_FLY_END) + 1)
				setPlayFrame(FL_FLY_START);
		}
		
		override public function groundBelow(g:Ground):void 
		{
			if (!lastOnGround && !onGround && !(g is SpringRed))
				landOnGround();
			super.groundBelow(g);
		}
		
		override protected function removeListeners():void
		{
			super.removeListeners();
			if (jumpTimer != null)
				jumpTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,jumpTimerHandler);
		}
		override protected function reattachLsrs():void
		{
			super.reattachLsrs();
			if (jumpTimer != null)
				jumpTimer.addEventListener(TimerEvent.TIMER_COMPLETE,jumpTimerHandler, false, 0, true);
		}
	}
}