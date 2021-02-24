package com.smbc.characters.base
{
	import com.explodingRabbit.cross.data.ConsoleType;
	import com.explodingRabbit.cross.gameplay.statusEffects.StatFxTransparent;
	import com.explodingRabbit.cross.gameplay.statusEffects.StatusProperty;
	import com.explodingRabbit.cross.games.Games;
	import com.explodingRabbit.cross.sound.Song;
	import com.explodingRabbit.utils.CustomDictionary;
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.characters.Bass;
	import com.smbc.characters.Character;
	import com.smbc.characters.MegaMan;
	import com.smbc.data.AnimationTimers;
	import com.smbc.data.Cheats;
	import com.smbc.data.DamageValue;
	import com.smbc.data.GameSettings;
	import com.smbc.data.MovieClipInfo;
	import com.smbc.data.MusicType;
	import com.smbc.data.PaletteTypes;
	import com.smbc.data.PickupInfo;
	import com.smbc.data.SoundNames;
	import com.smbc.enemies.Enemy;
	import com.smbc.enums.DamageResponse;
	import com.smbc.enums.MegaManShootType;
	import com.smbc.enums.MegaManSpecialWeapon;
	import com.smbc.events.CustomEvents;
	import com.smbc.graphics.*;
	import com.smbc.graphics.BmdInfo;
	import com.smbc.graphics.BmdSkinCont;
	import com.smbc.graphics.SkinNames;
	import com.smbc.ground.Brick;
	import com.smbc.ground.Ground;
	import com.smbc.interfaces.IAttackable;
	import com.smbc.interfaces.ICustomTimer;
	import com.smbc.level.CharacterSelect;
	import com.smbc.level.TitleLevel;
	import com.smbc.main.LevObj;
	import com.smbc.managers.GraphicsManager;
	import com.smbc.managers.StatManager;
	import com.smbc.managers.TutorialManager;
	import com.smbc.pickups.MegaManPickup;
	import com.smbc.pickups.Pickup;
	import com.smbc.pickups.PipeTransporter;
	import com.smbc.pickups.Rush;
	import com.smbc.pickups.Vine;
	import com.smbc.projectiles.*;
	import com.smbc.sound.MusicInfo;
	import com.smbc.sound.SoundContainer;
	import com.smbc.utils.GameLoopTimer;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	import org.si.sound.core.EffectChain;
	
	public class MegaManBase extends Character
	{
		public static const PROTO_MAN_NAME:String = "Proto Man";
		public static const PROTO_MAN_SKIN:Array = [ 3, 4, 5, 8, 9, 19 ];
		
		public static const TELEPORT_SPEED:int = 600;
		private var chargePalYOfs:int = 0;
		private static const CHARGE_PAL_NUM_ROWS:int = 6;
		private static const CHARGE_PAL_FULL_CHARGE_START_OFS:int = 3;
//		private var paletteChargeMegaBuster:Palette;
		private var paletteChargeMagmaBazooka:Palette;
		protected static const PAL_TYPE_CHARGE:String = "charge";
		protected static const PAL_TYPE_CHARGE_FIRE_POWER:String = "chargeFirePower";
		private static const PR_TYPE_SUPER_ARM_GRABBABLE:String = StatusProperty.TYPE_SUPER_ARM_GRABBABLE_PAS;
		public static const IND_CI_MegaManSuitColors:int = 1;
		public static const IND_CI_MegaManFlash:int = 2;
		public static const IND_CI_MegaManChargeMegaBuster:int = 4;
		public static const IND_CI_MegaManChargeMagmaBazooka:int = 5;
		public static const IND_CI_Portrait:int = 6;
		public static const IND_CI_Energy:int = 7;
		private static const DIE_TMR_DEL_NORMAL:int = 2500;
		private static const DIE_TMR_DEL_PIT:int = 2500;
		protected static const MAX_WPN_ENGY:int = 112;
		protected static const MM_BASS_BUSTER:String = PickupInfo.MEGA_MAN_BASS_BUSTER;
		protected static const MM_CHARGE_KICK:String = PickupInfo.MEGA_MAN_CHARGE_KICK;
		protected static const MM_CHARGE_SHOT:String = PickupInfo.MEGA_MAN_CHARGE_SHOT;
		protected static const MM_ENERGY_BALANCER:String = PickupInfo. MEGA_MAN_ENERGY_BALANCER;
		protected static const MM_FLAME_BLAST:String = PickupInfo.MEGA_MAN_FLAME_BLAST;
		protected static const MM_HARD_KNUCKLE:String = PickupInfo.MEGA_MAN_HARD_KNUCKLE;
		protected static const MM_MAGMA_BAZOOKA:String = PickupInfo.MEGA_MAN_MAGMA_BAZOOKA;
		protected static const MM_MEGA_BUSTER:String = PickupInfo.MEGA_MAN_MEGA_BUSTER;	
		protected static const MM_METAL_BLADE:String = PickupInfo.MEGA_MAN_METAL_BLADE;
		protected static const MM_PHARAOH_SHOT:String = PickupInfo.MEGA_MAN_PHARAOH_SHOT;
		protected static const MM_RUSH_COIL:String = PickupInfo.MEGA_MAN_RUSH_COIL;
		protected static const MM_RUSH_JET:String = PickupInfo.MEGA_MAN_RUSH_JET;
		protected static const MM_MAN_RUSH_MARINE:String = PickupInfo.MEGA_MAN_RUSH_MARINE;
		protected static const MM_SCREW_CRUSHER:String = PickupInfo.MEGA_MAN_SCREW_CRUSHER;
		protected static const MM_SUPER_ARM:String = PickupInfo.MEGA_MAN_SUPER_ARM;
		protected static const MM_WATER_SHIELD:String = PickupInfo.MEGA_MAN_WATER_SHIELD;
		private static const SWAP_ATTACK_BUTTONS_STR:String = MM_HARD_KNUCKLE;
		
//		private static const COLLECTABLE_WEAPONS:Vector.<String> = Vector.<String>([
//			MM_CHARGE_KICK, MM_FLAME_BLAST, MM_HARD_KNUCKLE, MM_MAGMA_BAZOOKA, MM_METAL_BLADE, MM_PHARAOH_SHOT, MM_SUPER_ARM, MM_WATER_SHIELD
//		]);
		
		
		public static const MM_WEAPON_ENERGY_BIG:String = PickupInfo.MEGA_MAN_WEAPON_ENERGY_BIG;
		public static const MM_WEAPON_ENERGY_SMALL:String = PickupInfo.MEGA_MAN_WEAPON_ENERGY_SMALL;
		private static const WEAPON_ENERGY_BIG_RECOVERY:int = 40;
		private static const WEAPON_ENERGY_SMALL_RECOVERY:int = 8;
		public static const ENEMY_CHANGE_COLOR_PNT:Point = new Point(2,41);
		private static const SECONDS_LEFT_SND:String = SoundNames.BGM_MEGA_MAN_SECONDS_LEFT;
		private static const SND_MUSIC_WIN:String = SoundNames.MFX_MEGA_MAN_WIN;
		private static const BASE_FL_WALK:String = "walk";
		private static const BASE_FL_WALK_SHOOT:String = "walkShoot";
		private static const BASE_FL_SHOOT:String = "shoot";
		private static const BASE_FL_JUMP_SHOOT:String = "jumpShoot";
		private static const BASE_FL_UP:String = "Up";		
		private static const BASE_FL_DIAG_UP:String = "DiagUp";		
		private static const BASE_FL_DIAG_DWN:String = "DiagDwn";		
		private static const FL_DASH:String = "dash";
		private static const FL_SLIDE:String = "slide";
		private static const FL_TAKE_DAMAGE:String = "takeDamage";
		private static const FL_JUMP:String = "jump";
		private static const FL_JUMP_SHOOT:String = "jumpShoot";
		private static const FL_JUMP_THROW:String = "jumpThrow";
		private static const FL_SHOOT:String = "shoot";
		private static const FL_THROW:String = "throw";
		private static const FL_STAND:String = "stand";
		private static const FL_STEP:String = "walk-0";
		protected static const FL_TELEPORT_START:String = "teleportStart";
		private static const FL_TELEPORT_2:String = "teleport-2";
		private static const FL_TELEPORT_END:String = "teleportEnd";
		private static const FL_WALK_START:String = "walk-1";
		private static const FL_WALK_2:String = "walk-2";
		private static const FL_WALK_3:String = "walk-3";
		private static const FL_WALK_END:String = "walk-4";
		private static const FL_WALK_SHOOT_START:String = "walkShoot-1";
		private static const FL_WALK_SHOOT_2:String = "walkShoot-2";
		private static const FL_WALK_SHOOT_3:String = "walkShoot-3";		
		private static const FL_WALK_SHOOT_END:String = "walkShoot-4";
		private static const FL_SHOOT_DIAG_DWN:String = BASE_FL_SHOOT + BASE_FL_DIAG_DWN;
		private static const FL_SHOOT_DIAG_UP:String = BASE_FL_SHOOT + BASE_FL_DIAG_UP;
		private static const FL_SHOOT_UP:String = BASE_FL_SHOOT + BASE_FL_UP;
		private static const FL_JUMP_SHOOT_DIAG_DWN:String = BASE_FL_JUMP_SHOOT + BASE_FL_DIAG_DWN;
		private static const FL_JUMP_SHOOT_DIAG_UP:String = BASE_FL_JUMP_SHOOT + BASE_FL_DIAG_UP;
		private static const FL_JUMP_SHOOT_UP:String = BASE_FL_JUMP_SHOOT + BASE_FL_UP;
		private static const FL_ARM_NORMAL:String = "normal";
		private static const FL_ARM_STAND_THROW:String = "standThrow";
		private static const FL_ARM_SUPER_ARM:String = "superArm";
		private static const FL_ARM_SHOOT:String = "shoot";
		private static const FL_ARM_THROW:String = "throw";
		private static const FL_ARM_FIST:String = "fist";
		private static const FL_ARM_NO_HAND:String = "noHand";
		private static const FL_ARM_WALK_1:String = "walk-1";
		private static const FL_ARM_WALK_2:String = "walk-2";
		private static const FL_ARM_WALK_3:String = "walk-3";
		private static const CS_CHARGE_OUTLINE_2:String = "chargeOutline2";
		private static const CS_CHARGE_START:String = "chargeStart";
		private static const CS_FULL_CHARGE:String = "fullCharge";
		private static const CS_NORMAL:String = "normal";
		private static const CS_WEAK_CHARGE:String = "weakCharge";
		private static const NUM_MEGA_BUSTER_SHOTS_ALLOWED:int = 3;
		private static const NUM_BASS_BUSTER_NO_MUSHROOM_SHOTS_ALLOWED:int = 3;
		private static const NUM_BASS_BUSTER_SHOTS_ALLOWED:int = 4;
		private static const NUM_METAL_BLADES_ALLOWED:int = 3;
		private static const NUM_HARD_KNUCKLES_ALLOWED:int = 1;
		private static const NUM_PHARAOH_SHOTS_ALLOWED:int = 1;
		private static const NUM_FLAME_BLASTS_ALLOWED:int = 3;
		private static const NUM_MAGMA_BAZOOKAS_ALLOWED:int = 1;
		private static const NUM_SCREW_CRUSHERS_ALLOWED:int = 4;
		public static const ST_SLIDE:String = "slide";
		private static const SUIT_COLOR_OFS_DCT:Dictionary = new Dictionary();
		private static const WEAPON_FLASH_COLORS_OFFSETS_DCT:Dictionary = new Dictionary();
		private static const WEAPON_FLASH_PALETTES_DCT:Dictionary = new Dictionary();
		private static const SKIN_APPEARANCE_NUM_DCT:Dictionary = new Dictionary();
		{
			SUIT_COLOR_OFS_DCT[MM_BASS_BUSTER] = 1;
			SUIT_COLOR_OFS_DCT[MM_MEGA_BUSTER] = 1;
			SUIT_COLOR_OFS_DCT[MM_RUSH_COIL] = 2;
			SUIT_COLOR_OFS_DCT[MM_SUPER_ARM] = 3;
			SUIT_COLOR_OFS_DCT[MM_METAL_BLADE] = 4;
			SUIT_COLOR_OFS_DCT[MM_HARD_KNUCKLE] = 5;
			SUIT_COLOR_OFS_DCT[MM_PHARAOH_SHOT] = 6;
			SUIT_COLOR_OFS_DCT[MM_CHARGE_KICK] = 7;
			SUIT_COLOR_OFS_DCT[MM_FLAME_BLAST] = 8;
			SUIT_COLOR_OFS_DCT[MM_MAGMA_BAZOOKA] = 9;
			SUIT_COLOR_OFS_DCT[MM_WATER_SHIELD] = 10;
			SUIT_COLOR_OFS_DCT[MM_SCREW_CRUSHER] = 11;
			
			SKIN_APPEARANCE_NUM_DCT[ MM_BASS_BUSTER ] = 0;
			SKIN_APPEARANCE_NUM_DCT[ MM_MEGA_BUSTER ] = 0;
			SKIN_APPEARANCE_NUM_DCT[ MM_RUSH_COIL ] = 0;
			SKIN_APPEARANCE_NUM_DCT[ MM_SUPER_ARM ] = 1;
			SKIN_APPEARANCE_NUM_DCT[ MM_METAL_BLADE ] = 2;
			SKIN_APPEARANCE_NUM_DCT[ MM_HARD_KNUCKLE ] = 3;
			SKIN_APPEARANCE_NUM_DCT[ MM_PHARAOH_SHOT ] = 4;
			SKIN_APPEARANCE_NUM_DCT[ MM_CHARGE_KICK ] = 5;
			SKIN_APPEARANCE_NUM_DCT[ MM_FLAME_BLAST ] = 6;
			SKIN_APPEARANCE_NUM_DCT[ MM_MAGMA_BAZOOKA ] = 7;
			SKIN_APPEARANCE_NUM_DCT[ MM_WATER_SHIELD ] = 8;
			SKIN_APPEARANCE_NUM_DCT[ MM_SCREW_CRUSHER ] = 9;
			
			WEAPON_FLASH_COLORS_OFFSETS_DCT[ MM_BASS_BUSTER ] = 4;
			WEAPON_FLASH_COLORS_OFFSETS_DCT[ MM_MEGA_BUSTER ] = 4;
			WEAPON_FLASH_COLORS_OFFSETS_DCT[ MM_RUSH_COIL ] = 4;
			WEAPON_FLASH_COLORS_OFFSETS_DCT[ MM_SUPER_ARM ] = 8;
			WEAPON_FLASH_COLORS_OFFSETS_DCT[ MM_METAL_BLADE ] = 9;
			WEAPON_FLASH_COLORS_OFFSETS_DCT[ MM_HARD_KNUCKLE ] = 10;
			WEAPON_FLASH_COLORS_OFFSETS_DCT[ MM_PHARAOH_SHOT ] = 11;
			WEAPON_FLASH_COLORS_OFFSETS_DCT[ MM_CHARGE_KICK ] = 12;
			WEAPON_FLASH_COLORS_OFFSETS_DCT[ MM_FLAME_BLAST ] = 13;
			WEAPON_FLASH_COLORS_OFFSETS_DCT[ MM_MAGMA_BAZOOKA ] = 14;
			WEAPON_FLASH_COLORS_OFFSETS_DCT[ MM_WATER_SHIELD ] = 15;
			WEAPON_FLASH_COLORS_OFFSETS_DCT[ MM_SCREW_CRUSHER ] = 16;
		}
		private const SFX_MEGA_MAN_CHARGE_LOOP:String = SoundNames.SFX_MEGA_MAN_CHARGE_LOOP;
		private const SFX_MEGA_MAN_CHARGE_START:String = SoundNames.SFX_MEGA_MAN_CHARGE_START;
		private const SFX_MEGA_MAN_CHARGE_HEAT_START:String = SoundNames.SFX_MEGA_MAN_CHARGE_HEAT_START;
		private const SFX_MEGA_MAN_CHARGE_HEAT_LOOP:String = SoundNames.SFX_MEGA_MAN_CHARGE_HEAT_LOOP;
		private const SFX_MEGA_MAN_LAND:String = SoundNames.SFX_MEGA_MAN_LAND;
		private static const SN_GET_ENERGY:String = SoundNames.SFX_MEGA_MAN_GET_ENERGY;
		private static const SN_CHARGE_KICK:String = SoundNames.SFX_MEGA_MAN_CHARGE_KICK;
		private static const SN_TAKE_DAMAGE:String = SoundNames.SFX_MEGA_MAN_TAKE_DAMAGE;
		private var chargeCtr:int;
		private const NUM_CHARGE_COLORS:int = 3;
		private var shoot:Boolean;
		public var shiftBullet:Boolean;
		private var shootTmr:CustomTimer;
		private var damageSplash:MegaManSimpleGraphics;
		private var slideDust:MegaManSimpleGraphics;
		private const SHOOT_TMR_DUR:int = 200;
		private static const SLIDE_SPEED:int = 300;
		private var slideSpeed:int = SLIDE_SPEED;
		private const SLIDE_SPEED_WATER:int = slideSpeed;
		private const TOT_SLIDE_DIST:int = 125;
		private const TOT_SLIDE_DIST_WATER:int = TOT_SLIDE_DIST; // 100;
		private var slideStartX:Number;
		private var slideEndX:Number;
		private var chargeTmr:CustomTimer;
		private const CHARGE_START_DUR:int = 550;
		private const CHARGE_OUTLINE_2_DUR:int = 250;
		private const WEAK_CHARGE_DUR:int = 300;
		private const FULL_CHARGE_DUR:int = 350;
		private const DEFAULT_ANIM_TMR:CustomTimer = AnimationTimers.ANIM_SLOW_TMR;
		private const GRAVITY:int = 1500;
		private const GRAVITY_WATER:int = 500;
		private const JUMP_PWR:int = 565;
		private const JUMP_PWR_HIGH_JUMP:int = 650;
		private const JUMP_PWR_WATER:int = 500;
		private const JUMP_PWR_WATER_HIGH_JUMP:int = 560;
		private const DEF_SPRING_PWR:int = 475;
		private const BOOST_SPRING_PWR:int = 1000;
		private static const WALK_SPEED:int = 165;
		private var walkSpeed:int = WALK_SPEED;
		private var chargeState:String;
		private static const FLICKER_TMR_DEL:int = 70;
		private static const NO_DAMAGE_TMR_DEL:int = 1250;
//		private static const WEAPON_ICON_TMR_DEL:int = 1500;
		public var head:MegaManHead;
		public var arm:MegaManArm;
		private var particleTmr:CustomTimer;
		private var partVec:Vector.<MegaManParticle>;
		private const TUT_MNGR:TutorialManager = TutorialManager.TUT_MNGR;
		public var chargeShot:MegaManProjectile;
		public var stopSlide:Boolean;
		private const SLIDE_CEILING_CHECK_DIST:int = 50;
		private const SLIDE_TOP_OFS:int = 30;
		private const SLIDE_BOT_OFS:int = 10;
		private var ceilingAboveSlide:Boolean;
		private var useEnterPipeVxMax:Boolean;
		private var takeDamageTmr:GameLoopTimer;
		private static const TAKE_DAMAGE_TMR_DEL:int = 450;
		private static const TAKE_DAMAGE_TMR_DEL_LONG:int = 450;
		private static const TAKE_DAMAGE_SPEED:int = 80;
		private static const TAKE_DAMAGE_SPEED_LONG:int = 160;
		private const STEP_TMR:CustomTimer = new CustomTimer(100,1);
		private const NSF_STR_DIE:String = MusicInfo.CHAR_STR_MEGA_MAN + MusicInfo.TYPE_DIE;
		private static const MEGA_MAN_HEAD_REMOVE_ARR:Array = [ FL_TELEPORT_START, FL_TELEPORT_2, FL_TELEPORT_END ];
		private static const ARM_STAY_ARR:Array = [ FL_STAND, FL_STEP, FL_SHOOT, FL_WALK_START, FL_WALK_2, FL_WALK_3, FL_WALK_END, 
			FL_WALK_SHOOT_START, FL_WALK_SHOOT_2, FL_WALK_SHOOT_3, FL_WALK_SHOOT_END, FL_JUMP_SHOOT, FL_THROW, FL_JUMP_THROW];
		public var rush:Rush;
		protected static const WEAPON_VEC_DEF:Vector.<String> = Vector.<String>([
			MM_MEGA_BUSTER, MM_SUPER_ARM, MM_METAL_BLADE, MM_HARD_KNUCKLE, MM_PHARAOH_SHOT, MM_CHARGE_KICK, MM_FLAME_BLAST, MM_MAGMA_BAZOOKA, MM_WATER_SHIELD, MM_SCREW_CRUSHER, MM_RUSH_COIL
		]);
		private var throwUsesNonShootFrames:Boolean;
		public var rotateBassBuster:Boolean;
		private var customThrowFrames:Boolean;
		private var armCustomFrame:Boolean; // for when proto man should use alternate frames
		protected const weaponVec:Vector.<String> = new Vector.<String>();
		protected var primaryWeapon:String;
		protected var changesColorOnPState:Boolean;
		protected var carryingItem:Brick;
		private static const SUPER_ARM_ITEM_X_OFS:int = 4;
		private static const SUPER_ARM_ITEM_Y_OFS:int = 10;
		private var energyBar:MegaManEnergyBar;
		
		protected var doubleJumpSkill:Boolean;
		private var canDoubleJump:Boolean;
		private var attackSlide:Boolean;
		protected var defWeapon:String;
		protected var rapidFireTmr:GameLoopTimer;
		protected static const BASS_BUSTER_DEL:int = 75;
		private var stopWhileShooting:Boolean;
		protected var canDashJump:Boolean;
		private static const STEP_MOVE_AMT:int = 4;
		protected var showHead:Boolean;
		public var waterShieldDct:CustomDictionary = new CustomDictionary();
		public var pharaohBalloon:MegaManProjectile;
		private var chargeKickGraphic:MegaManSimpleGraphics;
		public static const DEFAULT_PROPS_DCT:CustomDictionary = new CustomDictionary();
		private var energyTmr:Timer;
		private var ammoTypeToRefill:String;
		private static const ENERGY_TMR_DUR:int = 50;
		private static const ANIM_TMR_CLIMB:CustomTimer = AnimationTimers.ANIM_SLOWEST_TMR;
		private var energiesGottenSimultaneously:Vector.<MegaManPickup> = new Vector.<MegaManPickup>();
		
		private var skinDisableSlide:Boolean;
		private var oneThirdOfUpgradesCount:int;
		private var releasePharoahBalloonAfterSlide:Boolean;
		private var chargeType:MegaManShootType;
//		private var freezeStopAnim:Boolean;
		
		public static var skinProtoMan:Boolean;
		
		override public function get classicGetMushroomUpgrades():Vector.<String>
		{ return Vector.<String>([ MM_CHARGE_SHOT ]); }
		
		override public function get classicGetFireFlowerUpgrades():Vector.<String>
		{ return Vector.<String>([ classicWeapon ]); }

		public function MegaManBase()
		{
			putSubMcsOnTop = true;
			recolorsCharSkin = true;
			super();
			energyBar = new MegaManEnergyBar(this);
			_secondsLeftSnd = SECONDS_LEFT_SND;
			_sndWinMusic = SND_MUSIC_WIN;
			_secondsLeftSndIsBgm = true;
			_dieTmrDel = DIE_TMR_DEL_NORMAL;
			canCrossSmallGaps = true;
			walkStartLab = FL_WALK_START;
			walkEndLab = FL_WALK_END;
			flickerTmrDel = FLICKER_TMR_DEL;
//			if (showHead)
				head.visible = false;
//			chargePalYOfs = getPalRowOfs( PAL_TYPE_CHARGE );
			if (!DEFAULT_PROPS_DCT.length)
			{
				DEFAULT_PROPS_DCT.addItem( new StatusProperty( StatusProperty.TYPE_TRANSPARENT_AGG, 0, new StatFxTransparent(null,0,40) ) );
			}
			for each (var prop:StatusProperty in DEFAULT_PROPS_DCT)
			{
				addProperty(prop);
			}
		}
		
		private function get chargeKickIsActive():Boolean
		{
			return STAT_MNGR.getSubWeapon(charNum) == MM_CHARGE_KICK;
		}
		
		private function set chargeKickIsActive(value:Boolean):void
		{
			if (value)
				STAT_MNGR.setSubWeapon(charNum, MM_CHARGE_KICK);
			else
				STAT_MNGR.setSubWeapon(charNum, defWeapon);
			changeSuitColor();
			updateDisplay();
		}
		
		protected function get attackButtonsAreSwapped():Boolean
		{
			if (secondaryWeapon == null || secondaryWeapon == MM_CHARGE_KICK)
				return false;
			else
				return STAT_MNGR.getSubWeapon(charNum) == SWAP_ATTACK_BUTTONS_STR;
		}
		
		protected function set attackButtonsAreSwapped(value:Boolean):void
		{
			if (weaponCurrentlyBeingCharged != null)
				resetChargeState();
			if (rapidFireTmr)
				rapidFireTmr.stop();
			
			if (value)
				STAT_MNGR.setSubWeapon(charNum, SWAP_ATTACK_BUTTONS_STR);
			else
				STAT_MNGR.setSubWeapon(charNum, defWeapon);
			updateDisplay();
		}
		
		override protected function get currentSkinAppearanceNum():int
		{
			if (secondaryWeapon == null)
				return 0;
//			trace("skin appearance num: " + SKIN_APPEARANCE_NUM_DCT[secondaryWeapon]);
			return SKIN_APPEARANCE_NUM_DCT[secondaryWeapon];
		}
		
		override protected function setObjsToRemoveFromFrames():void
		{
			super.setObjsToRemoveFromFrames();
			removeObjsFromFrames(MegaManHead,MEGA_MAN_HEAD_REMOVE_ARR);
			removeObjsFromFrames(arm,ARM_STAY_ARR,true);
		}
		override protected function mcReplacePrep(thisMc:MovieClip):void
		{
			var headMc:MovieClip = new MovieClipInfo.MegaManHeadMc();
			var armMc:MovieClip = new MovieClipInfo.MegaManArmMc();
			for (var i:int = 0; i < thisMc.numChildren; i++)
			{
				var dObj:DisplayObject = thisMc.getChildAt(i);
				if (dObj is MovieClip)
				{
					var mc:MovieClip = dObj as MovieClip;
					if (mc.totalFrames == headMc.totalFrames)
					{
						head = new MegaManHead( this, headMc );
						headMc = null;
						headMc = mc;
					}
					else if (mc.totalFrames == armMc.totalFrames)
					{
						arm = new MegaManArm( this );
						armMc = null;
						armMc = mc;
					}
					if (head && arm)
						break;
				}
			}
			mcReplaceArr = [ headMc, head, armMc, arm ];
		}
		override protected function sortDisplayObjects(obj1:DisplayObject,obj2:DisplayObject):int
		{
			if (obj1 is Bitmap && obj2 is SubMc)
			{
				if (obj2 is MegaManHead)
					return -1;
				else
					return 1;
			}
			else if (obj1 is SubMc && obj2 is Bitmap)
			{
				if (obj1 is MegaManHead)
					return 1
				else
					return -1;
			}
			else
				return 0;
		}
		// SETSTATS sets statistics and initializes character
		override public function setStats():void
		{
			if (doubleJumpSkill)
				jumpPwr = JUMP_PWR;
			else
				jumpPwr = JUMP_PWR_HIGH_JUMP;
			gravity = GRAVITY;
			/* inColor1 = 0xFF00E8D8;
			outColor1 = 0xFFFF0000;
			replaceColors = true; */
			if (level.waterLevel)
			{
				defGravity = GRAVITY;
				gravity = GRAVITY_WATER;
				defGravityWater = gravity;
				if (doubleJumpSkill)
					jumpPwr = JUMP_PWR_WATER;
				else
					jumpPwr = JUMP_PWR_WATER_HIGH_JUMP;
			}
			defSpringPwr = DEF_SPRING_PWR;
			boostSpringPwr = BOOST_SPRING_PWR;
			ax = 800;
			fx = .0000001; 
			fy = .000001;
			vxMaxDef = walkSpeed;
			vyMaxPsv = 700;
			vxMax = vxMaxDef;
			vxMin = 5;
			//maxJumpHeight = 650;
			numParFrames = 4;
			pState2 = false;
			if (STAT_MNGR.newLev || GameSettings.classicMode)
				primaryWeapon = defWeapon;
			else
				primaryWeapon = STAT_MNGR.getSubWeapon(charNum);
			super.setStats();
			changeSuitColor();
			vineAnimTmr = ANIM_TMR_CLIMB;
			damageAmt = DamageValue.MEGA_MAN_CHARGE_KICK;
			// initiate timers
			shootTmr = new CustomTimer(SHOOT_TMR_DUR,1)
			shootTmr.addEventListener(TimerEvent.TIMER_COMPLETE,shootTmrHandler);
			addTmr(shootTmr);
			chargeTmr = new CustomTimer(CHARGE_START_DUR,1)
			chargeTmr.addEventListener(TimerEvent.TIMER_COMPLETE,chargeInt);
			addTmr(chargeTmr);
			addTmr(STEP_TMR);
			STEP_TMR.addEventListener(TimerEvent.TIMER_COMPLETE,stepTmrHandler,false,0,true);
			takeDamageTmr = new GameLoopTimer(TAKE_DAMAGE_TMR_DEL,1);
			takeDamageTmr.addEventListener(TimerEvent.TIMER_COMPLETE,takeDamageTmrHandler,false,0,true);
			noDamageTmr.delay = NO_DAMAGE_TMR_DEL;
			if (defWeapon == MM_BASS_BUSTER)
			{
				rapidFireTmr = new GameLoopTimer(BASS_BUSTER_DEL);
				rapidFireTmr.addEventListener(TimerEvent.TIMER,rapidFireTmrHandler,false,0,true);
			}
			setCurrentBmdSkin( STAT_MNGR.getCurrentBmc( charNum ) );
			//if (level.bg.currentLabel == "black")
			//	head.createHairOutline();
			changeBrickState();
		}
		override protected function startAndDamageFcts(start:Boolean = false):void
		{
			super.startAndDamageFcts(start);
			updateWeaponsVec();
			if (!start)
			{
				changeSuitColor();
//				if (!canChargePrimaryWeapon)
					resetChargeState();
				if (GameSettings.classicMode)
				{
					destroyAllMegaManProjectilesBesidesDefaultWeapon();
				}
			}
		}
		
		private function weaponUsesEnergy(weapon:String):Boolean
		{
			if (GameSettings.classicMode && weapon == MM_RUSH_COIL)
				return false;
			return weapon != defWeapon;
		}
		
		public function get primaryOrSecondaryWeaponUsesEnergy():Boolean
		{
			return primaryWeaponUsesEnergy || secondaryWeaponUsesEnergy;
		}
		
		public function get primaryWeaponUsesEnergy():Boolean
		{
			return !(primaryWeapon == null || primaryWeapon == defWeapon);
		}
		
		public function get secondaryWeaponUsesEnergy():Boolean
		{
			return !(secondaryWeapon == null || secondaryWeapon == defWeapon);
		}
		
		protected function get secondaryWeapon():String
		{
			if (GameSettings.classicMode && upgradeIsActive(classicWeapon) )
				return classicWeapon;
			else
				return null;
		}
		
		private function get canChargePrimaryWeapon():Boolean
		{
			return canChargeWeapon(primaryWeapon);
		}
		
		private function get canChargeSecondaryWeapon():Boolean
		{
			return canChargeWeapon(secondaryWeapon);
		}
		
		private function canChargeWeapon(weapon:String):Boolean
		{
			if (weapon == null)
				return false;
			else if ( (weapon == MM_PHARAOH_SHOT && hasEnoughAmmo(MM_PHARAOH_SHOT, MegaManProjectile.TYPE_PHARAOH_BALLOON) )
				|| (weapon == MM_MAGMA_BAZOOKA && hasEnoughAmmo(MM_MAGMA_BAZOOKA, MegaManProjectile.TYPE_MAGMA_BAZOOKA_CHARGE) ) )
				return true;
			else if (this is Bass || skinNum == MegaMan.SKIN_ROKKO_CHAN || skinNum == MegaMan.SKIN_ROCK_NES || skinNum == MegaMan.SKIN_ROCK_SNES)
				return false;
			else if (weapon == MM_MEGA_BUSTER && (upgradeIsActive(MM_CHARGE_SHOT) || skinProtoMan) )
				return true;
			else
				return false;
		}
		
		protected function updateWeaponsVec(inc:int = 0, forceDefWeapon:Boolean = false, updateStatMngr:Boolean = true):void
		{
			var primaryWeaponStart:String = primaryWeapon;
			var cwInd:int;
			weaponVec.length = 0;
			weaponVec.push(defWeapon);
			var n:int = WEAPON_VEC_DEF.length;
			for (var i:int = 0; i < n; i++)
			{
				var upgName:String = WEAPON_VEC_DEF[i];
				if (upgradeIsActive(upgName) && upgName != defWeapon)
				{
					weaponVec.push(upgName);
					if (primaryWeapon == upgName)
						cwInd = weaponVec.length - 1;
				}
			}
			if (inc != 0)
			{
				cwInd += inc;
				var maxInd:int = weaponVec.length - 1;
				if (cwInd > maxInd)
					cwInd = 0;
				else if (cwInd < 0)
					cwInd = maxInd;	
				primaryWeapon = weaponVec[cwInd];
			}
			if ( forceDefWeapon || !upgradeIsActive(primaryWeapon) )
				primaryWeapon = defWeapon;
			if (updateStatMngr && !GameSettings.classicMode)
			{
				STAT_MNGR.setSubWeapon(charNum,primaryWeapon);
//				trace("stat subweapon :"+STAT_MNGR.getSubWeapon(charNum)+" cursubweaon: "+primaryWeapon);
			}
			if (primaryWeaponStart != primaryWeapon)
				changeSuitColor();
			
			updateDisplay();
			
			if (primaryWeapon != MM_CHARGE_KICK)
				attackSlide = false;
			if (primaryWeaponStart != primaryWeapon) // changed weapons
			{
				var projDct:CustomDictionary = level.PLAYER_PROJ_DCT;
				for each (var proj:Projectile in projDct)
				{
					if (proj != hammerWeapon)
						proj.destroy();
				}
				if (rush)
					rush.destroy();
				if (carryingItem)
				{
					EVENT_MNGR.removeEventListener(CustomEvents.LEVEL_SET_INDEXES,levelSetIndexesHandler);
					carryingItem.destroy();
					carryingItem = null;
				}
			}
		}
		
		private function destroyAllMegaManProjectilesBesidesDefaultWeapon():void
		{
			for each (var proj:Projectile in level.PLAYER_PROJ_DCT)
			{
				if (proj is MegaManProjectile && !MegaManProjectile(proj).isDefaultWeapon)
					proj.destroy();
			}
		}
		
		private function updateDisplay():void
		{
			var ammoRemaining:int
			if (primaryWeapon == defWeapon && secondaryWeapon == null)
			{
				tsTxt.UpdAmmoIcon(false);
			}
			else
			{
				var weapon:String = primaryWeapon;
				if (secondaryWeapon != null)
					weapon = secondaryWeapon;
				
				ammoRemaining = getAmmo(weapon);
				if (GameSettings.classicMode)
				{
					if (attackButtonsAreSwapped || (secondaryWeapon == MM_CHARGE_KICK && chargeKickIsActive) )
						tsTxt.UpdAmmoIcon( true, weapon.substr(PickupInfo.UPGRADE_STR.length), TopScreenText.AMMO_ICON_X_ALIGNED );
					else
						tsTxt.UpdAmmoIcon(false);
				}
				else
					tsTxt.UpdAmmoIcon( true, weapon.substr(PickupInfo.UPGRADE_STR.length), TopScreenText.AMMO_ICON_X_ALIGNED );
			}
			energyBar.update( ammoRemaining );
		}
		
		protected function changeSuitColor(yOfs:int = -1):void
		{
			if (yOfs < 0)
			{
				yOfs = SUIT_COLOR_OFS_DCT[primaryWeapon];
				if (GameSettings.classicMode && secondaryWeapon != null)
				{
					yOfs = SUIT_COLOR_OFS_DCT[secondaryWeapon];
					if (secondaryWeapon == MM_CHARGE_KICK && !chargeKickIsActive)
						yOfs = SUIT_COLOR_OFS_DCT[defWeapon];
				}
			}
//			if ( upgradeIsActive(MUSHROOM) )
//				head.visible = false;
//			else
//			{
////				if (showHead)
////					head.visible = true;
////				if (primaryWeapon == MM_MEGA_BUSTER)
////					yOfs--;
//			}
			graphicsMngr.recolorCharacterSheet(charNum,yOfs,[ IND_CI_MegaManSuitColors, IND_CI_Portrait, IND_CI_Energy ]);
			defColors = paletteMain.extractRowsAsPalette(0,yOfs);
//			if (GameSettings.classicMode && secondaryWeapon != null)
//			{
//				yOfs = SUIT_COLOR_OFS_DCT[secondaryWeapon];
//				graphicsMngr.recolorCharacterSheet(charNum,yOfs,[ IND_CI_Energy ]);
//			}
		}
		
		protected function get classicWeapon():String
		{
			return getClassicWeapon(GameSettings.megaManWeapon);
		}
		
		protected function getClassicWeapon(weapon:MegaManSpecialWeapon):String
		{
			switch(weapon)
			{
				case MegaManSpecialWeapon.ChargeKick:
					return PickupInfo.MEGA_MAN_CHARGE_KICK;
				case MegaManSpecialWeapon.FlameBlast:
					return PickupInfo.MEGA_MAN_FLAME_BLAST;
				case MegaManSpecialWeapon.HardKnuckle:
					return PickupInfo.MEGA_MAN_HARD_KNUCKLE;
				case MegaManSpecialWeapon.MagmaBazooka:
					return PickupInfo.MEGA_MAN_MAGMA_BAZOOKA;
				case MegaManSpecialWeapon.MetalBlade:
					return PickupInfo.MEGA_MAN_METAL_BLADE;
				case MegaManSpecialWeapon.PharaohShot:
					return PickupInfo.MEGA_MAN_PHARAOH_SHOT;
				case MegaManSpecialWeapon.ScrewCrusher:
					return PickupInfo.MEGA_MAN_SCREW_CRUSHER;
				case MegaManSpecialWeapon.SuperArm:
					return PickupInfo.MEGA_MAN_SUPER_ARM;
				case MegaManSpecialWeapon.WaterShield:
						return PickupInfo.MEGA_MAN_WATER_SHIELD;
				default:
					return null;
			}
		}
		
		private function updatePalettes():void
		{
			for (var weapon:String in WEAPON_FLASH_COLORS_OFFSETS_DCT)
			{
				var index:int = WEAPON_FLASH_COLORS_OFFSETS_DCT[weapon];
				WEAPON_FLASH_PALETTES_DCT[weapon] = paletteSheet.getPaletteFromRow(index, skinNum);
			}
			paletteChargeMagmaBazooka = paletteSheet.getPaletteFromRow(IND_CI_MegaManChargeMagmaBazooka,skinNum);
		}
		
		override public function setCurrentBmdSkin(bmc:BmdSkinCont, characterInitiating:Boolean = false):void
		{
			super.setCurrentBmdSkin(bmc);
			updatePalettes();
//			paletteChargeMegaBuster = paletteSheet.getPaletteFromRow(IND_CI_MegaManChargeMegaBuster,skinNum);
//			paletteChargeMagmaBazooka = paletteSheet.getPaletteFromRow(IND_CI_MegaManChargeMagmaBazooka,skinNum);
			skinProtoMan = checkSkinProtoMan();
//			if (STAT_MNGR.getSkinName() == PROTO_MAN_NAME)
			// Change shooting frames for Proto Man style skins
			if ( (this is MegaMan) && ( skinProtoMan || skinNum == MegaMan.SKIN_ICE_MAN_NES ) )
			{
				throwUsesNonShootFrames = true;
				customThrowFrames = true;
				showHead = false;
//				head.visible = false;
			}
			else
			{
				throwUsesNonShootFrames = false;
				customThrowFrames = false;
				showHead = false;
//				if ( !upgradeIsActive(MUSHROOM) )
//					head.visible = true;
			}

			if ( (this is MegaMan) && skinNum == MegaMan.SKIN_ROKKO_CHAN )
			{
				canDashJump = true;
			}
			else if ( (this is MegaMan) && skinNum != MegaMan.SKIN_ROKKO_CHAN )
			{
				canDashJump = false;
			}

			// Rotate Bass Buster for skins
			if (this is Bass && ( skinNum != Bass.SKIN_BASS_NES && skinNum != Bass.SKIN_BASS_SNES && skinNum != Bass.SKIN_BASS_X1 && skinNum != Bass.SKIN_SKULL_MAN_NES ) ) // (skinNum == Bass.SKIN_BASS_GB || skinNum == Bass.SKIN_DR_WILY_NES || skinNum == Bass.SKIN_DR_WILY_SNES || skinNum == Bass.SKIN_MR_X_NES || skinNum == Bass.SKIN_MR_X_SNES || skinNum == Bass.SKIN_QUICK_MAN_NES) )
				rotateBassBuster = true;
			else
				rotateBassBuster = false;

			if (!characterInitiating)
			{
				changeSuitColor();
				updateWeaponsVec();
			}

			// Change walking and sliding speeds for skins
			if ( this is Bass && !(level is CharacterSelect) )
			{
				if (skinNum == Bass.SKIN_QUICK_MAN_NES || skinNum == Bass.SKIN_QUICK_MAN_SNES )
				{
					walkSpeed = WALK_SPEED * 1.3;
	//				slideSpeed = SLIDE_SPEED * 1.175;
					vxMaxDef = walkSpeed;
					skinDisableSlide = true;
					doubleJumpSkill = false;
					canDashJump = false;
				}
				else
				{
					walkSpeed = WALK_SPEED;
	//				slideSpeed = SLIDE_SPEED;
					vxMaxDef = walkSpeed;
					skinDisableSlide = false;
					doubleJumpSkill = true;
					canDashJump = true;
				}
				if (level.waterLevel)
					forceWaterStats();
				else
					forceNonwaterStats();
			}
			if ( this is MegaMan )
			{
				if ( skinNum == MegaMan.SKIN_ROCK_NES || skinNum == MegaMan.SKIN_ROCK_SNES || skinNum == MegaMan.SKIN_FRANCESCA || skinNum == MegaMan.SKIN_DOROPIE )
					skinDisableSlide = true;
				else
					skinDisableSlide = false;
			}
		}
		
		override protected function playDefaultPickupSoundEffect():void
		{
			SND_MNGR.playSound(SoundNames.SFX_MEGA_MAN_GET_NEW_LIFE);
		}
		
		override protected function setAmmo(ammoType:String, value:int):void
		{
			super.setAmmo(ammoType, value);
			if (primaryWeapon == ammoType || secondaryWeapon == ammoType)
				energyBar.update( getAmmo( ammoType ) );
		}
		
		
		protected function takeDamageTmrHandler(event:Event):void
		{
			takeDamageEnd();
		}
		override public function forceWaterStats():void
		{
			defGravity = GRAVITY;
			gravity = GRAVITY_WATER;
			defGravityWater = gravity;
			if (doubleJumpSkill)
				jumpPwr = JUMP_PWR_WATER;
			else
				jumpPwr = JUMP_PWR_WATER_HIGH_JUMP;
			super.forceWaterStats();
		}
		override public function forceNonwaterStats():void
		{
			if (doubleJumpSkill)
				jumpPwr = JUMP_PWR;
			else
					jumpPwr = JUMP_PWR_HIGH_JUMP;
			gravity = GRAVITY;
			super.forceNonwaterStats();
		}
		/*public function toggleHighJump(highJump:Boolean):void
		{
			if (highJump && !doubleJumpSkill)
				jumpPwr = JUMP_PWR_HIGH_JUMP;
			else if (!underWater)
				jumpPwr = JUMP_PWR;
			else
				jumpPwr = JUMP_PWR_WATER;
		}*/
		override protected function movePlayer():void
		{
			if (cState == ST_TAKE_DAMAGE || (onGround && shoot && stopWhileShooting) )
				return;
			if (cState != ST_SLIDE)
			{
				if (rhtBtn && !lftBtn && !wallOnRight) 
				{
					if (stuckInWall)
						return;
					if (cState == ST_VINE)
					{
						if (exitVine)
							getOffVine();
						else
							return;
					}
					vx = vxMax;
					scaleX = 1;
				}
				else if (lftBtn && !rhtBtn && !wallOnLeft) 
				{
					if (stuckInWall)
						return;
					if (cState == ST_VINE)
					{
						if (exitVine)
							getOffVine();
						else
							return;
					} 
					vx = -vxMax;
					scaleX = -1;
				}
				else if ( (lftBtn && rhtBtn) || (!lftBtn && !rhtBtn) )
					vx = 0;
				if (onGround && STEP_TMR.running)
					vx = 0;
			}
			else // && cState == ST_SLIDE
			{
				if (lftBtn && !rhtBtn)
				{
					if (!ceilingAboveSlide)
					{
						if (vx > 0)
						{
							vx = 0;
							setState(ST_STAND);
						}
					}
					else
					{
						scaleX = -1;
						vx = -slideSpeed;
						stopSlide = true;
						if (chargeKickGraphic != null)
							chargeKickGraphic.scaleX = -1;
					}
				}
				else if (rhtBtn && !lftBtn)
				{
					if (!ceilingAboveSlide)
					{
						if (vx < 0)
						{
							vx = 0;
							setState(ST_STAND);
						}
					}
					else 
					{
						scaleX = 1;
						vx = slideSpeed;
						stopSlide = true;
						if (chargeKickGraphic != null)
							chargeKickGraphic.scaleX = 1;
					}
				}
			}
			if (useEnterPipeVxMax)
				vxMax = ENTER_PIPE_VX_MAX;
			
		}
		override public function activateWatchModeEnterPipe():void
		{
			super.activateWatchModeEnterPipe();
			useEnterPipeVxMax = true;
			
		}
		// Public Methods:
		// JUMP
		override protected function jump():void
		{
			vy = -jumpPwr;
			if (onGround)
			{
				canDoubleJump = true;
				if (canDashJump)
				{
					if (cState == ST_SLIDE)
						vy = -JUMP_PWR_HIGH_JUMP;
					else
						vxMax = vxMaxDef;
				}
			}
			else
			{
				canDoubleJump = false;
				vxMax = vxMaxDef;
			}
			onGround = false;
			setStopFrame("jump");
			setState("jump");
			jumped = true;
			releasedJumpBtn = false;
			frictionY = false;
		}
		// CHECKSTATE
		override protected function checkState():void
		{
			ceilingAboveSlide = false;
//			trace("x: "+x);
			if (cState == ST_VINE)
			{
				mainAnimTmr = vineAnimTmr;
				checkVineBtns();
				checkVinePosition();
				return;
			}
			else if (cState == ST_TAKE_DAMAGE)
				return;
			else
				mainAnimTmr = DEFAULT_ANIM_TMR;
			if (onGround)
			{
				jumped = false;
				if (cState == ST_SLIDE)
				{
					canCrossSmallGaps = true;
					for each (var ground:Ground in level.GROUND_STG_DCT)
					{
						if (!ground.onScreen || !ground.visible || level.getDistance(hMidX,hMidY,ground.hMidX,ground.hMidY) > SLIDE_CEILING_CHECK_DIST)
							continue;
						if (scaleX > 0)
						{
							if (hTop - SLIDE_TOP_OFS <= ground.hBot && hBot - SLIDE_BOT_OFS > ground.hTop && hLft <= ground.hRht && hRht > ground.hLft)
							{
								ceilingAboveSlide = true;
								break;
							}
						}
						else // if (scaleX <= 0)
						{
							if (hTop - SLIDE_TOP_OFS <= ground.hBot && hBot - SLIDE_BOT_OFS > ground.hTop && hLft < ground.hRht && hRht >= ground.hLft)
							{
								ceilingAboveSlide = true;
								break;
							}
						}
					}
					if (!ceilingAboveSlide && (stopSlide || (scaleX > 0 && (nx > slideEndX || nx < slideStartX - 1 || wallOnRight) ) || (scaleX < 0 && (nx < slideEndX || nx > slideStartX + 1 || wallOnLeft))))
					{
						setState(ST_STAND);
						vx = 0;
					}
				}
				else if (vx == 0)
				{	
					setState(ST_STAND);
					if (shoot)
					{	
						if ( !armCustomFrame || !customThrowFrames )
							setStopFrame(FL_SHOOT);
						else
							setStopFrame(FL_THROW);
					}
					else if (STEP_TMR.running)
						setStopFrame(FL_STEP);
					else
						setStopFrame(FL_STAND);
				}
				else if (cState == ST_WALK) // same as current state
				{
					if (!shoot && (!carryingItem || throwUsesNonShootFrames) )
					{
						if (STEP_TMR.running)
							setStopFrame(FL_STEP);
						else
							setPlayFrame(getParFrame(BASE_FL_WALK));
					}
					else
					{
						if ( currentLabel == convLab(FL_STEP) )
							setStopFrame(FL_SHOOT);
						else
							setPlayFrame(getParFrame(BASE_FL_WALK_SHOOT) );
					}
				}
				else if (cState != ST_WALK)
				{
					if (!shoot && (!carryingItem || throwUsesNonShootFrames) )
					{
						if (STEP_TMR.running)
							setStopFrame(FL_STEP);
						else
							setPlayFrame(FL_WALK_START);
					}
					else
					{
						if (currentLabel == convLab(FL_STEP))
							setStopFrame("shoot");
						else
							setPlayFrame(FL_WALK_SHOOT_START);
					}
					setState(ST_WALK);
				}
				if (cState != ST_SLIDE)
				{
					vxMax = vxMaxDef;
					canCrossSmallGaps = false;
				}
			}
			else
			{
				if (!canDashJump)
					vxMax = vxMaxDef;
				if (shoot || carryingItem)
				{
					if ( carryingItem && throwUsesNonShootFrames)
						setStopFrame(FL_JUMP_THROW);
					else if ( (carryingItem && !throwUsesNonShootFrames) || !armCustomFrame || !customThrowFrames )
						setStopFrame(FL_JUMP_SHOOT);
					else
						setStopFrame(FL_JUMP_THROW);
				}
				else
					setStopFrame(FL_JUMP);
				if (cState == ST_SLIDE) // fixes bug where Mega Man gets stuck in wall after falling when sliding
				{
					setHitPoints();
					for each (var grnd:Ground in level.GROUND_STG_DCT)
					{
						if (!grnd.onScreen || !grnd.visible || level.getDistance(hMidX,hMidY,grnd.hMidX,grnd.hMidY) > SLIDE_CEILING_CHECK_DIST)
							continue;
						if (scaleX > 0)
						{
							if (hTop - SLIDE_TOP_OFS <= grnd.hBot && hBot - SLIDE_BOT_OFS > grnd.hTop && hLft <= grnd.hRht && hRht > grnd.hLft)
							{
								ny = grnd.hBot + hHeight;
								break;
							}
						}
						else // if (scaleX <= 0)
						{
							if (hTop - SLIDE_TOP_OFS <= grnd.hBot && hBot - SLIDE_BOT_OFS > grnd.hTop && hLft < grnd.hRht && hRht >= grnd.hLft)
							{
								ny = grnd.hBot + hHeight;
								break;
							}
						}
					}
				}
				setState(ST_JUMP);
				if (frictionY)
				{
					if (vy < 0) vy *= Math.pow(fy,dt);
					else frictionY = false;
				}
			}
			if (primaryWeapon == MM_BASS_BUSTER && primaryAttackButtonIsPressed && cState != ST_SLIDE)
				checkBassBusterStance();
//			else if (primaryWeapon == MM_SUPER_ARM && atkBtn && cState != ST_SLIDE && !carryingItem && !shoot)
//				pressAtkBtn();
		}		
		override public function drawObj():void
		{
			super.drawObj();
			if (carryingItem)
			{
				carryingItem.x = nx - TILE_SIZE/2 + (Math.abs(arm.x) + SUPER_ARM_ITEM_X_OFS)*scaleX ;
				carryingItem.y = ny - Math.abs(arm.y) - arm.height - TILE_SIZE + SUPER_ARM_ITEM_Y_OFS;
			}
		}
		
		override protected function getParFrame(_parSeq:String):String
		{
			var cl:String = currentLabel;
			var num:uint = uint(cl.charAt(cl.indexOf("-")+1));
			if (num > numParFrames)
				num -= numParFrames;
			if (num == 0)
				num = 1;
			_parSeq += "-" + num.toString();
			return _parSeq;
		}
		override protected function lastCharacterCheck():void
		{
			if (level.waterLevel && cState == ST_SLIDE)
			{
				if (scaleX > 0)
					vx = SLIDE_SPEED_WATER;
				else
					vx = -SLIDE_SPEED_WATER;
				vxMax = vx;
				if (vxMax < 0)
					vxMax = -vxMax;
			}
		}
		override protected function getOnVine(_vine:Vine):void
		{
			super.getOnVine(_vine);
			head.setStopFrame("climb");
		}
		override public function setState(nState:String):void
		{
			if (!lockState)
			{
				if (cState == ST_SLIDE && nState != ST_SLIDE)
					endSlide();
				if (nState == "stand" && cState != "stand")
					head.setStopFrame("openClosed");
				else if (nState == "jump" && cState != "jump")
					head.setStopFrame("openOpen");
				else if (nState == "walk" && cState != "walk")
					head.setStopFrame("openClosed");
				else if (nState == ST_SLIDE && cState != ST_SLIDE)
					head.setStopFrame("openOpen");
				lState = cState;
				cState = nState;
			}
		}
		
		private function endSlide():void
		{
			if (chargeKickGraphic)
			{
				chargeKickGraphic.destroy();
				chargeKickGraphic = null;
			}
			if (releasePharoahBalloonAfterSlide)
			{
				if (pharaohBalloon)
					launchPharoahBalloon();
				releasePharoahBalloonAfterSlide = false;
			}
		}
		protected function rapidFireTmrHandler(event:Event):void
		{
			if (primaryWeapon == MM_BASS_BUSTER)
			{
				if (attackButtonsAreSwapped)
					pressSpcBtn();
				else
					pressAtkBtn();
			}
			else
				rapidFireTmr.stop();
		}
		private function slide():void
		{
			if (carryingItem || (shoot && stopWhileShooting) )
				return;
			if (hasEnoughAmmo(MM_CHARGE_KICK) && (primaryWeapon == MM_CHARGE_KICK || (secondaryWeapon == MM_CHARGE_KICK && chargeKickIsActive) ) )
			{
				if (cState == ST_SLIDE)
					return;
				attackSlide = true;
				chargeKickGraphic = new MegaManSimpleGraphics(this,MegaManSimpleGraphics.TYPE_CHARGE_KICK);
				level.addToLevel(chargeKickGraphic);
				decAmmo(MM_CHARGE_KICK);
				SND_MNGR.playSound(SN_CHARGE_KICK);
			}
			else
				attackSlide = false;
//				slideDust = new MegaManSimpleGraphics( this, MegaManSimpleGraphics.TYPE_SLIDE_DUST );
//				level.addToLevel( slideDust );
			if (scaleX > 0)
			{
				wallOnRight = false;
				if (!level.waterLevel)
				{
					vx = slideSpeed;
					vxMax = slideSpeed;
					slideStartX = nx;
					slideEndX = nx + TOT_SLIDE_DIST;
				}
				else
				{
					vx = SLIDE_SPEED_WATER;
					vxMax = SLIDE_SPEED_WATER;
					slideStartX = nx;
					slideEndX = nx + TOT_SLIDE_DIST_WATER;
				}
			}
			else if (scaleX < 0)
			{	
				wallOnLeft = false;
				if (!level.waterLevel)
				{
					vx = -slideSpeed;
					vxMax = slideSpeed;
					slideStartX = nx;
					slideEndX = nx - TOT_SLIDE_DIST;
				}
				else
				{
					vx = -SLIDE_SPEED_WATER;
					vxMax = SLIDE_SPEED_WATER;
					slideStartX = nx;
					slideEndX = nx - TOT_SLIDE_DIST_WATER;
				}
			}
			if (canDashJump)
				setStopFrame(FL_DASH);
			else
				setStopFrame(FL_SLIDE);
			setState(ST_SLIDE);
			stopSlide = false;
			setHitPoints();
		}
		// PRESSJMPBTN
		override public function pressJmpBtn():void
		{
			if (cState == ST_VINE)
				return;
			if (onGround)
			{
				if (dwnBtn && cState != ST_SLIDE && (!skinDisableSlide || ( hasEnoughAmmo(MM_CHARGE_KICK) && (primaryWeapon == MM_CHARGE_KICK || (secondaryWeapon == MM_CHARGE_KICK && chargeKickIsActive) )  ) ) )
					slide();
				else if (cState != ST_SLIDE || (!ceilingAboveSlide && ( !(this is MegaMan) || ((this is MegaMan) && skinNum == MegaMan.SKIN_ROKKO_CHAN) || !dwnBtn ) ) )
					jump();
			}
			else if (doubleJumpSkill && canDoubleJump && !onSpring)
				jump();
			super.pressJmpBtn();
		}
		
		// RELJUMPBTN
		override public function relJmpBtn():void
		{
			super.relJmpBtn();
			if (!releasedJumpBtn) 
			{
				//vyMaxNgv = Math.abs(vy);
				frictionY = true;
				releasedJumpBtn = true;
			}
		}
		override public function hitProj(proj:Projectile):void
		{
			if (level is TitleLevel)
				return;
			if ( !( proj is FireBar && skinNum == MegaMan.SKIN_FIRE_MAN_NES ) )
				super.hitProj(proj);
		}
		private function get megaManProjectileCount():int
		{
			var counter:int = 0;
			for each (var projectile:Projectile in level.PLAYER_PROJ_DCT)
			{
				if (projectile is MegaManProjectile)
					counter++;
			}
			return counter;
		}
		
		private function get defaultMegaManProjectileCount():int
		{
			var counter:int = 0;
			for each (var projectile:Projectile in level.PLAYER_PROJ_DCT)
			{
				if (projectile is MegaManProjectile && MegaManProjectile(projectile).isDefaultWeapon)
					counter++;
			}
			return counter;
		}
		
		private function get notDefaultMegaManProjectileCount():int
		{
			var counter:int = 0;
			for each (var projectile:Projectile in level.PLAYER_PROJ_DCT)
			{
				if (projectile is MegaManProjectile && !MegaManProjectile(projectile).isDefaultWeapon)
					counter++;
			}
			return counter;
		}
		
		private function get pharoahShotCount():int
		{
			var counter:int = 0;
			for each (var projectile:Projectile in level.PLAYER_PROJ_DCT)
			{
				if (projectile is MegaManProjectile && MegaManProjectile(projectile).isPharoahShot)
					counter++;
			}
			return counter;
		}
		
		private function get waterShieldCount():int
		{
			return waterShieldDct.length;
		}
		
		private function get megaManProjectileCountWithoutWaterShieldAndPharoahShot():int
		{
			var count:int = megaManProjectileCount - waterShieldCount - pharoahShotCount;
			return count >= 0 ? count : 0;
		}
		
		private function pressedAttackButton(shootType:MegaManShootType):void
		{
			var weapon:String = primaryWeapon;
			if (shootType == MegaManShootType.Secondary)
				weapon = secondaryWeapon;
			if (cState != ST_SLIDE)
			{
				if (weaponUsesEnergy(weapon) && !hasEnoughAmmo(weapon) && !waterShieldDct.length )
					return;
				attackIfPossible(weapon);
			}
			if (canChargeWeapon(weapon) && !isChargingOppositeWeaponType(shootType) && GS_MNGR.gameState == GS_PLAY && weapon != MM_PHARAOH_SHOT)
			{
				resetChargeState();
				chargeTmr.delay = CHARGE_START_DUR;
				chargeTmr.start();
				chargeType = shootType;
			}
		}
		
		private function isChargingOppositeWeaponType(weaponType:MegaManShootType):Boolean
		{
			if (weaponType == MegaManShootType.Primary)
				return isChargingSecondaryWeapon;
			else
				return isChargingPrimaryWeapon;
		}
		
		// PRESSATTACKBTN
		override public function pressAtkBtn():void
		{
			if (cState == ST_VINE)
				return;
			super.pressAtkBtn();
			if (attackButtonsAreSwapped)
				pressedAttackButton(MegaManShootType.Secondary);
			else
				pressedAttackButton(MegaManShootType.Primary);
		}
		
		override public function pressSpcBtn():void
		{
			if (cState == ST_VINE)
				return;
			super.pressSpcBtn();
			if (GameSettings.classicMode)
			{
				if (attackButtonsAreSwapped)
					pressedAttackButton(MegaManShootType.Primary);
				else if (secondaryWeapon == MM_CHARGE_KICK)
					chargeKickIsActive = !chargeKickIsActive;
				else if (secondaryWeapon != null)
					pressedAttackButton(MegaManShootType.Secondary);
			}
			else
			{
				if (selBtn)
					updateWeaponsVec(0,true);
				else
					updateWeaponsVec(1);
				if (chargeState != CS_NORMAL)
					resetChargeState();
			}
		}
		
//		private function get isCharging():Boolean
//		{
//			return chargeState != CS_NORMAL;
//		}
		
		private function get weaponCurrentlyBeingCharged():String
		{
			if (isChargingPrimaryWeapon)
				return primaryWeapon;
			else if (isChargingSecondaryWeapon)
				return secondaryWeapon;
			else
				return null;
		}
		
		private function get primaryAttackButtonIsPressed():Boolean
		{
			if (attackButtonsAreSwapped)
				return spcBtn;
			else
				return atkBtn;
		}
		
		private function get secondaryAttackButtonIsPressed():Boolean
		{
			if (attackButtonsAreSwapped)
				return atkBtn;
			else
				return spcBtn;
		}
		
		private function get isChargingPrimaryWeapon():Boolean
		{
			return canChargePrimaryWeapon && chargeType == MegaManShootType.Primary && primaryAttackButtonIsPressed;
		}
		
		private function get isChargingSecondaryWeapon():Boolean
		{
			return canChargeSecondaryWeapon && chargeType == MegaManShootType.Secondary && secondaryAttackButtonIsPressed;
		}
		

		protected function attackIfPossible(weapon:String):void
		{
			var numProjs:int = megaManProjectileCount;
			if (carryingItem && weapon != MM_RUSH_COIL)
			{
				level.addToLevel( new MegaManProjectile(this,MM_SUPER_ARM,carryingItem) );
				EVENT_MNGR.removeEventListener(CustomEvents.LEVEL_SET_INDEXES,levelSetIndexesHandler);
				carryingItem = null;
				shootStart(MM_SUPER_ARM, true,FL_ARM_THROW);
				return;
			}
			switch(weapon)
			{
				case MM_RUSH_COIL:
				{
					if (!rush)
					{
						rush = new Rush(this);
						level.addToLevel(rush);
						break;
					}
					else if (GameSettings.classicMode)
					{
						if (rush.isWaitingForMegaMan)
							rush.forceExit();
						break;
					}
					// overflows into mega mbuster
				}
				case MM_MEGA_BUSTER:
				{
					var numShotsMB:int = NUM_MEGA_BUSTER_SHOTS_ALLOWED;
					
					if( ( skinProtoMan && !upgradeIsActive(MUSHROOM) ) || ( skinNum == MegaMan.SKIN_CUT_MAN_NES || skinNum == MegaMan.SKIN_CUT_MAN_SNES || skinNum == MegaMan.SKIN_FIRE_MAN_NES ) )
						numShotsMB -= 1;
					
					if (megaManProjectileCountWithoutWaterShieldAndPharoahShot < numShotsMB && !chargeShot)
					{
						var shot:Projectile;
						shot = new MegaManProjectile(this,MegaManProjectile.TYPE_MEGA_BUSTER);
						level.addToLevel(shot);
						shootStart(weapon, false, null, false);
						checkState();
					}
					//					if (shiftBullet)
					//						shiftBullet = false;
					//					else
					//						shiftBullet = true;
					break;
				}
				case MM_BASS_BUSTER:
				{
					var NumShotsBB:int = NUM_BASS_BUSTER_NO_MUSHROOM_SHOTS_ALLOWED;
					if (upgradeIsActive(MUSHROOM))
						NumShotsBB = NUM_BASS_BUSTER_SHOTS_ALLOWED;
					if (megaManProjectileCountWithoutWaterShieldAndPharoahShot < NumShotsBB)
					{
						level.addToLevel( new MegaManProjectile(this,MegaManProjectile.TYPE_BASS_BUSTER) );
					}
					shootStart(weapon, true);
					checkState();
					break;
				}
				case MM_SUPER_ARM:
				{
					if (!carryingItem)
					{
						for each (var levObj:LevObj in curHitDct)
						{
							if ( levObj.getProperty( PR_TYPE_SUPER_ARM_GRABBABLE) )
							{
								pickUpWithSuperArm(levObj as Brick);
								break;
							}
						}
					}
//					else
//					{
//						level.addToLevel( new MegaManProjectile(this,MM_SUPER_ARM,carryingItem) );
//						EVENT_MNGR.removeEventListener(CustomEvents.LEVEL_SET_INDEXES,levelSetIndexesHandler);
//						carryingItem = null;
//						shootStart(weapon, true,FL_ARM_THROW);
//					}
					break;
				}
				case MM_METAL_BLADE:
				{
					if (numProjs < NUM_METAL_BLADES_ALLOWED)
					{
						level.addToLevel( new MegaManProjectile( this, MegaManProjectile.TYPE_METAL_BLADE ) );
						shootStart(weapon, true,FL_ARM_THROW);
					}
					break;
				}
				case MM_HARD_KNUCKLE:
				{
					if (notDefaultMegaManProjectileCount < NUM_HARD_KNUCKLES_ALLOWED)
					{
						level.addToLevel( new MegaManProjectile( this, MegaManProjectile.TYPE_HARD_KNUCKLE ) );
						shootStart(weapon, true,FL_ARM_FIST);
						if (!onGround)
							stopUpdate = true;
					}
					break;
				}
				case MM_PHARAOH_SHOT:
				{
					if (numProjs < NUM_PHARAOH_SHOTS_ALLOWED)
					{
						level.addToLevel( new MegaManProjectile( this, MegaManProjectile.TYPE_PHARAOH_SHOT ) );
						shootStart(weapon, true,FL_ARM_THROW);
					}
					if ( hasEnoughAmmo( MM_PHARAOH_SHOT ) )
						level.addToLevel( new MegaManProjectile( this, MegaManProjectile.TYPE_PHARAOH_BALLOON ) );
					break;
				}
				case MM_FLAME_BLAST:
				{
					if (numProjs < NUM_FLAME_BLASTS_ALLOWED)
					{
						level.addToLevel( new MegaManProjectile( this, MegaManProjectile.TYPE_FLAME_BLAST ) );
						shootStart(weapon);
					}
					break;
				}
				case MM_MAGMA_BAZOOKA:
				{
					if (notDefaultMegaManProjectileCount < NUM_MAGMA_BAZOOKAS_ALLOWED)
					{
						level.addToLevel( new MegaManProjectile( this, MegaManProjectile.TYPE_MAGMA_BAZOOKA,MegaManProjectile.MB_UP ) );
						level.addToLevel( new MegaManProjectile( this, MegaManProjectile.TYPE_MAGMA_BAZOOKA,MegaManProjectile.MB_MID ) );
						level.addToLevel( new MegaManProjectile( this, MegaManProjectile.TYPE_MAGMA_BAZOOKA,MegaManProjectile.MB_DOWN ) );
						shootStart(weapon);
					}
					break;
				}
				case MM_WATER_SHIELD:
				{
					if (!waterShieldDct.length)
					{
						MegaManProjectile.createWaterShield(this);
						shootStart(weapon);
					}
					else
					{
						var cancel:Boolean;
						for each (var proj:MegaManProjectile in waterShieldDct)
						{
							if (!proj.visible)
							{
								cancel = true;
								//								break;
							}
						}
						if (!cancel)
						{
							for each (proj in waterShieldDct)
							{
								proj.waterShieldExpandInit();
							}
						}
					}
					break;
				}
				case MM_SCREW_CRUSHER:
				{
					if (numProjs < NUM_SCREW_CRUSHERS_ALLOWED)
					{
						level.addToLevel( new MegaManProjectile( this, MegaManProjectile.TYPE_SCREW_CRUSHER ) );
						shootStart(weapon, true,FL_ARM_THROW);
					}
					break;
				}
			}
		}
		
		override public function hitEnemy(enemy:Enemy,side:String):void
		{
			if (!starPwr && cState == ST_SLIDE && attackSlide)
				landAttack(enemy);
			else
				super.hitEnemy(enemy,side);
		}
		override public function hitGround(mc:Ground,hType:String):void
		{
			if (cState == ST_SLIDE && attackSlide && mc is IAttackable)
				landAttack(mc as IAttackable);
			else if (primaryWeapon == MM_SUPER_ARM && primaryAttackButtonIsPressed && hasEnoughAmmo(primaryWeapon) && cState != ST_SLIDE && !carryingItem && !shoot && mc.getProperty( PR_TYPE_SUPER_ARM_GRABBABLE))
				pickUpWithSuperArm(mc as Brick);
			else if (secondaryWeapon == MM_SUPER_ARM && secondaryAttackButtonIsPressed && hasEnoughAmmo(secondaryWeapon) && cState != ST_SLIDE && !carryingItem && !shoot && mc.getProperty( PR_TYPE_SUPER_ARM_GRABBABLE))
				pickUpWithSuperArm(mc as Brick);
			if (!mc.destroyed && mc != carryingItem)
				super.hitGround(mc,hType);
		}
		
		override protected function attackObjPiercing(obj:IAttackable):void
		{
			super.attackObjPiercing(obj);
			if (obj is Enemy)
				SND_MNGR.playSound(SoundNames.SFX_MEGA_MAN_HIT_ENEMY);
		}
		
		private function launchPharoahBalloon():void
		{
			var ballCharge:int = pharaohBalloon.pharaohChargeLevel;
			if (ballCharge >= MegaManProjectile.PHARAOH_CHARGE_MED)
			{
				level.addToLevel( new MegaManProjectile(this, MegaManProjectile.TYPE_PHARAOH_SHOT, ballCharge ) );
				shootStart(MM_PHARAOH_SHOT, true, FL_ARM_THROW, false);
				decAmmo(MM_PHARAOH_SHOT, MegaManProjectile.TYPE_PHARAOH_BALLOON);
			}
			pharaohBalloon.destroy();
			pharaohBalloon = null;
		}
		
		private function willReleaseAttackButton(shootType:MegaManShootType):void
		{
			var weapon:String = primaryWeapon;
			if (shootType == MegaManShootType.Secondary)
				weapon = secondaryWeapon;
			var weaponIsTheOneCurrentlyBeingCharged:Boolean = (weapon == weaponCurrentlyBeingCharged);
			
			var shot:Projectile;
			if (weaponIsTheOneCurrentlyBeingCharged)
				chargeTmr.reset();
			
			if (weapon == MM_BASS_BUSTER && rapidFireTmr && rapidFireTmr.running)
			{
				rapidFireTmr.stop();
				stopWhileShooting = false;
				if (!shootTmr.running)
					shootTmrHandler( new TimerEvent(TimerEvent.TIMER_COMPLETE) );
			}
			
			if (weapon == MM_PHARAOH_SHOT && pharaohBalloon)
			{
				if (cState != ST_SLIDE)
					launchPharoahBalloon();
				else
					releasePharoahBalloonAfterSlide = true;
			}
			else if (weaponIsTheOneCurrentlyBeingCharged && GS_MNGR.gameState == GS_PLAY)
			{
				if (cState != ST_SLIDE)
				{
					if ((chargeState == CS_WEAK_CHARGE || chargeState == CS_CHARGE_OUTLINE_2) && weapon != MM_MAGMA_BAZOOKA)
					{	
						shot = new MegaManProjectile(this,MegaManProjectile.TYPE_CHARGE_WEAK);
						level.addToLevel(shot);
						shootStart(MM_MEGA_BUSTER);
					}
					else if (chargeState == CS_FULL_CHARGE)
					{
						if (weapon == MM_MEGA_BUSTER)
						{
							shot = new MegaManProjectile(this,MegaManProjectile.TYPE_CHARGE_STRONG);
							shootStart(MM_MEGA_BUSTER);
						}
						else if (weapon == MM_MAGMA_BAZOOKA)
						{
							level.addToLevel( new MegaManProjectile( this, MegaManProjectile.TYPE_MAGMA_BAZOOKA_CHARGE,MegaManProjectile.MB_UP ) );
							level.addToLevel( new MegaManProjectile( this, MegaManProjectile.TYPE_MAGMA_BAZOOKA_CHARGE,MegaManProjectile.MB_MID ) );
							level.addToLevel( new MegaManProjectile( this, MegaManProjectile.TYPE_MAGMA_BAZOOKA_CHARGE,MegaManProjectile.MB_DOWN ) );
							shootStart(MM_MAGMA_BAZOOKA, false, null, false);
							decAmmo(MM_MAGMA_BAZOOKA, MegaManProjectile.TYPE_MAGMA_BAZOOKA_CHARGE);
						}
						level.addToLevel(shot);
					}
				}
			}
			if ( chargeState != CS_NORMAL && weaponIsTheOneCurrentlyBeingCharged)
				resetChargeState();	
		}
		
		// RELATTACKBTN
		override public function relAtkBtn():void
		{
			if (secondaryWeapon != null && attackButtonsAreSwapped)
				willReleaseAttackButton(MegaManShootType.Secondary);
			else
				willReleaseAttackButton(MegaManShootType.Primary);
			super.relAtkBtn();
		}
		
		override public function relSpcBtn():void
		{
			if (secondaryWeapon != null)
			{
				if (attackButtonsAreSwapped)
					willReleaseAttackButton(MegaManShootType.Primary);
				else
					willReleaseAttackButton(MegaManShootType.Secondary);
			}			
			super.relSpcBtn();
		}
		
		private function pickUpWithSuperArm(brick:Brick):void
		{
			brick.stopHit = true;
			carryingItem = brick;
			/*for (var i:int = 0; i < brick.numChildren; i++) 
			{
				var obj:DisplayObject = brick.getChildAt(i);
				if (obj is Bitmap)
				{
					trace("obj.x: "+obj.x);
					brick.setChildPoperty(obj,"x",-TILE_SIZE,brick.currentFrame);
					brick.setChildPoperty(obj,"y",-TILE_SIZE,brick.currentFrame);
					trace("obj.x: "+obj.x);
				}	
			}*/
			brick.ny = ny - height;
			brick.nx = nx;
			arm.setStopFrame(FL_ARM_SUPER_ARM);
			EVENT_MNGR.addEventListener(CustomEvents.LEVEL_SET_INDEXES,levelSetIndexesHandler,false,0,true);
		} 
		override public function finalCheck():void
		{
			super.finalCheck();
			var cf:String = currentLabel;
			var af:String;
			if (!shoot && !carryingItem)
			{
				if (cf == FL_STAND || cf == FL_STEP)
					af = FL_ARM_NORMAL;
				if (cf == FL_WALK_START)
					af = FL_ARM_WALK_1;
				else if (cf == FL_WALK_2 || cf == FL_WALK_END)
					af = FL_ARM_WALK_2;
				else if (cf == FL_WALK_3)
					af = FL_ARM_WALK_3;
			}
			if (carryingItem)
			{
				af = FL_ARM_SUPER_ARM;
				carryingItem.x = nx - TILE_SIZE/2 + (Math.abs(arm.x) + SUPER_ARM_ITEM_X_OFS)*scaleX ;
				carryingItem.y = ny - Math.abs(arm.y) - arm.height - TILE_SIZE + SUPER_ARM_ITEM_Y_OFS;
			}
			if (af)
				arm.setStopFrame(af);
		}
		protected function levelSetIndexesHandler(event:Event):void
		{
			var par:DisplayObjectContainer = carryingItem.parent;
			if (par)
			{
				var ind:int = par.getChildIndex(this) - 1;
				if (ind < 0)
					ind = 0;
				par.setChildIndex(carryingItem,ind);
			}
		}
		private function shootStart(weapon:String, stopWalking:Boolean = false, armType:String = null, loseAmmo:Boolean = true):void
		{
			if (armType == FL_ARM_THROW || armType == FL_ARM_FIST)
				armCustomFrame = true;
			if (!armType)
				armType = FL_ARM_SHOOT;
			else if (armType == FL_ARM_THROW && onGround && (vx == 0 || stopWalking) )
				armType = FL_ARM_STAND_THROW;
			arm.setStopFrame(armType);
			shoot = true;
			shootTmr.reset();
			shootTmr.start();
			stopWhileShooting = stopWalking;
			if (stopWalking && onGround)
			{
				vx = 0;
				if (!armCustomFrame || !customThrowFrames)
					setStopFrame(FL_SHOOT);
				else
					setStopFrame(FL_THROW); // this should pretty much only be used on proto man skins
			}
			if (weapon == MM_BASS_BUSTER && onGround)
				checkBassBusterStance();
			if (loseAmmo && weaponUsesEnergy(weapon) )
			{
				decAmmo(weapon);
//				trace(primaryWeapon+" ammo: "+getAmmo(primaryWeapon) );
			}
//			trace("label: "+currentLabel+" num: "+currentFrame);
		}

		override protected function decreaseAmmoByValue(ammoType:String, value:int):void
		{
//			if ( this is Bass && skinNum == Bass.SKIN_SKULL_MAN_NES && primaryWeapon == MM_WATER_SHIELD)
//				value = value / 2;
//			else
//				value = value;
			super.decreaseAmmoByValue(ammoType, value);
		}
//		override protected function getAmmoCost(ammoDeplType:String):int
//		{
//			var num:int = super.getAmmoCost(ammoDeplType);
//			if ( !(this is Bass && (skinNum == Bass.SKIN_SKULL_MAN_NES) && primaryWeapon == MM_WATER_SHIELD ))
//				return num;
//			else
//				return num / 2;
//		}

		override protected function hasEnoughAmmo(ammoType:String,ammoDeplType:String = null,cost:int = -1):Boolean
		{
			if (ammoType == MM_RUSH_COIL && getAmmo(ammoType) >= MegaManEnergyBar.NUM_UNITS_PER_BAR)
				return true;
			return super.hasEnoughAmmo(ammoType,ammoDeplType,cost);
		}
		public function rushCoilBounce():void
		{
			decAmmo(MM_RUSH_COIL);
		}
		private function checkBassBusterStance():void
		{
			shoot = true;
			if (rhtBtn)
				scaleX = 1;
			else if (lftBtn)
				scaleX = -1;
			if (!rapidFireTmr.running)
				rapidFireTmr.start();
			var baseStr:String = BASE_FL_SHOOT;
			if (onGround)
				vx = 0;
			else
				baseStr = BASE_FL_JUMP_SHOOT;
			if (upBtn)
			{
				if (rhtBtn || lftBtn)
					setStopFrame(baseStr + BASE_FL_DIAG_UP);
				else
					setStopFrame(baseStr + BASE_FL_UP);
			}
			else if (dwnBtn)
				setStopFrame(baseStr + BASE_FL_DIAG_DWN);
		}
		
		override public function pressSelBtn():void
		{
			super.pressSelBtn();
			if (!GameSettings.classicMode)
			{
				if (spcBtn)
					updateWeaponsVec(0,true);
				else
					updateWeaponsVec(-1);
				if (chargeState != CS_NORMAL)
					resetChargeState();
			}
		}
		override public function pressLftBtn():void
		{
			super.pressLftBtn();
			if (onGround && vx >= 0 && !STEP_TMR.running && !(primaryWeapon == MM_BASS_BUSTER && primaryAttackButtonIsPressed) )
			{
				if (cState == ST_SLIDE && (ceilingAboveSlide || rhtBtn) )
					return;
				STEP_TMR.start();
				nx -= STEP_MOVE_AMT;
				if (!shoot)
					setStopFrame(FL_STEP);
			}
		}
		override public function pressRhtBtn():void
		{
			super.pressRhtBtn();
			if (onGround && vx <= 0 && !STEP_TMR.running && !(primaryWeapon == MM_BASS_BUSTER && primaryAttackButtonIsPressed) )
			{
				if (cState == ST_SLIDE && (ceilingAboveSlide || lftBtn))
					return;
				STEP_TMR.start();
				nx += STEP_MOVE_AMT;
				if (!shoot)
					setStopFrame(FL_STEP);
			}
		}
		override public function relLftBtn():void
		{
			super.relLftBtn();
			//if (STEP_TMR.running)
			//	STEP_TMR.reset();
		}
		override protected function changeBrickState():void
		{
			if ( ( this is MegaMan ) && ( skinNum == MegaMan.SKIN_CUT_MAN_NES || skinNum == MegaMan.SKIN_CUT_MAN_SNES ) )
				brickState = BRICK_BREAKER;
			else
				brickState = BRICK_BOUNCER;
		}
		override public function relRhtBtn():void
		{
			super.relRhtBtn();
			//if (STEP_TMR.running)
			//	STEP_TMR.reset();
		}
		private function stepTmrHandler(event:TimerEvent):void
		{
			STEP_TMR.reset();
		}
		private function resetChargeState():void
		{
			var snd:SoundContainer = SND_MNGR.findSound(SFX_MEGA_MAN_CHARGE_LOOP);
			
			if (snd)
			{
				snd.pauseSound();
				SND_MNGR.removeSnd(snd);
			}
			else
			{
				snd = SND_MNGR.findSound(SFX_MEGA_MAN_CHARGE_START);
				if (snd)
				{
					snd.pauseSound();
					SND_MNGR.removeSnd(snd);
				}
			}
			SND_MNGR.removeStoredSound(SFX_MEGA_MAN_CHARGE_LOOP);
			SND_MNGR.removeStoredSound(SFX_MEGA_MAN_CHARGE_START);
			if (!starPwr && cState != ST_GET_MUSHROOM)
				endReplaceColor();
			chargeState = CS_NORMAL;
			if (chargeTmr.running)
				chargeTmr.reset();
			//chargeCtr = 0;
		}
		
		override public function hitPickup(pickup:Pickup,showAnimation:Boolean = true):void
		{
			var hadFireFlower:Boolean = upgradeIsActive(FIRE_FLOWER);
//			if (GameSettings.classicMode && hadFireFlower && secondaryWeaponUsesEnergy && getAmmo(secondaryWeapon) < MAX_WPN_ENGY)
//				showAnimation = false;
			super.hitPickup(pickup,showAnimation);
			var puType:String = pickup.type;
			switch(puType)
			{
				case MUSHROOM:
				{
					updateDisplay();
					changeSuitColor();
					break;
				}
				case FIRE_FLOWER:
				{
					updateDisplay();
					changeSuitColor();
					if (!hadFireFlower)
					{
						if (secondaryWeapon == MM_CHARGE_KICK)
							chargeKickIsActive = true;
//						else
//							attackButtonsAreSwapped = false;
					}
//					if (!hadFireFlower)
//					{
						if (secondaryWeaponUsesEnergy)
							increaseAmmoByValue(secondaryWeapon, WEAPON_ENERGY_BIG_RECOVERY);
						break;
//					} // if you already had fire flower, get a big energy
				}
				case MM_WEAPON_ENERGY_BIG:
				{
					if (primaryOrSecondaryWeaponUsesEnergy || upgradeIsActive(MM_ENERGY_BALANCER))
					{
						weaponEnergyTouch(true);
//						increaseAmmoByValue(primaryWeapon,WEAPON_ENERGY_BIG_RECOVERY);
//						SND_MNGR.playSound(SN_GET_ENERGY);
					}
					break;
				}
				case MM_WEAPON_ENERGY_SMALL:
				{
					if (primaryOrSecondaryWeaponUsesEnergy || upgradeIsActive(MM_ENERGY_BALANCER))
					{
						weaponEnergyTouch(false);
//						increaseAmmoByValue(primaryWeapon,WEAPON_ENERGY_SMALL_RECOVERY);
//						SND_MNGR.playSound(SN_GET_ENERGY);
					}
					break;
				}
			}
			if (pickup.mainType == PickupInfo.MAIN_TYPE_UPGRADE)
				updateWeaponsVec();
			if (!pickup.playsRegularSound && pickup.mainType != PickupInfo.MAIN_TYPE_FAKE && showAnimation)
			{
				if (puType != MM_WEAPON_ENERGY_BIG && puType != MM_WEAPON_ENERGY_SMALL)
					SND_MNGR.playSound(SoundNames.SFX_MEGA_MAN_GET_NEW_LIFE);
			}
		}
		private function weaponEnergyTouch(big:Boolean):void
		{
			if (energyTmr != null) // energy is currently being filled
			{
				if (big)
					energiesGottenSimultaneously.push( new MegaManPickup(PickupInfo.MEGA_MAN_WEAPON_ENERGY_BIG ) );
				else
					energiesGottenSimultaneously.push( new MegaManPickup(PickupInfo.MEGA_MAN_WEAPON_ENERGY_SMALL ) );
				return;
			}
			var count:int;
			ammoTypeToRefill = null;
			if (big)
				count = WEAPON_ENERGY_BIG_RECOVERY;
			else
				count = WEAPON_ENERGY_SMALL_RECOVERY;
			count /= MegaManEnergyBar.NUM_UNITS_PER_BAR;
			if ( primaryWeaponUsesEnergy && getAmmo( primaryWeapon ) < MAX_WPN_ENGY )
				ammoTypeToRefill = primaryWeapon;
			else if ( secondaryWeaponUsesEnergy && getAmmo( secondaryWeapon ) < MAX_WPN_ENGY )
				ammoTypeToRefill = secondaryWeapon;
			else if (upgradeIsActive(MM_ENERGY_BALANCER))
				ammoTypeToRefill = getAmmoTypeWithLeastAmmo();
			if (ammoTypeToRefill && getAmmo(ammoTypeToRefill) < MAX_WPN_ENGY)
			{
				level.freezeGame(false);
				energyTmr = new Timer(ENERGY_TMR_DUR,count);
				energyTmr.addEventListener(TimerEvent.TIMER,energyTmrHandler,false,0,true);
				energyTmr.start();
				if (count <= 3)
					SND_MNGR.playSound(SN_GET_ENERGY);
				else
					SND_MNGR.playSound(SoundNames.SFX_MEGA_MAN_GET_ENERGY_LOOPING);
			}
		}
		
		
		protected function energyTmrHandler(event:Event):void
		{
			increaseAmmoByValue(ammoTypeToRefill,MegaManEnergyBar.NUM_UNITS_PER_BAR);
			if (primaryWeapon == ammoTypeToRefill || secondaryWeapon == ammoTypeToRefill)
				energyBar.update( getAmmo(ammoTypeToRefill) );
//			if ( !SND_MNGR.findSound(SN_GET_ENERGY) )
//				SND_MNGR.playSoundNow(SN_GET_ENERGY);
			if ( getAmmo(ammoTypeToRefill) == MAX_WPN_ENGY || energyTmr.currentCount == energyTmr.repeatCount )
			{
				energyTmr.stop();
				energyTmr.removeEventListener(TimerEvent.TIMER,energyTmrHandler);
				energyTmr = null;
				level.unfreezeGame();
				var snd:SoundContainer = SND_MNGR.findSound(SoundNames.SFX_MEGA_MAN_GET_ENERGY_LOOPING);
				if (snd)
					SND_MNGR.removeSnd(snd);
				if (!primaryAttackButtonIsPressed && !secondaryAttackButtonIsPressed)
					resetChargeState();
				if (energiesGottenSimultaneously.length > 0)
					hitPickup( energiesGottenSimultaneously.pop() );
			}
		}
		
		override protected function starPwrTmr3Handler(e:TimerEvent):void
		{
			if (starPwrTmr3)
			{
				starPwrTmr3.stop();
				starPwrTmr3.removeEventListener(TimerEvent.TIMER_COMPLETE,starPwrTmr3Handler);
				starPwrTmr3 = null;
			}
			starPwr = false;
			if (chargeState == CS_NORMAL)
			{
				endReplaceColor();
				visible = true;
				resetColor();
			}
			flashAnimTmr = STAR_PWR_FLASH_ANIM_TMR;
			TopScreenText.instance.updateUpgIcons();
		}
		
		private function get currentChargePalette():Palette
		{
			if (level is TitleLevel)
			{
				updatePalettes();
				return WEAPON_FLASH_PALETTES_DCT[MM_MEGA_BUSTER];
			}
			else if (weaponCurrentlyBeingCharged == null)
				return null;
			else if (!GameSettings.classicMode)
			{
				if (weaponCurrentlyBeingCharged == MM_MAGMA_BAZOOKA)
					return paletteChargeMagmaBazooka;
				else
					return WEAPON_FLASH_PALETTES_DCT[MM_MEGA_BUSTER];
			}
			else if (secondaryWeapon == null)
				return WEAPON_FLASH_PALETTES_DCT[MM_MEGA_BUSTER];
			else
			{
				if (secondaryWeapon == MM_CHARGE_KICK && !chargeKickIsActive)
					return WEAPON_FLASH_PALETTES_DCT[MM_MEGA_BUSTER];
				else if (weaponCurrentlyBeingCharged == MM_MAGMA_BAZOOKA)
					return paletteChargeMagmaBazooka;
				else
					return WEAPON_FLASH_PALETTES_DCT[secondaryWeapon];
			}
			return null;
		}
		
		override public function groundOnSide(g:Ground,side:String):void
		{
			if (cState == ST_SLIDE && !ceilingAboveSlide)
			{
				setState(ST_STAND);
				vx = 0;
			} 
			super.groundOnSide(g,side);
		}
		override public function flash(incCtr:Boolean = true):void
		{
			if (starPwr || poweringUp)
			{
				super.flash(incCtr);
				return;
			}
//			var palette:Palette = paletteChargeMegaBuster;
			var outRow:int = 1;
//			resetColor(true);
			chargeCtr++;	
			if (chargeState == CS_FULL_CHARGE && chargeCtr > NUM_CHARGE_COLORS)
				chargeCtr = 1;
			else if (chargeState != CS_FULL_CHARGE && chargeCtr > 2)
				chargeCtr = 1;
			if (chargeState == CS_FULL_CHARGE)
				outRow += CHARGE_PAL_FULL_CHARGE_START_OFS + chargeCtr - 1;
			else if (chargeCtr == 1)
			{
				if ( chargeState == CS_CHARGE_START || chargeState == CS_CHARGE_OUTLINE_2 || chargeState == CS_WEAK_CHARGE )
				{
					resetColor();
					flashArr = null;
					return; // don't change color
				}
			}
			else if (chargeCtr == 2)
			{
				if (chargeState == CS_CHARGE_START)
					outRow += 0;
				else if (chargeState == CS_CHARGE_OUTLINE_2)
					outRow += 1;
				else if (chargeState == CS_WEAK_CHARGE)
					outRow += 2;
			}
//			if (GameSettings.classicMode)
//			{
//				
//			}
//			else
//			{
//			if (primaryWeapon == MM_MAGMA_BAZOOKA)
//				palette = paletteChargeMagmaBazooka;
//			else
//				palette = paletteChargeMegaBuster;
			var palette:Palette = currentChargePalette;
			if (palette == null)
			{
				resetColor();
				flashArr = null;
			}
			else
			{
				flashArr = [defColors, palette, IND_DEF_COLORS_OUT, outRow];
				recolorBmps(defColors, palette, IND_DEF_COLORS_OUT, outRow);
			}
		}
		public function repositionBullets():Boolean
		{
			if ( (this is MegaMan) && ( skinProtoMan || (skinNum == MegaMan.SKIN_MEGA_MAN_GB || skinNum == MegaMan.SKIN_ROKKO_CHAN)) )
				return true;
			else
				return false;

//			if (this is MegaMan)
//			{
//				if ( (skinNum > 1 && skinNum < 6) || skinNum == MegaMan.SKIN_BREAK_MAN_NES || skinNum == MegaMan.SKIN_BREAK_MAN_SNES || skinNum == MegaMan.SKIN_BREAK_MAN_GB || skinNum == MegaMan.SKIN_ROKKO_CHAN )
//					return true;
//			}
//			return false;
		}
		// CHARGEINT
		private function chargeInt(e:TimerEvent):void
		{
			chargeTmr.reset();
			if (chargeState == CS_NORMAL)
			{
				chargeTmr.delay = CHARGE_OUTLINE_2_DUR;
				chargeTmr.start();
				chargeState = CS_CHARGE_START;
				SND_MNGR.playSound(SFX_MEGA_MAN_CHARGE_START);
				startReplaceColor();
				chargeCtr = 2;
				flash(); // resets color to make sure it doesn't flash finished charge color before starting
				// outline 1
			}
			else if (chargeState == CS_CHARGE_START)
			{
				chargeTmr.delay = WEAK_CHARGE_DUR;
				chargeTmr.start();
				chargeState = CS_CHARGE_OUTLINE_2;
				// outline 2
			}
			else if (chargeState == CS_CHARGE_OUTLINE_2)
			{
				chargeTmr.delay = FULL_CHARGE_DUR;
				chargeTmr.start();
				chargeState = CS_WEAK_CHARGE;
				// outline 3
			}
			else if (chargeState == CS_WEAK_CHARGE)
			{
				chargeState = CS_FULL_CHARGE;
			}
		}
		/*override protected function getMushroom():void
		{
			super.getMushroom();
			if (pState != 3)
				relAtkBtn();
			if (pState == 1)
			{
				setPowerState(2);
				pState = 1;
			}
		}*/
		override protected function getMushroomEnd():void
		{
//			swapPsEnd();
			lockFrame = false;
			if (!starPwr && chargeState == CS_NORMAL)
				endReplaceColor();
			var pStateNum:int = pState + 1;
			if (pStateNum > 3)
				pStateNum = 3;
			setPowerState(pStateNum);
//			head.visible = false;
			lockState = false;
			setState(ST_NEUTRAL);
			getDataFromDamageInfoArr();
			if (GameSettings.tutorials)
				TUT_MNGR.gotPowerUp(this);
			poweringUp = false;
			if (!primaryAttackButtonIsPressed)
				resetChargeState();
		}
		override protected function hitAnimation():void
		{
			head.hitStopAnim = head.stopAnim;
			head.stopAnim = true;
			head.hitFrameLabel = head.currentLabel;
			super.hitAnimation();
			head.setStopFrame("closedOpen");
		}
		override protected function takeDamageStart(source:LevObj):void
		{
			if (GameSettings.damageResponse == DamageResponse.LoseSomeUpgrades && !GameSettings.classicMode)
				removeOneThirdOfUpgrades();
			super.takeDamageStart(source);
			setStopFrame(FL_TAKE_DAMAGE);
			SND_MNGR.playSound(SN_TAKE_DAMAGE);
			takeNoDamage = true;
			disableInput = true;
			nonInteractive = true;
			setState(ST_TAKE_DAMAGE);
//			resetChargeState();
			BTN_MNGR.relPlyrBtns();
			
			if ( skinProtoMan || skinNum == MegaMan.SKIN_FIRE_MAN_NES )
			{
				if (scaleX > 0)
					vx = -TAKE_DAMAGE_SPEED_LONG;
				else
					vx = TAKE_DAMAGE_SPEED_LONG;
				takeDamageTmr.delay = TAKE_DAMAGE_TMR_DEL_LONG;
			}
			else
			{
				if (scaleX > 0)
					vx = -TAKE_DAMAGE_SPEED;
				else
					vx = TAKE_DAMAGE_SPEED;
				takeDamageTmr.delay = TAKE_DAMAGE_TMR_DEL;
			}
//			if ( (this is MegaMan) && (skinNum > 2 && skinNum < 6) || skinNum == MegaMan.SKIN_BREAK_MAN_NES || skinNum == MegaMan.SKIN_BREAK_MAN_SNES || skinNum == MegaMan.SKIN_BREAK_MAN_GB )
//				takeDamageTmr.delay = TAKE_DAMAGE_TMR_DEL_LONG;
//			else
//				takeDamageTmr.delay = TAKE_DAMAGE_TMR_DEL;
			vy = 0;
			flickerStart();
			damageSplash = new MegaManSimpleGraphics( this, MegaManSimpleGraphics.TYPE_DAMAGE_SPLASH );
			level.addToLevel( damageSplash );
			takeDamageTmr.start();
		}
		
		override protected function beforeLoseSomeUpgradesCalled():void
		{
			var possibleUpgradesCount:int = 0;
			for each( var upg:String in STAT_MNGR.getObtainedUpgradesDct(charNum) )
			{
				if ( restorableUpgrades.containsKey(upg) )
					possibleUpgradesCount++;
			}
			oneThirdOfUpgradesCount = Math.floor( possibleUpgradesCount / 3 );
			if (oneThirdOfUpgradesCount < 1)
				oneThirdOfUpgradesCount = 1;
			trace("one third: "+oneThirdOfUpgradesCount);
			removeOneThirdOfUpgrades();
		}
		
		private function removeOneThirdOfUpgrades():void
		{
//			var num:int = Math.ceil( storedUpgrades.length / 2 );
			var num:int = oneThirdOfUpgradesCount;
			var vec:Vector.<String> = new Vector.<String>();
			for each( var upg:String in STAT_MNGR.getObtainedUpgradesDct(charNum) )
			{
				if ( restorableUpgrades.containsKey(upg) )
					vec.push(upg);
			}
			
			if (vec.length == 0)
				return;
			var dct:CustomDictionary = new CustomDictionary();
			while (dct.length < num)
			{
				var str:String = vec[ int(Math.random()*num) ];
				if ( dct[str] == undefined )
					dct.addItem(str,str);
			}
			
			for each (var upgradeName:String in dct)
				STAT_MNGR.removeCharUpgrade(charNum, upgradeName, true);
		}

		override protected function flickerTmrHandler(event:Event):void
		{
			super.flickerTmrHandler(event);
			if (damageSplash)
				damageSplash.visible = !visible;
		}
		
		
		override protected function takeDamageEnd():void
		{
			damageSplash = null;
			disableInput = false;
			nonInteractive = false;
			setState(ST_NEUTRAL);
			setStopFrame(FL_STAND);
			if (onGround)
				vx = 0;
			noDamageTmr.start();
			checkState();
			BTN_MNGR.sendPlayerBtns();
			dispatchEvent( new Event(CustomEvents.CHARACTER_TAKE_DAMAGE_END) );
		}
		
		override protected function noDamageTmrLsr(e:TimerEvent):void
		{
			super.noDamageTmrLsr(e);
			flickerStop();
		}
		
		
		override protected function swapPs():void
		{
			super.swapPs();
			var hcl:String = head.currentLabel;
			var hsf:String = hcl.substr(0,hcl.length-2);
			head.setStopFrame(hsf);
			if (pState == 1)
			{
//				if (showHead)
//					head.visible = true;
			}
			else if (pState == 2 || pState == 3)
				head.visible = false;
		}
		override public function manualChangePwrState():void
		{
			head.hitFrameLabel = head.currentLabel;
			super.manualChangePwrState();
			var hcl:String = head.currentLabel;
			var hsf:String = hcl.substr(0,hcl.length-2);
			head.setStopFrame(hsf);
		}
		override public function recolorBmps(inPalette:Palette,outPalette:Palette,inColorRow:int = 0,outColorRow:int = 0,defColorsOvrd:Palette = null):void
		{
			super.recolorBmps(inPalette, outPalette, inColorRow, outColorRow);
//			head.recolorBmps(inPalette, outPalette, inColorRow, outColorRow, defColors);
			arm.recolorBmps(inPalette, outPalette, inColorRow, outColorRow, defColors);
		}
		
		override public function resetColor(useCleanBmd:Boolean=false):void
		{
			super.resetColor(useCleanBmd);
//			head.resetColor(useCleanBmd);
			arm.resetColor(useCleanBmd);
		}
		
		override public function exitPipeVert(pt:PipeTransporter):void
		{
			super.exitPipeVert(pt);
			head.setStopFrame("openClosed");
		}
		override protected function initiateNormalDeath(source:LevObj = null):void
		{
			super.initiateNormalDeath(source);
			stopUpdate = true;
			stopAnim = true;
			stopHit = true;
			partVec = new Vector.<MegaManParticle>();
			var skinNumColor:Boolean;
			
			if ( ((this is MegaMan) && (MegaManParticle.MEGA_MAN_COLOR_PARTICLE_SKIN_NUM.indexOf(skinNum) != -1)) || ((this is Bass) && (MegaManParticle.BASS_COLOR_PARTICLE_SKIN_NUM.indexOf(skinNum) != -1)) )
				skinNumColor = true;
			else
				skinNumColor = false;

			partVec.push(new MegaManParticle(true,"up",this));
			partVec.push(new MegaManParticle(true,"rht",this));
			partVec.push(new MegaManParticle(true,"dwn",this));
			partVec.push(new MegaManParticle(true,"lft",this));
			partVec.push(new MegaManParticle(false,"up",this));
			partVec.push(new MegaManParticle(false,"up-rht",this));
			partVec.push(new MegaManParticle(false,"rht",this));
			partVec.push(new MegaManParticle(false,"dwn-rht",this));
			partVec.push(new MegaManParticle(false,"dwn",this));
			partVec.push(new MegaManParticle(false,"dwn-lft",this));
			partVec.push(new MegaManParticle(false,"lft",this));
			partVec.push(new MegaManParticle(false,"up-lft",this));

			if (!skinNumColor)
			{
				partVec.push(new MegaManParticle(true,"up-rht",this));
				partVec.push(new MegaManParticle(true,"dwn-rht",this));
				partVec.push(new MegaManParticle(true,"dwn-lft",this));
				partVec.push(new MegaManParticle(true,"up-lft",this));
			}

			var n:int = partVec.length;
			for (var i:int = 0; i < n; i++)
			{
				var part:MegaManParticle = partVec[i];
				level.addToLevel(part);
			}
			if (skinNumColor)
				particleTmr = new CustomTimer(MegaManParticle.PARTICLE_COLOR_SEP_TMR_DEL,1);
			else
				particleTmr = new CustomTimer(MegaManParticle.PARTICLE_WHITE_SEP_TMR_DEL,1);
			addTmr(particleTmr);
			particleTmr.addEventListener(TimerEvent.TIMER_COMPLETE,particleTmrLsr,false,0,true);
			particleTmr.start();

			// Set SFX Mega Man
			if (skinNumColor)
				SND_MNGR.playSound(SoundNames.SFX_MEGA_MAN_DIE_ALT);
			else
				SND_MNGR.playSound(SoundNames.SFX_MEGA_MAN_DIE);
			
			// Set SFX Bass
			
//			SND_MNGR.playMusic(MusicInfo[NSF_STR_DIE]);
//			SND_MNGR.changeMusic( MusicType.DIE );
		}
		override protected function initiatePitDeath():void
		{
			_dieTmrDel = DIE_TMR_DEL_PIT;
			super.initiatePitDeath();
			if (atkBtn)
				relAtkBtn();
//			SND_MNGR.playMusic(MusicInfo[NSF_STR_DIE]);
			SND_MNGR.playSound(SoundNames.SFX_MEGA_MAN_DIE);
		}
		override public function slideDownFlagPole():void
		{
			super.slideDownFlagPole();
			nx = level.flagPole.hMidX;
			setPlayFrame("climbStart");
			head.setStopFrame("climb");
			shoot = false;
		}
		public static function getProtoManWhistleSong():Song
		{
			var statMngr:StatManager = StatManager.STAT_MNGR;
			if (statMngr.getSkinName() == PROTO_MAN_NAME)
			{
				switch(statMngr.getCurrentBmc(statMngr.curCharNum).consoleType)
				{
					case ConsoleType.BIT_8:
						return Games.megaMan9.SngProtoManWhistle;
					case ConsoleType.BIT_16:
						return Games.megaMan7.SngProtoManWhistle;
					case ConsoleType.GB:
						return Games.megaMan4Gb.SngProtoWhistle;
				}
			}
			return null;
		}
		public static function checkSkinProtoMan():Boolean
		{
			if ( (player is MegaMan) && (PROTO_MAN_SKIN.indexOf(player.skinNum) != -1) )
				return true;
			else
				return false;
		}
		override public function stopFlagPoleSlide():void
		{
			super.stopFlagPoleSlide();
			if (onGround)
			{
				setState(ST_STAND);
				setStopFrame("stand");
			}
			else
			{
				setState(ST_JUMP);
				setStopFrame("jump");
			}
		}
		override protected function flagDelayTmrLsr(e:TimerEvent):void
		{
			super.flagDelayTmrLsr(e);
			if (onGround)
			{
				setState(ST_WALK);
				onGround = true;
			}
		}
		private function particleTmrLsr(e:TimerEvent):void
		{
			particleTmr.stop();
			particleTmr.removeEventListener(TimerEvent.TIMER_COMPLETE,particleTmrLsr);
			particleTmr = null;
			visible = false;
//			if (playerGraphic)
//				playerGraphic.visible = false;
			EVENT_MNGR.startDieTmr(DIE_TMR_DEL_NORMAL);
			var n:int = partVec.length;
			for (var i:int = 0; i < n; i++)
			{
				var part:MegaManParticle = partVec[i];
				part.separate();
			}
		}
		override public function checkFrame():void
		{
			var cl:String = currentLabel;
			var cf:int = currentFrame;
			if (cState == ST_WALK || cState == ST_PIPE)
			{
				for (var i:uint = 1;i <= numParFrames;i++)
				{
					if (shoot || (carryingItem && !throwUsesNonShootFrames) )
					{
						if (cl == convLab("walk-" + i.toString()))
						{
							if (i != numParFrames)
								setPlayFrame("walkShoot-" + i.toString());
							else
								setPlayFrame("walkShoot-1");
						}
					}
					else if (cl == convLab("walkShoot-" + i.toString()))
					{
						if (i != numParFrames)
							setPlayFrame("walk-" + i.toString());
						else
							setPlayFrame("walk-1");
					}
				}
				cf = currentFrame;
				if (cf == getLabNum("walk-4") + 1 || cf == getLabNum("walkShoot-4") + 1)
				{
					if (shoot || carryingItem)
						setPlayFrame("walkShoot-1");
					else
						setPlayFrame("walk-1");
				}
			}
			else if (cState == ST_JUMP && currentFrameLabel == convLab("jumpShoot") && !shoot) setStopFrame("jump");
			else if (cState == ST_FLAG_SLIDE || cState == ST_VINE)
			{
				if (cf == getLabNum("climbEnd") + 1)
					setPlayFrame("climbStart");
			}
			if (cl == FL_TELEPORT_END)
				teleportRaise();
			//super.checkFrame();
		}
		
		private function shootTmrHandler(e:TimerEvent):void
		{
			if (primaryWeapon == MM_BASS_BUSTER && primaryAttackButtonIsPressed && onGround)
				return;
			shoot = false;
			armCustomFrame = false;
//			arm.setStopFrame(FL_ARM_NORMAL);
		}
		override protected function landOnGround():void
		{
			SND_MNGR.playSound(SFX_MEGA_MAN_LAND);
			canDoubleJump = true;
			if (shoot && stopWhileShooting)
			{
				vx = 0;
				if (!armCustomFrame || !customThrowFrames)
					setStopFrame(FL_SHOOT);
				else
				{
					arm.setStopFrame(FL_ARM_STAND_THROW);
					setStopFrame(FL_THROW);
				}
			}
		}
		override protected function removeListeners():void
		{
			super.removeListeners();
			if (shootTmr && shootTmr.hasEventListener(TimerEvent.TIMER_COMPLETE)) shootTmr.removeEventListener(TimerEvent.TIMER_COMPLETE,shootTmrHandler);
			if (chargeTmr && chargeTmr.hasEventListener(TimerEvent.TIMER_COMPLETE)) chargeTmr.removeEventListener(TimerEvent.TIMER_COMPLETE,chargeInt);
			if (particleTmr && particleTmr.hasEventListener(TimerEvent.TIMER_COMPLETE)) particleTmr.removeEventListener(TimerEvent.TIMER_COMPLETE,particleTmrLsr);
			if (rapidFireTmr)
				rapidFireTmr.removeEventListener(TimerEvent.TIMER,rapidFireTmrHandler);
			EVENT_MNGR.removeEventListener(CustomEvents.LEVEL_SET_INDEXES,levelSetIndexesHandler);
			STEP_TMR.removeEventListener(TimerEvent.TIMER_COMPLETE,stepTmrHandler);
			if (takeDamageTmr != null)
				takeDamageTmr.removeEventListener(TimerEvent.TIMER_COMPLETE,takeDamageTmrHandler);
		}
		override protected function reattachLsrs():void
		{
			super.reattachLsrs();
			if (shootTmr && !shootTmr.hasEventListener(TimerEvent.TIMER_COMPLETE))
				shootTmr.addEventListener(TimerEvent.TIMER_COMPLETE,shootTmrHandler);
			if (chargeTmr && !chargeTmr.hasEventListener(TimerEvent.TIMER_COMPLETE))
				chargeTmr.addEventListener(TimerEvent.TIMER_COMPLETE,chargeInt);
			if (rapidFireTmr)
				rapidFireTmr.addEventListener(TimerEvent.TIMER,rapidFireTmrHandler,false,0,true);
			STEP_TMR.addEventListener(TimerEvent.TIMER_COMPLETE,stepTmrHandler,false,0,true);
			if (takeDamageTmr != null)
				takeDamageTmr.addEventListener(TimerEvent.TIMER_COMPLETE,takeDamageTmrHandler,false,0,true);
		}
		
		override public function fallenCharSelScrn():void
		{
			super.fallenCharSelScrn();
			cancelCheckState = true;
			setStopFrame(FL_TAKE_DAMAGE);
		}
		private function teleportRaise():void
		{
			stopAnim = true;
			vy = -TELEPORT_SPEED;
			defyGrav = true;
			stopHit = true;
		}
		override public function animate(ct:ICustomTimer):Boolean
		{
			if (energyTmr)
				return false;
			var bool:Boolean = super.animate(ct);
			if (ct == mainAnimTmr)
			{
				head.animate(ct);
			}
			return bool;
		}
		override protected function prepareDrawCharacter(skinAppearanceState:int = -1):void
		{
			if (skinAppearanceState < 0)
				skinAppearanceState = 0;
			
			updateWeaponsVec(0,true,false);
			endReplaceColor();
			arm.setStopFrame(FL_ARM_NORMAL);
			changeSuitColor( getSuitColorOfsFromSkinAppearanceNum(skinAppearanceState) );
			super.prepareDrawCharacter(skinAppearanceState);
		}
		
		private function getSuitColorOfsFromSkinAppearanceNum(skinAppearanceNum:int):int
		{
			var weapon:String = defWeapon;
			if (skinAppearanceNum > 0)
			{
				for (var weaponName:String in SKIN_APPEARANCE_NUM_DCT)
				{
					if ( SKIN_APPEARANCE_NUM_DCT[weaponName] == skinAppearanceNum )
					{
						weapon = weaponName;
						break;
					}
				}
			}
			return SUIT_COLOR_OFS_DCT[weapon];
		}
		
		override public function cleanUp():void
		{
			if (!head.visible)
				removeObjsFromFrames(head,[currentFrameLabel]);
			super.cleanUp();
			if (energyBar.parent)
				energyBar.parent.removeChild(energyBar);
		}
		
		
	}
	
}