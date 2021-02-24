package com.smbc.characters.base
{
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.characters.Character;
	import com.smbc.characters.Luigi;
	import com.smbc.characters.Mario;
	import com.smbc.data.AnimationTimers;
	import com.smbc.data.GameSettings;
	import com.smbc.data.GameStates;
	import com.smbc.data.MusicType;
	import com.smbc.data.PickupInfo;
	import com.smbc.data.SoundNames;
	import com.smbc.enemies.Bloopa;
	import com.smbc.enemies.Enemy;
	import com.smbc.enums.ClassicDamageResponse;
	import com.smbc.enums.DamageResponse;
	import com.smbc.graphics.BmdSkinCont;
	import com.smbc.ground.*;
	import com.smbc.level.Level;
	import com.smbc.level.TitleLevel;
	import com.smbc.main.GlobVars;
	import com.smbc.main.LevObj;
	import com.smbc.messageBoxes.GridMenuBox;
	import com.smbc.pickups.BowserAxe;
	import com.smbc.pickups.Pickup;
	import com.smbc.pickups.Vine;
	import com.smbc.projectiles.*;
	import com.smbc.sound.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import nl.stroep.utils.ImageSaver;
	
	public class MarioBase extends Character
	{
		private const DIE_TMR_DEL_NORMAL:int = 3000;
		private const DIE_TMR_DEL_PIT:int = 3000;
		public static const IND_CI_Mario:int = 1;
		public static const IND_CI_MarioFireBall:int = 6;
		public static const IND_CI_MarioFireFlowerNormal:int = 7;
		public static const IND_CI_MarioFireFlowerUnderGround:int = 8;
		public static const IND_CI_MarioStar:int = 9;
		public static const IND_CI_MarioPortrait:int = 4;
		private const REPL_COLOR_1_1:uint = 0xFFD82800;
		private const REPL_COLOR_2_1:uint = 0xFF7B6601; // brown
		private const REPL_COLOR_3_1:uint = 0xFFFC9838;
		private const REPL_COLOR_1_2:uint = REPL_COLOR_1_1;
		private const REPL_COLOR_2_2:uint = REPL_COLOR_2_1;
		private const REPL_COLOR_3_2:uint = REPL_COLOR_3_1;
		private const REPL_COLOR_1_3:uint = 0xFFFCD8A8;
		private const REPL_COLOR_2_3:uint = REPL_COLOR_1_1;
		private const REPL_COLOR_3_3:uint = REPL_COLOR_3_1;
		private static const PAL_COL_NORMAL:int = 1;
		private static const PAL_COL_FIRE_FLOWER:int = 3;
		
		private static const SKIN_APPEARANCE_NUM_SMALL:int = 0;
		private static const SKIN_APPEARANCE_NUM_BIG:int = 1;
		private static const SKIN_APPEARANCE_NUM_FIRE_POWER:int = 2;
		protected static const MARIO_FIRE_FLOWER:String = PickupInfo.MARIO_FIRE_FLOWER;
		private const ANIM_TMR_FOR_FREEZE:CustomTimer = AnimationTimers.ANIM_MIN_FAST_TMR;
		private const ANIM_TMR_FOR_TAKE_DAMAGE:CustomTimer = AnimationTimers.ANIM_MODERATE_TMR;
		private const ANIM_TMR_FOR_JUMP:CustomTimer = AnimationTimers.ANIM_FAST_TMR;
		private const SWIM_ANIM_TMR:CustomTimer = AnimationTimers.ANIM_MODERATE_TMR;
		private var walkAnimTmr1:CustomTimer = AnimationTimers.ANIM_VERY_SLOW_TMR;
		private var walkAnimTmr2:CustomTimer = AnimationTimers.ANIM_SLOW_TMR;
		private var walkAnimTmr3:CustomTimer = AnimationTimers.ANIM_MODERATE_TMR;
		private var runAnimTmr1:CustomTimer = AnimationTimers.ANIM_MIN_FAST_TMR;
		private var runAnimTmr2:CustomTimer = AnimationTimers.ANIM_FAST_TMR;
		public static const SFX_MARIO_FIREBALL:String = SoundNames.SFX_MARIO_FIREBALL;
		public static const SFX_MARIO_JUMP_BIG:String = SoundNames.SFX_MARIO_JUMP_BIG
		public static const SFX_MARIO_JUMP_SMALL:String = SoundNames.SFX_MARIO_JUMP_SMALL;
		public static const SFX_GAME_PIPE:String = SoundNames.SFX_GAME_PIPE;
		public static const SFX_GAME_STOMP:String = SoundNames.SFX_GAME_STOMP;
		public static const MFX_MARIO_DIE:String = SoundNames.MFX_MARIO_DIE;
		public static const MAX_WALK_SPEED:int = 175;
		private const MAX_RUN_SPEED:int = 300;
		private const JUMP_HEIGHT_RUN_SPEED:int = 175;
		private static const NO_DAMAGE_TMR_DEL:int = 2500;
		private const FLAG_POLE_X_OFS:int = 6;
		private const FLAG_POLE_SLIDE_ANIM_TMR:CustomTimer = AnimationTimers.ANIM_MIN_FAST_TMR;
		private const MIN_WALK_SPEED:int = 40; // 40
		private const MAX_FIREBALLS_ON_SCREEN:int = 2;
		private const WALK_TMR_1_MIN_VX:int = 0;
		private const WALK_TMR_2_MIN_VX:int = 50;
		private const WALK_TMR_3_MIN_VX:int = 100;
		private const RUN_TMR_1_MIN_VX:int = MAX_WALK_SPEED - 10;
		private const RUN_TMR_2_MIN_VX:int = 220;
		private const MIN_RUN_OVER_GAP_SPEED:int = RUN_TMR_2_MIN_VX;
		private const BASE_FL_WALK:String = "walk";
		private const BASE_FL_WALK_SHOOT:String = "walkShoot";
		private static const FL_CLIMB_START:String = "climbStart";
		private static const FL_CLIMB_END:String = "climbEnd";
		private static const FL_CROUCH:String = "crouch";
		private static const FL_DIE:String = "die";		
		private static const FL_JUMP_START:String = "jumpStart";
		private static const FL_JUMP_END:String = "jumpEnd";
		private static const FL_FALL_START:String = "fallStart";
		private static const FL_FALL_END:String = "fallEnd";
		private static const FL_GROW_START:String = "growStart";
		private static const FL_GROW_END:String = "growEnd";
		private static const FL_SHOOT:String = "shoot";
		private static const FL_PIPE:String = "pipe";
		private static const FL_PIPE_2:String = "pipe_2";
		private static const FL_SKID:String = "skid";
		private static const FL_STAND:String = "stand";
		private static const FL_STAND_UP:String = "standUp";
		private static const FL_STAND_UP_2:String = "standUp_2";
		private static const FL_TAKE_DAMAGE_START:String = "takeDamageStart";
		private static const FL_TAKE_DAMAGE_END:String = "takeDamageEnd";
		private static const FL_WALK_START:String = "walk-1";
		private static const FL_WALK_END_NES:String = "walk-3";
		private static const FL_WALK_END_NORMAL:String = "walk-4";
		private static const FL_WALK_SHOOT_START:String = "walkShoot-1";
		private static const FL_WALK_SHOOT_END:String = "walkShoot-3";
		private static const FL_WALK_DUR_TEST_FRAME:String = "walk-4_2";
		private static const FL_SMALL_CROUCH_TEST_FRAME:String = FL_CROUCH + "_1";
		private static const FL_FALL_TEST_FRAME:String = FL_FALL_START+"_2";
		private static const ST_SKID:String = "skid";
		private var hitMainAnimTmr:CustomTimer;
		private var singleFirePowerFrame:Boolean;
//		private static const FX_WALK:Number = .02;
//		private static const FX_RUN_CROUCH:Number = .02;
		private static const FX_RUN_TO_WALK:Number = .02;
		private var fxSkid:Number;
		private static const FX_DUNGEON_GOT_AXE:Number = .0001;
		private static const AX_PIT_VACUUM_SLOW_SPEED:int = 700;
		private static const AX_PIT_VACUUM:int = 575;
		private var jumpPwrDef:Number;
		private var jumpPwrRun:Number;
		public static const JUMP_PWR:int = 630; //630
		private const JUMP_PWR_RUN:int = 700;
		private const JUMP_PWR_WATER:int = 200;
		public static const GRAVITY_NAME:String = "GRAVITY";
		private var skidThreshold:int;
		private var paddleFastSpeed:Number = 100;
		private const DIE_BOOST:int = 500;
		private const DIE_GRAVITY:int = 1200;
		private const DIE_VY_MAX_PSV:int = 540;
		private var dieFreezeTmr:CustomTimer;
		private const DIE_FREEZE_TMR_DUR:int = 250;
		private const CLIMB_OFFSET_X:int = 0;
		private const SHOOT_TMR:CustomTimer = new CustomTimer(75,1);
		private var shoot:Boolean;
		private var justCrouched:Boolean;
		private const SECONDS_LEFT_DUNGEON:String = SoundNames.BGM_MARIO_DUNGEON_FAST;
		private const SECONDS_LEFT_OVER_WORLD:String = SoundNames.BGM_MARIO_OVER_WORLD_FAST;
		private const SECONDS_LEFT_UNDER_GROUND:String = SoundNames.BGM_MARIO_UNDER_GROUND_FAST;
		private const SECONDS_LEFT_WATER:String = SoundNames.BGM_MARIO_WATER_FAST;
		private const SND_MUSIC_WIN:String = SoundNames.MFX_MARIO_WIN;
		private const SND_MUSIC_WIN_DUNGEON:String = SoundNames.MFX_MARIO_WIN_CASTLE;
		private const NSF_STR_DIE:String = MusicInfo.CHAR_STR_MARIO + MusicInfo.TYPE_DIE;
		private var useEnterPipeVxMax:Boolean;
		private const BLOOPA_NO_HURT_Y:int = Level.GLOB_STG_BOT - Level.levelInstance.TILE_SIZE*2;
		private var frameBmd:BitmapData = new BitmapData(50,50);
		private var frameBmp:Bitmap = new Bitmap(frameBmd);
		private var bmdArr:Vector.<BitmapData> = new Vector.<BitmapData>();
		private var jumpRise:Boolean;
		private var jumpEnd:Number;
		private var jumpEndMin:Number;
		private var fxWalk:Number;
		
		private static const JUMP_SPEED_NORMAL_NAME:String = "JUMP_SPEED_NORMAL";
		private static const JUMP_SPEED_RUN_NAME:String = "JUMP_SPEED_RUN";
		private static const JUMP_HEIGHT_MIN_NAME:String = "JUMP_HEIGHT_MIN";
		private static const JUMP_HEIGHT_NORMAL_STR:String = "JUMP_HEIGHT_NORMAL";
		private static const JUMP_HEIGHT_RUN_STR:String = "JUMP_HEIGHT_RUN";
		private static const VY_MAX_PSV_NORMAL_NAME:String = "VY_MAX_PSV_NORMAL";
		private static const AX_DEFAULT_NAME:String = "AX_DEFAULT";
		private static const AX_RUN_NAME:String = "AX_RUN";
		private static const FX_SKID_NAME:String = "FX_SKID";
		private static const FX_WALK_NAME:String = "FX_WALK";
		private static const FX_RUN_CROUCH_NAME:String = "FX_RUN_CROUCH";
		private static const FY_NAME:String = "FY";
		private static const SKID_THRESHOLD_NAME:String = "SKID_THRESHOLD";
		private static const FEATHER_NAME:String = "featherStg";
		private static const FEATHER_FRAMES_SHOW_ARR:Array = [
			"stand_2", "standUp_2", "pipe_2", "walk-1_2", "walk-2_2", "walk-3_2", "walkShoot-1_2", "walkShoot-2_2", "walkShoot-3_2", "jumpStart_2","jumpEnd_2",
			"skid_2", "shoot_2", "swimStillStart_2","swimStillEnd_2","paddleFastStart_2","paddleFast-2_2","paddleFast-3_2","paddleFast-4_2",
			"paddleFast-5_2","paddleFast-6_2","paddleFast-7_2","paddleFastEnd_2","paddleSlowStart_2","paddleSlow-2_2","paddleSlow-3_2",
			"paddleSlow-4_2","paddleSlow-5_2","paddleSlow-6_2","paddleSlow-7_2","paddleSlow-8_2","paddleSlow-9_2","paddleSlowEnd_2",
			"climbStart_2","climbEnd_2"
		];
		protected var appearanceNum:int;
		protected static const APPEARANCE_NUM_SMALL:int = 1,
			APPEARANCE_NUM_BIG:int = 2;
		private var appearancePossibilities:String;
		private static const AP_BIG_ONLY:String = "bigOnly",
			AP_SMALL_ONLY:String = "smallOnly",
			AP_BIG_AND_SMALL:String = "bigAndSmall";
		
		private var hasFallFrame:Boolean;
		private var hasSmallCrouchFrame:Boolean;
		
		protected static const SKIN_PREVIEW_SIZE_BIG:Point = new Point(26,36);
		protected static const SKIN_PREVIEW_SIZE_SMALL:Point = new Point(26,26);
		
		public function MarioBase()
		{
			_dieTmrDel = DIE_TMR_DEL_NORMAL;
			recolorsCharSkin = true;
			super();
			_isGoodSwimmer = true;
			bmdArr.push(frameBmd);
			walkStartLab = FL_WALK_START;
//			walkEndLab = FL_WALK_END_NORMAL;
			for each (var ct:CustomTimer in level.ALL_ANIM_TMRS_DCT)
			{
				ACTIVE_ANIM_TMRS_DCT.addItem(ct);
			}
			/*var bgt:int = level.bgmType;
			if (bgt == MusicType.DUNGEON)
				_secondsLeftSnd = SECONDS_LEFT_DUNGEON;
			else if (bgt == MusicType.OVER_WORLD)
				_secondsLeftSnd = SECONDS_LEFT_OVER_WORLD;
			else if (bgt == MusicType.UNDER_GROUND)
				_secondsLeftSnd = SECONDS_LEFT_UNDER_GROUND;
			else if (bgt == MusicType.WATER)
				_secondsLeftSnd = SECONDS_LEFT_WATER;*/
			_secondsLeftSndIsBgm = true;
			if (level.levNum != STAT_MNGR.DUNGEON_LEVEL_NUM)
				_sndWinMusic = SND_MUSIC_WIN;
			else
				_sndWinMusic = SND_MUSIC_WIN_DUNGEON;
		}
		override protected function setObjsToRemoveFromFrames():void
		{
			super.setObjsToRemoveFromFrames();
			removeObjsFromFrames(FEATHER_NAME,FEATHER_FRAMES_SHOW_ARR,true );
		}
		override public function setStats():void
		{
			inColor1_1 = REPL_COLOR_1_1;
			inColor2_1 = REPL_COLOR_2_1;
			inColor3_1 = REPL_COLOR_3_1;
			inColor1_2 = REPL_COLOR_1_2;
			inColor2_2 = REPL_COLOR_2_2;
			inColor3_2 = REPL_COLOR_3_2;
			inColor1_3 = REPL_COLOR_1_3;
			inColor2_3 = REPL_COLOR_2_3;
			inColor3_3 = REPL_COLOR_3_3;
			fxWalk = classObj[FX_WALK_NAME];
			if (level.waterLevel)
				jumpPwr = JUMP_PWR_WATER;
			else 
				jumpPwr = JUMP_PWR;
			jumpPwrDef = jumpPwr;
			jumpPwrRun = JUMP_PWR_RUN;
			gravity = classObj[GRAVITY_NAME];
			walksSlowUnderWater = true;
			if (level.waterLevel)
			{
				defGravity = 700;
				gravity = 350;
				defGravityWater = gravity;
			}
			defSpringPwr = 400;
			boostSpringPwr = 950;
			ax = classObj[AX_DEFAULT_NAME];
			fx = fxWalk;
			fy = classObj[FY_NAME];
			fxSkid = classObj[FX_SKID_NAME];
			vxMaxDef = MAX_WALK_SPEED;
			if (level.waterLevel)
				vyMaxPsv = 400;
			else
				vyMaxPsv = classObj[VY_MAX_PSV_NORMAL_NAME];
			vxMax = vxMaxDef;
			vyMaxNgv = 4000;
//			vxMin = 5;
			numParFrames = 4;
			skidThreshold = classObj[SKID_THRESHOLD_NAME];
			super.setStats();
			_canStomp = true;
			canStompUnderWater = false;
			setStopFrame(FL_STAND);
			changeBrickState();
			SHOOT_TMR.addEventListener(TimerEvent.TIMER_COMPLETE,shootTmrHandler,false,0,true);
			addTmr(SHOOT_TMR);
			noDamageTmr.delay = NO_DAMAGE_TMR_DEL;
		}
		override protected function startAndDamageFcts(start:Boolean = false):void
		{
			super.startAndDamageFcts(start);
			if (!start)
				changeAppearance();
		}
		override public function changedToThisChar():void
		{
			super.changedToThisChar();
			setStopFrame(FL_STAND);
		}
		override public function forceWaterStats():void
		{
			defGravity = 700;
			gravity = 350;
			defGravityWater = gravity;
			vyMaxPsv = 400;
			jumpPwr = 200;
			jumpPwrDef = jumpPwr;
			super.forceWaterStats();
			if (!onGround)
				setPlayFrame("swimStillStart");
		}
		
		override public function convLab(_fLab:String):String
		{
			return _fLab + "_" +appearanceNum.toString();
		}
		protected function changeAppearance(forceAppearanceNum:int = -1, forcePalCol:int = -1):void
		{
			var palCol:int;
			if ( upgradeIsActive(MARIO_FIRE_FLOWER) )
			{
				palCol = PAL_COL_FIRE_FLOWER;
				appearanceNum = APPEARANCE_NUM_BIG;
			}
			else if ( upgradeIsActive(MUSHROOM) )
			{
				palCol = PAL_COL_NORMAL;
				appearanceNum = APPEARANCE_NUM_BIG;
			}
			else
			{
				palCol = PAL_COL_NORMAL;
				appearanceNum = APPEARANCE_NUM_SMALL;
			}
			
			if (forceAppearanceNum >= 0)
				appearanceNum = forceAppearanceNum;
			if (forcePalCol >= 0)
				palCol = forcePalCol;
			
			// for skins that have only big or only small
			if (appearancePossibilities == AP_SMALL_ONLY)
				appearanceNum = APPEARANCE_NUM_SMALL;
			else if (appearancePossibilities == AP_BIG_ONLY)
				appearanceNum = APPEARANCE_NUM_BIG;
			
//			if (GridMenuBox.instance != null)
//			{
//				appearanceNum = APPEARANCE_NUM_BIG
//				graphicsMngr.recolorCharacterSheet(charNum,PAL_COL_NORMAL,[IND_CI_Mario]);
//			}
//			else
				graphicsMngr.recolorCharacterSheet(charNum,palCol,[IND_CI_Mario,IND_CI_MarioPortrait]);
			defColors = paletteMain.extractRowsAsPalette(0,palCol);
			if (skinNum == 2 || skinNum == 12 || skinNum == 14)
			{
				var show:Boolean;
				if (upgradeIsActive(MARIO_FIRE_FLOWER) && forceAppearanceNum == -1)
					show = true;
				removeObjsFromFrames(FEATHER_NAME,FEATHER_FRAMES_SHOW_ARR, false, int(show) );
			}
		}
		
		
		override public function forceNonwaterStats():void
		{
			gravity = 1400;
			vyMaxPsv = classObj[VY_MAX_PSV_NORMAL_NAME];
			jumpPwr = 630;
			jumpPwrDef = jumpPwr;
			_canStomp = true;
			super.forceNonwaterStats();
		}
		
		override public function hitPickup(pickup:Pickup,showAnimation:Boolean = true):void
		{
			var hasFireFlower:Boolean = upgradeIsActive(MARIO_FIRE_FLOWER);
			if (pickup.type == MARIO_FIRE_FLOWER && !upgradeIsActive(MUSHROOM) )
				pickup.type = MUSHROOM;
			super.hitPickup(pickup,showAnimation);
			switch(pickup.type)
			{
				case MUSHROOM:
				{
					changeAppearance();
					break;
				}
				case MARIO_FIRE_FLOWER:
				{
					if ( !upgradeIsActive(MUSHROOM) )
						hitPickup( new Pickup(MUSHROOM) );
					else if (!hasFireFlower)
					{
						super.getMushroom();
						changeAppearance();
					}
					break;
				}
				case PickupInfo.STAR:
				{
					/*if (ImageSaver.INSTANCE.recording)
					{
						ImageSaver.INSTANCE.store(game);
						GameSettings.changeMapPalette(0);
						graphicsMngr.changeCharacterSkin(this,2);
//						level.toggleScreenScroll();
						ImageSaver.INSTANCE.store(game);
					}*/
					break;
				}
			}
		}
		
		
		override protected function movePlayer():void 
		{
			
			if (rhtBtn && !lftBtn && !wallOnRight && cState != ST_CROUCH) 
			{
				if (justCrouched)
				{
					justCrouched = false;
					return;
				}	
				if (cState == ST_VINE)
				{
					if (exitVine)
						getOffVine();
					else
						return;
				}
				vx += ax*dt;
				if (onGround)
				{
					scaleX = 1;
					if (vx < 0)
						vx *= Math.pow(fxSkid,dt);
				}
				else if (level.waterLevel)
					scaleX = 1;
			}
			else if (lftBtn && !rhtBtn && !wallOnLeft && cState != ST_CROUCH) 
			{
				if (justCrouched)
				{
					justCrouched = false;
					return;
				}	
				if (cState == ST_VINE)
				{
					if (exitVine)
						getOffVine();
					else
						return;
				}
				vx -= ax*dt;
				if (onGround)
				{
					scaleX = -1;
					if (vx > 0)
						vx *= Math.pow(fxSkid,dt);
				}
				else if (level.waterLevel)
					scaleX = -1;
			}
			else if (cState == ST_SKID)
				vx *= Math.pow(fxSkid,dt);
			else if (cState == ST_CROUCH || atkBtn && ( (lftBtn && rhtBtn) || (!lftBtn && !rhtBtn && onGround) ) )
			{
				vx *= Math.pow(classObj[FX_RUN_CROUCH_NAME],dt);
				if ( (vx > 0 && vx < MIN_WALK_SPEED) || (vx < 0 && vx > -MIN_WALK_SPEED) )
					vx = 0;
			}
			else if ( (lftBtn && rhtBtn) || (!lftBtn && !rhtBtn && onGround) )
			{
				vx *= Math.pow(fxWalk,dt);
				if ( (vx > 0 && vx < MIN_WALK_SPEED) || (vx < 0 && vx > -MIN_WALK_SPEED) )
					vx = 0;
			}
			if (atkBtn && !level.waterLevel && currentFrameLabel != convLab(FL_CROUCH))
			{
				vxMax = MAX_RUN_SPEED;
			}
			if (vx > vxMax)
				vx = vxMax;
			if (vx < -vxMax)
				vx = -vxMax;
			if (!atkBtn)
			{
				if (vx > vxMaxDef || vx < -vxMaxDef)
				{
					if (rhtBtn || lftBtn)
						vx *= Math.pow(FX_RUN_TO_WALK,dt);
				}
				else
					vxMax = vxMaxDef;
			}
			if (onGround)
			{
				if (vx > 0)
				{
					if (vx >= WALK_TMR_1_MIN_VX && vx <= WALK_TMR_2_MIN_VX)
						mainAnimTmr = walkAnimTmr1;
					else if (vx > WALK_TMR_2_MIN_VX && vx <= WALK_TMR_3_MIN_VX)
						mainAnimTmr = walkAnimTmr2;
					else if (vx > WALK_TMR_3_MIN_VX && vx <= RUN_TMR_1_MIN_VX)
						mainAnimTmr = walkAnimTmr3;
					else if (vx > RUN_TMR_1_MIN_VX && vx <= RUN_TMR_2_MIN_VX)
						mainAnimTmr = runAnimTmr1;
					else
						mainAnimTmr = runAnimTmr2;
				}
				else
				{
					if (vx <= WALK_TMR_1_MIN_VX && vx >= -WALK_TMR_2_MIN_VX)
						mainAnimTmr = walkAnimTmr1;
					else if (vx < -WALK_TMR_2_MIN_VX && vx >= -WALK_TMR_3_MIN_VX)
						mainAnimTmr = walkAnimTmr2;
					else if (vx < -WALK_TMR_3_MIN_VX && vx >= -RUN_TMR_1_MIN_VX)
						mainAnimTmr = walkAnimTmr3;
					else if (vx < -RUN_TMR_1_MIN_VX && vx >= -RUN_TMR_2_MIN_VX)
						mainAnimTmr = runAnimTmr1;
					else
						mainAnimTmr = runAnimTmr2;
				}
				if (mainAnimTmr == runAnimTmr2)
					canCrossSmallGaps = true;
				else
					canCrossSmallGaps = false;
			}
			else if (!level.waterLevel)
				if (this is Mario && skinNum == 5)
					mainAnimTmr = ANIM_VERY_SLOW_TMR;
				else
					mainAnimTmr = ANIM_TMR_FOR_JUMP;
			else
				mainAnimTmr = SWIM_ANIM_TMR;
			if (cState == ST_VINE || cState == ST_FLAG_SLIDE)
			{
				if (vy == 0)
					stopAnim = true;
				else
					stopAnim = false;
				mainAnimTmr = vineAnimTmr;
			}
			if (useEnterPipeVxMax)
				vxMax = ENTER_PIPE_VX_MAX;
			if (onGround && vx == 0 && cState != ST_CROUCH)
			{
				if (rhtBtn && wallOnRight)
					scaleX = 1;
				else if (lftBtn && wallOnLeft)
					scaleX = -1;
			}
			
		}
		override public function activateWatchModeEnterPipe():void
		{
			super.activateWatchModeEnterPipe();
			useEnterPipeVxMax = true;
			
		}
		public function getRealBounds(displayObject:DisplayObject):Rectangle
		{
			var bounds:Rectangle;
			var boundsDispO:Rectangle = displayObject.getBounds( displayObject );
			
			var bitmapData:BitmapData = new BitmapData( int( boundsDispO.width + 0.5 ), int( boundsDispO.height + 0.5 ), true, 0 );
			
			var matrix:Matrix = new Matrix();
			matrix.translate( -boundsDispO.x, -boundsDispO.y);
			
			bitmapData.draw( displayObject, matrix, new ColorTransform( 1, 1, 1, 1, 255, -255, -255, 255 ) );
			
			bounds = bitmapData.getColorBoundsRect( 0xFF000000, 0xFF000000 );
			bounds.x += boundsDispO.x;
			bounds.y += boundsDispO.y;
			
			bitmapData.dispose();
			return bounds;
		}
		
		
		// CHECKSTATE
		override protected function checkState():void
		{
			if (cState == ST_VINE)
			{
				checkVineBtns();
				checkVinePosition();
				return;
			}
			else if (cState == ST_DIE)
				return;
			if (onGround)
			{
				if (atkBtn)
					ax = classObj[AX_RUN_NAME];
				else
					ax = classObj[AX_DEFAULT_NAME];
				jumped = false;
				if (vx == 0 && !lftBtn && !rhtBtn && (!canCrouch() || (canCrouch() && !dwnBtn)))
				{
					setState(ST_STAND);
					if (!upgradeIsActive(MARIO_FIRE_FLOWER) || !shoot)
					{
						if (!upBtn)
							setStopFrame(FL_STAND);
						else
							setStopFrame(FL_STAND_UP);
					}
					else
						setStopFrame(FL_SHOOT);
				}
				else if (canCrouch() && dwnBtn)
				{
					setState(ST_CROUCH);
					justCrouched = true;
					setStopFrame(FL_CROUCH);
				}
				else if (vx > skidThreshold && lftBtn)
				{
					setState(ST_SKID);
					setStopFrame(FL_SKID);
				}
				else if (vx < -skidThreshold && rhtBtn)
				{
					setState(ST_SKID);
					setStopFrame(FL_SKID);
				}
				else if (cState == ST_SKID && vx >= 0 && lftBtn)
					setStopFrame(FL_SKID);
				else if (cState == ST_SKID && vx <= 0 && rhtBtn)
					setStopFrame(FL_SKID);
				else if ((pulledLeft && !rhtBtn && !lftBtn) || (pulledRight && !lftBtn && !rhtBtn))
				{
					setState(ST_STAND);
					setStopFrame(FL_STAND);
				}
				else if (upgradeIsActive(MARIO_FIRE_FLOWER) && cState == ST_WALK)
				{
					if (!shoot)
						setPlayFrame(getParFrame(BASE_FL_WALK))
					else if (!singleFirePowerFrame)
						setPlayFrame(getParFrame(BASE_FL_WALK_SHOOT));
				}
				else if (cState != ST_WALK)
				{
					if (!upgradeIsActive(MARIO_FIRE_FLOWER) )
						setPlayFrame(FL_WALK_START);
					else if (!shoot)
						setPlayFrame(FL_WALK_START);
					else if (!singleFirePowerFrame)
						setPlayFrame(FL_WALK_SHOOT_START);
					setState(ST_WALK);
				}
			}
			else // not onGround
			{
				if (level.waterLevel)
				{
					if (cState != "paddle" && cState != "jump")
					{
						setPlayFrame("swimStillStart");
						setState(ST_JUMP);
					}
					if (pulledLeft || pulledRight)
					{
						if ( (vx > 0 && vx < 60) || (vx < 0 && vx > -60) )
							ax = AX_PIT_VACUUM_SLOW_SPEED;
						else
							ax = AX_PIT_VACUUM;
					}
					else
						ax = classObj[AX_DEFAULT_NAME];
				}
				else // not underwater && not on ground
				{
					setState(ST_JUMP);
					
					if (!jumped && !hasFallFrame)
						stopAnim = true;
					if (jumpRise)
					{
						if (ny <= jumpEnd)
						{
							ny = jumpEnd;
							setJumpRise(false);
						}
						else if (releasedJumpBtn && ny <= jumpEndMin)
						{
							ny = jumpEndMin;
							setJumpRise(false);
						}
						
					}
					var cl:String = currentLabel;
					if (cl == convLab(FL_STAND) || cl == convLab(FL_CLIMB_START) || cl == convLab(FL_CLIMB_END))
						setPlayFrame(FL_JUMP_START);
					else if (cl == convLab(FL_SKID))
						setStopFrame(walkEndLab);
					if (frictionY)
					{
						if (vy < 0)
							vy *= Math.pow(fy,dt);
						else
							frictionY = false;
					}
					if (hasFallFrame && vy >= 0 && cl != convLab(FL_FALL_START) && cl != convLab(FL_FALL_END) && cl != convLab(FL_CROUCH) && !shoot)
						setPlayFrame(FL_FALL_START);
				}
			}
			if (stuckInWall && !disableStuckInWallShift && jumpRise)
				setJumpRise(false);
		}
		
		private function canCrouch():Boolean
		{
			if (hasSmallCrouchFrame || upgradeIsActive(MUSHROOM))
				return true;
			return false;
		}
		override public function gravityPull():void
		{
			if (lastOnGround && !onGround && !jumped && (vx > -MIN_RUN_OVER_GAP_SPEED && vx < MIN_RUN_OVER_GAP_SPEED ) )
			{
				FALL_BTWN_TMR.reset();
				FALL_BTWN_TMR.start();
				_fallBtwn = true;
			}
//			trace("gravity pull");
			originalGravityPull();
		}
		
		override protected function originalGravityPull():void
		{
//			trace("original gravity pull");
			super.originalGravityPull();
//			trace("vy: "+vy);
			/*if (vy < -50)
			{
				vy -= 800*dt;
			}*/
		}
		// JUMP
		override protected function jump():void
		{
			onGround = false;
			if (!level.waterLevel)
			{
				if (Math.abs(vx) >= JUMP_HEIGHT_RUN_SPEED) //Adjusted to allow Mario to jump higher sooner, for accuracy and ability to pass levels (JUMP_HEIGHT_RUN_SPEED = MAX_RUN_SPEED * 0.63)
				{
					jumpEnd = ny - classObj[JUMP_HEIGHT_RUN_STR];
					vy = -classObj[JUMP_SPEED_RUN_NAME];
				}
				else
				{
					jumpEnd = ny - classObj[JUMP_HEIGHT_NORMAL_STR];
					vy = -classObj[JUMP_SPEED_NORMAL_NAME];
				}
				jumpEndMin = ny - classObj[JUMP_HEIGHT_MIN_NAME];
				setJumpRise(true);
			}
			else
				vy = -jumpPwr;
			jumped = true;
			releasedJumpBtn = false;
			frictionY = false;
			if (!level.waterLevel)
			{
				if (!upgradeIsActive(MUSHROOM))
				{
					if (dwnBtn && hasSmallCrouchFrame)
						setStopFrame(FL_CROUCH)
					else
						setPlayFrame(FL_JUMP_START);
					SND_MNGR.playSound(SFX_MARIO_JUMP_SMALL);
				}
				else
				{
					if (dwnBtn)
						setStopFrame(FL_CROUCH)
					else
					{
						setPlayFrame(FL_JUMP_START);
						mainAnimTmr = ANIM_TMR_FOR_JUMP;
					}
					SND_MNGR.playSound(SFX_MARIO_JUMP_BIG);
				}
				setHitPoints();
			}
			else // if (level.waterLevel)
			{
				SND_MNGR.playSound(SFX_GAME_STOMP);
				if (vx > paddleFastSpeed || vx < -paddleFastSpeed)
					setPlayFrame("paddleFastStart");
				else
					setPlayFrame("paddleSlowStart");
				setState("paddle");
			}
		}
		// RELJUMPBTN
		override public function relJmpBtn():void
		{
			super.relJmpBtn();
			if (!releasedJumpBtn) 
			{
				//vyMaxNgv = Math.abs(vy);
				releasedJumpBtn = true;
				if (ny <= jumpEndMin)
				{
					frictionY = true;
					setJumpRise(false);
				}
			}
		}
		
		private function get fireBallsOnScreenCount():int
		{
			var fireBallCount:int = 0;
			for each(var projectile:Projectile in level.PLAYER_PROJ_DCT)
			{
				if (projectile is MarioFireBall)
					fireBallCount++;
			}
			return fireBallCount;
		}
		
		override public function pressAtkBtn():void
		{
			if (cState == ST_VINE)
				return;
			super.pressAtkBtn();
			if (upgradeIsActive(MARIO_FIRE_FLOWER) && fireBallsOnScreenCount < MAX_FIREBALLS_ON_SCREEN && currentFrameLabel != convLab(FL_CROUCH))
			{
				level.addToLevel(new MarioFireBall(this));
				if (SHOOT_TMR.running)
					SHOOT_TMR.reset();
				SHOOT_TMR.start();
				shoot = true;
				var cl:String = currentLabel;
				hitFrameLabel = cl.substring(0,cl.length-2);
				if (singleFirePowerFrame)
					setStopFrame(FL_SHOOT);
				else if (!onGround)
					setStopFrame(FL_SHOOT);
				else
					checkState();
				
			}
		}
		override public function pressSpcBtn():void
		{
			if (cState == ST_VINE)
				return;
			super.pressSpcBtn();
//			if (GameSettings.DEBUG_MODE)
//			{
//				pressRhtBtn();
//				pressAtkBtn();
//				vx = vxMax;
//			}
		}
		private function shootTmrHandler(e:TimerEvent):void
		{
			SHOOT_TMR.reset();
			if (shoot)
			{
				shoot = false;
				if (singleFirePowerFrame && cState == ST_WALK)
				{
					setPlayFrame(FL_WALK_START);
					return;
				}
				if (onGround)
					checkState();
				else if (!level.waterLevel)
				{
					if (jumped)
						setPlayFrame(FL_JUMP_START);
					else
						setStopFrame(hitFrameLabel);
				}
				else
					setPlayFrame(hitFrameLabel);
			}
		}
		override protected function getMushroom():void
		{
			if (GS_MNGR.gameState == GameStates.CHARACTER_SELECT)
				return;
//			setStopFrame(FL_JUMP);
//			if (pState > 1)
//				super.getMushroom();
//			else
//			{
				var cl:String = currentLabel;
				hitFrameLabel = cl.substring(0,cl.length-2);
				hitStopAnim = stopAnim;
				hitMainAnimTmr = mainAnimTmr;
				setState(ST_GET_MUSHROOM);
				mainAnimTmr = ANIM_TMR_FOR_FREEZE;
				gotoAndStop(FL_GROW_START);
				stopAnim = false;
				freezeGame();
//			}
		}
		// MegaMan overrides this function and does not call super
		override protected function getMushroomEnd():void
		{
//			if (pState != 1)
//				super.getMushroomEnd();
//			else
//			{
//				pState++;
			if (!upgradeIsActive(MARIO_FIRE_FLOWER))
			{
				setStopFrame(hitFrameLabel);
				mainAnimTmr = hitMainAnimTmr;
				stopAnim = hitStopAnim;
				setState(ST_NEUTRAL);
				checkState();
			}
			else
				super.getMushroomEnd();
			shoot = false;
			changeBrickState();
		}
		override protected function changeBrickState():void
		{
			if (!upgradeIsActive(MUSHROOM))
				brickState = BRICK_BOUNCER;
			else
				brickState = BRICK_BREAKER;
		}
		override protected function takeDamageStart(source:LevObj):void
		{
			super.takeDamageStart(source);
			SND_MNGR.playSound(SFX_GAME_PIPE);
			freezeGame();
			STAT_MNGR.removeCharUpgrade(charNum,MARIO_FIRE_FLOWER);
			setDamageInfoArr();
			setState(ST_TAKE_DAMAGE);
			lockState = true;
			hitAnimation();
			alpha = TD_ALPHA;

			if ( GameSettings.classicMode && GameSettings.classicDamageResponse == ClassicDamageResponse.LoseCurrent && upgradeIsActive(MUSHROOM) )
			{
				lockFrame = true;
				stopAnim = true;
				startReplaceColor();
			}
			else
			{
				lockFrame = false;
				mainAnimTmr = ANIM_TMR_FOR_TAKE_DAMAGE;
				gotoAndStop(FL_TAKE_DAMAGE_START);
				stopAnim = false;
			}
		}
		
		override protected function hitAnimation():void
		{
			
		}
		
		
		override protected function swapPs():void
		{
			if (cState == ST_TAKE_DAMAGE && nPState == PS_NORMAL)
				return;
			super.swapPs();
		}
		
		
		override protected function takeDamageEnd():void
		{
			super.takeDamageEnd();
			if (!starPwr)
				endReplaceColor();
			if (nPState != 1)
				return;
			shoot = false;
			checkFrame();
		}
		override public function hitEnemy(enemy:Enemy,side:String):void
		{
			if (enemy is Bloopa && ny == BLOOPA_NO_HURT_Y && onGround)
				return;
			super.hitEnemy(enemy,side);
		}
		override protected function enterPipeVert():void
		{
			super.enterPipeVert();
//			if (canCrouch())
				setStopFrame(FL_PIPE);
		}
		override public function groundAbove(g:Ground):void
		{
			setJumpRise(false);
			if (cState == ST_CROUCH)
				hitCeiling = true;
			else
				super.groundAbove(g);			
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
				/*else
				{
					vyMax = VY_MAX_WATER;
					if (!jmpBtn)
						vxMax = VX_MAX_WATER_NORMAL;
					else
						vxMax = VX_MAX_WATER_BOOST;
				}*/
			}
			else if (!jumpRise && value) // activate
			{
				defyGrav = true;
				lastOnGround = false;
				frictionY = false;
			}
			jumpRise = value;
		}
		
		private function determineAppearancePossibilities():void
		{
			appearancePossibilities = AP_BIG_AND_SMALL;
			
//			if (this is Mario)
//			{
//				if (skinNum == Mario.SKIN_MARIO_SMB2_NES)
//					appearancePossibilities = AP_BIG_ONLY;
//				else if (skinNum == Mario.SKIN_MARIO_SMAS_SNES)
//					appearancePossibilities = AP_SMALL_ONLY;
//			}
//			else if (this is Luigi)
//			{
//				
//			}
			
		}
		override public function setCurrentBmdSkin(bmc:BmdSkinCont, characterInitiating:Boolean = false):void
		{
			super.setCurrentBmdSkin(bmc);
			determineAppearancePossibilities();
			var stopAnimTemp:Boolean = stopAnim;
			changeAppearance();
//			var cf:int = currentFrame;
//			gotoAndStop(FL_WALK_DUR_TEST_FRAME);
//			gotoAndStop(cf);
//			removeObjsFromFrames(FEATHER_NAME, [ FL_WALK_DUR_TEST_FRAME ], false, int(false) );
			if ( frameIsEmpty(FL_WALK_DUR_TEST_FRAME) )
			{
				walkEndLab = FL_WALK_END_NES;
			}
			else
				walkEndLab = FL_WALK_END_NORMAL;
			if (bmc.skinNum == 0)
				singleFirePowerFrame = false;
			else
 			{
				singleFirePowerFrame = true;
				if (upgradeIsActive(MARIO_FIRE_FLOWER) && shoot)
					setStopFrame(FL_SHOOT);
			}
			if (cState == ST_WALK && !shoot)
				setPlayFrame(FL_WALK_START);
			stopAnim = stopAnimTemp;
			if (!frameIsEmpty(FL_FALL_TEST_FRAME))
				hasFallFrame = true;
			else
			{
				hasFallFrame = false;
				var cl:String = currentLabel;
				if (cl == convLab(FL_FALL_START) || cl == convLab(FL_FALL_END))
					setStopFrame(walkStartLab);
			}
			if (!frameIsEmpty(FL_SMALL_CROUCH_TEST_FRAME))
				hasSmallCrouchFrame = true;
			else
			{
				hasSmallCrouchFrame = false;
				if (cl == convLab(FL_SMALL_CROUCH_TEST_FRAME))
					setStopFrame(FL_STAND);
			}
//			if (this is Luigi && (skinNum == 4 || skinNum == 5))
			if (skinNum == 4 || skinNum == 5)
			{
				walkAnimTmr1 = AnimationTimers.ANIM_VERY_SLOW_TMR;
				walkAnimTmr2 = AnimationTimers.ANIM_SLOW_TMR;
				walkAnimTmr3 = AnimationTimers.ANIM_SLOW_TMR;
				runAnimTmr1 = AnimationTimers.ANIM_MODERATE_TMR;
				runAnimTmr2 = AnimationTimers.ANIM_MIN_FAST_TMR;
			}
			else
			{
				walkAnimTmr1 = AnimationTimers.ANIM_VERY_SLOW_TMR;
				walkAnimTmr2 = AnimationTimers.ANIM_SLOW_TMR;
				walkAnimTmr3 = AnimationTimers.ANIM_MODERATE_TMR;
				runAnimTmr1 = AnimationTimers.ANIM_MIN_FAST_TMR;
				runAnimTmr2 = AnimationTimers.ANIM_FAST_TMR;
			}
			checkState();
		}
		
		override protected function playDefaultPickupSoundEffect():void
		{
			SND_MNGR.playSound(SoundNames.SFX_GAME_POWER_UP);
		}
		
		override protected function prepareDrawCharacter(skinAppearanceState:int = -1):void
		{
//			skinAppearanceState = SKIN_APPEARANCE_NUM_FIRE_POWER;
//			trace("mario luigi skin: "+skinAppearanceState);
			switch (skinAppearanceState)
			{
				case SKIN_APPEARANCE_NUM_SMALL:
				{
					changeAppearance(APPEARANCE_NUM_SMALL, PAL_COL_NORMAL);
					break;
				}
				case SKIN_APPEARANCE_NUM_BIG:
				{
					changeAppearance(APPEARANCE_NUM_BIG, PAL_COL_NORMAL);
					break;
				}
				case SKIN_APPEARANCE_NUM_FIRE_POWER:	
				{
					changeAppearance(APPEARANCE_NUM_BIG, PAL_COL_FIRE_FLOWER);
					break;
				}
				default:
				{
					changeAppearance();
				}
			}
			drawFrameLabel = convLab(FL_STAND);
			super.prepareDrawCharacter(skinAppearanceState);
		}
		override protected function initiateNormalDeath(source:LevObj = null):void
		{
			super.initiateNormalDeath(source);
			SND_MNGR.changeMusic(MusicType.DIE);
			setJumpRise(false);
			stopAnim = true;
			stopHit = true;
			stopUpdate = true;
			changeAppearance(APPEARANCE_NUM_SMALL, PAL_COL_NORMAL);
			setStopFrame("die");
			lockFrame = true;
			onGround = false;
			gravity = DIE_GRAVITY;
			dieFreezeTmr = new CustomTimer(DIE_FREEZE_TMR_DUR,1);
			addTmr(dieFreezeTmr);
			dieFreezeTmr.addEventListener(TimerEvent.TIMER_COMPLETE,dieFreezeTmrLsr,false,0,true);
			dieFreezeTmr.start();
		}
		override protected function initiatePitDeath():void
		{
			_dieTmrDel = DIE_TMR_DEL_PIT;
			super.initiatePitDeath();
			SND_MNGR.changeMusic( MusicType.DIE );
		}
		override public function slideDownFlagPole():void
		{
			super.slideDownFlagPole();
			shoot = false;
			setPlayFrame("climbStart");
			nx = level.flagPole.hMidX;
			mainAnimTmr = FLAG_POLE_SLIDE_ANIM_TMR;
		}
		override public function stopFlagPoleSlide():void
		{
			super.stopFlagPoleSlide();
			scaleX = -scaleX;
			setStopFrame("climbStart");
			lockFrame = true;
		}
		override public function getAxe(axe:BowserAxe):void
		{
			super.getAxe(axe);
			if (level.levNum == STAT_MNGR.DUNGEON_LEVEL_NUM)
				fxWalk = FX_DUNGEON_GOT_AXE;
		}
		override protected function getOnVine(_vine:Vine):void
		{
			var right:Boolean;
			if (nx > _vine.hMidX)
				right = true;
			super.getOnVine(_vine);
			if (right)
			{
				nx += CLIMB_OFFSET_X;
				scaleX = -1;
			}
			else
			{
				nx -= CLIMB_OFFSET_X;
				scaleX = 1;
			}	
		}
		override protected function flagDelayTmrLsr(e:TimerEvent):void
		{
			lockFrame = false;
			super.flagDelayTmrLsr(e);
			nx += FLAG_POLE_X_OFS;
			this.x = nx;
			level.rightScrollPosOvRd = localToGlobal(ZERO_PT).x;
			if (level.waterLevel)
			{
				setPlayFrame("swimStillStart");
				setState(ST_JUMP);
				jumped = true;
				//checkState();
			}
		}
		private function dieFreezeTmrLsr(e:TimerEvent):void
		{
			dieFreezeTmr.stop();
			dieFreezeTmr.removeEventListener(TimerEvent.TIMER_COMPLETE,dieFreezeTmrLsr);
			dieFreezeTmr = null;
			EVENT_MNGR.startDieTmr(DIE_TMR_DEL_NORMAL);
			stopUpdate = false;
			gravity = DIE_GRAVITY;
			vyMaxPsv = DIE_VY_MAX_PSV;
			vy = -DIE_BOOST;
			jumped = true;
			frictionY = false;
		}
		override public function pressJmpBtn():void
		{
			if (cState == ST_VINE)
				return;
			if (onGround || (level.waterLevel && underWater))
				jump();
			/*else if (GameSettings.DEBUG_MODE && !onGround && !onSpring)
			{
				bounce(null);
				SND_MNGR.playSound(SoundNames.SFX_GAME_STOMP);
			}*/
			super.pressJmpBtn();
		}
		
		override public function fallenCharSelScrn():void
		{
			super.fallenCharSelScrn();
			cancelCheckState = true;
			setStopFrame(FL_DIE);
		}
		// CHECKFRAME
		override public function checkFrame():void
		{
			var cf:int = currentFrame;
			var cfl:String = currentFrameLabel;
			if ((cState == "walk" || cState == "pipe") && cf == getLabNum(walkEndLab) + 1) 
				setPlayFrame(FL_WALK_START);
			else if (cState == ST_GET_MUSHROOM && cfl == FL_GROW_END)
			{
				setStopFrame(hitFrameLabel);
			}
			else if ( cf == getLabNum(FL_JUMP_END) + 1 && !underWater )
				setPlayFrame(FL_JUMP_START);
			else if ( cf == getLabNum(FL_FALL_END) + 1 && !underWater )
				setPlayFrame(FL_FALL_START);
			else if (cState == ST_TAKE_DAMAGE && cfl == FL_TAKE_DAMAGE_END)
			{
				gotoAndStop(hitFrameLabel+"_1");
				stopAnim = true;
			}
			else if (cState == ST_FLAG_SLIDE || cState == ST_VINE)
			{
				if (cf == getLabNum(FL_CLIMB_END) + 1)
					setPlayFrame(FL_CLIMB_START);
			}
			else if (level.waterLevel)
			{
				if (cState == "jump" && cf == getLabNum("swimStillEnd") + 1) setPlayFrame("swimStillStart");
				else if (cState == "paddle")
				{
					if (cf == getLabNum("paddleSlowEnd") + 1 || currentFrame == getLabNum("paddleFastEnd") + 1)
					{
						setPlayFrame("swimStillStart");
						setState("jump");
					}
				}
			}
			super.checkFrame();
		}
		
		override protected function get currentSkinAppearanceNum():int
		{
			if (level is TitleLevel)
				return SKIN_APPEARANCE_NUM_SMALL;
			if ( upgradeIsActive(MARIO_FIRE_FLOWER) )
				return SKIN_APPEARANCE_NUM_FIRE_POWER;
			else if ( upgradeIsActive(MUSHROOM) )
				return SKIN_APPEARANCE_NUM_BIG;
			else
				return SKIN_APPEARANCE_NUM_SMALL;
		}
		
		override public function cleanUp():void
		{
			super.cleanUp();
			if (fellInPit)
			{
				changeAppearance();
			}
		}
		override public function checkStgPos():void
		{
			if (dead)
				return;
			super.checkStgPos();
		}
		override protected function removeListeners():void
		{
			super.removeListeners();
			SHOOT_TMR.removeEventListener(TimerEvent.TIMER_COMPLETE,shootTmrHandler);
		}
		override protected function reattachLsrs():void
		{
			super.reattachLsrs();
			SHOOT_TMR.addEventListener(TimerEvent.TIMER_COMPLETE,shootTmrHandler,false,0,true);
		}
		
	}
}