package com.smbc.enemies
{
	import com.explodingRabbit.cross.gameplay.statusEffects.StatusProperty;
	import com.smbc.data.EnemyInfo;
	import com.smbc.data.HealthValue;
	import com.smbc.data.ScoreValue;
	import com.smbc.ground.Ground;
	
	import flash.geom.Point;

//	[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="SpikeTop")]
	public class SpikeTop extends Goomba
	{
		public static const ENEMY_NUM:int = EnemyInfo.SpikeTop;
		
		private const BOUNCE_AMT:int = 350;
		private static const BOUNCE_GRAVITY:int = 1500;
		private var bounced:Boolean;
		
		public function SpikeTop(fLab:String)
		{
			super(fLab);
			//stompable = false;
			addProperty( new StatusProperty( PR_PIERCE_PAS, PIERCE_STR_ARMORED ) );
		}
		override protected function overwriteInitialStats():void
		{
			_health = HealthValue.SPIKE_TOP;
			scoreAttack = ScoreValue.BEETLE_ATTACK;
			scoreBelow = ScoreValue.BEETLE_BELOW;
			scoreStar = ScoreValue.BEETLE_STAR;
			scoreStomp = ScoreValue.BEETLE_STOMP;
			super.overwriteInitialStats();
		}
		override public function setStats():void
		{
			super.setStats();
			stompable = false;
		}
		override protected function checkState():void
		{
			if (!onGround)
				falling = true;
			else if (onGround)
			{
				if (falling && !bounced)
				{
					if (nx > player.nx)
						vx = -xSpeed;
					else
						vx = xSpeed;
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
		}
	}
}