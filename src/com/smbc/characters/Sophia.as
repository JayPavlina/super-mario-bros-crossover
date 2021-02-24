package com.smbc.characters
{
	
	import com.explodingRabbit.cross.gameplay.statusEffects.StatFxFlash;
	import com.explodingRabbit.cross.gameplay.statusEffects.StatusProperty;
	import com.explodingRabbit.utils.CustomDictionary;
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.data.AnimationTimers;
	import com.smbc.data.CharacterInfo;
	import com.smbc.data.Cheats;
	import com.smbc.data.Difficulties;
	import com.smbc.data.GameSettings;
	import com.smbc.data.HitTester;
	import com.smbc.data.MovieClipInfo;
	import com.smbc.data.PaletteTypes;
	import com.smbc.data.PickupInfo;
	import com.smbc.data.RandomDropGenerator;
	import com.smbc.data.SoundNames;
	import com.smbc.displayInterface.SophiaHoverBar;
	import com.smbc.displayInterface.SophiaMissileCount;
	import com.smbc.enemies.Enemy;
	import com.smbc.enums.SophiaWeapon;
	import com.smbc.graphics.*;
	import com.smbc.graphics.BmdSkinCont;
	import com.smbc.ground.Brick;
	import com.smbc.ground.Ground;
	import com.smbc.ground.Platform;
	import com.smbc.ground.SpringRed;
	import com.smbc.interfaces.ICustomTimer;
	import com.smbc.main.AnimatedObject;
	import com.smbc.main.GlobVars;
	import com.smbc.main.LevObj;
	import com.smbc.managers.TutorialManager;
	import com.smbc.messageBoxes.MessageBox;
	import com.smbc.messageBoxes.PlainMessageBox;
	import com.smbc.pickups.BowserAxe;
	import com.smbc.pickups.Pickup;
	import com.smbc.pickups.PipeTransporter;
	import com.smbc.pickups.Rush;
	import com.smbc.pickups.SophiaPickup;
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
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
			
	public final class Sophia extends Character
	{
		public static const CHAR_NAME:String = CharacterInfo.Sophia[ CharacterInfo.IND_CHAR_NAME ];
		public static const CHAR_NAME_CAPS:String = CharacterInfo.Sophia[ CharacterInfo.IND_CHAR_NAME_CAPS ];
		public static const CHAR_NAME_TEXT:String = CharacterInfo.Sophia[ CharacterInfo.IND_CHAR_NAME_MENUS ];
		public static const CHAR_NUM:int = CharacterInfo.Sophia[ CharacterInfo.IND_CHAR_NUM ];
		public static const PAL_ORDER_ARR:Array = [ PaletteTypes.FLASH_POWERING_UP ];
		public static const SOPHIA_CEILING_CLIMB:String = PickupInfo.SOPHIA_CEILING_CLIMB;
		public static const SOPHIA_HOMING_MISSILE:String = PickupInfo.SOPHIA_HOMING_MISSILE;
		public static const HOMING_MISSILE_AMMO:String = PickupInfo.SOPHIA_HOMING_MISSILE_AMMO;
		public static const MISSILE_AMMO:String = PickupInfo.SOPHIA_MISSILE_AMMO;
		public static const SOPHIA_HOVER:String = PickupInfo.SOPHIA_HOVER;
		public static const SOPHIA_WALL_CLIMB:String = PickupInfo.SOPHIA_WALL_CLIMB;
		public static const SOPHIA_WALL_JUMP:String = PickupInfo.SOPHIA_WALL_JUMP;
		public static const SOPHIA_CRUSHER:String = PickupInfo.SOPHIA_CRUSHER;
		public static const SOPHIA_HYPER:String = PickupInfo.SOPHIA_HYPER;
		public static const SOPHIA_MISSILE:String = PickupInfo.SOPHIA_MISSILE;
		public static const OBTAINABLE_UPGRADES_ARR:Array = [ [ SOPHIA_HOVER, SOPHIA_CRUSHER, SOPHIA_WALL_CLIMB ] ];
		public static const REPLACEABLE_UPGRADES_ARR:Array = [ [ SOPHIA_WALL_CLIMB, SOPHIA_CEILING_CLIMB ] ];
		
		override public function get classicGetMushroomUpgrades():Vector.<String>
		{ return Vector.<String>([ SOPHIA_HYPER, SOPHIA_HOVER ]); }
		
		override public function get classicGetFireFlowerUpgrades():Vector.<String>
		{ return Vector.<String>([ SOPHIA_CRUSHER, SOPHIA_WALL_CLIMB, SOPHIA_CEILING_CLIMB, classicWeapon ]); }
		
		override public function get classicLoseFireFlowerUpgrades():Vector.<String>
		{ return Vector.<String>([ SOPHIA_CRUSHER, SOPHIA_WALL_CLIMB, SOPHIA_CEILING_CLIMB ]); }
		
		public static const MUSHROOM_UPGRADES:Array = [ SOPHIA_HYPER ];
		public static const NEVER_LOSE_UPGRADES:Array = [ SOPHIA_MISSILE, SOPHIA_HOMING_MISSILE ];
		public static const START_WITH_UPGRADES:Array = [ ];
		public static const RESTORABLE_UPGRADES:Array = [ SOPHIA_WALL_CLIMB, SOPHIA_CEILING_CLIMB, SOPHIA_HOVER ];
		public static const SINGLE_UPGRADES_ARR:Array = [ ];
		public static const TITLE_SCREEN_UPGRADES:Array = [ MUSHROOM, SOPHIA_HYPER, SOPHIA_WALL_CLIMB, SOPHIA_CEILING_CLIMB ];
		public static const HOVER_MAX:int = 8;
		public static const HOVER_MIN:int = 0;
		public static const ICON_ORDER_ARR:Array = [ SOPHIA_MISSILE, SOPHIA_HOMING_MISSILE, SOPHIA_CRUSHER, SOPHIA_HOVER, SOPHIA_WALL_CLIMB, SOPHIA_CEILING_CLIMB ]; 
		public static const AMMO_ARR:Array = [ [ SOPHIA_MISSILE, 9, 60 ], [ SOPHIA_HOMING_MISSILE, 3, 20 ], [ SOPHIA_HOVER, HOVER_MAX, HOVER_MAX ] ];
		public static const AMMO_DEPLETION_ARR:Array = [ [ SOPHIA_MISSILE, 3 ], [ SOPHIA_HOMING_MISSILE, 1 ], [ SOPHIA_HOVER, 1 ] ];
		public static const AMMO_DEPLETION_DCT:CustomDictionary = new CustomDictionary();
		private static const DROP_ARR_HOMING_MISSILE:Array = [ [ 0, HOMING_MISSILE_AMMO ] ];
		private static const DROP_ARR_MISSILE:Array = [ [ 0, MISSILE_AMMO ] ];
		private static const DROP_ARR_BOTH:Array = [ [ 0, MISSILE_AMMO ], [ .5, HOMING_MISSILE_AMMO ] ];
		public static const AMMO_DCT:CustomDictionary = new CustomDictionary();
		public static const WIN_SONG_DUR:int = 3000;
		public static const CHAR_SEL_END_DUR:int = 2000;
		private static const DIE_TMR_DEL_NORMAL:int = 2500;
		private static const DIE_TMR_DEL_PIT:int = 2500;
		public static const IND_CI_Sophia:int = 1;
		public static const IND_CI_SophiaLightning:int = 6;
		public static const IND_CI_Jason:int = 7;
		public static const IND_CI_SophiaBullet:int = 8;
		public static const IND_CI_SophiaHoverBar:int = 9;
		public static const COL_PINK:uint = 0xFFe44a85;
		public static const COL_MAGENTA:uint = 0xFFe40058;
		public static const COL_RED:uint = 0xFFb10000;
		private static const COL_WHITE:uint = 0xFFffffff;
		private static const COL_BLACK:uint = 0xFF000000;
		// replace color constants
		// 1 = base, 2 = white, 3 = black
		private static const REPL_COLOR_1_1:uint = COL_PINK;
		private static const REPL_COLOR_2_1:uint = COL_WHITE;
		private static const REPL_COLOR_3_1:uint = COL_BLACK;
		private static const REPL_COLOR_1_2:uint = COL_MAGENTA;
		private static const REPL_COLOR_2_2:uint = COL_WHITE;
		private static const REPL_COLOR_3_2:uint = COL_BLACK;
		private static const REPL_COLOR_1_3:uint = COL_RED;
		private static const REPL_COLOR_2_3:uint = COL_WHITE;
		private static const REPL_COLOR_3_3:uint = COL_BLACK;
		private static const FLASH_COLOR_1_1:uint = 0xFFf87858; // orange
		private static const FLASH_COLOR_2_1:uint = 0xFFf8b7a6; // light orange
		private static const FLASH_COLOR_3_1:uint = COL_BLACK; // black
		private static const FLASH_COLOR_1_2:uint = 0xFF7c7c7c; // dark gray
		private static const FLASH_COLOR_2_2:uint = COL_WHITE; // white
		private static const FLASH_COLOR_3_2:uint = COL_BLACK; // black
		private static const FLASH_COLOR_1_3:uint = 0xFF00a844; // dark green
		private static const FLASH_COLOR_2_3:uint = 0xFFb8f8d8; // light green
		private static const FLASH_COLOR_3_3:uint = COL_BLACK; // black
		public static const ROT_WALL_BOT:int = 0;
		public static const ROT_WALL_LEFT:int = 90;
		public static const ROT_WALL_RIGHT:int = -90;
		public static const ROT_WALL_TOP:int = 180;
		private static const WALL_BOTTOM_STR:String = "bottom";
		private static const WALL_LEFT_STR:String = "left";
		private static const WALL_TOP_STR:String = "top";
		private static const WALL_RIGHT_STR:String = "right";
		private static const SECONDS_LEFT_SND:String = SoundNames.BGM_MEGA_MAN_SECONDS_LEFT;
		private static const SND_MUSIC_WIN:String = SoundNames.MFX_MEGA_MAN_WIN;
		public static const FL_BASE_HORZ:String = "horz";
		public static const FL_BASE_TURN_START:String = "turnStart";
		public static const FL_BASE_TURN_2:String = "turn-2";
		public static const FL_BASE_OPEN:String = "open";
		private static const FL_BASE_DIAG:String = "diag";
		private static const FL_BASE_UP:String = "up";
		private static const FL_MAIN:String = "main";
		private static const FL_CLIMB_VINE:String = "climbVine";
		private static const FL_VINE_TRANS_START:String = "vineTransStart";
		private static const FL_VINE_TRANS_END:String = "vineTransEnd";
		private static const FL_WALL_TRANS_START:String = "wallTransStart";
		private static const FL_WALL_TRANS_END:String = "wallTransEnd";
		private static const FL_WALL_TRANS_INV_START:String = "wallTransInvStart";
		private static const FL_WALL_TRANS_INV_END:String = "wallTransInvEnd";
		private static const FL_WHEEL_HOVER:String = "hover";
		public static const FL_WHEEL_HOVER_BIG_FLAME:String = "hoverBigFlame";
		public static const FL_WHEEL_HOVER_SMALL_FLAME:String = "hoverSmallFlame";
		private static const FL_WHEEL_HOVER_TRANS:String = "hoverTrans";
		private static const FL_WHEEL_WATER_1:String = "water-1";
		private static const FL_WHEEL_WATER_2:String = "water-2";
		public static const FL_WHEEL_START:String = "start";
		public static const FL_WHEEL_END:String = "end";
		private static const MAIN_REMOVE_ARR:Array = [ FL_MAIN ];
		private const WALL_TRANS_FRAMES_DCT:CustomDictionary = new CustomDictionary(true);
		private static const SN_HOVER:String = SoundNames.SFX_SOPHIA_HOVER;
		private static const SN_JUMP:String = SoundNames.SFX_SOPHIA_JUMP;
		private static const SN_LAND:String = SoundNames.SFX_SOPHIA_LAND;
		private static const SN_TAKE_DAMAGE:String = SoundNames.SFX_SOPHIA_TAKE_DAMAGE;
		private static const ST_WALL_TRANS:String = "wallTrans";
		public static const ST_CLIMB:String = "climb";
		public static const ST_CLIMB_JUMP:String = "climbJump";
		public static const SHOOT_UP_FRAME:String = FL_BASE_UP;
		private static const NUM_BASE_TURN_FRAMES:int = 2;
		private static const NUM_WALL_TRANS_FRAMES:int = 8;
		private static const NUM_WALL_TRANS_INV_FRAMES:int = 9;
		private static const SHOT_TYPE_HOMING_MISSILE:String = SophiaBullet.SH_HOMING_MISSILE;
		private static const SHOT_TYPE_MISSILE:String = SophiaBullet.SH_MISSILE;
		/*private const SFX_MEGA_MAN_CHARGE_LOOP:String = SoundNames.SFX_MEGA_MAN_CHARGE_LOOP;
		private const SFX_MEGA_MAN_CHARGE_START:String = SoundNames.SFX_MEGA_MAN_CHARGE_START;
		private const SFX_MEGA_MAN_DIE:String = SoundNames.SFX_MEGA_MAN_DIE;
		private const SFX_MEGA_MAN_LAND:String = SoundNames.SFX_MEGA_MAN_LAND;*/
		private static const DEL_BASE_JUMP_BOUNCE_TMR:int = 60;
		private static const DEL_BASE_BOUNCE_TMR_SLOW:int = 150;
		private static const DEL_BASE_BOUNCE_TMR_MEDIUM:int = 125;
		private static const DEL_BASE_BOUNCE_TMR_FAST:int = 100;
		private static const DEL_WALL_TRANS_TMR:int = 25; // 25 for wall transfer animation, uses BASE_VERT_TMR
		private static const DEL_WHEEL_TMR_SLOW:int = 100;
		private static const DEL_WHEEL_TMR_MEDIUM:int = 70;
		public static const DEL_WHEEL_TMR_FAST:int = 45;
		private static const DEL_WHEEL_TMR_WATER_SLOW:int = 60;
		private static const DEL_WHEEL_TMR_WATER_FAST:int = 30;
		private static const DEL_WHEEL_HOVER_TRANS:int = 60;
		private static const DEL_HOVER_FLAME:int = 25;
		private const DEFAULT_ANIM_TMR:CustomTimer = AnimationTimers.ANIM_MIN_FAST_TMR;
		private const WHEEL_TMR:GameLoopTimer = new GameLoopTimer(45);
		private const BASE_VERT_TMR:GameLoopTimer = new GameLoopTimer(DEL_BASE_BOUNCE_TMR_FAST); // controls vertical base movement
		private const BASE_TURN_TMR:GameLoopTimer = new GameLoopTimer(60,NUM_BASE_TURN_FRAMES);
		private const MOVE_PARTS_TMR:GameLoopTimer = new GameLoopTimer(50);
		private const GAIN_HOVER_TMR:GameLoopTimer = new GameLoopTimer(2000);
		private const LOSE_HOVER_TMR:GameLoopTimer = new GameLoopTimer(300);
		private static const NUM_SCREEN_SCROLL_CYCLES:int = 15;
		private var fixScreenScroll:Boolean;
		private static const HOVER_CHANGE_INC:int = 1;
		private static const FIRE_MISSILE_COST:int = -1;
		public static const HOMING_MISSILE_PICKUP_VALUE:int = 2;
		public static const MISSILE_PICKUP_VALUE:int = 6;
		private static const VX_MIN:int = 5;
		public static const GRAVITY:int = 1050;
		private static const GRAVITY_WATER:int = 400;
		private static const JUMP_PWR:int = 400;
		private static const JUMP_PWR_WATER:int = JUMP_PWR;
		private static const JUMP_HEIGHT_VERT:int = 82; // 82
		private static const JUMP_HEIGHT_HORZ:int = 130;
		private static const DEF_SPRING_PWR:int = 400;
		private static const BOOST_SPRING_PWR:int = 930;
		private static const AY_WATER:int = 900;
		private static const VY_MAX_WATER:int = 190;
	//	private static const VY_MAX_PSV_WATER_NOT_MOVING:int = 50;
		private static const VX_MAX_DEF:int = 185;
		private static const VY_MAX_DEF:Number = NaN;
		private static const VX_MAX_WATER_NORMAL:int = 130;
		private static const VX_MAX_WATER_BOOST:int = 200;
		private static const VY_MAX_PSV_DEF:int = 500;
		private static const MAX_PLAT_DIST:int = 100;
		private static const MAX_SPEED_CLIMB_WATER:int = 80;
		private static const FX_DEF:Number = .001;
		private static const FX_DUNGEON_GOT_AXE:Number = .0000001;
		private static const FY_DEF:Number = .00000000001;
		private static const FY_HOLD_JMP:Number = .5;
		private static const FY_WATER_NGV:Number = .01;
		private static const FY_WATER_PSV:Number = .0000001;
		private static const FX_WALL_JUMP_HOLD_BTN:Number = .0025;
		private static const FX_WALL_JUMP_REL_BTN:Number = .000001;
		private static const WALL_JUMP_MIN_VX:int = 50;
		private static const WATER_FALL_SPEED:int = 1;
		private static const WHEEL_DEF_Y:int = -8;
		private static const WHEEL_JUMP_Y:int = 0;
		private static const FRONT_WHEEL_DEF_X:int = 16;
		private static const FRONT_WHEEL_INWARD_X:int = 10;
		private static const BACK_WHEEL_DEF_X:int = -16;
		private static const BACK_WHEEL_INWARD_X:int = -10;
		private static const WHEEL_X_SHIFT_INT:int = 2;
		private static const BASE_Y_SHIFT_INT:int = 4;
		public static const BASE_DEF_Y:int = -4;
		private static const BASE_DEF_X:int = 0;
		public static const BASE_BOUNCE_Y:int = -2;
		//private static const BASE_FALL_Y:int = -2;
		private static const BASE_JUMP_BOUNCE_Y:int = 0;
		private static const BASE_UP_DEF_Y:int = -16;
		private static const BASE_UP_BOUNCE_Y:int = -14;
		private static const BASE_UP_JUMP_BOUNCE_Y:int = -12;
		private static const BASE_VERT_OFS_DEF:int = 0;
		private static const BASE_VERT_OFS_FALL:int = 2;
		private static const MAX_BULLETS_ON_SCREEN:int = 3;
		private static const MAX_HOMING_MISSILES_ON_SCREEN:int = 4;
		private static const MAX_MISSILES_ON_SCREEN:int = 1;
		private static const HOVER_BOOST_POWER:int = 40;
		private static const HOVER_MAX_SPEED:int = 100;
		private static const CLIMB_INVERTED_OFS:int = 8;
		private static const CLIMB_OFS:int = 24;
		private static const SLOW_DELAY_MAX_VX:int = 40;
		private static const MEDIUM_DELAY_MAX_VX:int = 120;
		private static const MAX_INVERTED_CLIMB_DIST:int = 30;
		private static const MIN_NORMAL_CLIMB_DIST:int = 20;
		private static const DAMAGE_BOOST_SPEED_STATIONARY:int = 1000;
		private static const DAMAGE_BOOST_SPEED_MOVING:int = 50;
		public var jason:Jason;
		private var attachedToPlatform:Platform;
		private var fakeWallTransRealStatsArr:Array;
		private var recolorMain:Boolean;
		private var baseVertOfs:int;
		private var sophiaUpBtn:Boolean;
		private var sophiaDwnBtn:Boolean;
		private var sophiaLftBtn:Boolean;
		private var sophiaRhtBtn:Boolean;
		public var sophiaScaleX:Number;
		private var useEnterPipeVxMax:Boolean;
		public var hover:Boolean;
		private var engagedHover:Boolean;
		private var readyToJump:Boolean;
		public var jumpRise:Boolean;
		public var vertical:Boolean;
		private var revScaleX:Boolean;
		private var wallToAttachTo:Ground;
		private var wallSideToAttachTo:String;
		private var invertedWallTrans:Boolean;
		private var wallTransEndNx:Number = 0;
		private var wallTransEndNy:Number = 0;
		private var wallTransEndVx:Number = 0;
		private var wallTransEndVy:Number = 0;
		private var wallTransEndRevScaleX:Boolean;
		private var wallTransEndRotation:int;
		private var wallTransEndVertical:Boolean;
		private var falseGroundRect:Rectangle;
		private var lastRotation:int;
		private var ssxInt:Number; // dummy screen scroll interval
		private var yOfsInt:Number; // for inverted wall transfer y value
		private static const SCROLL_EASE_SPEED:int = 5;
		private static const SCROLL_FRICTION:Number = .01;
		private static const SCROLL_MIN_DIST:Number = .5;
		private var scrollDist:Number;
		private var hRectMainWidth:Number;
		private var hRectMainHeight:Number;
		public var hoverBar:SophiaHoverBar;
//		public const MISSILE_COUNT:SophiaMissileCount = new SophiaMissileCount();
		private var pBmd:BitmapData;
		private var scrollScreenDuringWallTrans:Boolean;
		// begin stage vars
		public var sophiaBase:SophiaBase;
		public var frontWheel:SophiaFrontWheel;
		public var backWheel:SophiaBackWheel;
		private var jumpEnd:Number;
		public var classic:Boolean;
		private const SKIN_CONT_DCT:CustomDictionary = new CustomDictionary(true);
		// end stage vars
		public static const DEFAULT_PROPS_DCT:CustomDictionary = new CustomDictionary();
		private var curSubWeapon:String;
		
		public static const SKIN_PREVIEW_SIZE:Point = new Point(36,24);
		public static const SKIN_ORDER:Array = [ 
			SKIN_SOPHIA_III_NES, 
			SKIN_SOPHIA_III_SNES, 
			SKIN_SOPHIA_III_16B, 
			SKIN_SOPHIA_III_GB, 
			SKIN_SOPHIA_III_X1, 
			SKIN_SOPHIA_III_ATARI, 
			SKIN_SOPHIA_J7_NES, 
			SKIN_SOPHIA_J7_SNES, 
			SKIN_SOPHIA_J7_GB, 
			SKIN_TETRIMINO_NES, 
			SKIN_TETRIMINO_SNES 
		];
		
		public static const SKIN_SOPHIA_III_NES:int = 0;
		public static const SKIN_SOPHIA_III_SNES:int = 1;
		public static const SKIN_SOPHIA_III_GB:int = 2;
		public static const SKIN_SOPHIA_J7_NES:int = 3;
		public static const SKIN_SOPHIA_J7_SNES:int = 4;
		public static const SKIN_SOPHIA_J7_GB:int = 5;
		public static const SKIN_TETRIMINO_NES:int = 6;
		public static const SKIN_SOPHIA_III_ATARI:int = 7;
		public static const SKIN_SOPHIA_III_X1:int = 8;
		public static const SKIN_TETRIMINO_SNES:int = 9;
		public static const SKIN_SOPHIA_III_16B:int = 10;
		
		public static const SPECIAL_SKIN_NUMBER:int = SKIN_SOPHIA_III_X1;
		public static const ATARI_SKIN_NUMBER:int = SKIN_SOPHIA_III_ATARI;
		
		public function Sophia() 
		{
			charNum = CHAR_NUM;
			super();
			if (!DEFAULT_PROPS_DCT.length)
			{
				DEFAULT_PROPS_DCT.addItem( new StatusProperty(PR_FLASH_AGG,0, new StatFxFlash(null,AnimationTimers.DEL_FAST,400) ) );
			}
			for each (var prop:StatusProperty in DEFAULT_PROPS_DCT)
			{
				addProperty(prop);
			}
//			pStateRecolor = true;
			_canGetAmmoFromBricks = true;
			_charName = CHAR_NAME;
			_charNameTxt = CHAR_NAME_TEXT;
			_charNameCaps = CHAR_NAME_CAPS;
			winSongDur = WIN_SONG_DUR;
			hidesBmps = true;
			_secondsLeftSnd = SECONDS_LEFT_SND;
			_sndWinMusic = SND_MUSIC_WIN;
			_secondsLeftSndIsBgm = true;
			_dieTmrDel = DIE_TMR_DEL_NORMAL;
			_usesHorzObjs = true;
			_usesVertObjs = true;
			_isWideCharacter = true;
			_isGoodSwimmer = true;
			canCrossSmallGaps = false;
			walkStartLab = "";
			walkEndLab = "";
			canHitMultipleBricks = true;
			if (this == player)
				hoverBar = new SophiaHoverBar(this);
//			if (level.player == this)
//			{
//				game.addChild(hoverBar);
////				game.addChild(MISSILE_COUNT);
//			}
//			MISSILE_COUNT.x = hoverBar.x; //448
//			MISSILE_COUNT.y = hoverBar.y + hoverBar.height + SophiaMissileCount.Y_OFS;
//			MISSILE_COUNT.updateDisplay(STAT_MNGR.numSophiaMissiles);
			hoverBar.updateDisplay( getAmmo(SOPHIA_HOVER) );
			//MISSILE_COUNT.visible = false;
			//HOVER_BAR.visible = false;
			//STAT_MNGR.changeStat(STAT_MNGR.STAT_NUM_SOPHIA_MISSILES,STAT_MNGR.NUM_SOPHIA_MISSILES_MAX,MISSILE_COUNT.updateDisplay);
		}
		public function setMaxHover():void
		{
			setAmmo( SOPHIA_HOVER, HOVER_MAX );
			hoverBar.updateDisplay( getAmmo( SOPHIA_HOVER ) );
		}
		override protected function setObjsToRemoveFromFrames():void
		{
			super.setObjsToRemoveFromFrames();
			removeObjsFromFrames(Bitmap,MAIN_REMOVE_ARR);
			removeObjsFromFrames(sophiaBase,MAIN_REMOVE_ARR,true);
			removeObjsFromFrames(frontWheel,MAIN_REMOVE_ARR,true);
			removeObjsFromFrames(backWheel,MAIN_REMOVE_ARR,true);
		}
		override protected function mcReplacePrep(thisMc:MovieClip):void
		{
			var frontWheelOld:MovieClip = thisMc.getChildByName("frontWheel") as MovieClip;
			var backWheelOld:MovieClip = thisMc.getChildByName("backWheel") as MovieClip;
			var baseOld:MovieClip = thisMc.getChildByName("base") as MovieClip;
			frontWheel = new SophiaFrontWheel( this, frontWheelOld );
			backWheel = new SophiaBackWheel( this, backWheelOld );
			sophiaBase = new SophiaBase( this, baseOld );
			mcReplaceArr = [ frontWheelOld, frontWheel, backWheelOld, backWheel, baseOld, sophiaBase ];
		}
		// SETSTATS sets statistics and initializes character
		override public function setStats():void
		{
			inColor1 = COL_MAGENTA;
			inColor2 = COL_WHITE;
			inColor3 = COL_BLACK;
			outColor1_1 = FLASH_COLOR_1_1;
			outColor2_1 = FLASH_COLOR_2_1;
			outColor3_1 = FLASH_COLOR_3_1;
			outColor1_2 = FLASH_COLOR_1_2;
			outColor2_2 = FLASH_COLOR_2_2;
			outColor3_2 = FLASH_COLOR_3_2;
			outColor1_3 = FLASH_COLOR_1_3;
			outColor2_3 = FLASH_COLOR_2_3;
			outColor3_3 = FLASH_COLOR_3_3;
			jumpPwr = JUMP_PWR;
			gravity = GRAVITY;
			//inColor1 = 0xFF00E8D8;
			//outColor1 = 0xFFFF0000;
			//_replaceColor = true; 
			if (level.waterLevel)
			{
				defGravity = gravity;
				gravity = GRAVITY_WATER;
				defGravityWater = gravity;
				jumpPwr = JUMP_PWR_WATER;
			}
			walksSlowUnderWater = true;
			defSpringPwr = DEF_SPRING_PWR;
			boostSpringPwr = BOOST_SPRING_PWR;
			ax = 800;
			fx = FX_DEF; 
			fy = FY_DEF;
			vxMaxDef = VX_MAX_DEF;
			vyMaxPsv = VY_MAX_PSV_DEF;
			vyMaxPsvWater = NaN;
			vxMax = vxMaxDef;
			vxMin = VX_MIN;
			//maxJumpHeight = 650;
			numParFrames = 0;
			pState2 = true;
			super.setStats();
			canStompUnderWater = false;
//			for each (var obj:BmdSkinCont in BMD_CONT_VEC)
//			{
//				SKIN_CONT_DCT.addItem(obj.bmp.parent as Sprite);
//			}
			gotoAndStop(FL_MAIN);
			setUpWheelsForLand();
//			initiateRecolor();
			releasedJumpBtn = true;
			sophiaScaleX = scaleX;
			updSubWeapon();
			stopAnim = false;
			hRectMainWidth = hRect.width;
			hRectMainHeight = hRect.height;
			// initiate timers
			WHEEL_TMR.addEventListener(TimerEvent.TIMER,wheelTmrHandler,false,0,true);
			addTmr(WHEEL_TMR);
			WHEEL_TMR.start();
			BASE_TURN_TMR.addEventListener(TimerEvent.TIMER,baseTurnTmrHandler,false,0,true);
			addTmr(BASE_TURN_TMR);
			MOVE_PARTS_TMR.addEventListener(TimerEvent.TIMER,movePartsTmrHandler,false,0,true);
			addTmr(MOVE_PARTS_TMR);
			BASE_VERT_TMR.addEventListener(TimerEvent.TIMER,baseVertTmrHandler,false,0,true);
			addTmr(BASE_VERT_TMR);
			GAIN_HOVER_TMR.addEventListener(TimerEvent.TIMER,gainHoverTmrHandler,false,0,true);
			addTmr(GAIN_HOVER_TMR);
			LOSE_HOVER_TMR.addEventListener(TimerEvent.TIMER,loseHoverTmrHandler,false,0,true);
			addTmr(LOSE_HOVER_TMR);
			if ( getAmmo(SOPHIA_HOVER) < HOVER_MAX )
				GAIN_HOVER_TMR.start();
			level.RECOLOR_OBJS_DCT.addItem(this);
			backWheel.setStopFrame(FL_WHEEL_HOVER_BIG_FLAME); // fixes wheel placement bug
		}
		
		private function updSubWeapon(change:Boolean = false):void
		{
			if ( upgradeIsActive(SOPHIA_HOMING_MISSILE) && !upgradeIsActive(SOPHIA_MISSILE) )
				curSubWeapon = SOPHIA_HOMING_MISSILE;
			else if ( !upgradeIsActive(SOPHIA_HOMING_MISSILE) && upgradeIsActive(SOPHIA_MISSILE) )
				curSubWeapon = SOPHIA_MISSILE;
			else if ( !upgradeIsActive(SOPHIA_HOMING_MISSILE) && !upgradeIsActive(SOPHIA_MISSILE) )
				curSubWeapon = null;
			else
			{
				curSubWeapon = STAT_MNGR.getSubWeapon(charNum);
				if (!curSubWeapon)
					curSubWeapon = SOPHIA_MISSILE;
				if (change)
				{
					if (curSubWeapon == SOPHIA_HOMING_MISSILE)
						curSubWeapon = SOPHIA_MISSILE;
					else
						curSubWeapon = SOPHIA_HOMING_MISSILE;
					SND_MNGR.playSound(SoundNames.SFX_SOPHIA_SELECT_WEAPON);
				}
			}
			if (curSubWeapon)
			{
				tsTxt.UpdAmmoIcon( true, curSubWeapon.substr(PickupInfo.UPGRADE_STR.length) );
				tsTxt.UpdAmmoText(true, getAmmo(curSubWeapon) );
			}
			else
			{
				tsTxt.UpdAmmoIcon(false);
				tsTxt.UpdAmmoText(false);
			}
			STAT_MNGR.setSubWeapon(charNum,curSubWeapon);
		}
		override protected function startAndDamageFcts(start:Boolean = false):void
		{
			super.startAndDamageFcts(start);
			updDrops();
			updSubWeapon();
			updHoverBarVisibility();
		}
		
		private function updHoverBarVisibility():void
		{
			if ( upgradeIsActive(SOPHIA_HOVER) )
				hoverBar.visible = true;
			else
				hoverBar.visible = false;
		}
		override public function forceWaterStats():void
		{
			defGravity = gravity;
			gravity = GRAVITY_WATER;
			defGravityWater = gravity;
			jumpPwr = JUMP_PWR_WATER;
			super.forceWaterStats();
		}
		override public function forceNonwaterStats():void
		{
			jumpPwr = JUMP_PWR;
			gravity = GRAVITY;
			super.forceNonwaterStats();
		}
		override protected function updateStats():void
		{
			if (onFallingPlatform)
				ny -= 8;
			super.updateStats();
		}
		override public function updateObj():void
		{
			super.updateObj();
			if (attachedToPlatform)
				onPlatform = attachedToPlatform;
		}
		/*private function updAmmoHud():void
		{
			if ( !upgradeIsActive(SOPHIA_HOMING_MISSILE) )
			{
				tsTxt.UpdAmmoIcon(false);
				tsTxt.UpdAmmoText(false);
			}
			else
			{
				tsTxt.UpdAmmoIcon( true, SOPHIA_HOMING_MISSILE.substr( PickupInfo.UPGRADE_STR.length ) );
				tsTxt.UpdAmmoText( true, getAmmo( SOPHIA_HOMING_MISSILE ) );
			}
		}*/
		private function updDrops():void
		{
			if (GameSettings.classicMode)
			{
				if ( upgradeIsActive(SOPHIA_MISSILE) )
					dropArr = DROP_ARR_MISSILE;
				else if ( upgradeIsActive(SOPHIA_HOMING_MISSILE) )
					dropArr = DROP_ARR_HOMING_MISSILE;
				else
					dropArr = [];
			}
			else
				dropArr = DROP_ARR_BOTH;
//			if ( upgradeIsActive(SOPHIA_HOMING_MISSILE) )
//			{
//				if ( !upgradeIsActive(SOPHIA_MISSILE) )
//					dropArr = DROP_ARR_HOMING_MISSILE;
//				else
//					dropArr = DROP_ARR_BOTH;
//			}
//			else if ( upgradeIsActive(SOPHIA_MISSILE) )
//				dropArr = DROP_ARR_MISSILE;
//			else
//				dropArr = [];
		}
		
		override protected function setAmmo(ammoType:String, value:int):void
		{
			super.setAmmo(ammoType, value);
			if (curSubWeapon == ammoType)
				tsTxt.UpdAmmoText( true, getAmmo( ammoType ) );
			if (ammoType == SOPHIA_HOVER)
				hoverBar.updateDisplay( getAmmo( SOPHIA_HOVER ) );
		}
		
		
		override protected function movePlayer():void 
		{
			if (cState == ST_WALL_TRANS)
				return;
			// if vertical, left = up, right = down
			if (sophiaRhtBtn && !sophiaLftBtn && !wallOnRight) 
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
				if (!vertical)
					vx += ax*dt;
				else
					vy += ax*dt;
				scaleX = 1;
				sophiaScaleX = scaleX;
				if (revScaleX)
					scaleX = -scaleX;
			}
			else if (sophiaLftBtn && !sophiaRhtBtn && !wallOnLeft) 
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
				if (!vertical)
					vx -= ax*dt;
				else
					vy -= ax*dt;
				scaleX = -1;
				sophiaScaleX = scaleX;
				if (revScaleX)
					scaleX = -scaleX;
			}
			else if (sophiaLftBtn && sophiaRhtBtn)
			{
				if (!vertical)
					vx *= Math.pow(fx,dt);
				else
					vy *= Math.pow(fx,dt);
			}
			else if (!sophiaLftBtn && !sophiaRhtBtn && onGround)
			{
				if (!vertical)
					vx *= Math.pow(fx,dt);
				else
					vy *= Math.pow(fx,dt);
			}
			if (underWater && !onGround && !jumpRise)
			{
				if (sophiaUpBtn && !sophiaDwnBtn)
				{
					vy -= AY_WATER*dt;
					//if (jumpRise)
					//	setJumpRise(false);
				}
				else if (sophiaDwnBtn && !sophiaUpBtn)
				{
					vy += AY_WATER*dt;
					//if (jumpRise)
					//	setJumpRise(false);
				}
				if ( !jumpRise && ( (!sophiaDwnBtn && !sophiaUpBtn) || (sophiaUpBtn && sophiaDwnBtn) ) )
				{
					if (vy > 0)
						vy *= Math.pow(FY_WATER_PSV,dt);
					else if (vy < 0)
						vy *= Math.pow(FY_WATER_NGV,dt);
					if (vy < 5 && vy > -5)
						vy = 0;
					ny += WATER_FALL_SPEED;
				}
				else
				{
					//vyMaxPsv = VY_MAX_PSV_WATER_NOT_MOVING;
					//defyGrav = false;
				}
				//if (!jumpRise)
				//{
					if (jmpBtn)
						vxMax = VX_MAX_WATER_BOOST;
					else
						vxMax = VX_MAX_WATER_NORMAL;
				//}
			}
			if (useEnterPipeVxMax)
				vxMax = ENTER_PIPE_VX_MAX;
		}
		override public function activateWatchModeEnterPipe():void
		{
			super.activateWatchModeEnterPipe();
			useEnterPipeVxMax = true;
			
		}
		override protected function jump():void
		{
			onGround = false;
			jumped = true;
			if (jmpBtn)
			{
				releasedJumpBtn = false;
				frictionY = false;
			}
			else
			{
				releasedJumpBtn = true;
				//frictionY = true;
			}
			if (cState === ST_CLIMB)
			{
				setState(ST_CLIMB_JUMP);
				brickState = BRICK_NONE;
			}
			var dir:int = -1;  // top, left
			if (!vertical)
			{
				if (rotation == ROT_WALL_BOT)
				{
					dir = 1;
					/*if (sophiaUpBtn)
						STAT_MNGR.sophiaWallGrapple = true;
					else if (sophiaDwnBtn)
						STAT_MNGR.sophiaWallGrapple = false;*/
				}
				if (underWater && !sophiaDwnBtn)
					jumpEnd = ny - JUMP_HEIGHT_HORZ*dir;
				else
					jumpEnd = ny - JUMP_HEIGHT_VERT*dir;
				vy = -JUMP_PWR*dir;
				if (underWater)
				{
					vxMax = VX_MAX_WATER_BOOST;
					//vyMaxPsv = VY_MAX_PSV_DEF;
				}
			//	else
					vyMax = VY_MAX_DEF;
			}
			else // vertical
			{
				if (rotation == ROT_WALL_RIGHT)
					dir = 1;
				jumpEnd = nx - JUMP_HEIGHT_HORZ*dir;
				vx = -JUMP_PWR*dir;
				vxMax = VY_MAX_DEF;
				if (underWater)
					vyMax = VY_MAX_WATER;
				//stuckInWall = false;
				//lastStuckInWall = false;
			}
			readyToJump = false;
			setJumpRise(true);
			if (sophiaBase.y >= BASE_DEF_Y + baseVertOfs)
				sophiaBase.y = BASE_DEF_Y + baseVertOfs;
			else
				sophiaBase.y = BASE_UP_DEF_Y + baseVertOfs;
			SND_MNGR.playSound(SN_JUMP);
			//if (!underWater)
			moveWheelsDown();
			if (attachedToPlatform || onPlatform)
			{
				attachedToPlatform = null;
				onPlatform = null;
			}
			disableStuckInWallShift = false;
		}
		
		private function get classicWeapon():String
		{
			switch(GameSettings.sophiaWeapon)
			{
				case SophiaWeapon.HomingMissile:
					return SOPHIA_HOMING_MISSILE;
				case SophiaWeapon.TripleMissile:
					return SOPHIA_MISSILE;
				default:
					return SOPHIA_MISSILE;
			}
		}
		
		override protected function bounce(enemy:Enemy):void
		{
			if (rotation != ROT_WALL_BOT)
			{
				detachFromWall();
				frictionY = false;
			}
			super.bounce(enemy);
		}
		override protected function checkState():void
		{
			if ( !isNaN(screenScrollPosOffset) && ( cState != ST_WALL_TRANS) )
			{
				screenScrollPosOffset -= scrollDist*SCROLL_EASE_SPEED*dt;
				screenScrollPosOffset *= Math.pow(SCROLL_FRICTION,dt);
				scrollDist = screenScrollPosOffset;
				var num:Number = SCROLL_MIN_DIST;
				if (cState != ST_WALL_TRANS)
				{
					if (screenScrollPosOffset > -num && screenScrollPosOffset < num)
						screenScrollPosOffset = NaN;
				}
			}
			if (cState == ST_VINE)
			{
				mainAnimTmr = vineAnimTmr;
				checkVineBtns();
				var yOfs:Number;
				if (GS_MNGR.gameState != GS_PLAY)
					stopHit = true;
				if (upBtn && sophiaBase.scaleX == -1)
				{
					//scaleY = 1;
					sophiaBase.scaleX = 1;
					frontWheel.scaleX = 1;
					backWheel.scaleX = 1;
					/*yOfs = scaleX*(height - 7);
					base.y += yOfs;
					frontWheel.y += yOfs;
					backWheel.y += yOfs;*/
				}
				else if (dwnBtn && sophiaBase.scaleX == 1)
				{
					//scaleY = -1;
					sophiaBase.scaleX = -1;
					frontWheel.scaleX = -1;
					backWheel.scaleX = -1;
					/*yOfs = -scaleX*(height - 7);
					base.y += yOfs;
					frontWheel.y += yOfs;
					backWheel.y += yOfs;*/
				}
				checkVinePosition();
				if (stopAnim)
					stopWheelAnimation();
				else
					startWheelAnimation();
				return;
			}
			else if (cState == ST_WALL_TRANS)
				return;
			else
				mainAnimTmr = DEFAULT_ANIM_TMR;
			if (onGround || cState == ST_CLIMB)
			{
				jumped = false;
				if (underWater && cState != ST_CLIMB && cState != ST_WALL_TRANS)
					defyGrav = false;
				if (hover)
				{
					stopHoverSound();
					hover = false;
				}
				engagedHover = false;
				if ( (!vertical && vx != 0) || (vertical && vy != 0) )
				{
					startWheelAnimation();
					if (!BASE_VERT_TMR.running)
					{
						BASE_VERT_TMR.numTotalCycles = 0;
						BASE_VERT_TMR.delay = DEL_BASE_BOUNCE_TMR_FAST;
						BASE_VERT_TMR.start();
					}
				}
				else
				{
					stopWheelAnimation();
					if (sophiaBase.y == BASE_BOUNCE_Y + baseVertOfs)
					{
						BASE_VERT_TMR.stop();
						sophiaBase.y = BASE_DEF_Y + baseVertOfs;
					}
					else if (sophiaUpBtn && BASE_VERT_TMR.running && sophiaBase.y == BASE_UP_BOUNCE_Y + baseVertOfs)
					{
						BASE_VERT_TMR.stop();
						sophiaBase.y = BASE_UP_DEF_Y + baseVertOfs;
					}
				}
				if (frontWheel.y != WHEEL_DEF_Y)
					moveWheelsUp();
				if (!readyToJump)
					checkWallsForClimb();
				else if (rotation != ROT_WALL_BOT)
					checkWallsForClimb(true,true);
			}
			else
			{
				setState(ST_JUMP);
				if (vy >= 0 && rotation == ROT_WALL_BOT && (frontWheel.y != WHEEL_DEF_Y || baseVertOfs != BASE_VERT_OFS_FALL) )
					moveWheelsUp();
				if (!engagedHover)
				{
					if ( (sophiaLftBtn && !sophiaRhtBtn) || (sophiaRhtBtn && !sophiaLftBtn) )
						startWheelAnimation();
					else
						stopWheelAnimation();
					if (!underWater && rotation == ROT_WALL_BOT)
						brickState = BRICK_BOUNCER;
				}
				else
					brickState = BRICK_NONE;
				if (underWater)
				{
					if (classic || !jumpRise )
					{
						defyGrav = true;
						brickState = BRICK_NONE;
						if ( (backWheel.currentLabel != FL_WHEEL_WATER_1 && backWheel.currentLabel != FL_WHEEL_WATER_2) || sophiaBase.currentLabel != FL_BASE_HORZ )
						{
							sophiaBase.setStopFrame(FL_BASE_HORZ);
							resetAllParts();
							setUpWheelsForWater();
						}
					}
				}
				else if (!jumpRise && (rotation == ROT_WALL_BOT || rotation == ROT_WALL_TOP))
					defyGrav = false;
				if (hover)
				{
					vy -= HOVER_BOOST_POWER;
					if (vy < -HOVER_MAX_SPEED)
						vy = -HOVER_MAX_SPEED;
				}
				else if (jumpRise)
				{
					if (rotation == ROT_WALL_BOT && ny <= jumpEnd)
					{
						ny = jumpEnd;
						setJumpRise(false);
					}
					else if (rotation == ROT_WALL_TOP && ny >= jumpEnd)
					{
						ny = jumpEnd;
						detachFromWall();
						setJumpRise(false);
					}
					else if (rotation == ROT_WALL_LEFT && nx >= jumpEnd)
					{
						nx = jumpEnd;
						detachFromWall();
						setJumpRise(false);
						defyGrav = true;
					}
					else if (rotation == ROT_WALL_RIGHT && nx <= jumpEnd)
					{
						nx = jumpEnd;
						detachFromWall();
						setJumpRise(false);
						defyGrav = true;
					}
				}
				if (!hover && !underWater)
				{
					if (frictionY && rotation == ROT_WALL_BOT)
					{
						if (vy < 0)
							vy *= Math.pow(fy,dt);
						else
							frictionY = false;
					}
					else if (!jumpRise && rotation == ROT_WALL_BOT && vy < 0)
						vy *= Math.pow(FY_HOLD_JMP,dt);
				}
			}
			if (underWater && ny <= GLOB_STG_TOP + level.TILE_SIZE*2)
				exitWater();
			if (!hover && cState != ST_WALL_TRANS)
				checkWheelTmrDelay();
			if (cState == ST_CLIMB && !attachedToPlatform) // makes sure Sophia isn't floating
			{
				var detach:Boolean = true;
				var arr:Array;
				if (rotation == ROT_WALL_LEFT)
				{
					arr = [
					level.getCurrentGrid(hLft - TILE_SIZE,hBot),
					level.getCurrentGrid(hLft - TILE_SIZE,ny),
					level.getCurrentGrid(hLft - TILE_SIZE,hTop) ];
				}
				else if (rotation == ROT_WALL_RIGHT)
				{
					arr = [
					level.getCurrentGrid(hRht,hBot),
					level.getCurrentGrid(hRht,ny),
					level.getCurrentGrid(hRht,hTop) ];
				}
				else // on ceiling
				{
					arr = [
					level.getCurrentGrid(hLft,hTop - TILE_SIZE),
					level.getCurrentGrid(nx,hTop - TILE_SIZE),
					level.getCurrentGrid(hRht,hTop - TILE_SIZE) ];
				}
				var n:int = arr.length;
				for (var i:int; i < n; i++)
				{
					var point:Point = arr[i];
					var ground:Ground = level.getGroundAt(point.x,point.y);
					if (ground && ground.visible)
					{
						detach = false;
						break;
					}
				}
				if (detach)
					detachFromWall();
			}
			if (stuckInWall && !disableStuckInWallShift && jumpRise)
				setJumpRise(false);
		}
		override protected function prepareDrawCharacter(skinAppearanceState:int = -1):void
		{
			endReplaceColor();
			resetAllParts();
			sophiaBase.setStopFrame(FL_MAIN);
			setUpWheelsForLand();
			drawFrameLabel = null;
			super.prepareDrawCharacter(skinAppearanceState);
		}
		override public function climbVineStarter(_vine:Vine):void
		{
			super.climbVineStarter(_vine);
			pressUpBtn();
		}
		override protected function checkVinePosition():void
		{
			super.checkVinePosition();
			if (!vine)
				return;
			// just did this to prevent wheels messing up glitch. see getOnVine() for numbers
			sophiaBase.setStopFrame(FL_BASE_HORZ);
			sophiaBase.rotation = -90;
			sophiaBase.x = 11;
			sophiaBase.y = -19;
			frontWheel.rotation = -90;
			frontWheel.x = 7;
			frontWheel.y = -35;
			backWheel.rotation = -90;
			backWheel.x = frontWheel.x;
			backWheel.y = -3;
		}		
		private function checkWheelTmrDelay():void
		{
			if (!onGround && !underWater)
			{
				WHEEL_TMR.delay = DEL_WHEEL_TMR_FAST;
				if (!readyToJump)
					BASE_VERT_TMR.delay = DEL_BASE_BOUNCE_TMR_FAST;
				return;
			}
			var num:Number; // speed without sign
			if (rotation == ROT_WALL_BOT || rotation == ROT_WALL_TOP)
				num = vx;
			else
				num = vy;
			var baseDel:Number = BASE_VERT_TMR.delay;
			if (num < 0)
				num = -num;
			if (backWheel.currentLabel == FL_WHEEL_WATER_1 || backWheel.currentLabel == FL_WHEEL_WATER_2)
			{
				if (num <= VX_MAX_WATER_NORMAL)
					WHEEL_TMR.delay = DEL_WHEEL_TMR_WATER_SLOW;
				else
					WHEEL_TMR.delay = DEL_WHEEL_TMR_WATER_FAST;
			}
			else if (num >= 0 && num < SLOW_DELAY_MAX_VX)
			{
				WHEEL_TMR.delay = DEL_WHEEL_TMR_SLOW;
				BASE_VERT_TMR.delay = DEL_BASE_BOUNCE_TMR_SLOW;
			}
			else if (SLOW_DELAY_MAX_VX >= 0 && num < MEDIUM_DELAY_MAX_VX)
			{
				WHEEL_TMR.delay = DEL_WHEEL_TMR_MEDIUM;
				BASE_VERT_TMR.delay = DEL_BASE_BOUNCE_TMR_MEDIUM;
			}
			else
			{
				WHEEL_TMR.delay = DEL_WHEEL_TMR_FAST;
				BASE_VERT_TMR.delay = DEL_BASE_BOUNCE_TMR_FAST;
			}
			if (readyToJump)
				BASE_VERT_TMR.delay = baseDel;
		}
		private function checkWallsForClimb(checkZeroVel:Boolean = false,disallowWallTrans:Boolean = false):void
		{
			var xNum:int;
			var yNum:int;
			var point:Point;
			var ground:Ground = null;
			var groundToClimb:Ground = null;
			var dirNum:int = 0; // 1 means going right or down, -1 means going left or up; makes it easier to change positives and negatives
			var allowWallTrans:Boolean = false;
			var checkInverted:Boolean = false;
			var dist:Number;
			var stp:Number;// sophiaTestPosition
			var gtp:Number;// ground test position
			falseGroundRect = null;
			//checkAttachToOppositeWall();
			if (!vertical)
			{
				var bottom:Boolean = false; // true if not on ceiling
				if (rotation == ROT_WALL_BOT)
					bottom = true;
				// check which way Sophia is moving
				if (vx > 0 || (checkZeroVel && sophiaScaleX > 0) )
				{
					dirNum = 1;
					if (sophiaRhtBtn && !sophiaLftBtn)
						allowWallTrans = true;
				}
				else if ( vx < 0 || (checkZeroVel && sophiaScaleX < 0) )
				{
					dirNum = -1;
					if (sophiaLftBtn && !sophiaRhtBtn)
						allowWallTrans = true;
				}
				else if (bottom)
				{
					if (sophiaRhtBtn && !sophiaLftBtn)
					{
						dirNum = 1;
						allowWallTrans = true;
					}
					else if (sophiaLftBtn && !sophiaRhtBtn)
					{
						dirNum = -1;
						allowWallTrans = true;
					}
				}
				if (dirNum == 0)
					return;
				if (disallowWallTrans && allowWallTrans)
					allowWallTrans = false;
				if (onPlatform)
				{
					stp = nx + CLIMB_INVERTED_OFS*dirNum;
					gtp = onPlatform.x + onPlatform.width/2*dirNum;
					if ( (dirNum > 0 && stp >= gtp ) || (dirNum < 0 && stp <= gtp) )
					{
						if (dirNum > 0 && ( (bottom && sophiaDwnBtn) || (!bottom && sophiaRhtBtn) ) )
							wallTransStart(onPlatform,WALL_LEFT_STR,true);
						else if ( dirNum < 0 && ( (bottom && sophiaDwnBtn) || (!bottom && sophiaLftBtn) ) )
							wallTransStart(onPlatform,WALL_RIGHT_STR,true);
						if (cState === ST_WALL_TRANS)
							return;
						else if (!bottom)
						{
							nx = gtp - CLIMB_INVERTED_OFS*dirNum;
							vx = 0;
							return;
						}
					}
				}
				// first check ground directly on side
				if (bottom)
					yNum = ny - TILE_SIZE;
				else
					yNum = ny;
				xNum = level.getNearestGrid(nx + CLIMB_OFS*dirNum,-1);
				groundToClimb = level.getGroundAt(xNum,yNum);
				if ( (!groundToClimb || !groundToClimb.visible) && sophiaUpBtn)
				{
					if (bottom)
					{
						ground = level.getGroundAt(xNum,yNum - TILE_SIZE);
						if (ground && ground.visible)
							falseGroundRect = new Rectangle(ground.x,ground.y + TILE_SIZE,TILE_SIZE,TILE_SIZE);
					}
					else
					{
						ground = level.getGroundAt(xNum,yNum + TILE_SIZE);
						if (ground && ground.visible)
							falseGroundRect = new Rectangle(ground.x,ground.y - TILE_SIZE,TILE_SIZE,TILE_SIZE);
					}
				}
				if (!bottom)
				{
					point = level.getCurrentGrid(nx,ny - TILE_SIZE);
					ground = level.getGroundAt(point.x,point.y);
					if (!ground || !ground.visible) // if current nx, ny is not touching ground, check for ground at diaganol and climb on it
					{
						//if (sophiaDwnBtn)
						//	checkInverted = true;
						ground = level.getGroundAt(point.x + TILE_SIZE*dirNum,point.y);
						if (!ground || !ground.visible ) // makes sure it's not a small gap
						{
							ground = level.getGroundAt(xNum,yNum + TILE_SIZE);
							if (ground && ground.visible)
							{
								ground = level.getGroundAt(ground.x - TILE_SIZE*dirNum,ground.y);
								if (!ground || !ground.visible)
									falseGroundRect = new Rectangle(xNum,yNum,TILE_SIZE,TILE_SIZE);
							}
							if (falseGroundRect)
							{
								if (dirNum < 1 && sophiaLftBtn && !sophiaRhtBtn)
									wallTransStart(null,WALL_LEFT_STR,false,falseGroundRect);
								else if (sophiaRhtBtn && !sophiaLftBtn)
									wallTransStart(null,WALL_RIGHT_STR,false,falseGroundRect);
								return;
							}
						}
					}
				}
				if ( (groundToClimb && groundToClimb.visible) || falseGroundRect) // if there is ground to the side
				{
					// now make sure there is no ground one tile over so there is space to move
					xNum = xNum - TILE_SIZE*dirNum;
					if (bottom)
						yNum -= TILE_SIZE;
					else
						yNum += TILE_SIZE;
					ground = level.getGroundAt(xNum,yNum);
					if ( (!ground || !ground.visible) && allowWallTrans ) // there is ground to the side but no ground diagonally
					{
						if (groundToClimb)
							dist = hMidX - groundToClimb.hMidX;
						else if (falseGroundRect)
							dist = hMidX - (falseGroundRect.x + falseGroundRect.width/2);						
						if (dist < 0)
							dist = -dist;
						if (dist > MIN_NORMAL_CLIMB_DIST)
						{
							if (dirNum > 0 && ( (bottom && sophiaUpBtn && !sophiaDwnBtn) || (!bottom && sophiaRhtBtn && !sophiaLftBtn ) ) )
								wallTransStart(groundToClimb,WALL_RIGHT_STR,false,falseGroundRect);
							else if (dirNum < 0 && ( (bottom && sophiaUpBtn && !sophiaDwnBtn) || (!bottom && sophiaLftBtn && !sophiaRhtBtn) ) )
								wallTransStart(groundToClimb,WALL_LEFT_STR,false,falseGroundRect);
							if (cState == ST_WALL_TRANS)
								return;
						}
					}
					if ( (!bottom && groundToClimb) || (bottom && cState == ST_WALL_TRANS) ) // moves sophia into proper location
					{
						vx = 0;
						if (dirNum > 0)
							xNum += TILE_SIZE;
						nx = xNum - CLIMB_OFS*dirNum;
						vx = 0;
					}
					if (vx == 0 && cState != ST_WALL_TRANS)
						checkInverted = true;
					if (falseGroundRect && cState != ST_WALL_TRANS)
						checkInverted = true;
				}
				else
					checkInverted = true;
				if (checkInverted) // there is no ground directly to the side or did not choose to climb ground on side
				{
					if (bottom)
						yNum = ny;
					else
						yNum = ny - TILE_SIZE;
					xNum = level.getNearestGrid(nx + CLIMB_INVERTED_OFS*dirNum,-1);
					ground = level.getGroundAt(xNum,yNum);
					if (!ground || !ground.visible) // there is no ground diagonally
					{
						groundToClimb = level.getGroundAt(xNum - TILE_SIZE*dirNum,yNum); // gets ground to climb on, it's not the ground we check for
						if (groundToClimb && groundToClimb.visible)
						{
							dist = hMidX - groundToClimb.hMidX;
							if (dist < 0)
								dist = -dist;
							if (dist < MAX_INVERTED_CLIMB_DIST)
							{
								if (bottom)
								{
									if (allowWallTrans)
									{
										if (dirNum > 0 && sophiaDwnBtn && !sophiaUpBtn )
											wallTransStart(groundToClimb,WALL_LEFT_STR,true);
										else if (dirNum < 0 && sophiaDwnBtn && !sophiaUpBtn )
											wallTransStart(groundToClimb,WALL_RIGHT_STR,true);
										if (cState == ST_WALL_TRANS)
											return;
									}
								}
								else // need to see if it is a small gap that sophia can optionally cross
								{
									ground = level.getGroundAt(xNum + TILE_SIZE*dirNum,yNum); // yNum stays the same
									if (!ground || !ground.visible) // check for one more possible scenario for small gap
									{
										ground = level.getGroundAt(xNum + TILE_SIZE*dirNum,yNum + level.TILE_SIZE);
									}
									if ( sophiaUpBtn && (!ground || !ground.visible ) ) // now check for ground one block over. last small gap check
									{
										ground = level.getGroundAt(xNum + TILE_SIZE*dirNum,yNum + level.TILE_SIZE*2);
										if (ground && ground.visible)
										{
											ground = level.getGroundAt(ground.x - TILE_SIZE*dirNum,ground.y);
											if (!ground || !ground.visible)
												return;
										}
										ground = null;
									}
									if (!ground || !ground.visible || sophiaDwnBtn )
									{
										if (allowWallTrans)
										{
											if (dirNum > 0 && (sophiaRhtBtn && !sophiaLftBtn ) )
												wallTransStart(groundToClimb,WALL_LEFT_STR,true);
											else if (dirNum < 0 && ( sophiaLftBtn && !sophiaRhtBtn ) )
												wallTransStart(groundToClimb,WALL_RIGHT_STR,true);
											if (cState == ST_WALL_TRANS)
												return;
										}
										if (!bottom && cState != ST_WALL_TRANS)
										{
											vx = 0;
											if (dirNum < 0)
												xNum += TILE_SIZE;
											nx = xNum - CLIMB_INVERTED_OFS*dirNum;
										}
									}
								}
							}
						}
					}
				}
			}
			// if vertical, left = up, right = down
			else // if vertical
			{
				var left:Boolean = false; // true if on left wall
				if (rotation == ROT_WALL_LEFT)
					left = true;
				if ( vy < 0 || (checkZeroVel && sophiaScaleX < 0) ) // moving up
				{
					dirNum = -1;
					if (sophiaLftBtn && !sophiaRhtBtn)
						allowWallTrans = true;
				}
				else if ( vy > 0 || (checkZeroVel && sophiaScaleX > 0) ) // moving down
				{
					dirNum = 1;
					if (sophiaRhtBtn && !sophiaLftBtn)
						allowWallTrans = true;
				}
				if (dirNum == 0)
					return;
				if (disallowWallTrans && allowWallTrans)
					allowWallTrans = false;
				if (attachedToPlatform)
				{
					if ( sophiaLftBtn && !sophiaRhtBtn )
						wallTransStart(attachedToPlatform,WALL_BOTTOM_STR,true);
					else if ( sophiaRhtBtn && !sophiaLftBtn )
						wallTransStart(attachedToPlatform,WALL_TOP_STR,true);
					if (cState === ST_WALL_TRANS)
						return;
				}
				// first check for ground directly above or below
				if (left)
					xNum = hLft;
				else
					xNum = hRht - TILE_SIZE;
				yNum = level.getNearestGrid(ny + CLIMB_OFS*dirNum,-1);
				if (left)
					point = level.getCurrentGrid(nx - TILE_SIZE,ny);
				else
					point = level.getCurrentGrid(nx,ny);
				ground = level.getGroundAt(point.x,point.y);
				if (!ground || !ground.visible) // if current nx, ny is not touching ground, check for ground at diaganol and climb on it
				{
					//if (sophiaDwnBtn)
					//	checkInverted = true;
					ground = level.getGroundAt(point.x,point.y + TILE_SIZE*dirNum);
					if (!ground || !ground.visible ) // makes sure it's not a small gap
					{
						var testX:Number;
						if (left)
							testX = xNum + TILE_SIZE;
						else
							testX = xNum - TILE_SIZE;
						ground = level.getGroundAt(testX,yNum);
						if (ground && ground.visible)
						{
							ground = level.getGroundAt(ground.x,ground.y - TILE_SIZE*dirNum);
							if (!ground || !ground.visible)
								falseGroundRect = new Rectangle(xNum,yNum,TILE_SIZE,TILE_SIZE);
						}
						if (falseGroundRect)
						{
							if (dirNum < 1 && sophiaLftBtn && !sophiaRhtBtn)
								wallTransStart(null,WALL_TOP_STR,false,falseGroundRect);
							else if (sophiaRhtBtn && !sophiaLftBtn)
								wallTransStart(null,WALL_BOTTOM_STR,false,falseGroundRect);
							if (cState === ST_WALL_TRANS)
								return;
							vy = 0;
							if (dirNum < 0)
								ny = falseGroundRect.bottom + CLIMB_OFS;
							else
								ny = falseGroundRect.top - CLIMB_OFS;
							return;
						}
					}
				}
				groundToClimb = level.getGroundAt(xNum,yNum);
				// checks if there is a gap to attach to nearby ground
				if ( (!groundToClimb || !groundToClimb.visible) && sophiaUpBtn)
				{
					if (left)
					{
						ground = level.getGroundAt(xNum + TILE_SIZE,yNum);
						if (ground && ground.visible)
							falseGroundRect = new Rectangle(ground.x - TILE_SIZE,ground.y,TILE_SIZE,TILE_SIZE);
					}
					else
					{
						ground = level.getGroundAt(xNum - TILE_SIZE,yNum);
						if (ground && ground.visible)
							falseGroundRect = new Rectangle(ground.x + TILE_SIZE,ground.y,TILE_SIZE,TILE_SIZE);
					}
				}
				if ( (groundToClimb && groundToClimb.visible) || falseGroundRect)
				{
					// now make sure there is space for the move
					yNum = yNum - TILE_SIZE*dirNum;
					if (left)
						xNum += TILE_SIZE;
					else
						xNum -= TILE_SIZE;
					ground = level.getGroundAt(xNum,yNum);
					if (allowWallTrans && (!ground || !ground.visible ) )
					{
						if (groundToClimb)
							dist = hMidY - groundToClimb.hMidY;
						else if (falseGroundRect)
							dist = hMidY - (falseGroundRect.y + falseGroundRect.height/2);						
						if (dist < 0)
							dist = -dist;
						if (dist > MIN_NORMAL_CLIMB_DIST)
						{
							if (dirNum < 0 && (sophiaLftBtn && !sophiaRhtBtn) )
								wallTransStart(groundToClimb,WALL_TOP_STR,false,falseGroundRect);
							else if (dirNum > 0 && (sophiaRhtBtn && !sophiaLftBtn) )
								wallTransStart(groundToClimb,WALL_BOTTOM_STR,false,falseGroundRect);
							if (cState === ST_WALL_TRANS)
								return;
						}
					}
					if (groundToClimb)
					{
						vy = 0;
						if (dirNum < 0)
							ny = groundToClimb.hBot + CLIMB_OFS;
						else
							ny = groundToClimb.hTop - CLIMB_OFS;
						if (vy == 0 && cState != ST_WALL_TRANS)
							checkInverted = true;
					}
					if (falseGroundRect && cState != ST_WALL_TRANS)
						checkInverted = true;
				}
				else
					checkInverted = true;
				if (checkInverted) // there is no ground directly above or below or player has chosen not to climb on it
				{
					if (left)
						xNum = hLft - TILE_SIZE;
					else
						xNum = hRht;
					yNum = level.getNearestGrid(ny + CLIMB_INVERTED_OFS*dirNum,-1);
					ground = level.getGroundAt(xNum,yNum);
					if (!ground || !ground.visible) // makes sure there is no ground diagonally
					{
						groundToClimb = level.getGroundAt(xNum,yNum - level.TILE_SIZE*dirNum);// gets ground directly to the side to climb on
						ground = level.getGroundAt(xNum,yNum + level.TILE_SIZE*dirNum); // checks if ground is small gap
						if (!ground || !ground.visible) // check for one more possible scenario for small gap
						{
							if (left)
								ground = level.getGroundAt(xNum + level.TILE_SIZE,yNum + level.TILE_SIZE*dirNum);
							else
								ground = level.getGroundAt(xNum - level.TILE_SIZE,yNum + level.TILE_SIZE*dirNum);
						}
						if ( sophiaUpBtn && (!ground || !ground.visible ) ) // now check for ground one block over. last small gap check
						{
							if (left)
								ground = level.getGroundAt(xNum + level.TILE_SIZE*2,yNum + level.TILE_SIZE*dirNum);
							else
								ground = level.getGroundAt(xNum - level.TILE_SIZE*2,yNum + level.TILE_SIZE*dirNum);
							if (ground && ground.visible)
							{
								ground = level.getGroundAt(ground.x,ground.y - TILE_SIZE*dirNum);
									if (!ground || !ground.visible)
										return;
							}
							ground = null;
						}
						if ( groundToClimb && (!ground || !ground.visible || sophiaDwnBtn) )
						{
							// checkDist for inverted
							dist = hMidY - groundToClimb.hMidY;
							if (dist < 0)
								dist = -dist;
							if (dist < MAX_INVERTED_CLIMB_DIST)
							{
								if (allowWallTrans)
								{
									if (dirNum < 0 && (groundToClimb && sophiaLftBtn && !sophiaRhtBtn) )
										wallTransStart(groundToClimb,WALL_BOTTOM_STR,true);
									else if ( dirNum > 0 && (groundToClimb && sophiaRhtBtn && !sophiaLftBtn) )
										wallTransStart(groundToClimb,WALL_TOP_STR,true);
									if (cState === ST_WALL_TRANS)
										return;
								}
								if (cState != ST_WALL_TRANS)
								{
									vy = 0;
									if (dirNum < 0)
										ny = yNum + TILE_SIZE + CLIMB_INVERTED_OFS;
									else
										ny = yNum - CLIMB_INVERTED_OFS;
								}
							}
						}
					}
				}
			}
		}
		private function resetAllParts():void
		{
			frontWheel.x = FRONT_WHEEL_DEF_X;
			frontWheel.y = WHEEL_DEF_Y;
			backWheel.x = BACK_WHEEL_DEF_X;
			backWheel.y = WHEEL_DEF_Y;
			sophiaBase.x = BASE_DEF_X;
			sophiaBase.y = BASE_DEF_Y + baseVertOfs;
			BASE_VERT_TMR.stop();
		}
		override protected function activateStarPwr():void
		{
			super.activateStarPwr();
			setAmmo( SOPHIA_HOVER, HOVER_MAX );
		}
		private function startWheelAnimation():void
		{
			if (!WHEEL_TMR.running)
				WHEEL_TMR.start();
			if (backWheel.currentLabel != convLab(FL_WHEEL_HOVER_TRANS))
			{
				if (!underWater || onGround )
					frontWheel.stopAnim = false;
				backWheel.stopAnim = false;
			}
		}
		private function stopWheelAnimation():void
		{
			if (WHEEL_TMR.running && backWheel.currentLabel != convLab(FL_WHEEL_HOVER_TRANS))
				WHEEL_TMR.stop();
			frontWheel.stopAnim = true;
			backWheel.stopAnim = true;
		}
		private function moveWheelsUp():void
		{
			frontWheel.y = WHEEL_DEF_Y;
			backWheel.y = WHEEL_DEF_Y;
			if (!onGround)
			{
				baseVertOfs = BASE_VERT_OFS_FALL;
				if (sophiaBase.y == BASE_DEF_Y)
					sophiaBase.y = BASE_DEF_Y + baseVertOfs;
			}
		}
		private function moveWheelsDown():void
		{
			frontWheel.y = WHEEL_JUMP_Y;
			backWheel.y = WHEEL_JUMP_Y;
			baseVertOfs = BASE_VERT_OFS_DEF;
		}
		private function moveWheelsLeft():void
		{
			//frontWheel.y = WHEEL_DEF_Y;
			//backWheel.y = WHEEL_DEF_Y;
		}
		private function moveWheelsRight():void
		{
			//frontWheel.y = WHEEL_DEF_Y;
			//backWheel.y = WHEEL_DEF_Y;
		}
		private function deactivateHoverMode():void
		{
			engagedHover = false;
			hover = false;
			stopHoverSound();
			WHEEL_TMR.delay = DEL_WHEEL_HOVER_TRANS;
			frontWheel.setStopFrame(FL_WHEEL_HOVER_TRANS);
			backWheel.setStopFrame(FL_WHEEL_HOVER_TRANS);
			WHEEL_TMR.start();
			activateGainHoverTmr();
		}
		private function activateGainHoverTmr():void
		{
			if (LOSE_HOVER_TMR.running)
				LOSE_HOVER_TMR.pause();
			if (GAIN_HOVER_TMR.running || getAmmo( SOPHIA_HOVER ) == HOVER_MAX )
				return;
			GAIN_HOVER_TMR.resume();
		}
		private function activateLoseHoverTmr():void
		{
			if (GAIN_HOVER_TMR.running)
				GAIN_HOVER_TMR.pause();
			if (LOSE_HOVER_TMR.running || getAmmo( SOPHIA_HOVER ) == HOVER_MIN)
				return;
			LOSE_HOVER_TMR.resume();
		}
		private function stopHoverSound():void
		{
			var snd:SoundContainer = SND_MNGR.findSound(SN_HOVER);
			if (snd)
			{
				snd.pauseSound();
				SND_MNGR.removeSnd(snd);
			}
		}
		override protected function bouncePit():void
		{
			if (rotation != ROT_WALL_BOT)
				detachFromWall();
			if (engagedHover || hover)
				deactivateHoverMode();
			super.bouncePit();
		}
		/*override protected function checkBouncePit():Boolean
		{
			var yNum:Number = ny;
			if (vertical)
				yNum = hbo
			return ny - hHeight*.8 >= GLOB_STG_BOT;
		}*/
		override protected function enterPipeVert():void
		{
			if (rotation != ROT_WALL_BOT || cState === ST_WALL_TRANS)
				return;
			sophiaBase.stopAnim = true;
			stopWheelAnimation();
			stopTimers();
			setUpWheelsForLand();
			sophiaBase.setStopFrame(FL_BASE_HORZ);
			super.enterPipeVert();
		}
		override protected function enterPipeHorz():void
		{
			if (rotation != ROT_WALL_BOT || cState === ST_WALL_TRANS)
				return;
			super.enterPipeHorz();
			stopAnim = true;
			startWheelAnimation();
			BASE_VERT_TMR.start();
		}
		override public function enterWater():void
		{
			var tm:TutorialManager = TutorialManager.TUT_MNGR;
			tm.checkTutorial(CHAR_NAME + tm.TYPE_WATER,true);
			super.enterWater();
			if (cState != ST_CLIMB)
			{
				if (!jmpBtn)
					vxMax = VX_MAX_WATER_NORMAL;
				else
					vxMax = VX_MAX_WATER_BOOST;
				vyMax = VY_MAX_WATER;
				if (hover || engagedHover)
					deactivateHoverMode();
				else
					setUpWheelsForWater();
				resetAllParts();
			}
			else
			{
				vxMax = MAX_SPEED_CLIMB_WATER;
				vyMax = MAX_SPEED_CLIMB_WATER;
			}
			if (sophiaBase.currentLabel != FL_BASE_HORZ)
				sophiaBase.setStopFrame(FL_BASE_HORZ);
			gravity = GRAVITY_WATER;
		}
		override protected function exitWater():void
		{
			var waterTop:Number = GLOB_STG_TOP + level.TILE_SIZE*2;
			if ( rotation == ROT_WALL_BOT && ny > waterTop && GS_MNGR.gameState == GS_PLAY)
			{
				if (!wallOnLeft && !wallOnRight)
				{
					if (ny < waterTop + hHeight)
						ny = waterTop + hHeight;
					if (vy < 0)
						vy = 0;
				}
				if (jumpRise)
					setJumpRise(false);
				return;
			}
			super.exitWater();
			vxMax = VX_MAX_DEF;
			if (cState != ST_CLIMB)
			{
				defyGrav = false;
				vyMax = VY_MAX_DEF;
			}
			else
				vyMax = VX_MAX_DEF;
			vyMaxPsv = VY_MAX_PSV_DEF;				
			gravity = GRAVITY;
			var cl:String = backWheel.currentLabel;
			if (cl == FL_WHEEL_WATER_1 || cl == FL_WHEEL_WATER_2)
				setUpWheelsForLand();
		}
		private function setUpWheelsForWater():void
		{
			frontWheel.setStopFrame(FL_WHEEL_START);
			backWheel.setStopFrame(FL_WHEEL_WATER_1);
		}
		private function setUpWheelsForLand():void
		{
			frontWheel.setStopFrame(FL_WHEEL_START);
			backWheel.setStopFrame(FL_WHEEL_END);
			backWheel.gotoAndStop(backWheel.currentFrame - 1);
		}
		override public function hitPickup(pickup:Pickup,showAnimation:Boolean = true):void
		{
			var hadFireFlower:Boolean = upgradeIsActive(FIRE_FLOWER);
			super.hitPickup(pickup,showAnimation);
			switch(pickup.type)
			{
				case MUSHROOM:
				{
					updDrops();
					updHoverBarVisibility();
					if (GameSettings.classicMode)
						setAmmo(SOPHIA_HOVER, HOVER_MAX);
					break;
				}
				case FIRE_FLOWER:
				{
					updDrops();
					updHoverBarVisibility();
					updSubWeapon();
					if (GameSettings.classicMode && hadFireFlower)
					{
						if (classicWeapon == SOPHIA_MISSILE)
							increaseAmmoByValue(SOPHIA_MISSILE, MISSILE_PICKUP_VALUE * 2);
						else if (classicWeapon == SOPHIA_HOMING_MISSILE)
							increaseAmmoByValue(SOPHIA_HOMING_MISSILE, HOMING_MISSILE_PICKUP_VALUE * 2);
					}
					break;
				}
				case SOPHIA_HOMING_MISSILE:
				{
					updSubWeapon();
//					updDrops();
					break;
				}
				case SOPHIA_MISSILE:
				{
					updSubWeapon();
//					updDrops();
					break;
				}
				case SOPHIA_HOVER:
				{
					updHoverBarVisibility();
					break;
				}
				case HOMING_MISSILE_AMMO:
				{
					STAT_MNGR.addCharUpgrade(charNum,SOPHIA_HOMING_MISSILE);
					updSubWeapon();
					increaseAmmoByValue(SOPHIA_HOMING_MISSILE, HOMING_MISSILE_PICKUP_VALUE );
					break;
				}
				case MISSILE_AMMO:
				{
					STAT_MNGR.addCharUpgrade(charNum,SOPHIA_MISSILE);
					updSubWeapon();
					increaseAmmoByValue(SOPHIA_MISSILE, MISSILE_PICKUP_VALUE );
					break;
				}
				
			}
/*			if (pickup is RandomDropGenerator && RandomDropGenerator(pickup).type == RandomDropGenerator.TYPE_SOPHIA)
			{
				var tm:TutorialManager = TutorialManager.TUT_MNGR;
				tm.checkTutorial(CHAR_NAME + tm.TYPE_AMMO,true);
				pickup.touchPlayer(this);
			}*/
		}
		override public function revivalBoost():void
		{
			super.revivalBoost();
//			if (upgradeIsActive(SOPHIA_HOMING_MISSILE) )
//			{
				hitPickup( new Pickup(HOMING_MISSILE_AMMO), false );
				hitPickup( new Pickup(HOMING_MISSILE_AMMO), false );
//			}
//			if (upgradeIsActive(SOPHIA_MISSILE) )
//			{
				hitPickup( new Pickup(MISSILE_AMMO), false );
				hitPickup( new Pickup(MISSILE_AMMO), false );
//			}
		}
		private function setSophiaDirBtns():void
		{
			sophiaRelUpBtn();
			sophiaRelDwnBtn();
			sophiaRelLftBtn();
			sophiaRelRhtBtn();
			if (upBtn)
				pressUpBtn();
			if (dwnBtn)
				pressDwnBtn();
			if (lftBtn)
				pressLftBtn();
			if (rhtBtn)
				pressRhtBtn();
		}
		override public function pressJmpBtn():void
		{
			if (cState == ST_VINE || cState == ST_WALL_TRANS)
				return;
			super.pressJmpBtn();
			if ( ( onGround && cState != ST_CLIMB ) || (onGround && !sophiaDwnBtn) ) // gets ready to jump
			{
				if (sophiaBase.y >= BASE_DEF_Y + baseVertOfs)
					sophiaBase.y = BASE_JUMP_BOUNCE_Y + baseVertOfs;
				else
					sophiaBase.y = BASE_UP_JUMP_BOUNCE_Y + baseVertOfs;
				BASE_VERT_TMR.numTotalCycles = 1;
				BASE_VERT_TMR.delay = DEL_BASE_JUMP_BOUNCE_TMR;
				BASE_VERT_TMR.start();
				readyToJump = true;
			}
			else if (upgradeIsActive(SOPHIA_HOVER) && !onGround && ( rotation == ROT_WALL_BOT || (!engagedHover) ) && checkDropFromWall(true) )
			{
				if (!onSpring && !underWater && (getAmmo( SOPHIA_HOVER ) > HOVER_MIN || starPwr || Cheats.infiniteAmmo ))
				{
					if (engagedHover)
					{
						backWheel.setPlayFrame(FL_WHEEL_HOVER_BIG_FLAME);
						frontWheel.setPlayFrame(FL_WHEEL_HOVER_BIG_FLAME);
						WHEEL_TMR.start();
					}
					else
					{
						backWheel.setPlayFrame(FL_WHEEL_HOVER_TRANS);
						frontWheel.setPlayFrame(FL_WHEEL_HOVER_TRANS);
						WHEEL_TMR.delay = DEL_BASE_JUMP_BOUNCE_TMR;
						WHEEL_TMR.start();
						moveWheelsUp();
						frontWheel.x = FRONT_WHEEL_DEF_X;
						backWheel.x = BACK_WHEEL_DEF_X;
					}
					if (!hover)
						SND_MNGR.playSound(SN_HOVER);
					engagedHover = true;
					hover = true;
					activateLoseHoverTmr();
					frictionY = false;
					setJumpRise(false);
					if (rotation != ROT_WALL_BOT)
						detachFromWall();
				}
			}
			else if (cState === ST_CLIMB)
			{
				checkDropFromWall();
			}
		}
		override public function relJmpBtn():void
		{
			super.relJmpBtn();
			if (!onGround)
			{
				if (!releasedJumpBtn) 
				{
					//vyMaxNgv = Math.abs(vy);
					if (!bounced)
						frictionY = true;
					releasedJumpBtn = true;
				}
				else if (hover)
				{
					frictionY = true;
					hover = false;
					activateGainHoverTmr();
					frontWheel.setStopFrame(FL_WHEEL_HOVER);
					backWheel.setStopFrame(FL_WHEEL_HOVER);
					stopHoverSound();
				}
				if (jumpRise)
					frictionY = false;
			}
		}
		override public function pressAtkBtn():void
		{
			if (sophiaDwnBtn && !underWater && GameSettings.classicSpecialInput)
			{
				pressedSpecialButton();
				return;
			}
			if (cState == ST_VINE)
				return;
			super.pressAtkBtn();
			if (cState === ST_WALL_TRANS)
				return;
			var n:int = 0;
			for each (var proj:Projectile in level.PLAYER_PROJ_DCT)
			{
				if ( !(proj is SophiaBullet) )
					continue;
				var sophBullet:SophiaBullet = proj as SophiaBullet;
				if (sophBullet.shotType != SHOT_TYPE_HOMING_MISSILE && sophBullet.shotType != SHOT_TYPE_MISSILE)
					n++;
			}
			if (n < MAX_BULLETS_ON_SCREEN)
				level.addToLevel(new SophiaBullet(this));
		}
		override public function pressSelBtn():void
		{
			super.pressSelBtn();
			updSubWeapon(true);
		}
		private function getNumMissilesOnScreen(type:String):int
		{
			var n:int;
			for each (var projectile:Projectile in level.PLAYER_PROJ_DCT)
			{
				if (projectile is SophiaBullet &&  (projectile as SophiaBullet).shotType == type)
					n++;
			}
			return n;
		}
		override public function pressSpcBtn():void
		{
			super.pressSpcBtn();
			pressedSpecialButton();
		}
		
		private function pressedSpecialButton():void
		{
			if (cState === ST_WALL_TRANS || cState == ST_VINE)
				return;
			switch(curSubWeapon)
			{
				case SOPHIA_HOMING_MISSILE:
				{
					if ( hasEnoughAmmo(SOPHIA_HOMING_MISSILE) && getNumMissilesOnScreen(SHOT_TYPE_HOMING_MISSILE) < MAX_HOMING_MISSILES_ON_SCREEN)
					{
						innerLoop: for each (var ao:AnimatedObject in level.AO_STG_DCT)
						{
							if (ao is Enemy && !ao.stopHit && ao.onScreen && (!ao.getProperty(PR_PIERCE_PAS) || Cheats.allWeaponsPierce) )
							{
								level.addToLevel(new SophiaBullet(this,SHOT_TYPE_HOMING_MISSILE));
								decAmmo(SOPHIA_HOMING_MISSILE);
								break innerLoop;
							}
						}
					}
					break;
				}
					case SOPHIA_MISSILE:
				{
					if ( hasEnoughAmmo(SOPHIA_MISSILE) && getNumMissilesOnScreen(SHOT_TYPE_MISSILE) < MAX_MISSILES_ON_SCREEN)
					{
						SophiaBullet.launchMissiles(this);
						decAmmo(SOPHIA_MISSILE);
					}
					break;
				}
			}
		}
		override public function pressUpBtn():void
		{			
			super.pressUpBtn();
			if (cState === ST_WALL_TRANS)
				return;
			if (rotation == ROT_WALL_BOT)
				sophiaPressUpBtn();
			else if (rotation == ROT_WALL_LEFT)
				sophiaPressLftBtn();
			else if (rotation == ROT_WALL_TOP)
				sophiaPressDwnBtn();
			else if (rotation == ROT_WALL_RIGHT)
				sophiaPressLftBtn();
		}
		override public function pressDwnBtn():void
		{			
			super.pressDwnBtn();
			if (cState === ST_WALL_TRANS)
				return;
			if (rotation == ROT_WALL_BOT)
				sophiaPressDwnBtn();
			else if (rotation == ROT_WALL_LEFT)
				sophiaPressRhtBtn();
			else if (rotation == ROT_WALL_TOP)
				sophiaPressUpBtn();
			else if (rotation == ROT_WALL_RIGHT)
				sophiaPressRhtBtn();
		}
		override public function pressLftBtn():void
		{
			super.pressLftBtn();
			if (cState === ST_WALL_TRANS)
				return;
			if (rotation == ROT_WALL_BOT)
				sophiaPressLftBtn();
			else if (rotation == ROT_WALL_LEFT)
				sophiaPressDwnBtn();
			else if (rotation == ROT_WALL_TOP)
				sophiaPressLftBtn();
			else if (rotation == ROT_WALL_RIGHT)
				sophiaPressUpBtn();
		}
		override public function pressRhtBtn():void
		{
			super.pressRhtBtn();
			if (cState === ST_WALL_TRANS)
				return;
			if (rotation == ROT_WALL_BOT)
				sophiaPressRhtBtn();
			else if (rotation == ROT_WALL_LEFT)
				sophiaPressUpBtn();
			else if (rotation == ROT_WALL_TOP)
				sophiaPressRhtBtn();
			else if (rotation == ROT_WALL_RIGHT)
				sophiaPressDwnBtn();
		}
		override public function relUpBtn():void
		{			
			super.relUpBtn();
			if (rotation == ROT_WALL_BOT)
				sophiaRelUpBtn();
			else if (rotation == ROT_WALL_LEFT)
				sophiaRelLftBtn();
			else if (rotation == ROT_WALL_TOP)
				sophiaRelDwnBtn();
			else if (rotation == ROT_WALL_RIGHT)
				sophiaRelLftBtn();
		}
		override public function relDwnBtn():void
		{			
			super.relDwnBtn();
			if (rotation == ROT_WALL_BOT)
				sophiaRelDwnBtn();
			else if (rotation == ROT_WALL_LEFT)
				sophiaRelRhtBtn();
			else if (rotation == ROT_WALL_TOP)
				sophiaRelUpBtn();
			else if (rotation == ROT_WALL_RIGHT)
				sophiaRelRhtBtn();
		}
		override public function relLftBtn():void
		{
			super.relLftBtn();
			if (rotation == ROT_WALL_BOT)
				sophiaRelLftBtn();
			else if (rotation == ROT_WALL_LEFT)
				sophiaRelDwnBtn();
			else if (rotation == ROT_WALL_TOP)
				sophiaRelLftBtn();
			else if (rotation == ROT_WALL_RIGHT)
				sophiaRelUpBtn();
		}
		override public function relRhtBtn():void
		{
			super.relRhtBtn();
			if (rotation == ROT_WALL_BOT)
				sophiaRelRhtBtn();
			else if (rotation == ROT_WALL_LEFT)
				sophiaRelUpBtn();
			else if (rotation == ROT_WALL_TOP)
				sophiaRelRhtBtn();
			else if (rotation == ROT_WALL_RIGHT)
				sophiaRelDwnBtn();
		}
		private function sophiaPressUpBtn():void
		{
			sophiaUpBtn = true;
			if (cState != ST_VINE && (!underWater || onGround))
			{
				MOVE_PARTS_TMR.start();
				sophiaBase.setStopFrame(FL_BASE_DIAG);
				if (BASE_TURN_TMR.running)
					BASE_TURN_TMR.stop();
			}
		}
		private function sophiaPressDwnBtn():void
		{
			sophiaDwnBtn = true;
			if (underWater && !onGround && vy == 0)
				vy = 100;
		}
		private function sophiaPressLftBtn():void
		{
			sophiaLftBtn = true;
			if ( (!revScaleX && scaleX < 0) || (revScaleX && scaleX > 0) )
				return;
			var bcl:String = sophiaBase.currentFrameLabel;
			if (!sophiaUpBtn && bcl != convLab(FL_BASE_UP))
			{
				BASE_TURN_TMR.start();
				scaleX = -1;
				sophiaScaleX = scaleX;
				if (revScaleX)
					scaleX = -scaleX;
				if (bcl == FL_BASE_HORZ || bcl == FL_BASE_TURN_2 || bcl == FL_BASE_TURN_START)
					sophiaBase.setPlayFrame(FL_BASE_TURN_START);
				else
					sophiaBase.stopAnim = true;
			}
		}
		private function sophiaPressRhtBtn():void
		{
			sophiaRhtBtn = true;
			if ( (!revScaleX && scaleX > 0) || (revScaleX && scaleX < 0) )
				return;
			var bcl:String = sophiaBase.currentFrameLabel;
			if (!sophiaUpBtn && bcl != convLab(FL_BASE_UP))
			{
				BASE_TURN_TMR.start();
				scaleX = 1;
				sophiaScaleX = scaleX;
				if (revScaleX)
					scaleX = -scaleX;
				if (bcl == FL_BASE_HORZ || bcl == FL_BASE_TURN_2 || bcl == FL_BASE_TURN_START)
					sophiaBase.setPlayFrame(FL_BASE_TURN_START);
				else
					sophiaBase.stopAnim = true;
			}
		}
		private function sophiaRelUpBtn():void
		{
			sophiaUpBtn = false;
			if (sophiaBase.currentLabel === convLab(FL_BASE_UP))
			{
				MOVE_PARTS_TMR.start();
				sophiaBase.setStopFrame(FL_BASE_DIAG);
			}
		}
		private function sophiaRelDwnBtn():void
		{
			sophiaDwnBtn = false;
		}
		private function sophiaRelLftBtn():void
		{
			sophiaLftBtn = false;
		}
		private function sophiaRelRhtBtn():void
		{
			sophiaRhtBtn = false;
		}
		override public function manualChangePwrState():void
		{
			var lcl:String;
			var lsf:String;
			sophiaBase.hitStopAnim = sophiaBase.stopAnim;
			sophiaBase.hitFrameLabel = sophiaBase.currentLabel;
			frontWheel.hitStopAnim = frontWheel.stopAnim;
			frontWheel.hitFrameLabel = frontWheel.currentLabel;
			backWheel.hitStopAnim = backWheel.stopAnim;
			backWheel.hitFrameLabel = backWheel.currentLabel;
			super.manualChangePwrState();
			setPStateColors();
			lcl = sophiaBase.hitFrameLabel;
			lsf = lcl.substr(0,lcl.length-2);
			sophiaBase.setStopFrame(lsf);
			sophiaBase.stopAnim = sophiaBase.hitStopAnim;
			lcl = frontWheel.hitFrameLabel;
			lsf = lcl.substr(0,lcl.length-2);
			frontWheel.setStopFrame(lsf);
			frontWheel.stopAnim = frontWheel.hitStopAnim;
			lcl = backWheel.hitFrameLabel;
			lsf = lcl.substr(0,lcl.length-2);
			backWheel.setStopFrame(lsf);
			backWheel.stopAnim = backWheel.hitStopAnim;
		}
		override public function exitPipeVert(pt:PipeTransporter):void
		{
			super.exitPipeVert(pt);
			//head.setStopFrame("openClosed");
		}
		override public function initiateDeath(source:LevObj = null):void
		{
			super.initiateDeath(source);
			var dif:int = GameSettings.difficulty;
			if (dif != Difficulties.VERY_EASY && dif != Difficulties.EASY)
				STAT_MNGR.changeStat(STAT_MNGR.STAT_NUM_SOPHIA_MISSILES,-STAT_MNGR.NUM_SOPHIA_MISSILES_MAX);
		}
		override protected function initiateNormalDeath(source:LevObj = null):void
		{
			super.initiateNormalDeath(source);
			stopUpdate = true;
			stopAnim = true;
			stopHit = true;
			level.addToLevelNow(new SophiaExplosion(this));
			visible = false;
			EVENT_MNGR.startDieTmr(DIE_TMR_DEL_NORMAL);
		}
		override protected function initiatePitDeath():void
		{
			_dieTmrDel = DIE_TMR_DEL_PIT;
			super.initiatePitDeath();
			SND_MNGR.playSound(SoundNames.SFX_SOPHIA_DIE);
		}
		override public function slideDownFlagPole():void
		{
			if (engagedHover)
			{
				deactivateHoverMode();
				setUpWheelsForLand();
			}
			resetAllParts();
			detachFromWall();
			super.slideDownFlagPole();
			sophiaBase.setStopFrame(FL_BASE_HORZ);
			
		}
		override public function stopFlagPoleSlide():void
		{
			super.stopFlagPoleSlide();
			if (engagedHover && onGround)
				landOnGround();
		}
		override protected function flagDelayTmrLsr(e:TimerEvent):void
		{
			super.flagDelayTmrLsr(e);
			/*if (onGround)
			{
				setState(ST_WALK);
				onGround = true;
			}*/
		}
		private function activateAttachToWall(g:Ground,side:String):Boolean
		{
			var nxStart:Number = nx;
			var xNum:Number = nx;
			var yNum:Number = ny;
			var lastVx:Number = vx;
			var lastVy:Number = vy;
			if ( !wallTransStart(g,side,true) )
				return false;
			attachToWall();
			if (vertical)
			{
				if (!(g is Platform))
					vy = lastVy;
				if (rotation == ROT_WALL_LEFT)
					xNum = g.hRht;
				else
					xNum = g.hLft;
				vxMax = VX_MAX_DEF;
			}
			else
			{
				yNum = g.hBot;
				vx = lastVx;
			}
			nx = xNum;
			ny = yNum;
			x = nx;
			y = ny;
			setHitPoints();
			//checkState();
			//sophiaUpBtn = false;
			//sophiaDwnBtn = false;
			//sophiaLftBtn = false;
			//sophiaRhtBtn = false;
			//checkWallsForClimb(true,true);
			scaleX = -scaleX;
			sophiaScaleX = -sophiaScaleX;
			checkWallsForClimb(true,true);
			x = nx;
			y = ny;
			setSophiaDirBtns();
			lastRotation = rotation;
			landOnGround();
			scrollDist = nxStart - nx;
			if (isNaN(screenScrollPosOffset))
				screenScrollPosOffset = scrollDist;
			else
				screenScrollPosOffset += scrollDist;
			if (g is Platform)
				attachedToPlatform = g as Platform;
			if (underWater)
				defyGrav = true;
			return true;
		}
		private function wallTransStart(g:Ground,side:String,inverted:Boolean = false,falseGroundRect:Rectangle = null):Boolean
		{
			/*if (rotation == ROT_WALL_BOT && inverted) // kind of sloppy, prevents bug by checking for ground directly above inverted walltrans
			{
				var ground:Ground = level.getGroundAt(g.x,g.y - TILE_SIZE)
				if (ground)
					return;
			}*/
			if ( !upgradeIsActive(SOPHIA_WALL_CLIMB) || ( side == WALL_TOP_STR && !upgradeIsActive(SOPHIA_CEILING_CLIMB) ) )
				return false;
			if (g && side == WALL_TOP_STR && ( g.y + TILE_SIZE == GLOB_STG_BOT || level.localToGlobal(new Point(g.x + TILE_SIZE,g.y)).x > GLOB_STG_RHT ) )
				return false; // checks if ground is on bottom or right side is off screen
			if (g is Platform)
				attachedToPlatform = onPlatform;
			invertedWallTrans = inverted;
			wallToAttachTo = g;
			wallSideToAttachTo = side;
			this.falseGroundRect = falseGroundRect;
			var gLft:Number;
			var gRht:Number;
			var gTop:Number;
			var gBot:Number;
			if (falseGroundRect)
			{
				gLft = falseGroundRect.left;
				gRht = falseGroundRect.right;
				gTop = falseGroundRect.top;
				gBot = falseGroundRect.bottom;
			}
			else
			{
				gLft = g.hLft;
				gRht = g.hRht;
				gTop = g.hTop;
				gBot = g.hBot;
			}
			setState(ST_WALL_TRANS);
			/*base.visible = false;
			frontWheel.visible = false;
			backWheel.visible = false;*/
			var nxStart:Number = nx;
			vx = 0;
			vy = 0;
			if (!underWater)
				vyMax = VX_MAX_DEF;
			jumped = false;
			defyGrav = true;
			onGround = true;
			lastRotation = rotation;
			// set current stats
			if (invertedWallTrans)
			{
				setStopFrame(FL_WALL_TRANS_INV_START);
				if (vertical)
				{
					if (wallSideToAttachTo === WALL_BOTTOM_STR)
						ny = gTop + CLIMB_INVERTED_OFS;
					else
						ny = gBot - CLIMB_INVERTED_OFS;
				}
				else
				{
					if (wallSideToAttachTo === WALL_LEFT_STR)
						nx = gRht - CLIMB_INVERTED_OFS;
					else
						nx = gLft + CLIMB_INVERTED_OFS;
				}
			}
			else
			{
				setStopFrame(FL_WALL_TRANS_START);
				if (vertical)
				{
					if (wallSideToAttachTo === WALL_BOTTOM_STR)
						ny = gTop - CLIMB_OFS;
					else
						ny = gBot + CLIMB_OFS;
				}
				else
				{
					if (wallSideToAttachTo === WALL_RIGHT_STR)
						nx = gLft - CLIMB_OFS;
					else
						nx = gRht + CLIMB_OFS;
				}
			}
			// set up stats after wallTrans
			if (wallSideToAttachTo == WALL_LEFT_STR || wallSideToAttachTo == WALL_RIGHT_STR)
			{
				if (wallSideToAttachTo == WALL_LEFT_STR)
				{
					wallTransEndRotation = ROT_WALL_LEFT;
					wallTransEndRevScaleX = false;
					wallTransEndNx = gRht;
				}
				else
				{
					wallTransEndRotation = ROT_WALL_RIGHT;
					wallTransEndRevScaleX = true;
					wallTransEndNx = gLft;
				}
				wallTransEndVertical = true;
				if (lastRotation == ROT_WALL_BOT)
				{
					if (invertedWallTrans)
					{
						wallTransEndNy = gTop + CLIMB_INVERTED_OFS;
						wallTransEndVy = VX_MAX_DEF;
					}
					else
					{
						wallTransEndNy = gBot - CLIMB_OFS;
						wallTransEndVy = -VX_MAX_DEF;
					}
				}
				else // came from top
				{
					if (invertedWallTrans)
					{
						wallTransEndNy = gBot - CLIMB_INVERTED_OFS;
						wallTransEndVy = -VX_MAX_DEF;
					}
					else
					{
						wallTransEndNy = gTop + CLIMB_OFS;
						wallTransEndVy = VX_MAX_DEF;
					}
				}
			}
			else // top or bottom
			{
				if (wallSideToAttachTo == WALL_TOP_STR)
				{
					wallTransEndRotation = ROT_WALL_TOP;
					wallTransEndRevScaleX = true;
					wallTransEndNy = gBot;
				}
				else // bottom
				{
					wallTransEndRotation = ROT_WALL_BOT;
					wallTransEndRevScaleX = false;
					wallTransEndNy = gTop;
				}
				wallTransEndVertical = false;
				if (lastRotation == ROT_WALL_LEFT)
				{
					if (invertedWallTrans)
					{
						wallTransEndNx = gRht - CLIMB_INVERTED_OFS;
						wallTransEndVx = -VX_MAX_DEF;
					}
					else
					{
						wallTransEndNx = gLft + CLIMB_OFS;
						wallTransEndVx = VX_MAX_DEF;
					}
				}
				else // if came from right wall
				{
					if (invertedWallTrans)
					{
						wallTransEndNx = gLft + CLIMB_INVERTED_OFS;
						wallTransEndVx = VX_MAX_DEF;
					}
					else
					{
						wallTransEndNx = gRht - CLIMB_OFS;
						wallTransEndVx = -VX_MAX_DEF;
					}
				}
			}
			// set up dummy screen scroll
			var numWallTransFrames:int = NUM_WALL_TRANS_FRAMES;
			if (inverted)
				numWallTransFrames = NUM_WALL_TRANS_INV_FRAMES;
			var defsspo:Number = nxStart - nx;
			if (isNaN(screenScrollPosOffset))
				screenScrollPosOffset = nxStart - nx;
			else
			{
				screenScrollPosOffset += nxStart - nx;
				scrollScreenDuringWallTrans = true;
			}
			//ssxInt = (wallTransEndNx - nxStart) / (numWallTransFrames - 1);
			ssxInt = ( (wallTransEndNx - nxStart) - (screenScrollPosOffset - defsspo) ) / (numWallTransFrames - 1);
			disableStuckInWallShift = true;
			WHEEL_TMR.stop();
			setUpWheelsForLand();
			BASE_VERT_TMR.numTotalCycles = 0;
			BASE_VERT_TMR.delay = DEL_WALL_TRANS_TMR;
			BASE_VERT_TMR.start();
			return true;
		}
		private function wallTransEnd():void
		{
			vx = 0;
			vy = 0;
			vx = wallTransEndVx;
			vy = wallTransEndVy;
			nx = wallTransEndNx;
			ny = wallTransEndNy;
			if (wallToAttachTo is Platform)
			{
				if (vertical)
				{
					if (rotation == ROT_WALL_LEFT)
						nx = attachedToPlatform.hRht - CLIMB_INVERTED_OFS;
					else
						nx = attachedToPlatform.hLft + CLIMB_INVERTED_OFS;
				}
			}
			x = nx;
			y = ny;
			attachToWall();
			if (rotation == ROT_WALL_BOT)
				detachFromWall();
			setSophiaDirBtns();
			//if (wallToAttachTo is Platform)
			//	activateAttachToWall(wallToAttachTo,wallSideToAttachTo);
		}
		private function attachToWall():void
		{
			revScaleX = wallTransEndRevScaleX;
			rotation = wallTransEndRotation;
			vertical = wallTransEndVertical;
			setHitPoints();
			setLastHitPointsToCurrent();
			sophiaScaleX = scaleX;
			if (revScaleX)
				sophiaScaleX = -scaleX;
			stuckInWall = false;
			lastStuckInWall = false;
			if (vertical)
				vyMin = VX_MIN;
			else
				vyMin = 0;
			wallTransEndVx = 0;
			wallTransEndVy = 0;
			ssxInt = NaN;
			//if (!scrollScreenDuringWallTrans)
				screenScrollPosOffset = NaN;
			//else
				scrollScreenDuringWallTrans = false;
			yOfsInt = NaN;
			wallTransEndRevScaleX = false;
			if (wallToAttachTo is Platform && vertical)
			{
				vx = 0;
				vy = 0;
			}
			wallToAttachTo = null;
			wallSideToAttachTo = null;
			falseGroundRect = null;
			BASE_VERT_TMR.stop();
			/*base.visible = true;
			frontWheel.visible = true;
			backWheel.visible = true;*/
			setStopFrame(FL_MAIN);
			sophiaBase.setStopFrame(FL_BASE_HORZ);
			setState(ST_CLIMB);
			resetAllParts();
			if (underWater)
			{
				vxMax = MAX_SPEED_CLIMB_WATER;
				vyMax = MAX_SPEED_CLIMB_WATER;
			}
		}
		private function detachFromWall(standardDetach:Boolean = true):void
		{
			var nxStart:Number = nx;
			if (vertical)
			{
				if (rotation == ROT_WALL_LEFT)
					nx += hRectMainWidth/2;
				else
					nx -= hRectMainWidth/2;
				ny += hRectMainHeight/2;
			}
			if (revScaleX)
			{
				if (!vertical)
					scaleX = -scaleX;
				revScaleX = false;
				sophiaScaleX = scaleX;
			}
			if (rotation == ROT_WALL_TOP)
				ny += hRectMainHeight;
			else if (rotation == ROT_WALL_BOT && attachedToPlatform)
			{
				ny = attachedToPlatform.y;
				if (attachedToPlatform.platType != "pully")
				{
					if (attachedToPlatform.useVy)
						vy = attachedToPlatform.vy;
					else if (attachedToPlatform.vertical)
						nyPlatform = attachedToPlatform.ny;
					else if (!attachedToPlatform.vertical)
						dxPlatform = attachedToPlatform.dx;
				}
				if (attachedToPlatform.platType == "falling" || attachedToPlatform.platType == "constantFall") 
					onFallingPlatform = true;
				attachedToPlatform.setCharOnPlat();
			}
			rotation = ROT_WALL_BOT;
			lastRotation = ROT_WALL_BOT;
			vertical = false;
			if (cState == ST_CLIMB)
				onGround = true;
			else
				onGround = false;
			//vx = 0;
			x = nx;
			y = ny;
			scrollDist = nxStart - nx;
			if (isNaN(screenScrollPosOffset))
				screenScrollPosOffset = scrollDist;
			else
				screenScrollPosOffset += scrollDist;
			screenScrollPosOffset = scrollDist;
			if (onGround)
				setState(ST_STAND);
			else
				setState(ST_JUMP);
			//vy = 0;
			defyGrav = false;
			setJumpRise(false);
			disableStuckInWallShift = false;
			attachedToPlatform = null;
			setStopFrame(FL_MAIN);
			/*base.visible = true;
			backWheel.visible = true;
			frontWheel.visible = true;*/
			if (!underWater)
			{
				vxMax = VX_MAX_DEF;
				vyMax = VY_MAX_DEF;
				brickState == BRICK_BOUNCER;
			}
			else
			{
				vxMax = VX_MAX_WATER_NORMAL;
				vyMax = VY_MAX_WATER;
			}
			vyMin = 0;
			//if (!sophiaDwnBtn && lastRotation == ROT_WALL_TOP)
			//	vy = JUMP_PWR;
			setSophiaDirBtns();
			setHitPoints();
		}
		private function checkAttachToOppositeWall():Boolean
		{
			// [ nx, ny, vx, vy ]
			// will never check while on ceiling, initially set up for on bottom
			var dir:int = 1; // right or bottom = 1, left = -1
			var xNum:Number = hLft;
			var yNum:Number = hBot;
			var xOfs:int;
			var yOfs:int;
			var ground:Ground;
			var newGround:Ground;
			var groundDct:CustomDictionary = new CustomDictionary(true);
			var point:Point;
			//hRect.visible = true;
			//base.visible = false;
			//backWheel.visible = false;
			//frontWheel.visible = false;
			if (rotation == ROT_WALL_LEFT)
			{
				dir = -1;
				xOfs = -TILE_SIZE;
			}
			else if (rotation == ROT_WALL_RIGHT)
				xNum = hRht;
			xNum += xOfs;
			yNum += yOfs;
			point = level.getCurrentGrid(xNum,yNum);
			groundDct.addItem( level.getGroundAt(point.x,point.y) );
			for (var i:int; i < 2; i++) // adds middle and right most points
			{
				if (!vertical)
					xNum += hRectMainWidth/2;
				else
					yNum -= hRectMainWidth/2;
				point = level.getCurrentGrid(xNum,yNum);
				groundDct.addItem( level.getGroundAt(point.x,point.y) );
			}
			var foundGround:Boolean;
			for each (ground in groundDct)
			{
				if (!ground.visible)
					continue;
				if (!vertical)
					newGround = level.getGroundAt(ground.x,ground.y - TILE_SIZE*2);
				else
					newGround = level.getGroundAt(ground.x - TILE_SIZE*2*dir,ground.y);
				if (newGround && newGround.visible)
				{
					foundGround = true;
					break;
				}
			}
			if (!foundGround)
				return false;
			if (vertical)
			{
				//fakeWallTransRealStatsArr = [ nx, ny, vx, vy ];
				/*var dct:CustomDictionary = new CustomDictionary(true);
				var xOfs:int;
				if (rotation == ROT_WALL_RIGHT)
					xOfs -= TILE_SIZE;
				dct.addItem(new Point(centerX,testRect.top));
				dct.addItem(new Point(centerX,testRect.bottom));
				if (rotation == ROT_WALL_LEFT)
				{
					dct.addItem(new Point(testRect.right,testRect.top));
					dct.addItem(testRect.bottomRight);
				}
				else
				{
					dct.addItem(new Point(testRect.left,testRect.bottom));
					dct.addItem(testRect.topLeft);
				}
				for each (var point:Point in dct)
				{
					var gridPnt:Point = level.getCurrentGrid(point.x,point.y);
					var ground:Ground = level.getGroundAt(gridPnt.x,gridPnt.y);
					if (ground && ground.visible)
						return false;
				}*/
			}
			else
			{
				
			}
			return true;
		}
		private function checkDropFromWall(testOnly:Boolean = false):Boolean
		{
			if (vertical)
			{
				// testRect shows future position for testing
				var testRect:Rectangle = new Rectangle(nx,ny - hRectMainHeight/2,hRectMainWidth,hRectMainHeight);
				var dct:CustomDictionary = new CustomDictionary(true);
				if (rotation == ROT_WALL_RIGHT)
					testRect.x -= hRectMainWidth;
				var centerX:Number = testRect.left + testRect.width/2;
				dct.addItem(new Point(centerX,testRect.top));
				dct.addItem(new Point(centerX,testRect.bottom));
				if (rotation == ROT_WALL_LEFT)
				{
					dct.addItem(new Point(testRect.right,testRect.top));
					dct.addItem(testRect.bottomRight);
				}
				else
				{
					dct.addItem(new Point(testRect.left,testRect.bottom));
					dct.addItem(testRect.topLeft);
				}
				for each (var point:Point in dct)
				{
					var gridPnt:Point = level.getCurrentGrid(point.x,point.y);
					var ground:Ground = level.getGroundAt(gridPnt.x,gridPnt.y);
					if (ground && ground.visible)
						return false;
				}
			}
			if (!testOnly)
				detachFromWall();
			return true;
			//ssxInt = -screenScrollPosOffset / (NUM_SCREEN_SCROLL_CYCLES - 1);
		}
		override protected function checkPlatform():void
		{
			if (onPlatform)
			{
				if (rotation != ROT_WALL_BOT || (rotation == ROT_WALL_BOT && cState === ST_WALL_TRANS) )
				{
					if (checkPlatDist(nx - attachedToPlatform.hMidX))
					{
						attachedToPlatform = null;
						detachFromWall();
						onPlatform = null;
						return;
					}
					else if (checkPlatDist(ny - attachedToPlatform.hMidY))
					{
						attachedToPlatform = null;
						detachFromWall();
						onPlatform = null;
						return;
					}
				}
				if (rotation == ROT_WALL_BOT && cState != ST_WALL_TRANS)
				{
					if (checkPlatDist(ny - onPlatform.y))
					{
						attachedToPlatform = null;
						onPlatform = null;
						return;
					}
					ny = onPlatform.y;
					if (!isNaN(dxPlatform) && !cloudPlatform)
					{
						nx += dxPlatform;
						dxPlatform = NaN;
					}
				}
				else
				{
					var yOfs:Number = attachedToPlatform.height;
					if (rotation == ROT_WALL_BOT)
						yOfs = 0;
					if (vertical)
					{
						yOfs = attachedToPlatform.height/2;
						if (rotation == ROT_WALL_LEFT)
							nx = attachedToPlatform.hRht;
						else
							nx = attachedToPlatform.hLft;
					}
					ny = attachedToPlatform.y + yOfs;
					if (!vertical && ( !isNaN(dxPlatform) || rotation == ROT_WALL_BOT) && !cloudPlatform)
					{
						if (!isNaN(attachedToPlatform.dx))
							nx += attachedToPlatform.dx;
						dxPlatform = NaN;
					}
				}
			}
			function checkPlatDist(num:Number):Boolean
			{
				if (num < 0)
					num = -num;
				if ( ( !cloudPlatform && num > MAX_PLAT_DIST ) || (cloudPlatform && num > onPlatform.width*.6) )
					return true;
				else
					return false;
			}
		}
		override public function groundOnSide(g:Ground, side:String):void
		{
			if (g != null && g == attachedToPlatform)
			{
				attachedToPlatform.setCharOnPlat();
				return;
			}
			if (cState == ST_CLIMB || cState === ST_WALL_TRANS)
				return;
			if (!onGround && !engagedHover && (!underWater || jumpRise) )
			{
				var ground:Ground;
				var point:Point;
				if (rotation == ROT_WALL_LEFT && side == HitTester.SIDE_RIGHT)
				{
					if (g && g.visible)
					{
						ground = level.getGroundAt(g.x - TILE_SIZE,g.y);
						if (!ground || !ground.visible)
						{
							if (activateAttachToWall(g,WALL_RIGHT_STR) )
								return;
						}
					}
					else
						detachFromWall();
				}
				else if (rotation == ROT_WALL_RIGHT && side == HitTester.SIDE_LEFT)
				{
					if (g && g.visible)
					{
						ground = level.getGroundAt(g.x + TILE_SIZE,g.y);
						if (!ground || !ground.visible)
						{
							if ( activateAttachToWall(g,WALL_LEFT_STR) )
								return;
						}
					}
					else
						detachFromWall();
				}
			}
			super.groundOnSide(g,side);
		}
		override public function groundAbove(g:Ground):void
		{
			if (attachedToPlatform && g == attachedToPlatform)
			{
				onPlatform = g as Platform;
				if (onPlatform.platType != "pully" && !onPlatform.vertical)
					dxPlatform = onPlatform.dx;
				onPlatform.setCharOnPlat();
				ny = g.hBot;
			}
			if (cState == ST_CLIMB || cState === ST_WALL_TRANS || stuckInWall || lastStuckInWall || (g && !g.visible && brickState == BRICK_NONE) )
				return;
			if (g && g.visible && !onGround && vy < 0 && (!underWater || jumpRise) && rotation == ROT_WALL_BOT && !sophiaDwnBtn && !engagedHover)
			{
				if ( activateAttachToWall(g,WALL_TOP_STR) )
				{
					if (g is Platform)
					{
						onPlatform = g as Platform;;
						if (onPlatform.platType != "pully" && !onPlatform.vertical)
							dxPlatform = onPlatform.dx;
						onPlatform.setCharOnPlat();
						ny = g.hBot;
					}
					setJumpRise(false);
					return;
				}
			}
			if (rotation == ROT_WALL_BOT)
				setJumpRise(false);
			_fallBtwn = false;
			hitCeiling = true;
			if (rotation == ROT_WALL_BOT)
				ny = g.hBot + hHeight;
			else if (vertical)
			{
				ny = g.hBot + hHeight/2;
				vy = 0;
			}
			else
			{
				ny = g.hBot;
				vy = 0;
			}
			if (!engagedHover && !underWater && rotation == ROT_WALL_BOT && vy < 0)
			{
				SND_MNGR.playSound(SND_GAME_HIT_CEILING);
				if (jumped)
					vy = CIELING_DISPLACE;
			}
			setHitPoints();	
		}
		override public function groundBelow(g:Ground):void
		{
			if (cState == ST_CLIMB || cState == ST_WALL_TRANS)
				return;
			if ( onPlatform && !(g is Platform))
			{
				attachedToPlatform = null;
				onPlatform = null;
			}
			if (rotation == ROT_WALL_TOP)
				detachFromWall();
			else if (vertical)
			{
				ny = g.hTop - hRectMainWidth/2;
				vy = 0;
				setHitPoints();
				hBot = g.hTop;
				return;
			}
			super.groundBelow(g);
		}
		override protected function landOnGround():void
		{
			super.landOnGround();
			baseVertOfs = BASE_VERT_OFS_DEF;
			if (sophiaBase.y >= BASE_DEF_Y + baseVertOfs)
				sophiaBase.y = BASE_JUMP_BOUNCE_Y + baseVertOfs;
			else
				sophiaBase.y = BASE_UP_JUMP_BOUNCE_Y + baseVertOfs;
			if (cState != ST_WALL_TRANS)
			{
				BASE_VERT_TMR.numTotalCycles = 1;
				BASE_VERT_TMR.delay = DEL_BASE_JUMP_BOUNCE_TMR;
				BASE_VERT_TMR.start();	
			}
			SND_MNGR.playSound(SN_LAND);
			if (engagedHover || hover)
				deactivateHoverMode();
			setJumpRise(false);
			if (underWater)
			{
				defyGrav = false;
				setUpWheelsForLand();
			}
			releasedJumpBtn = true;
		}
		private function wheelTmrHandler(event:TimerEvent):void
		{
			if (underWater && onGround)
			{
				var cl:String = backWheel.currentLabel;
				if (cl == FL_WHEEL_WATER_1 || cl == FL_WHEEL_WATER_2)
					setUpWheelsForLand();
			}
			if ( frontWheel.currentLabel === convLab(FL_WHEEL_HOVER_SMALL_FLAME) )
			{
				frontWheel.setPlayFrame(FL_WHEEL_HOVER_BIG_FLAME);
				backWheel.setPlayFrame(FL_WHEEL_HOVER_BIG_FLAME);
				return;
			}
			else if (backWheel.currentLabel === convLab(FL_WHEEL_WATER_2) )
			{
				backWheel.setPlayFrame(FL_WHEEL_WATER_1);
				return;
			}
			// preCheckFrame ends
			if (!frontWheel.stopAnim)
				frontWheel.animate(WHEEL_TMR);
			if (!backWheel.stopAnim)
				backWheel.animate(WHEEL_TMR);
			// next part is called when hoverTrans ends afer hover
			else if ( frontWheel.currentLabel == convLab(FL_WHEEL_HOVER_TRANS) )// stopAnim and hoverTrans
			{
				if (!underWater || onGround)
				{
					setUpWheelsForLand();
					MOVE_PARTS_TMR.dispatchEvent(new TimerEvent(TimerEvent.TIMER)); // resets wheel position
					WHEEL_TMR.delay = DEL_WHEEL_TMR_FAST;
				}
				else
				{
					setUpWheelsForWater();
					WHEEL_TMR.delay = DEL_WHEEL_TMR_FAST;
				}
			}
			if ( hover && frontWheel.currentFrameLabel == convLab(FL_WHEEL_HOVER) )
			{
				frontWheel.setPlayFrame(FL_WHEEL_HOVER_BIG_FLAME);
				backWheel.setPlayFrame(FL_WHEEL_HOVER_BIG_FLAME);
				WHEEL_TMR.delay = DEL_HOVER_FLAME;
			}
		}
		private function gainHoverTmrHandler(event:TimerEvent):void
		{
			if (GS_MNGR.gameState == GS_PLAY)
				increaseAmmoByValue(SOPHIA_HOVER, 1); 
			if ( getAmmo( SOPHIA_HOVER ) == HOVER_MAX && GAIN_HOVER_TMR.running)
				GAIN_HOVER_TMR.stop();
		}
		private function loseHoverTmrHandler(event:TimerEvent):void
		{
			if (GS_MNGR.gameState == GS_PLAY)
			{
				if ( !starPwr )
					decreaseAmmoByValue(SOPHIA_HOVER, 1);
			}
			if ( getAmmo( SOPHIA_HOVER ) == HOVER_MIN)
			{
				frictionY = true;
				hover = false;
				activateGainHoverTmr();
				frontWheel.setStopFrame(FL_WHEEL_HOVER);
				backWheel.setStopFrame(FL_WHEEL_HOVER);
				stopHoverSound();	
				LOSE_HOVER_TMR.stop();
			}
		}
		private function baseTurnTmrHandler(event:TimerEvent):void
		{
			if (!sophiaBase.stopAnim)
				sophiaBase.animate(BASE_TURN_TMR);
		}
		private function baseVertTmrHandler(event:TimerEvent):void
		{
			if (cState === ST_WALL_TRANS)
			{
				var cl:String = currentLabel;
				if ( cl === convLab(FL_WALL_TRANS_END) || cl === convLab(FL_WALL_TRANS_INV_END) )
					wallTransEnd();
				else
					gotoAndStop(currentFrame + 1);
				if ( !isNaN(yOfsInt) )
				{
					y += yOfsInt;
				}
				if ( !isNaN(screenScrollPosOffset) && !isNaN(ssxInt) )
					screenScrollPosOffset += ssxInt;
				return;
			}
			if (readyToJump)
				jump();
			else if (onGround)
			{
				if (sophiaBase.y == BASE_DEF_Y + baseVertOfs)
					sophiaBase.y = BASE_BOUNCE_Y + baseVertOfs;
				else if (sophiaBase.y == BASE_BOUNCE_Y + baseVertOfs)
					sophiaBase.y = BASE_DEF_Y + baseVertOfs;
				else if (sophiaBase.y == BASE_UP_DEF_Y + baseVertOfs)
					sophiaBase.y = BASE_UP_BOUNCE_Y + baseVertOfs;
				else if (sophiaBase.y == BASE_UP_BOUNCE_Y + baseVertOfs)
					sophiaBase.y = BASE_UP_DEF_Y + baseVertOfs;
				else if (sophiaBase.y == BASE_JUMP_BOUNCE_Y + baseVertOfs)
					sophiaBase.y = BASE_DEF_Y + baseVertOfs;
				else if (sophiaBase.y == BASE_UP_JUMP_BOUNCE_Y + baseVertOfs)
					sophiaBase.y = BASE_UP_DEF_Y + baseVertOfs;
			}
			else
			{
				if (sophiaBase.y == BASE_BOUNCE_Y + baseVertOfs)
					sophiaBase.y = BASE_DEF_Y + baseVertOfs;
				else if (sophiaBase.y == BASE_UP_BOUNCE_Y + baseVertOfs)
					sophiaBase.y = BASE_UP_DEF_Y + baseVertOfs;
				else if (sophiaBase.y == BASE_JUMP_BOUNCE_Y + baseVertOfs)
					sophiaBase.y = BASE_DEF_Y + baseVertOfs;
				else if (sophiaBase.y == BASE_UP_JUMP_BOUNCE_Y + baseVertOfs)
					sophiaBase.y = BASE_UP_DEF_Y + baseVertOfs;
				BASE_VERT_TMR.stop();
			}
		}
		override protected function getOffVine():void
		{
			setStopFrame(FL_MAIN);
			stopHit = false;
			sophiaBase.rotation = 0;
			frontWheel.rotation = 0;
			backWheel.rotation = 0;
			/*base.visible = true;
			frontWheel.visible = true;
			backWheel.visible = true;*/
			sophiaBase.scaleX = 1;
			frontWheel.scaleX = 1;
			backWheel.scaleX = 1;
			resetAllParts();
			setHitPoints();
			super.getOffVine();
		}
		override protected function getOnVine(_vine:Vine):void
		{
			super.getOnVine(_vine);
			if (rotation != ROT_WALL_BOT)
				detachFromWall();
//			setStopFrame(FL_CLIMB_VINE);
			resetAllParts();
			stopTimers();
			sophiaBase.setStopFrame(FL_BASE_HORZ);
			if (hover || engagedHover)
				deactivateHoverMode();
			setUpWheelsForLand();
			// didn't make the following constants because this is the only place they show up
			sophiaBase.rotation = -90;
			sophiaBase.x = 11;
			sophiaBase.y = -19;
			frontWheel.rotation = -90;
			frontWheel.x = 7;
			frontWheel.y = -35;
			backWheel.rotation = -90;
			backWheel.x = frontWheel.x;
			backWheel.y = -3;
			WHEEL_TMR.delay = DEL_WHEEL_TMR_FAST;
			/*setState("vine");
			vine = _vine;
			nx = vine.hMidX;
			if (hTop <= vine.hTop)
				ny = vine.hTop + hHeight;
			vx = 0;
			vy = 0;
			defyGrav = true;
			//setStopFrame("climbStart");
			exitVine = false;
			if (scaleX > 0)
			{
				rotation = ROT_WALL_RIGHT;
				nx = level.getNearestGrid(vine.hRht);
			}
			else
			{
				rotation = ROT_WALL_LEFT;
				nx = level.getNearestGrid(vine.hLft);
			}
			//setSophiaDirBtns();
			base.setStopFrame(FL_BASE_HORZ);
			setUpWheelsForLand();
			resetAllParts();
			ny -= hRectMainWidth/2;
			disableStuckInWallShift = true;
			vertical = true;
			WHEEL_TMR.delay = DEL_WHEEL_TMR_MEDIUM;*/
			/*base.visible = false;
			frontWheel.visible = false;
			backWheel.visible = false;*/
		}
		private function movePartsTmrHandler(event:TimerEvent):void
		{
			if (sophiaUpBtn)
			{
				if (!engagedHover)
				{
					frontWheel.x -= WHEEL_X_SHIFT_INT;
					backWheel.x += WHEEL_X_SHIFT_INT;
				}
				else
				{
					frontWheel.x = FRONT_WHEEL_DEF_X;
					backWheel.x = BACK_WHEEL_DEF_X;
				}
				sophiaBase.y -= BASE_Y_SHIFT_INT + baseVertOfs;
				if (sophiaBase.y <= BASE_UP_DEF_Y + baseVertOfs)
				{
					if (!engagedHover)
					{
						frontWheel.x = FRONT_WHEEL_INWARD_X;
						backWheel.x = BACK_WHEEL_INWARD_X;
					}
					sophiaBase.y = BASE_UP_DEF_Y + baseVertOfs;
					sophiaBase.setStopFrame(FL_BASE_UP);
					MOVE_PARTS_TMR.stop();
				}
			}
			else
			{
				if (!engagedHover)
				{
					frontWheel.x += WHEEL_X_SHIFT_INT;
					backWheel.x -= WHEEL_X_SHIFT_INT;
				}
				else
				{
					frontWheel.x = FRONT_WHEEL_DEF_X;
					backWheel.x = BACK_WHEEL_DEF_X;
				}
				sophiaBase.y += BASE_Y_SHIFT_INT + baseVertOfs;
				if (sophiaBase.y >= BASE_DEF_Y + baseVertOfs)
				{
					frontWheel.x = FRONT_WHEEL_DEF_X;
					backWheel.x = BACK_WHEEL_DEF_X;
					sophiaBase.y = BASE_DEF_Y + baseVertOfs;
					MOVE_PARTS_TMR.stop();
					if (!BASE_TURN_TMR.running)
						sophiaBase.setStopFrame(FL_BASE_HORZ);
					else
					{
						sophiaBase.setPlayFrame(FL_BASE_TURN_START);
						sophiaBase.gotoAndStop(sophiaBase.currentFrame + BASE_TURN_TMR.currentCount);
					}
				}
			}
		}
		override public function getAxe(axe:BowserAxe):void
		{
			super.getAxe(axe);
			if (level.levNum == STAT_MNGR.DUNGEON_LEVEL_NUM)
				fx = FX_DUNGEON_GOT_AXE;
		}		
		override public function resetColor(useCleanBmd:Boolean=false):void
		{
			super.resetColor(useCleanBmd);
			sophiaBase.resetColor(useCleanBmd);
			frontWheel.resetColor(useCleanBmd);
			backWheel.resetColor(useCleanBmd);
		}
		
		override public function recolorBmps(inPalette:Palette,outPalette:Palette,inColorRow:int = 0,outColorRow:int = 0,defColorsOvrd:Palette = null):void
		{
			super.recolorBmps(inPalette, outPalette, inColorRow, outColorRow);
			sophiaBase.recolorBmps(inPalette, outPalette, inColorRow, outColorRow, defColors);
			frontWheel.recolorBmps(inPalette, outPalette, inColorRow, outColorRow, defColors);
			backWheel.recolorBmps(inPalette, outPalette, inColorRow, outColorRow, defColors);
		}
		
		override public function convLab(_fLab:String):String
		{
			return _fLab; // labels don't need to be converted
		}
		override protected function setPStateColors():void
		{
			if (pState == PS_NORMAL)
				outColor1 = COL_PINK;
			else if (pState == PS_MUSHROOM)
				outColor1 = COL_MAGENTA;
			else if (pState == PS_FIRE_FLOWER)
				outColor1 = COL_RED;
			outColor2 = COL_WHITE;
			outColor3 = COL_BLACK;
		}
		override protected function getMushroomEnd():void
		{
			super.getMushroomEnd();
		}
		
		override protected function takeDamageStart(source:LevObj):void
		{
			super.takeDamageStart(source);
			if (cState == ST_CLIMB || rotation != ROT_WALL_BOT || cState == ST_WALL_TRANS)
				detachFromWall();
			else
			{
				var dir:int = 1;
				if (source.nx > nx)
					dir = -1;
				if (vx == 0)
					vx = DAMAGE_BOOST_SPEED_STATIONARY*dir;
				else
					vx = DAMAGE_BOOST_SPEED_MOVING*dir;
			}
			landOnGround();
			SND_MNGR.removeStoredSound(SN_LAND);
			SND_MNGR.playSound(SN_TAKE_DAMAGE);
			takeNoDamage = true;
			setState(ST_TAKE_DAMAGE);
			startReplaceColor();
			noDamageTmr.start();
		}
		override protected function noDamageTmrLsr(e:TimerEvent):void
		{
			super.noDamageTmrLsr(e);
			if (!starPwr)
				endReplaceColor();
		}
		
		override protected function takeDamageEnd():void
		{
			super.takeDamageEnd();
		}
		override protected function swapPs():void
		{
			if (!SWAP_PS_VEC.length)
				return;
			var ps1:int = SWAP_PS_VEC[0];
			var ps2:int = SWAP_PS_VEC[1];
			if (pState == ps1)
				pState = ps2;
			else if (pState == ps2)
				pState = ps1;
		}
