package com.smbc.projectiles
{
	
	import com.customClasses.*;
	import com.explodingRabbit.cross.gameplay.statusEffects.StatFxFreeze;
	import com.explodingRabbit.cross.gameplay.statusEffects.StatusProperty;
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.characters.Character;
	import com.smbc.characters.Pit;
	import com.smbc.characters.Samus;
	import com.smbc.data.DamageValue;
	import com.smbc.data.PickupInfo;
	import com.smbc.data.SoundNames;
	import com.smbc.enemies.Enemy;
	import com.smbc.graphics.SamusSimpleGraphics;
	import com.smbc.ground.Brick;
	import com.smbc.ground.Ground;
	import com.smbc.interfaces.IAttackable;
	import com.smbc.main.*;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class PitProjectile extends Projectile
	{
		
		// Constants:
		public static const FL_ARROW_SHORT:String = "arrowShort";
		public static const FL_ARROW_LONG:String = "arrowLong";
		public static const FL_ARROW_FIRE:String = "arrowFire";
		public static const FL_FIRE_BALL_ROTATE_START:String = "fireBallRotateStart";
		public static const FL_FIRE_BALL_ROTATE_END:String = "fireBallRotateEnd";
		public static const FL_FIRE_BALL_TIP_START:String = "fireBallTipStart";
		public static const FL_FIRE_BALL_TIP_END:String = "fireBallTipEnd";
		public static const FL_BARRIER:String = "barrier";
		
		
		public static const SHOT_TYPE_ARROW:String = "arrow";
		public static const SHOT_TYPE_FIRE_BALL_ROTATE:String = "fireBallRotate";
		public static const SHOT_TYPE_FIRE_BALL_TIP:String = "fireBallTip";
		public static const SHOT_TYPE_SHIELD:String = "shield";
		
		private var shotType:String;
		private var shotDist:Number = 0;
		private var shootUp:Boolean;
		
		private static const FL_NORMAL:String = "normal";
		private static const FL_ICE:String = "ice";
		private static const FL_WAVE:String = "wave";
		private static const FL_MISSILE:String = "missile";
		private var short:Boolean;
		private static  const INVERTED_WAVE_NUM:int = 1;
		private static  const ARROW_SPEED:int = 500;
		private static  const ICE_BEAM_SPEED:int = 500;
		private static  const WAVE_BEAM_SPEED:int = 400;
		private static  const SHORT_ARROW_DISTANCE:int = 100;
		
		private static const X_OFFSET:int = 25;
		private static const X_OFFSET_UP:int = 4;
		private static const Y_OFFSET_STAND:int = 22;
		private static const Y_OFFSET_STAND_UP:int = 72;
		private static const Y_OFS_WALK_GB:int = 52;
		private static const X_OFFSET_CROUCH:int = 25;
		private static const Y_OFFSET_CROUCH:int = 27;
		private static const Y_OFFSET_JUMP:int = 30;
		
		private var pit:Pit;

		public function PitProjectile(pit:Pit,shotType:String = null) 
		{
			this.pit = pit;
			this.shotType = shotType;
			super(pit,SOURCE_TYPE_PLAYER);
			for each (var prop:StatusProperty in Pit.DEFAULT_PROPS_DCT)
			{
				addProperty(prop);
			}
			stopAnim = true;
			defyGrav = true;
			mainAnimTmr = null;
			determineShotType();
			addAllGroundToHitTestables();
			setDir();
		}

		override protected function updateStats():void
		{
			super.updateStats();
			if (short)
				checkDist();
		}
		private function determineShotType():void
		{
//			if (shotType == SHOT_TYPE_SHIELD)
//			{
//				missile();
//				return;
//			}
			arrow();
		}
		
		private function arrow():void
		{
			if ( pit.upgradeIsActive(PickupInfo.PIT_FIRE_ARROW) )
			{
				addFireBall();
				gotoAndStop(FL_ARROW_FIRE);
				_damageAmt = DamageValue.PIT_FIRE_ARROW; 
			}
			else if ( pit.upgradeIsActive(PickupInfo.PIT_LONG_ARROW) )
			{
				gotoAndStop(FL_ARROW_LONG);
				_damageAmt = DamageValue.PIT_LONG_ARROW;
			}
			else
			{
				gotoAndStop(FL_ARROW_SHORT);
				_damageAmt = DamageValue.PIT_SHORT_ARROW;
				short = true;
			}
			shotType = SHOT_TYPE_ARROW;
			pit.ARROW_DCT.addItem(this);
			speed = ARROW_SPEED;
		}
		
		private function addFireBall():void
		{
			// TODO Auto Generated method stub
			
		}

		override protected function setDir():void
		{
			var dir:int = pit.scaleX;
			if (pit.upBtn)
			{
				vy = -speed;
				this.rotation = 270;
				if (dir > 0)
					x = pit.nx + X_OFFSET_UP;
				else
					x = pit.nx - X_OFFSET_UP;
				y = pit.ny - Y_OFFSET_STAND_UP;
				shootUp = true;
			}
			else
			{
				vx = speed*dir;
				x = pit.nx + X_OFFSET*dir;
				scaleX = dir;
				if (pit.onGround)
					y = pit.ny - Y_OFFSET_STAND;
				else
					y = pit.ny - Y_OFFSET_JUMP;
			}
//			if ( pit.repositionWalkingBullets() )
//				y = pit.ny - Y_OFS_WALK_GB;
			//			trace("repositoin: "+samus.repositionWalkingBullets() );
		}
		
		private function checkDist():void
		{
			shotDist += speed*dt;
			if (shotDist >= SHORT_ARROW_DISTANCE)
				destroy();
		}
		
		override protected function attackObjPiercing(obj:IAttackable):void
		{
			super.attackObjPiercing(obj);
//			if (obj is Enemy)
//				SND_MNGR.playSound(SoundNames.SFX_SAMUS_HIT_ENEMY);
		}
		override public function hitGround(ground:Ground,side:String):void
		{
			super.hitGround(ground,side);
			if (!ground.hitTestTypesDct[HT_BRICK])
				destroy();
		}
		override protected function attackObjNonPiercing(obj:IAttackable):void
		{
			super.attackObjNonPiercing(obj);
//			SND_MNGR.playSound(SoundNames.SFX_SAMUS_BULLET_PROOF);
		}
		
		override public function cleanUp():void
		{
			super.cleanUp();
			if (shotType == SHOT_TYPE_ARROW)
				pit.ARROW_DCT.removeItem(this);
		}
	}
	
}