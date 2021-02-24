package com.smbc.characters
{
	import com.explodingRabbit.cross.gameplay.statusEffects.StatFxFlash;
	import com.explodingRabbit.cross.gameplay.statusEffects.StatFxInvulnerable;
	import com.explodingRabbit.cross.gameplay.statusEffects.StatFxStop;
	import com.explodingRabbit.cross.gameplay.statusEffects.StatusProperty;
	import com.explodingRabbit.display.CustomMovieClip;
	import com.explodingRabbit.utils.CustomDictionary;
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.data.AnimationTimers;
	import com.smbc.data.CharacterInfo;
	import com.smbc.data.Cheats;
	import com.smbc.data.DamageValue;
	import com.smbc.data.Difficulties;
	import com.smbc.data.GameSettings;
	import com.smbc.data.PaletteTypes;
	import com.smbc.data.PickupInfo;
	import com.smbc.data.RandomDropGenerator;
	import com.smbc.data.SoundNames;
	import com.smbc.enemies.Bowser;
	import com.smbc.enemies.Enemy;
	import com.smbc.graphics.HudAlwaysOnTop;
	import com.smbc.graphics.Palette;
	import com.smbc.graphics.BmdSkinCont;
	import com.smbc.ground.Ground;
	import com.smbc.ground.Platform;
	import com.smbc.interfaces.IAttackable;
	import com.smbc.level.TitleLevel;
	import com.smbc.main.LevObj;
	import com.smbc.managers.TutorialManager;
	import com.smbc.pickups.BowserAxe;
	import com.smbc.pickups.Pickup;
	import com.smbc.pickups.PitPickup;
	import com.smbc.projectiles.*;
	import com.smbc.text.TextFieldContainer;
	import com.smbc.utils.GameLoopTimer;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	
	import org.osmf.traits.PlayState;
	
	public class Pit extends Character
	{
//		public static const CHAR_NAME:String = CharacterInfo.Pit[ CharacterInfo.IND_CHAR_NAME ];
//		public static const CHAR_NAME_CAPS:String = CharacterInfo.Pit[ CharacterInfo.IND_CHAR_NAME_CAPS ];
//		public static const CHAR_NAME_TEXT:String = CharacterInfo.Pit[ CharacterInfo.IND_CHAR_NAME_MENUS ];
//		public static const CHAR_NUM:int = CharacterInfo.Pit[ CharacterInfo.IND_CHAR_NUM ];
//		public static const PAL_ORDER_ARR:Array = [ PaletteTypes.FLASH_POWERING_UP ]; 
//		private static const REPOSITION_BULLETS_DCT:Dictionary = new Dictionary();
		protected static const PIT_FIRE_ARROW:String = PickupInfo.PIT_FIRE_ARROW;
		public static const PIT_FEATHER:String = PickupInfo.PIT_FEATHER;
		public static const PIT_LONG_ARROW:String = PickupInfo.PIT_LONG_ARROW;
		public static const PIT_BARRIER:String = PickupInfo.PIT_BARRIER;
		public static const PIT_HAMMER:String = PickupInfo.PIT_HAMMER;
		
		public static const OBTAINABLE_UPGRADES_ARR:Array = [
			[ PIT_FIRE_ARROW, PIT_FEATHER, PIT_BARRIER ]
		];
		public static const MUSHROOM_UPGRADES:Array = [ PIT_LONG_ARROW ];
		public static const NEVER_LOSE_UPGRADES:Array = [ PIT_HAMMER ];
		public static const RESTORABLE_UPGRADES:Array = [ PIT_BARRIER ];
		public static const START_WITH_UPGRADES:Array = [ PIT_HAMMER ];
		public static const SINGLE_UPGRADES_ARR:Array = [ ];
		public static const REPLACEABLE_UPGRADES_ARR:Array = [ ];
		public static const TITLE_SCREEN_UPGRADES:Array = [ ];
		public static const ICON_ORDER_ARR:Array = [ PIT_HAMMER, PIT_FIRE_ARROW, PIT_BARRIER, PIT_FEATHER ];
		public static const AMMO_ARR:Array = [ [ ] ];
		public static const AMMO_DEPLETION_ARR:Array = [ [ ] ];
		public static const AMMO_DCT:CustomDictionary = new CustomDictionary();
		public static const AMMO_DEPLETION_DCT:CustomDictionary = new CustomDictionary();
//		private static const PAL_ROW_POWER_SUIT:int = 1;
//		private static const PAL_ROW_POWER_SUIT_MISSILE:int = 2;
//		private static const PAL_ROW_VARIA_SUIT:int = 3;
//		private static const PAL_ROW_VARIA_SUIT_MISSILE:int = 4;
		public static const IND_CI_Pit:int = 1;
		public static const IND_CI_Shield:int = 4;
		public static const IND_CI_PitPortrait:int = 5;
		
		private static const PAL_ROW_NORMAL:int = 0;
		private static const PAL_ROW_LONG_ARROW:int = 1;
		private static const PAL_ROW_FIRE_ARROW:int = 2;		
		
		private const DIE_TMR_DEL_NORMAL:int = 3000;
		private const DIE_TMR_DEL_PIT:int = 2500;
		//		public static const SUFFIX_VEC:Vector.<String> = Vector.<String>(["_1","_2","_2"]);
		public static const WIN_SONG_DUR:int = 4250;
		public static const CHAR_SEL_END_DUR:int = 2000;

		private const BASE_FL_WALK:String = "walk";
		private const BASE_FL_WALK_SHOOT:String = "walkShoot";
		
//		labels for arrow icon
		private static const FL_ICON_ARROW_WEAK:String = "arrowWeak";
		private static const FL_ICON_ARROW_MID:String = "arrowMid";
		private static const FL_ICON_ARROW_STRONG:String = "arrowStrong";
		
		
		private static const FL_CLIMB_START:String = "climbStart";
		private static const FL_CLIMB_END:String = "climbEnd";
		private static const FL_CROUCH:String = "crouch";
		private static const FL_CROUCH_SHOOT:String = "crouchShoot";
		private static const FL_FLY_START:String = "fly-1";
		private static const FL_FLY_END:String = "fly-2";
		private static const FL_JUMP:String = "jump";
		private static const FL_JUMP_SHOOT:String = "jumpShoot";
		private static const FL_JUMP_UP:String = "upJump";
		private static const FL_JUMP_UP_SHOOT:String = "upJumpShoot";
		private static const FL_STAND:String = "stand";
		private static const FL_STAND_SHOOT:String = "standShoot";
		private static const FL_STAND_UP:String = "standUp";
		private static const FL_STAND_UP_SHOOT:String = "standUpShoot";
		private static const FL_WALK_SHOOT_START:String = "walkShoot-1";
		private static const FL_WALK_SHOOT_END:String = "walkShoot-3";
		private static const FL_WALK_SHOOT_2:String = "walkShoot-2";
		private static const FL_WALK_START:String = "walk-1";
		private static const FL_WALK_END:String = "walk-4";
		
		private static const STILL_SHOOT_TMR:CustomTimer = new CustomTimer(50,1);
		private static const MOVE_SHOOT_TMR:CustomTimer = new CustomTimer(140,1);
		private static const STEP_TMR:CustomTimer = new CustomTimer(150,1);
		private static const MAX_ARROWS_ON_SCREEN:int = 2;
		private static const CLIMB_ANIM_TMR:CustomTimer = AnimationTimers.ANIM_SLOW_TMR;
		private static const WALK_SPEED:int = 180;
		private static const FLIP_HEIGHT_DIST:int = 60;
		private static const BALL_CHECK_DIST:int = 60;
		private const BALL_TOP_OFS:int = 30;
		private const BALL_BOT_OFS:int = 10;
		public const ARROW_DCT:CustomDictionary = new CustomDictionary();
		private var shoot:Boolean;
		private const FLAG_POLE_OFFSET:int = 15;
		public var muteStepSounds:Boolean;
		private static const JUMP_PWR:int = 500;
		private var standFrame:String = FL_STAND;
		private static const DAMAGE_BOOST_TMR_DEL:int = 250;
		private var missileMode:Boolean;
		public static const DEFAULT_PROPS_DCT:CustomDictionary = new CustomDictionary();
		
		public static const SKIN_PIT_NES:int = 0;
		public static const SKIN_PIT_SNES:int = 1;
		public static const SKIN_PIT_GB:int = 2;
		
		private static const FLASH_DUR:int = 3000;
		
		public function Pit() 
		{
//			charNum = CHAR_NUM;
//			recolorsCharSkin = true;
//			super();
//			if (!DEFAULT_PROPS_DCT.length)
//			{
//				DEFAULT_PROPS_DCT.addItem( new StatusProperty(PR_FLASH_AGG,0, new StatFxFlash(null,AnimationTimers.DEL_FAST, FLASH_DUR) ) );
//			}
//			for each (var prop:StatusProperty in DEFAULT_PROPS_DCT)
//			{
//				addProperty(prop);
//			}
//			mainAnimTmr = ANIM_MIN_FAST_TMR;
//			_charName = CHAR_NAME;
//			//			suffixVec = SUFFIX_VEC.concat();
//			_charNameCaps = CHAR_NAME_CAPS;
//			_charNameTxt = CHAR_NAME_TEXT;
////			_sndWinMusic = SND_MUSIC_WIN;
//			_dieTmrDel = DIE_TMR_DEL_NORMAL;
//			winSongDur = WIN_SONG_DUR;
//			_usesHorzObjs = true;
//			walkStartLab = FL_WALK_START;
//			walkEndLab = FL_WALK_END;
//			vineAnimTmr = CLIMB_ANIM_TMR;
//			addProperty( new StatusProperty(PR_PIERCE_AGG,10) );
		}
		private function changeBodyColor():void
		{
			var palRow:int;
			if (upgradeIsActive(PIT_FIRE_ARROW) )
				palRow = PAL_ROW_FIRE_ARROW;
			else if (upgradeIsActive(PIT_LONG_ARROW) )
				palRow = PAL_ROW_LONG_ARROW;
			else
				palRow = PAL_ROW_NORMAL;
			graphicsMngr.recolorCharacterSheet(charNum,palRow,[ IND_CI_Pit, IND_CI_PitPortrait ]);
		}
		
		override protected function prepareDrawCharacter():void
		{
			changeBodyColor();
			super.prepareDrawCharacter();
		}
		
		
		override public function setStats():void
		{
			gravity = 700;
			if (level.waterLevel)
			{
				defGravity = gravity;
				gravity = 400;
				defGravityWater = gravity;
			}
			defSpringPwr = 300;
			boostSpringPwr = 700;
			vxMax = WALK_SPEED;
			vyMaxPsv = 450;
			fx = .0001;
			fy = .0001;
			numParFrames = 4;
			pState2 = true;
			super.setStats();
			jumpPwr = JUMP_PWR;
			changeBrickState();
			MOVE_SHOOT_TMR.addEventListener(TimerEvent.TIMER_COMPLETE,moveShootTmrHandler,false,0,true);
			addTmr(MOVE_SHOOT_TMR);
			STILL_SHOOT_TMR.addEventListener(TimerEvent.TIMER_COMPLETE,stillShootTmrHandler,false,0,true);
			addTmr(STILL_SHOOT_TMR);
			STEP_TMR.addEventListener(TimerEvent.TIMER_COMPLETE,stepTmrHandler,false,0,true);
			addTmr(STEP_TMR);
		}
		override protected function startAndDamageFcts(start:Boolean = false):void
		{
			super.startAndDamageFcts(start);
			if (!start)
				changeBodyColor();
			updAmmoDisplay();
		}
		override public function setCurrentBmdSkin(bmc:BmdSkinCont, characterInitiating:Boolean = false):void
		{
			super.setCurrentBmdSkin(bmc);
			changeBodyColor();
		}
		override public function forceWaterStats():void
		{
			defGravity = gravity;
			gravity = 400;
			defGravityWater = gravity;
			super.forceWaterStats();
		}
		override public function forceNonwaterStats():void
		{
			gravity = 700;
			super.forceNonwaterStats();
		}
		public function repositionWalkingBullets():Boolean
		{
			if (REPOSITION_BULLETS_DCT[skinNum] != undefined && cState == ST_WALK)
				return true;
			return false;
		}
		
		override protected function jump():void
		{
			onGround = false;
			vy = -jumpPwr;
			setStopFrame(FL_JUMP);
			setState(ST_JUMP);
			releasedJumpBtn = false;
			frictionY = false;
			jumped = true;
		}
		
		override public function hitPickup(pickup:Pickup,showAnimation:Boolean = true):void
		{
			super.hitPickup(pickup,showAnimation);
			switch(pickup.type)
			{
				case MUSHROOM:
				{
					changeBodyColor();
					updAmmoDisplay();
					break;
				}
				case PIT_FIRE_ARROW:
				{
					changeBodyColor();
					updAmmoDisplay();
					break;
				}
				case PIT_BARRIER:
				{
//					activate wand
					break;
				}
			}
		}

		private function updAmmoDisplay():void
		{
			if ( !upgradeIsActive(PIT_HAMMER) )
			{
				tsTxt.UpdAmmoIcon(true, PIT_HAMMER);
//				tsTxt.UpdAmmoText(false);
			}
			else
			{
				var lab:String = FL_ICON_ARROW_WEAK;
				if (upgradeIsActive(PIT_FIRE_ARROW))
					lab = FL_ICON_ARROW_STRONG;
				else if (upgradeIsActive(PIT_LONG_ARROW))
					lab = FL_ICON_ARROW_MID;
				tsTxt.UpdAmmoIcon(true, lab);
//				tsTxt.UpdAmmoText( true, getAmmo( PIT_MISSILE) );
			}
		}
		
		override protected function movePlayer():void 
		{
			if (cState == ST_TAKE_DAMAGE)
				return;
			var dir:int = 0;
			if (rhtBtn && !lftBtn && !wallOnRight)
				dir = 1;
			else if (lftBtn && !rhtBtn && !wallOnLeft)
				dir = -1;
			if (stuckInWall || ( upBtn && onGround ) || (lftBtn && rhtBtn) || (!lftBtn && !rhtBtn) )
				dir = 0;
			if (dir != 0)
			{
				if (cState == ST_VINE)
				{
					if (exitVine)
						getOffVine();
					else
						return;
				}
				vx = WALK_SPEED*dir;
				scaleX = dir;
			}
			else
				vx = 0;
		}
		
		override protected function checkState():void
		{
			if (cState == ST_VINE)
			{
				mainAnimTmr = vineAnimTmr;
				checkVineBtns();
				checkVinePosition();
				return;
			}
			else if (cState == ST_TAKE_DAMAGE)
				return;
			if (onGround)
			{
				jumped = false;
				mainAnimTmr = ANIM_MODERATE_TMR;
				if (vx == 0)
				{
					if (STEP_TMR.running)
						STEP_TMR.stop();
					setState(ST_STAND);
					if (upBtn)
					{
						if (!shoot)
							setStopFrame(FL_STAND_UP);
						else
							setStopFrame(FL_STAND_UP_SHOOT);
					}
					else
					{
						if (cState == ST_STAND)
						{
							if (!shoot)
								setStopFrame(standFrame);
							else
								setStopFrame(FL_STAND_SHOOT);
						}
						else
						{
							if (!shoot)
								setStopFrame(FL_CROUCH);
						}
					}
				}
				else // moving 
				{
					if (!STEP_TMR.running)
						STEP_TMR.start();
					if (!upBtn && !dwnBtn)
					{
						if (cState != ST_WALK)
						{
							if (!shoot)
								setPlayFrame(FL_WALK_START);
							else
								setPlayFrame(FL_WALK_SHOOT_START);
							setState(ST_WALK);
						}
						else if (cState == ST_WALK) // same as current state
						{
							if (!shoot)
								setPlayFrame(getParFrame(BASE_FL_WALK));
							else
								setPlayFrame(getParFrame(BASE_FL_WALK_SHOOT));
						}
					}
				}
			}
			else // !onGround
			{
				if (STEP_TMR.running)
					STEP_TMR.stop();
				setState(ST_JUMP);
				if (!dwnBtn && !upBtn)
				{
					if (!shoot)
						setStopFrame(FL_JUMP);
					else
						setStopFrame(FL_JUMP_SHOOT);
				}
				
				if (frictionY)
				{
					if (vy < 0)
						vy *= Math.pow(fy,dt);
					else
						frictionY = false;
				}
			}
//			doesn't matter if onGround for these
			if (dwnBtn)
				setStopFrame(FL_CROUCH);
			else if (upBtn)
			{
				if (!shoot)
					setStopFrame(FL_STAND_UP);
				else
					setStopFrame(FL_STAND_UP_SHOOT);
			}
		}
		
		private function exitMorphBall(frameToSet:String,stateToSet:String):void
		{
			var cancelExitMorphBall:Boolean = false;
			for each (var ground:Ground in level.GROUND_STG_DCT)
			{
				if (!ground.onScreen || !ground.visible || level.getDistance(hMidX,hMidY,ground.hMidX,ground.hMidY) > BALL_CHECK_DIST)
					continue;
				if (hTop - BALL_TOP_OFS <= ground.hBot && hBot - BALL_BOT_OFS > ground.hTop && hLft < ground.hRht && hRht > ground.hLft)
				{
					cancelExitMorphBall = true;
					break;
				}
			}
			if (!cancelExitMorphBall)
			{
				setStopFrame(frameToSet);
				setState(stateToSet);
			}
			changeBrickState();
		}
		// PRESSUPBTN press up once
		override public function pressUpBtn():void
		{
			super.pressUpBtn();
		}
		// PRESSJMPBTN
		override public function pressJmpBtn():void
		{
			if (cState == ST_VINE)
				return;
//			if (cState == ST_CROUCH)
//				exitMorphBall(FL_JUMP,ST_JUMP);
			if (onGround)
				jump();
			super.pressJmpBtn();
		}
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
		// PRESSATTACKBTN
		override public function pressAtkBtn():void
		{
			if (cState == ST_VINE)
				return;
			super.pressAtkBtn();
			if (dwnBtn)
				return;
			if (ARROW_DCT.length < MAX_ARROWS_ON_SCREEN)
			{
				level.addToLevel( new PitProjectile(this) );
				shoot = true;
				if ((!onGround && upBtn) || (onGround && !lftBtn && !rhtBtn))
				{
					if (STILL_SHOOT_TMR.running)
						STILL_SHOOT_TMR.reset();
					STILL_SHOOT_TMR.start();
				}
				else
				{
					if (MOVE_SHOOT_TMR.running)
						MOVE_SHOOT_TMR.reset();
					MOVE_SHOOT_TMR.start();
				}
				checkState();
			}
		}
		override public function pressSpcBtn():void
		{
			super.pressSpcBtn();
		}
		private function fireMissile():void
		{
//			var infiniteAmmo:Boolean = false;
//			if (Cheats.infiniteAmmo || starPwr)
//				infiniteAmmo = true;
//			if ( (hasEnoughAmmo(PIT_MISSILE) ) && BULLET_DCT.length < MAX_SHOTS_ON_SCREEN)
//			{
//				var shot:PitShot = new PitShot(this,PitShot.SHOT_TYPE_MISSILE);
//				BULLET_DCT.addItem(shot);
//				level.addToLevel(shot);
//				decAmmo(PIT_MISSILE);
//				shoot = true;
//				if ((!onGround && upBtn) || (onGround && !lftBtn && !rhtBtn))
//				{
//					if (STILL_SHOOT_TMR.running)
//						STILL_SHOOT_TMR.reset();
//					STILL_SHOOT_TMR.start();
//				}
//				else
//				{
//					if (MOVE_SHOOT_TMR.running)
//						MOVE_SHOOT_TMR.reset();
//					MOVE_SHOOT_TMR.start();
//				}
//				checkState();
//			}
		}
		private function moveShootTmrHandler(e:TimerEvent):void
		{
			MOVE_SHOOT_TMR.reset();
			shoot = false;
		}
		private function stillShootTmrHandler(e:TimerEvent):void
		{
			STILL_SHOOT_TMR.reset();
			shoot = false
		}
		private function stepTmrHandler(e:TimerEvent):void
		{
			STEP_TMR.reset();
//			if (!muteStepSounds)
//				SND_MNGR.playSound(SFX_PIT_STEP);
			if (onGround && vx != 0)
				STEP_TMR.start();
		}
		override public function pressDwnBtn():void
		{
			super.pressDwnBtn();
			if (cState == ST_PIPE || cState == ST_VINE)
				return;
			setState(ST_CROUCH);
			checkState();
			changeBrickState();
		}
		override protected function enterPipeHorz():void
		{
			super.enterPipeHorz();
			mainAnimTmr = ANIM_MIN_FAST_TMR;
		}
		override protected function takeDamageStart(source:LevObj):void
		{
			super.takeDamageStart(source);
			updAmmoDisplay();
//			takeNoDamage = true;
//			disableInput = true;
//			nonInteractive = true;
//			if (onGround)
//				vy = -DAMAGE_BOOST_VY;
//			var dir:int = 1;
//			if (source.nx > nx)
//				dir = -1;
//			damageBoostTmr.start();
//			vx = DAMAGE_BOOST_VX*dir;
//			if (cState != ST_CROUCH)
//				setStopFrame(FL_JUMP);
//			if ( !upgradeIsActive(PIT_MORPH_BALL) && (morphBall || cState == ST_CROUCH) )
//				exitMorphBall(FL_JUMP,ST_JUMP);
//			setState(ST_TAKE_DAMAGE);
//			flickerStart();
//			BTN_MNGR.relPlyrBtns();
//			SND_MNGR.playSound(SN_TAKE_DAMAGE);
		}
		override protected function takeDamageEnd():void
		{
			super.takeDamageEnd();
		}
		override public function getAxe(axe:BowserAxe):void
		{
			if (cState == ST_CROUCH)
				exitMorphBall(FL_JUMP,ST_JUMP);
			super.getAxe(axe);
		}
		
		override public function charSelectInitiate():void
		{
			super.charSelectInitiate();
			muteStepSounds = true;
		}
		
		override public function chooseCharacter():void
		{
			super.chooseCharacter();
//			standFrame = FL_STAND_FRONT;
//			setStopFrame(FL_STAND_FRONT);
//			level.getGroundAt(nx - TILE_SIZE,ny).destroy();
//			level.getGroundAt(nx,ny).destroy();
//			level.getGroundAt(nx - TILE_SIZE,ny + TILE_SIZE).destroy();
//			level.getGroundAt(nx,ny + TILE_SIZE).destroy();
//			charSelPlatform = new Platform(null,Platform.PT_CONSTANT_FALL,4);
//			charSelPlatform.x = nx;
//			charSelPlatform.y = ny;
//			level.addToLevel(charSelPlatform);
		}
		override public function fallenCharSelScrn():void
		{
			super.fallenCharSelScrn();
			cancelCheckState = true;
			setStopFrame(FL_CROUCH);
		}
		override protected function initiateNormalDeath(source:LevObj = null):void
		{
			super.initiateNormalDeath(source);
//			flickerStop();
//			stopUpdate = true;
//			stopAnim = true;
//			stopHit = true;
//			visible = false;
//			//			if (playerGraphic)
//			//				playerGraphic.visible = false;
//			level.addToLevel(new PitGuts(this,1));
//			level.addToLevel(new PitGuts(this,2));
//			level.addToLevel(new PitGuts(this,3));
//			level.addToLevel(new PitGuts(this,4));
//			level.addToLevel(new PitGuts(this,5));
//			level.addToLevel(new PitGuts(this,6));
//			EVENT_MNGR.startDieTmr(DIE_TMR_DEL_NORMAL);
//			SND_MNGR.playSound(SFX_PIT_DIE);
		}
		override protected function initiatePitDeath():void
		{
			_dieTmrDel = DIE_TMR_DEL_PIT;
			super.initiatePitDeath();
		}
		override public function slideDownFlagPole():void
		{
			super.slideDownFlagPole();
//			setStopFrame(FL_SLIDE);
//			nx = level.flagPole.hMidX - FLAG_POLE_OFFSET;
//			shoot = false;
//			if (screwAttack)
//			{
//				screwAttack = false;
//				if (!starPwr)
//					endReplaceColor();
//			}
		}
		override public function stopFlagPoleSlide():void
		{
			super.stopFlagPoleSlide();
			if (onGround)
			{
				setState(ST_STAND);
				setStopFrame(standFrame);
			}
			else
			{
				setState(ST_JUMP);
				jumped = true;
			}
		}
		override protected function changeBrickState():void
		{
			if (cState == ST_CROUCH)
				brickState = BRICK_NONE;
			else 
				brickState = BRICK_BOUNCER;
		}
		override public function activateWatchModeEnterPipe():void
		{
			super.activateWatchModeEnterPipe();
			muteStepSounds = true;
		}
		override protected function removeListeners():void
		{
			super.removeListeners();
			MOVE_SHOOT_TMR.removeEventListener(TimerEvent.TIMER_COMPLETE,moveShootTmrHandler);
			STILL_SHOOT_TMR.removeEventListener(TimerEvent.TIMER_COMPLETE,stillShootTmrHandler);
			STEP_TMR.removeEventListener(TimerEvent.TIMER_COMPLETE,stepTmrHandler);
			
		}
		override protected function reattachLsrs():void
		{
			super.reattachLsrs();
			MOVE_SHOOT_TMR.addEventListener(TimerEvent.TIMER_COMPLETE,moveShootTmrHandler,false,0,true);
			STILL_SHOOT_TMR.addEventListener(TimerEvent.TIMER_COMPLETE,stillShootTmrHandler,false,0,true);
			STEP_TMR.addEventListener(TimerEvent.TIMER_COMPLETE,stepTmrHandler,false,0,true);
		}
		override public function checkFrame():void
		{
			var cf:int = currentFrame;
			var cl:String = currentLabel;
			if ((cState == ST_WALK || cState == ST_PIPE) 
				&& (cf == getLabNum(FL_WALK_END) + 1 || cf == getLabNum(FL_WALK_SHOOT_END) + 1))
			{
				if (!shoot)
					setPlayFrame(FL_WALK_START);
				else
					setPlayFrame(FL_WALK_SHOOT_START);
			}
			else if (cState == ST_VINE && cf == getLabNum(FL_CLIMB_END) + 1)
				setPlayFrame(FL_CLIMB_START);
			super.checkFrame();
		}
		override public function cleanUp():void
		{
			super.cleanUp();
			tsTxt.UpdAmmoIcon(false);
			tsTxt.UpdAmmoText(false);
		}
	}	
}