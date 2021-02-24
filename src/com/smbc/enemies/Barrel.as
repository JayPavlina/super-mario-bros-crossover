package com.smbc.enemies
{
	import com.explodingRabbit.cross.gameplay.statusEffects.StatusProperty;
	import com.smbc.data.EnemyInfo;
	import com.smbc.data.HealthValue;
	import com.smbc.data.ScoreValue;
	import com.smbc.ground.Ground;
	
	import flash.geom.Point;
	
	public class Barrel extends Goomba
	{
		public static const ENEMY_NUM:int = EnemyInfo.Barrel;
		
		private const BOUNCE_AMT:int = 350;
		private static const BOUNCE_GRAVITY:int = 1500;
		private var bounced:Boolean;
		
		public function Barrel(itemText:String)
		{
			super(itemText);
			addProperty( new StatusProperty( PR_PIERCE_PAS, PIERCE_STR_ARMORED ) );
		}
		override protected function overwriteInitialStats():void
		{
			super.overwriteInitialStats();
			_health = HealthValue.BARREL;
			scoreAttack = ScoreValue.BARREL_ATTACK;
			scoreBelow = ScoreValue.BARREL_BELOW;
			scoreStar = ScoreValue.BARREL_STAR;
			scoreStomp = ScoreValue.BARREL_STOMP;
		}
		override public function setStats():void
		{
			super.setStats();
			stompable = false;
		}
		override protected function checkState():void
		{
			if (onGround)
				bounced = false;
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
	}
}