/*		override protected function swapPsEnd():void
		{
			super.swapPsEnd();
			resetAllColors();
			setPStateColors();
		}*/
		override protected function removeListeners():void
		{
			super.removeListeners();
			WHEEL_TMR.removeEventListener(TimerEvent.TIMER,wheelTmrHandler);
			BASE_TURN_TMR.removeEventListener(TimerEvent.TIMER,baseTurnTmrHandler);
			MOVE_PARTS_TMR.removeEventListener(TimerEvent.TIMER,movePartsTmrHandler);
			BASE_VERT_TMR.removeEventListener(TimerEvent.TIMER,baseVertTmrHandler);
			GAIN_HOVER_TMR.removeEventListener(TimerEvent.TIMER,gainHoverTmrHandler);
			LOSE_HOVER_TMR.removeEventListener(TimerEvent.TIMER,loseHoverTmrHandler);
		}
		override protected function reattachLsrs():void
		{
			super.reattachLsrs();
		}
		
		override public function chooseCharacter():void
		{
			super.chooseCharacter();
			stopAnim = true;
			vx = 0;
			sophiaBase.gotoAndStop(Sophia.FL_BASE_OPEN);
			if (jason)
				jason.destroy();
			jason = new Jason(this);
			level.addToLevel(jason);
		}
		override public function fallenCharSelScrn():void
		{
			super.fallenCharSelScrn();
			cancelCheckState = true;
			sophiaBase.y = BASE_JUMP_BOUNCE_Y;
		}
		
		override public function animate(ct:ICustomTimer):Boolean
		{
			if (ct == swapAnimTmr && SWAP_PS_VEC.length)
				swapPs();
			if (ct == flashAnimTmr && _replaceColor)
				flash();
			return false;
		}	
		override public function cleanUp():void
		{
			super.cleanUp();
			if ( hoverBar.parent )
				hoverBar.parent.removeChild(hoverBar);
//			if ( game.contains(MISSILE_COUNT) )
//				game.removeChild(MISSILE_COUNT);
			level.RECOLOR_OBJS_DCT.removeItem(this);
			if (jason)
				jason.destroy();
			tsTxt.UpdAmmoIcon(false);
			tsTxt.UpdAmmoText(false);
		}
		private function setJumpRise(value:Boolean):void
		{
			if (jumpRise && !value && !onGround) // deactivate
			{
				if (!underWater)
				{
					defyGrav = false;
					if (releasedJumpBtn)
						frictionY = true;
				}
				else
				{
					vyMax = VY_MAX_WATER;
					if (!jmpBtn)
						vxMax = VX_MAX_WATER_NORMAL;
					else
						vxMax = VX_MAX_WATER_BOOST;
				}
			}
			else if (!jumpRise && value) // activate
			{
				defyGrav = true;
				lastOnGround = false;
				frictionY = false;
			}
			jumpRise = value;
		}

		override protected function getAllDroppedUpgrades():void
		{
			hitPickup(new SophiaPickup( SOPHIA_HOMING_MISSILE), false);
			hitPickup(new SophiaPickup( SOPHIA_MISSILE), false);
		}
		
		public static function setMaxHover():void
		{
			// TODO Auto Generated method stub
			
		}
		
		override protected function playDefaultPickupSoundEffect():void
		{
			SND_MNGR.playSound(SoundNames.SFX_SOPHIA_GET_PICKUP);
		}
	}
}