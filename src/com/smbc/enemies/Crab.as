package com.smbc.enemies
{
	import com.explodingRabbit.cross.gameplay.statusEffects.StatusProperty;
	import com.smbc.data.DamageValue;
	import com.smbc.data.EnemyInfo;
	import com.smbc.data.HealthValue;
	import com.smbc.data.ScoreValue;
	import com.smbc.ground.Ground;
	import com.smbc.main.LevObj;
	import com.smbc.projectiles.MarioFireBall;
	
	import flash.geom.Point;

	public class Crab extends Goomba
	{
		public static const ENEMY_NUM:int = EnemyInfo.Crab;
		private static const ANGRY_SPEED_MULTIPLIER:Number = 1.66;
		private static const FL_WALK_START_ANGRY:String = "walkStartAngry",
			FL_WALK_END_ANGRY:String = "walkEndAngry",
			FL_WALK_START:String = "walkStart",
			FL_WALK_END:String = "walkEnd";
		
		private const BOUNCE_AMT:int = 350;
		private static const BOUNCE_GRAVITY:int = 1500;
		private var bounced:Boolean;

		private var angry:Boolean;
		
		private static const HEALTH_VALUE_ANGRY:int = 400;
		
		public function Crab(itemText:String)
		{
			super(itemText);
//			addProperty( new StatusProperty( PR_PIERCE_PAS, PIERCE_STR_ARMORED ) );
		}
		override protected function overwriteInitialStats():void
		{
			super.overwriteInitialStats();
			_health = HealthValue.CRAB;
			scoreAttack = ScoreValue.SPINEY_ATTACK;
			scoreBelow = ScoreValue.SPINEY_BELOW;
			scoreStar = ScoreValue.SPINEY_STAR;
			scoreStomp = ScoreValue.SPINEY_STOMP;
		}
		
		override protected function takeDamage(dmg:int,dmgSrc:LevObj = null):void
		{
			if (dmgSrc is MarioFireBall && !angry)
				_health = HEALTH_VALUE_ANGRY;
			else
				super.takeDamage(dmg, dmgSrc);
			if (!angry && cState != ST_DIE && _health <= HEALTH_VALUE_ANGRY && !getStatusEffect(STATFX_FREEZE))
			{
				setPlayFrame(FL_WALK_START_ANGRY);
				angry = true;
				_health = HEALTH_VALUE_ANGRY;
				vx *= ANGRY_SPEED_MULTIPLIER;
				vx = Math.abs(vx);
				if (player.nx < nx)
					vx *= -1;
			}
		}
		
		override public function setStats():void
		{
			super.setStats();
			stompable = false;
		}
		
		override public function checkFrame():void
		{
			super.checkFrame();
			var cfl:String = currentLabel;
			var cf:int = currentFrame;
			if (!angry)
			{
				if (cf == convFrameToInt(FL_WALK_END) + 1)
					setPlayFrame(FL_WALK_START);
			}
			else if (cf == convFrameToInt(FL_WALK_END_ANGRY) + 1)
				setPlayFrame(FL_WALK_START_ANGRY);
		}
		override protected function checkState():void
		{
			if (!onGround)
				falling = true;
			else if (onGround)
			{
				if (falling && !bounced && angry)
				{
					if (nx > player.nx)
						vx = -xSpeed * ANGRY_SPEED_MULTIPLIER;
					else
						vx = xSpeed * ANGRY_SPEED_MULTIPLIER;
				}
				else
				{
					bounced = false;
				}
				falling = false;
			}
			//			else if ( vx == 0 && !getStatusEffect(STATFX_STOP) )
			//				vx = xSpeed*scaleX;
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
			if (!angry && !getStatusEffect(STATFX_FREEZE))
			{
				setPlayFrame(FL_WALK_START_ANGRY);
				angry = true;
				vx *= ANGRY_SPEED_MULTIPLIER;
				vx = Math.abs(vx);
				if (player.nx < nx)
					vx *= -1;
			}
		}
	}
}