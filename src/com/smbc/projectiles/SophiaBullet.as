package com.smbc.projectiles
{
	import com.explodingRabbit.cross.gameplay.statusEffects.StatFxFlash;
	import com.explodingRabbit.cross.gameplay.statusEffects.StatusEffect;
	import com.explodingRabbit.cross.gameplay.statusEffects.StatusProperty;
	import com.explodingRabbit.utils.CustomDictionary;
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.characters.Character;
	import com.smbc.characters.Sophia;
	import com.smbc.data.AnimationTimers;
	import com.smbc.data.Cheats;
	import com.smbc.data.DamageValue;
	import com.smbc.data.PaletteTypes;
	import com.smbc.data.PickupInfo;
	import com.smbc.data.SoundNames;
	import com.smbc.enemies.Enemy;
	import com.smbc.graphics.SophiaExplosion;
	import com.smbc.ground.Brick;
	import com.smbc.ground.Ground;
	import com.smbc.interfaces.IAttackable;
	import com.smbc.interfaces.ICustomTimer;
	import com.smbc.level.Level;
	import com.smbc.main.AnimatedObject;
	import com.smbc.utils.GameLoopTimer;
	
	import flash.events.TimerEvent;

	public class SophiaBullet extends Projectile
	{
		private static const FL_CRUSHER_END:String = "crusherEnd";
		private static const FL_CRUSHER_START:String = "crusherStart";
		private static const FL_HYPER_START:String = "hyperStart";
		private static const FL_HYPER_END:String = "hyperEnd";
		private static const FL_MISSILE:String = "missile";
		private static const FL_MISSILE_FLAME_START:String = "missileFlameStart";
		private static const FL_MISSILE_FLAME_END:String = "missileFlameEnd";
		private static const FL_NORMAL_START:String = "normalStart";
		private static const FL_NORMAL_END:String = "normalEnd";
		private static const SH_CRUSHER:String = "crusher";
		private static const SH_HYPER:String = "hyper";
		private static const SH_NORMAL:String = "normal";
		public static const SH_HOMING_MISSILE:String = "homingMissile";
		public static const SH_MISSILE:String = "missile";
		private static const ST_ACTIVE:String = "active";
		private static const ST_INACTIVE:String = "inactive";
		private static const HORZ_X_OFS:int = 12;
		private static const HORZ_Y_OFS:int = 25;
		private static const UP_X_OFS:int = 8;
		private static const UP_Y_OFS:int = 50;
		private static const MAIN_ANIM_TMR:CustomTimer = AnimationTimers.ANIM_FAST_TMR;
		private static const SPEED:int = 450;
		private static const MISSILE_MAX_SPEED:int = 425;
		private static const HOMING_MISSILE_ACCELERATION:int = 3000;
		private static const MISSILE_ACCELERATION:int = 700;
		private static const FRICTION:Number = .1;
		private static const FACING_RIGHT_ROTATION_NUM:int = 270;
		private static const FACING_LEFT_ROTATION_NUM:int = 90;
		private static const MISSILE_POS_TOP:String = "top";
		private static const MISSILE_POS_MID:String = "mid";
		private static const MISSILE_POS_BOT:String = "bot";
		private static const SHOT_DIR_UP:String = "up";
		private static const SHOT_DIR_RIGHT:String = "right";
		private static const SHOT_DIR_DOWN:String = "down";
		private static const SHOT_DIR_LEFT:String = "left";
		private var shotDir:String; 
		private var missilePos:String;
		private static const PAL_ORDER_ARR:Array = [ PaletteTypes.FLASH_GENERAL ];
		private var sophia:Sophia;
		public var shotType:String;
		private var enemyToTrack:Enemy;
		private var missileSpeed:Number = 0;
		private var missileExpireTmr:GameLoopTimer;
		private var missile:Boolean;
		private static const DEL_MISSILE_EXPIRE:int = 2000;
		private static const TRI_MISSILE_ANGLE_SPEED:int = 120; 
		private static const FRICT_MISSILE:Number = .6;
		
		public function SophiaBullet(sophia:Sophia,shotType:String = null,missilePos:String = null)
		{
			this.sophia = sophia;
			super(sophia,SOURCE_TYPE_PLAYER);
			this.missilePos = missilePos;
			for each (var prop:StatusProperty in Sophia.DEFAULT_PROPS_DCT)
			{
				addProperty(prop);
			}
			defyGrav = true;
			stopAnim = false;
			mainAnimTmr = MAIN_ANIM_TMR;
			this.shotType = shotType;
			setShotType();
			setDir();
			if (!missile)
			{
				addHitTestableItem(HT_GROUND_NON_BRICK);
				addHitTestableItem(HT_PLATFORM);
				
			}
			vxMax = MISSILE_MAX_SPEED;
			vyMax = MISSILE_MAX_SPEED;
			palOrderArr = PAL_ORDER_ARR.concat();
		}
		override public function setStats():void
		{
			super.setStats();
			if (shotType == SH_HOMING_MISSILE)
				getEnemyToTrack();
		}
		private function setShotType():void
		{
			if (shotType == SH_HOMING_MISSILE)
			{
				SND_MNGR.playSound(SoundNames.SFX_SOPHIA_MISSILE);
				removeHitTestableItem(HT_BRICK);
				setState(ST_ACTIVE);
				missile = true;
				gotoAndStop(FL_MISSILE_FLAME_START);
				_damageAmt = DamageValue.SOPHIA_MISSILE;
//				addProperty( new StatusProperty(PR_PIERCE_AGG,10) );
				destroyOffScreen = false;
				updateOffScreen = true;
				return;
			}
			else if (shotType == SH_MISSILE)
			{
				SND_MNGR.playSound(SoundNames.SFX_SOPHIA_MISSILE);
				setState(ST_ACTIVE);
				missile = true;
				gotoAndStop(FL_MISSILE_FLAME_START);
				_damageAmt = DamageValue.SOPHIA_MISSILE;
				addProperty( new StatusProperty(PR_PIERCE_AGG,10) );
				return;
			}
			if (sophia.upgradeIsActive( PickupInfo.SOPHIA_CRUSHER ) )
				shotType = SH_CRUSHER;
			else if (sophia.upgradeIsActive( PickupInfo.SOPHIA_HYPER ) )
				shotType = SH_HYPER
			else
				shotType = SH_NORMAL;
			switch (shotType)
			{
				case SH_NORMAL:
				{
					shotType = SH_NORMAL;
					gotoAndStop(FL_NORMAL_START);
					SND_MNGR.playSound(SoundNames.SFX_SOPHIA_SHOOT_NORMAL);
					_damageAmt = DamageValue.SOPHIA_BULLET_NORMAL;
					break;
				}
				case SH_HYPER:
				{
					shotType = SH_HYPER;
					gotoAndStop(FL_HYPER_START);
					SND_MNGR.playSound(SoundNames.SFX_SOPHIA_SHOOT_HYPER);
					_damageAmt = DamageValue.SOPHIA_BULLET_HYPER;
					break;
				}
				case SH_CRUSHER:
				{
//					flashTmr = new GameLoopTimer(AnimationTimers.DEL_FAST);
					if (shotType == SH_CRUSHER)
						addStatusEffect( new StatFxFlash(this, AnimationTimers.DEL_FAST) );
					shotType = SH_CRUSHER;
					gotoAndStop(FL_CRUSHER_START);
					SND_MNGR.playSound(SoundNames.SFX_SOPHIA_SHOOT_CRUSHER);
					_damageAmt = DamageValue.SOPHIA_BULLET_CRUSHER;
					break;
				}
				default:
				{
					throw new Error("Sophia's shot type must be set!");
					break;
				}
			}
		}
		
		override protected function setDir():void
		{
			var dirNumHorz:int;
			var dirNumVert:int;
			if (!sophia.vertical)
			{
				dirNumHorz = sophia.sophiaScaleX;
				scaleX = dirNumHorz;
				if (sophia.rotation == Sophia.ROT_WALL_BOT)
					dirNumVert = 1;
				else
					dirNumVert = -1;
				if (sophia.sophiaBase.currentLabel != Sophia.SHOOT_UP_FRAME) // shooting horizontal
				{
						vx = SPEED*dirNumHorz;
						x = sophia.nx + HORZ_X_OFS*dirNumHorz;
						y = sophia.ny - HORZ_Y_OFS*dirNumVert;
				}
				else // shooting up
				{
					if (scaleX > 0)
						rotation = FACING_RIGHT_ROTATION_NUM + sophia.rotation;
					else
						rotation = FACING_LEFT_ROTATION_NUM + sophia.rotation;
					x = sophia.nx - UP_X_OFS*dirNumHorz;
					vy = -SPEED*dirNumVert;
					y = sophia.ny - UP_Y_OFS*dirNumVert;
				}
			}
			else
			{
				dirNumVert = sophia.sophiaScaleX;
				scaleX = dirNumVert;
				if (sophia.rotation == Sophia.ROT_WALL_LEFT)
					dirNumHorz = -1;
				else
					dirNumHorz = 1;
				if (sophia.sophiaBase.currentLabel != Sophia.SHOOT_UP_FRAME) // shooting horizontal
				{
					vy = SPEED*dirNumVert;
					x = sophia.nx - HORZ_Y_OFS*dirNumHorz;
					y = sophia.ny + HORZ_X_OFS*dirNumVert;
					rotation = -sophia.rotation*dirNumHorz;
				}
				else // shooting up
				{
					if (scaleX > 0)
						rotation = FACING_RIGHT_ROTATION_NUM + sophia.rotation;
					else
						rotation = FACING_LEFT_ROTATION_NUM + sophia.rotation;
					vx = -SPEED*dirNumHorz;
					x = sophia.nx - UP_Y_OFS*dirNumHorz;
					y = sophia.ny - UP_X_OFS*dirNumVert;
				}
			}
			if (shotType === SH_HOMING_MISSILE)
			{
				vx = 0;
				vy = 0;
				scaleX = 1;
			}
			else if (shotType == SH_MISSILE)
			{
				var mult:int = 1;
				if (missilePos == MISSILE_POS_TOP)
					mult = -1;
				if (vy == 0) // moving horizontally
				{
					if (vx > 0)
						shotDir = SHOT_DIR_RIGHT;
					else
						shotDir = SHOT_DIR_LEFT;
					if (missilePos != MISSILE_POS_MID)
						vy = TRI_MISSILE_ANGLE_SPEED*mult;
				}
				else if (vx == 0)
				{
					if (vy > 0)
						shotDir = SHOT_DIR_DOWN;
					else
						shotDir = SHOT_DIR_UP;
					if (missilePos != MISSILE_POS_MID)
						vx = TRI_MISSILE_ANGLE_SPEED*mult;
				}
				if (shotDir == SHOT_DIR_LEFT || shotDir == SHOT_DIR_RIGHT)
					vx = 0;
				else
					vy = 0;
			}
		}
		private function getEnemyToTrack():void
		{
			var cDist:Number;
			var nDist:Number;
			for each (var ao:AnimatedObject in level.AO_STG_DCT)
			{
				if ( !(ao is Enemy) || (ao.getProperty(PR_PIERCE_PAS) && !Cheats.allWeaponsPierce) )
					continue;
				if (!enemyToTrack && !ao.stopHit && ao.onScreen)
				{
					enemyToTrack = ao as Enemy;
					cDist = level.getDistance(hMidX,hMidY,ao.hMidX,ao.hMidY);
				}
				else if (!ao.stopHit && ao.onScreen)
				{
					nDist = level.getDistance(hMidX,hMidY,ao.hMidX,ao.hMidY);
					if (nDist < cDist)
						enemyToTrack = ao as Enemy;
				}
			}
			if (cState == ST_ACTIVE && !enemyToTrack)
				deactivateMissile();
			else if (cState == ST_INACTIVE && enemyToTrack)
				reactivateMissile();
		}
		override protected function updateStats():void
		{
			super.updateStats();
			if (shotType == SH_MISSILE)
			{
				if (shotDir == SHOT_DIR_RIGHT)
				{
					vx += MISSILE_ACCELERATION*dt;
					if (missilePos != MISSILE_POS_MID)
						vy *= Math.pow(FRICT_MISSILE,dt);
				}
				else if (shotDir == SHOT_DIR_LEFT)
				{
					vx -= MISSILE_ACCELERATION*dt;
					if (missilePos != MISSILE_POS_MID)
						vy *= Math.pow(FRICT_MISSILE,dt);
				}
				else if (shotDir == SHOT_DIR_DOWN)
				{
					vy += MISSILE_ACCELERATION*dt;
					if (missilePos != MISSILE_POS_MID)
						vx *= Math.pow(FRICT_MISSILE,dt);
				}
				else if (shotDir == SHOT_DIR_UP)
				{
					vy -= MISSILE_ACCELERATION*dt;
					if (missilePos != MISSILE_POS_MID)
						vx *= Math.pow(FRICT_MISSILE,dt);
				}
			}
			if (shotType != SH_HOMING_MISSILE)
				return;
			verifyEnemyToTrack();
			if (cState === ST_ACTIVE)
			{
				var yDist:Number = enemyToTrack.hMidY - hMidY;
				var xDist:Number = enemyToTrack.hMidX - hMidX;
				var radian:Number = Math.atan2(yDist, xDist);
				missileSpeed += HOMING_MISSILE_ACCELERATION*dt;
				/*if (Math.sqrt(yDist*yDist +  xDist*xDist) < speed)
				{
					nx = enemyToTrack.nx;
					ny = enemyToTrack.ny;
				}
				else
				{*/
					vx += Math.cos(radian) * missileSpeed*dt;
					vy += Math.sin(radian) * missileSpeed*dt;
					vx *= Math.pow(FRICTION,dt);
					vy *= Math.pow(FRICTION,dt);
					rotation = radian * 180 / Math.PI;
				//}
			}
		}
		private function verifyEnemyToTrack():void
		{
			if (enemyToTrack)
			{
				if (enemyToTrack.stopHit || !enemyToTrack.onScreen)
				{
					enemyToTrack = null;
					getEnemyToTrack();
				}
			}
			else
				getEnemyToTrack();
		}
		
		override protected function attackObjPiercing(obj:IAttackable):void
		{
			super.attackObjPiercing(obj);
			if (obj is Enemy && obj.health > 0)
				SND_MNGR.playSound(SoundNames.SFX_SOPHIA_HIT_ENEMY);
		}
		
		override protected function attackObjNonPiercing(obj:IAttackable):void
		{
			super.attackObjNonPiercing(obj);
			level.addToLevel(new SophiaExplosion(this));
		}
		
		public static function launchMissiles(sophia:Sophia):void
		{
			var level:Level = Level.levelInstance;
			level.addToLevel( new SophiaBullet(sophia, SH_MISSILE, MISSILE_POS_BOT) );
			level.addToLevel( new SophiaBullet(sophia, SH_MISSILE, MISSILE_POS_MID) );
			level.addToLevel( new SophiaBullet(sophia, SH_MISSILE, MISSILE_POS_TOP) );
		}
		private function deactivateMissile():void
		{
			stopAnim = true;
			enemyToTrack = null;
			destroyOffScreen = true;
			updateOffScreen = false;
			gotoAndStop(FL_MISSILE);
			setState(ST_INACTIVE);
			missileExpireTmr = new GameLoopTimer(DEL_MISSILE_EXPIRE,1);
			missileExpireTmr.addEventListener(TimerEvent.TIMER_COMPLETE,missileExpireTmrHandler,false,0,true);
			addTmr(missileExpireTmr);
			missileExpireTmr.start();
		}
		private function reactivateMissile():void
		{
			stopAnim = false;
			destroyOffScreen = false;
			updateOffScreen = true;
			setState(ST_ACTIVE);
			missileExpireTmr.stop();
			missileExpireTmr.removeEventListener(TimerEvent.TIMER_COMPLETE,missileExpireTmrHandler);
			removeTmr(missileExpireTmr);
			missileExpireTmr = null;
			getEnemyToTrack();
		}
		private function missileExpireTmrHandler(event:TimerEvent):void
		{
			missileExpireTmr.stop();
			missileExpireTmr.removeEventListener(TimerEvent.TIMER_COMPLETE,missileExpireTmrHandler);
			removeTmr(missileExpireTmr);
			missileExpireTmr = null;
			level.addToLevel(new SophiaExplosion(this));
			destroy();
		}
		override public function hitGround(ground:Ground,side:String):void
		{
			if ( !(ground is Brick) || (ground is Brick && Brick(ground).disabled) )
			{
				level.addToLevel(new SophiaExplosion(this));
				destroy();
			}
		}
		override public function animate(ct:ICustomTimer):Boolean
		{
			if (!missile)
				return super.animate(ct);
			else if (!stopAnim)
			{
				if (currentLabel === FL_MISSILE)
					gotoAndStop(FL_MISSILE_FLAME_START);
				else
					gotoAndStop(FL_MISSILE);
				return true;
			}
			return false;
		}
		override protected function removeListeners():void
		{
			super.removeListeners();
			if (missileExpireTmr)
				missileExpireTmr.removeEventListener(TimerEvent.TIMER_COMPLETE,missileExpireTmrHandler);
		}
		override public function checkFrame():void
		{
			var cl:String = currentLabel;
			if ( (shotType == SH_HYPER || shotType == SH_CRUSHER) && cl == FL_CRUSHER_END)
				gotoAndStop(FL_CRUSHER_START);
			else if (shotType == SH_NORMAL && cl == FL_NORMAL_END)
				gotoAndStop(FL_NORMAL_START);
		}
	}
}