package com.smbc.projectiles 
{
	import com.explodingRabbit.cross.gameplay.statusEffects.StatusProperty;
	import com.explodingRabbit.utils.CustomDictionary;
	import com.smbc.characters.Character;
	import com.smbc.characters.Simon;
	import com.smbc.data.AnimationTimers;
	import com.smbc.data.DamageValue;
	import com.smbc.data.SoundNames;
	import com.smbc.enemies.Enemy;
	import com.smbc.graphics.SimonSimpleGraphics;
	import com.smbc.ground.Brick;
	import com.smbc.ground.Ground;
	import com.smbc.interfaces.IAttackable;
	import com.smbc.main.LevObj;
	import com.smbc.sound.SoundContainer;
	import com.smbc.utils.GameLoopTimer;
	
	public class SimonProjectile extends Projectile
	{
		public static const TYPE_AXE:String = "axe";
		public static const TYPE_DAGGER:String = "dagger";
		public static const TYPE_HOLY_WATER:String = "holyWater";
		public static const TYPE_CROSS:String = "cross";
		private static const FL_AXE_END:String = "axeEnd";
		private static const FL_AXE_START:String = "axeStart";
		private static const FL_CROSS_END:String = "crossEnd";
		private static const FL_CROSS_START:String = "crossStart";
		private static const FL_DAGGER:String = "dagger";
		private static const FL_HOLY_WATER_BOTTLE:String = "holyWaterBottle";
		private static const FL_HOLY_WATER_FLAME_END:String = "holyWaterFlameEnd";
		private static const FL_HOLY_WATER_FLAME_START:String = "holyWaterFlameStart";
		private const FL_SIMON_THROW_CROUCH:String = Simon.FL_CROUCH_THROW_END;
		private const FL_SIMON_THROW_STAND:String = Simon.FL_THROW_END;
		private const Y_OFFSET_CROUCH:int = 30;
		private const Y_OFFSET_STAND:int = 50;
		private const X_OFFSET:int = 22;
		private const SFX_SIMON_AXE:String = SoundNames.SFX_SIMON_AXE;
		private const VY_MAX_PSV:int = 900;
		private const AXE_GRAVITY:int = 1500;
		private const AXE_VX:int = 250;
		private const AXE_VY:int = 560;
		private const CROSS_AX:int = 700;
		private const CROSS_VX:int = 200;
		private const CROSS_DISTANCE:int = 220;
		private const HOLY_WATER_GRAVITY:int = 1200;
		private const HOLY_WATER_VX:int = 250;
		private const HOLY_WATER_VY:int = 100;
		private const DAGGER_VX:int = 500;
		private var crossEndX:Number;
		private var crossDirStart:int; // 1 for right, -1 for left 
		private var simon:Simon;
		private var type:String;
		
		public function SimonProjectile(simon:Simon,type:String):void
		{ 
			super(simon,SOURCE_TYPE_PLAYER);
			this.simon = simon;
			this.type = type;
			for each (var prop:StatusProperty in Simon.DEFAULT_PROPS_DCT)
			{
				addProperty(prop);
			}
			setType();
			destroyOffScreen = false;
			dosRht = true;
			dosLft = true;
			dosBot = true;
		}
		private function setType():void
		{
			switch(type)
			{
				case TYPE_AXE:
				{
					gotoAndStop(FL_AXE_START);
					stopAnim = false;
					setStartPos();
					gravity = AXE_GRAVITY;
					addProperty( new StatusProperty( PR_PASSTHROUGH_ALWAYS) );
					vx = AXE_VX*scaleX;
					vy = -AXE_VY;
					vyMaxPsv = VY_MAX_PSV;
					_damageAmt = DamageValue.SIMON_AXE;
					SND_MNGR.playSound(SFX_SIMON_AXE);
					break;
				}
				case TYPE_CROSS:
				{
					gotoAndStop(FL_CROSS_START);
					stopAnim = false;
					defyGrav = true;
					setStartPos();
					vx = CROSS_VX*scaleX;
					_damageAmt = DamageValue.SIMON_CROSS;
					addProperty( new StatusProperty( PR_PASSTHROUGH_ALWAYS ) );
					crossEndX = x + CROSS_DISTANCE*scaleX;
					ax = NaN;
					crossDirStart = scaleX;
					vxMax = Math.abs(vx);
					SND_MNGR.playSound(SoundNames.SFX_SIMON_CROSS);
					break;
				}
				case TYPE_DAGGER:
				{
					gotoAndStop(FL_DAGGER);
					stopAnim = true;
					defyGrav = true;
					setStartPos();
					vx = DAGGER_VX*scaleX;
					_damageAmt = DamageValue.SIMON_DAGGER;
					SND_MNGR.playSound(SoundNames.SFX_SIMON_THROW_DAGGER);
					break;
				}
				case TYPE_HOLY_WATER:
				{
					gotoAndStop(FL_HOLY_WATER_BOTTLE);
					stopAnim = true;
					accurateAnimTmr = new GameLoopTimer(AnimationTimers.DEL_SLOWEST);
					setStartPos();
					addProperty( new StatusProperty( PR_PASSTHROUGH_ALWAYS ) );
					addProperty( new StatusProperty( PR_PIERCE_AGG, PIERCE_STR_ARMOR_PIERCING ) );
					vx = HOLY_WATER_VX*scaleX;
					vy = -HOLY_WATER_VY;
					gravity = HOLY_WATER_GRAVITY;
					addAllGroundToHitTestables();
					_damageAmt = DamageValue.SIMON_HOLY_WATER_BOTTLE;
					break;
				}
			}
		}
		private function setStartPos():void
		{
			var cl:String = simon.currentLabel;
			var simonScaleX:int = simon.scaleX;
			x = simon.nx + X_OFFSET*simonScaleX;
			scaleX = simonScaleX;
			if (cl == FL_SIMON_THROW_CROUCH)
				y = simon.ny - Y_OFFSET_CROUCH;
			else
				y = simon.ny - Y_OFFSET_STAND;
		}
		
		override public function updateObj():void
		{
			super.updateObj();
			if (type == TYPE_CROSS)
			{ 
				if (isNaN(ax))
				{
					if ( ( scaleX > 0 && nx > crossEndX ) || ( scaleX < 0 && nx < crossEndX ) )
						ax = -crossDirStart*CROSS_AX;
				}
				else
				{
					vx += ax*dt;
					if (!hitTestTypesDct[HT_PROJECTILE_ENEMY] && ( (crossDirStart > 0 && vx < 0) || (crossDirStart < 0 && vx > 0) ) )
						crossReverse();
				}
			}	
		}
		
		
		private function holyWaterExplode():void
		{
			gotoAndStop(FL_HOLY_WATER_FLAME_START);
			stopAnim = false;
			vx = 0;
			vy = 0;
			defyGrav = true;
			destroyOffScreen = true;
			_damageAmt = DamageValue.SIMON_HOLY_WATER_FLAME;
			C_HIT_DCT.clear();
			L_HIT_DCT.clear();
			clearHitsAfterTime = Simon.HIT_DEL;
			removeHitTestableItem(HT_GROUND_NON_BRICK);
			removeHitTestableItem(HT_PLATFORM);
			SND_MNGR.playSound(SoundNames.SFX_SIMON_HOLY_WATER_EXPLODE);
		}
		private function crossReverse(force:Boolean = false):void
		{
			if (force)
				vx = -vxMax*crossDirStart;
			if (hitTestTypesDct[HT_PROJECTILE_ENEMY])
				return;
			scaleX = -crossDirStart;
			addHitTestableItem(HT_CHARACTER);
			hitTestTypesDct.addItem(HT_PROJECTILE_ENEMY);
		}
		override public function checkLoc():void
		{
			super.checkLoc();
			if (type == TYPE_CROSS && !hitTestTypesDct[HT_PROJECTILE_ENEMY])
			{
//				if (globY - hHeight*.5 <= GLOB_STG_TOP)
//					crossReverse(true);
//				else if (globY + hHeight*.5 >= GLOB_STG_BOT)
//					crossReverse(true);
				if (globX + hWidth*.5 >= GLOB_STG_RHT)
					crossReverse(true);
				else if (globX - hWidth*.5 <= GLOB_STG_LFT)
					crossReverse(true);
			}
		}
		override public function hitCharacter(char:Character,side:String):void
		{
			super.hitCharacter(char,side);
			if (type == TYPE_CROSS)
				destroy();
		}
		
		override protected function attackObjPiercing(obj:IAttackable):void
		{
			super.attackObjPiercing(obj);
			if (obj is Enemy)
			{
				level.addToLevel( new SimonSimpleGraphics(obj as LevObj,SimonSimpleGraphics.TYPE_WHIP_SPARK,this) );
				if (simon.skinNum == Simon.SKIN_SIMON_CV2_NES)
				{
					if (obj.health <= 0)
						SND_MNGR.playSound(SoundNames.SFX_SIMON_KILL_ENEMY_C2);
					else
						SND_MNGR.playSound(SoundNames.SFX_SIMON_HIT_ENEMY_C2);
				}
				else
					SND_MNGR.playSound(SoundNames.SFX_SIMON_HIT_ENEMY);
			}
		}

//		override protected function attackObjNonPiercing(obj:IAttackable):void
//		{
//			super.attackObjNonPiercing(obj);
//			if (obj is Enemy)
//				SND_MNGR.playSound(SoundNames.SFX_SIMON_HIT_ENEMY_ARMOR);
//		}

		override public function hitGround(ground:Ground,side:String):void
		{
			if (type == TYPE_HOLY_WATER && currentLabel == FL_HOLY_WATER_BOTTLE)
				holyWaterExplode();
			super.hitGround(ground,side);
		}
		override public function checkFrame():void
		{
			if (type == TYPE_AXE && currentFrame == convFrameToInt(FL_AXE_END) + 1)
				gotoAndStop(FL_AXE_START);
			else if (type == TYPE_CROSS && currentFrame == convFrameToInt(FL_CROSS_END) + 1)
				gotoAndStop(FL_CROSS_START);
			else if (type == TYPE_HOLY_WATER && currentFrame == convFrameToInt(FL_HOLY_WATER_FLAME_END) + 1)
				destroy();
		}
		override public function cleanUp():void
		{
			super.cleanUp();
			if (type == TYPE_AXE || type == TYPE_CROSS)
			{
				var soundName:String;
				if (type == TYPE_AXE)
					soundName = SFX_SIMON_AXE;
				else if (type == TYPE_CROSS)
					soundName = SoundNames.SFX_SIMON_CROSS;
					
				for each (var proj:Projectile in level.PLAYER_PROJ_DCT)
				{
					if (proj is SimonProjectile && (proj as SimonProjectile).type == type && proj != this)
						return;
				}
				var snd:SoundContainer = SND_MNGR.findSound(soundName);
				if (snd)
				{
					snd.pauseSound();
					SND_MNGR.removeSnd(snd);
				}
			}
		}
	}
	
}