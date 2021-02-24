package com.smbc.enemies
{
	import com.explodingRabbit.cross.gameplay.statusEffects.StatusProperty;
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.data.EnemyInfo;
	import com.smbc.data.HealthValue;
	import com.smbc.data.ScoreValue;
	import com.smbc.ground.Ground;
	
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	public class FireEnemy extends Goomba
	{
		public static const ENEMY_NUM:int = EnemyInfo.FireEnemy;
		private var changeDirectionTimer:CustomTimer = new CustomTimer(250);
		
		private const BOUNCE_AMT:int = 350;
		private static const BOUNCE_GRAVITY:int = 1500;
		private var bounced:Boolean;
		
		public function FireEnemy(itemText:String)
		{
			super(itemText);
			addProperty( new StatusProperty( PR_PIERCE_PAS, 11 ) );
		}
		override protected function overwriteInitialStats():void
		{
			super.overwriteInitialStats();
//			_health = HealthValue.FIRE_ENEMY;
			scoreAttack = ScoreValue.SPINEY_ATTACK;
			scoreBelow = ScoreValue.SPINEY_BELOW;
			scoreStar = ScoreValue.SPINEY_STAR;
			scoreStomp = ScoreValue.SPINEY_STOMP;
		}
		override public function setStats():void
		{
			super.setStats();
			stompable = false;
			addTmr(changeDirectionTimer);
			changeDirectionTimer.addEventListener(TimerEvent.TIMER, changeDirectionTimerHandler, false, 0, true);
			changeDirectionTimer.start();
		}
		
		protected function changeDirectionTimerHandler(event:TimerEvent):void
		{
			var randomNumber:Number = Math.random();
			if (randomNumber < .33)
			{
				vx = -defaultWalkSpeed;
				scaleX = -1;
			}
			else if (randomNumber < .66)
			{
				vx = defaultWalkSpeed;
				scaleX = 1;
			}
			else
				vx = 0;
			
		}
		override protected function checkState():void
		{
			if (onGround)
				bounced = false;
			if (stunned)
			{
				stunned = false;
				stopUpdate = false;
				stopHit = false;
			}
			super.checkState();
		}
		override public function stomp():void
		{
			// cannot stomp
		}
		override public function gBounceHit(g:Ground):void
		{
			vy = -BOUNCE_AMT;
			gravity = BOUNCE_GRAVITY;
			onGround = false;
			lastOnGround = false;
			bounced = true;
			updateLoc();
			setHitPoints();
			if (nx < g.hMidX)
				vx = -vx;
		}
		override protected function removeListeners():void
		{
			super.removeListeners();
			if (changeDirectionTimer != null)
				changeDirectionTimer.removeEventListener(TimerEvent.TIMER,changeDirectionTimerHandler);
		}
		override protected function reattachLsrs():void
		{
			super.reattachLsrs();
			if (changeDirectionTimer != null)
				changeDirectionTimer.addEventListener(TimerEvent.TIMER,changeDirectionTimerHandler, false, 0, true);
		}
		
	}
}