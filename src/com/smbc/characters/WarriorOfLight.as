package com.smbc.characters
{
	import com.explodingRabbit.display.CustomMovieClip;
	import com.smbc.data.CharacterInfo;
	import com.smbc.data.DamageValue;
	import com.smbc.data.PaletteTypes;
	import com.smbc.data.Spell;
	import com.smbc.displayInterface.FinalFantasyPointer;
	import com.smbc.interfaces.IAttackable;
	import com.smbc.utils.GameLoopTimer;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	
	import org.osmf.events.TimeEvent;

	public class WarriorOfLight extends Character
	{
//		public static const CHAR_NAME:String = CharacterInfo.WarriorOfLight[ CharacterInfo.IND_CHAR_NAME ];
//		public static const CHAR_NAME_CAPS:String = CharacterInfo.WarriorOfLight[ CharacterInfo.IND_CHAR_NAME_CAPS ];
//		public static const CHAR_NAME_TEXT:String = CharacterInfo.WarriorOfLight[ CharacterInfo.IND_CHAR_NAME_MENUS ];
//		public static const CHAR_NUM:int = CharacterInfo.WarriorOfLight[ CharacterInfo.IND_CHAR_NUM ];
		public static const PAL_ORDER_ARR:Array = [ PaletteTypes.P_STATE,PaletteTypes.FLASH_POWERING_UP ];
		private static const UPGRADE_X_OFS:int = 423;
		public static const TYPE_FIGHTER:String = "Fighter";
		public static const TYPE_THIEF:String = "Thief";
		public static const TYPE_BLACK_MAGE:String = "BlackMage";
		public static const TYPE_WHITE_MAGE:String = "WhiteMage";
		public static var charPState:int;
		//		public static const SUFFIX_VEC:Vector.<String> = Vector.<String>(["_1","_2","_2"]);
		public static const WIN_SONG_DUR:int = 5400;
		public static const CHAR_SEL_END_DUR:int = 1700;
		private static const JUMP_PWR:int = 630;
		private static const GRAVITY:int = 1400;
		private static const MOVEMENT_SPEED:int = 200;
		protected const FL_ATTACK_END:String = "attackEnd";
//		protected const FL_ATTACK_END_THIEF:String = "attackEndThief";
		protected const FL_ATTACK_START:String = "attackStart";
		protected const FL_CROUCH:String = "crouch";
		protected const FL_DIE:String = "die";
		protected const FL_FALL:String = "fall";
		protected const FL_JUMP:String = "jump";
		protected const FL_CAST_SPELL:String = "castSpell";
		protected const FL_PREPARE_SPELL_END:String = "prepareSpellEnd";
		protected const FL_PREPARE_SPELL_START:String = "prepareSpellStart";
		protected const FL_STAND:String = "stand";
		protected const FL_TAKE_DAMAGE:String = "takeDamage";
		protected const FL_WALK_END:String = "walkEnd";
		protected const FL_WALK_START:String = "walkStart";		
		protected const ST_CAST_SPELL:String = "castSpell";
		protected const ST_PREPARE_SPELL:String = "prepareSpell";
		protected static const DEL_CAST_SPELL:int = 300;
		protected static const DEL_PREPARE_SPELL:int = 500;
//		protected static const DEL_PREPARE_SPELL:int = 500;
//		protected static const DEL_PREPARE_SPELL:int = 500;
		protected var pressedJmpBtn:Boolean;
		private const SUBCASSES:Array = [ Fighter, Thief, BlackMage, WhiteMage ];
		protected var animationTmr:GameLoopTimer = new GameLoopTimer(100);
		protected var actionTmr:GameLoopTimer = new GameLoopTimer(600,1);
		protected var copyPixelsYOfs:int;
		protected var flAttackEnd:String;
		public var pointer:FinalFantasyPointer;
		protected var spellToCast:Spell;
		protected var idle:Boolean = true;
		protected var pointerAppearanceDelTmr:GameLoopTimer = new GameLoopTimer(250,1);
		
		public function WarriorOfLight()
		{
			inheritedForceShortClassName = "WarriorOfLight";
			super();
			_charName = WarriorOfLight[Character.CHAR_NAME_PROPERTY_NAME];
			_charNameTxt = WarriorOfLight[Character.CHAR_NAME_TEXT_PROPERTY_NAME];
			_charNameCaps = WarriorOfLight[Character.CHAR_NAME_CAPS_PROPERTY_NAME];
			winSongDur = WarriorOfLight[Character.WIN_SONG_DUR_PROPERTY_NAME];
			brickState = BRICK_NONE;
			pointerAppearanceDelTmr.addEventListener(TimerEvent.TIMER_COMPLETE, pointerAppearanceDelTmrHandler, false, 0, true);
		}
		
		protected function pointerAppearanceDelTmrHandler(event:Event):void
		{
			if (atkBtn)
				createPointer(FinalFantasyPointer.TYPE_NORMAL);
		}
		
		protected function attackTmrHandler(event:TimerEvent):void
		{
			gotoAndStop(currentFrame + 1);
			checkFrame();
		}
		protected function prepareSpellTmrHandler(event:Event):void
		{
			actionTmr.stop();
			castSpell(spellToCast);
		}
		
		override protected function firstCall():void
		{
			classObj = WarriorOfLight;
			copyPixelsOfsPnt = new Point(0,copyPixelsYOfs); 
			if ( charPState == PS_FIRE_FLOWER)
				copyPixelsOfsPnt.x = UPGRADE_X_OFS;
			trace("charPState: "+copyPixelsOfsPnt);
			super.firstCall();
		}
		
		
		/*override protected function setUpPalOrder():void
		{
			var realClassObj:Object = classObj; // hack to use this as classObj temporarily
			classObj = WarriorOfLight;
			super.setUpPalOrder();
			classObj = realClassObj;
		}*/
		
		override public function setStats():void
		{
			jumpPwr = JUMP_PWR;
			gravity = GRAVITY;
			if (level.waterLevel)
			{
				defGravity = gravity;
				gravity = 750;
				defGravityWater = gravity;
			}
			defSpringPwr = 500;
			boostSpringPwr = 1000;
			xSpeed = MOVEMENT_SPEED;
			super.setStats();		
		}
		
		override protected function movePlayer():void 
		{
			if ( (!idle && onGround) || cState == ST_CROUCH)
			{
				vx = 0;
				return;
			}
			if (rhtBtn && !lftBtn && !wallOnRight)
			{
				/*if (justCrouched)
				{
				justCrouched = false;
				return;
				}	*/
				if (stuckInWall)
					return;
				if (cState == ST_VINE)
				{
					if (exitVine)
						getOffVine();
					else
						return;
				}
				vx = MOVEMENT_SPEED;
				scaleX = 1;
			}
			else if (lftBtn && !rhtBtn && !wallOnLeft) 
			{
				//					if (justCrouched)
				//					{
				//						justCrouched = false;
				//						return;
				//					}	
				if (stuckInWall)
					return;
				if (cState == ST_VINE)
				{
					if (exitVine)
						getOffVine();
					else
						return;
				}
				vx = -MOVEMENT_SPEED;
				scaleX = -1;
			}
			else if (lftBtn && rhtBtn && cState != ST_DIE)
				vx = 0;
			else if (!lftBtn && !rhtBtn && cState != ST_DIE)
				vx = 0;
			if (cState == ST_VINE)
			{
				if (rhtBtn && !lftBtn)
				{
					if (exitVine)
						getOffVine();
					else
						return;
					vx = MOVEMENT_SPEED;
					this.scaleX = 1;
				}
				else if (lftBtn && !rhtBtn) 
				{
					if (exitVine)
						getOffVine();
					else
						return;
					vx = -MOVEMENT_SPEED;
					this.scaleX = -1;
				}
			}
			//if (!jumped) vx = 0;
			
		}
		// Public Methods:
		// CHECKSTATE
		override protected function checkState():void
		{
			if (pointer)
				pointer.update(dt);
			if (cState == ST_VINE)
			{
				checkVineBtns();
				checkVinePosition();
				return;
			}
			if (onGround)
			{
				lastVX = 0;
				jumped = false;
				pressedJmpBtn = false;
				if (idle)
				{
					if (dwnBtn)
					{
						setState(ST_CROUCH);
						setStopFrame(FL_CROUCH);
//						justCrouched = true;
					}
					else if (vx == 0)
					{	
						setState(ST_STAND);
						setStopFrame(FL_STAND );
					}
					else 
					{
						setState(ST_WALK);
						if (lState != ST_WALK)
							setPlayFrame(FL_WALK_START);
					}
				}
			}
			else if (idle)
			{
				setState(ST_JUMP);
				if (pressedJmpBtn)
				{
//					if (vy < 0)
						setStopFrame(FL_JUMP);
//					else
//						setStopFrame(FL_JUMP_FALL);
				}
				else
					setStopFrame(FL_FALL);
				if (lastOnSpring && !onSpring)
				{
					if (rhtBtn && !lftBtn)
					{
						vx = MOVEMENT_SPEED;
						scaleX = 1;
						if (lastVX < 0) lastVX = 0;
					}
					else if (lftBtn && !rhtBtn)
					{
						vx = -MOVEMENT_SPEED;
						scaleX = -1;
						if (lastVX > 0) lastVX = 0;
					}
				}
				if (onSpring) // turns player while on spring
				{
					if (rhtBtn)
						scaleX = 1;
					else if (lftBtn)
						scaleX = -1;
				}
			}
			if (cState == ST_ATTACK)
				checkAtkRect = true;
			else
				checkAtkRect = false;
			/*if (currentFrame == getLabNum(FL_ATTACK_END) || currentFrame == getLabNum(FL_CROUCH_ATTACK_END))
			{
				checkAtkRect = true;
				var crouchNum:int = IND_HIT_BOX_VEC_STAND;
				if (currentLabel.indexOf("crouch") != -1)
					crouchNum = IND_HIT_BOX_VEC_CROUCH;
				var rect:Rectangle = HIT_BOX_VEC[pState-1][crouchNum];
				ahRect.x = rect.x;
				ahRect.y = rect.y;
				ahRect.width = rect.width;
				ahRect.height = rect.height;
				if (pState != PS_NORMAL)
					hitDistOver = rect.width*2;
				else
					hitDistOver = 0;
			}
			else
			{
				checkAtkRect = false;
				hitDistOver = 0;
			}*/
		}
		protected function attack():void
		{
			if (!idle)
				return;
			
			setState(ST_ATTACK);
			idle = false;
			setStopFrame(FL_ATTACK_START);
			animationTmr.addEventListener(TimerEvent.TIMER, attackTmrHandler, false, 0, true);
			animationTmr.start();
		}
		override public function landAttack(obj:IAttackable):void
		{
			
			
//			if (pState == 1)
//				obj.hitByAttack(DV_RYU_SWORD_1);
//			else if (pState == 2)
//				obj.hitByAttack(DV_RYU_SWORD_2);
//			else if (pState == 3)
//				obj.hitByAttack(DV_RYU_SWORD_3);	
//			if (obj is Enemy && !(obj as Enemy).attackProof && obj.health > 0)
//				SND_MNGR.playSound(SN_RYU_DAMAGE_ENEMY);
		}
		protected function sideAttack():void
		{
			trace("normal attack");
		}
		protected function upAttack():void
		{
			trace("up attack");
		}
		protected function downAttack():void
		{
			trace("down attack");
		}
		override public function pressJmpBtn():void
		{
			if (pointer)
			{
				pointer.pressJmpBtn();
				return;
			}
			super.pressJmpBtn();
			if (!onGround)
				return;
			idle = true;
			removeActionTmrListeners();
			removeAnimationTmrListeners();
			onGround = false;
			vy = -jumpPwr;
			setStopFrame(FL_JUMP);
			setState(ST_JUMP);
			jumped = true;
			pressedJmpBtn = true;
			releasedJumpBtn = false;
			frictionY = false;
		}
		
		override public function pressUpBtn():void
		{
			if (pointer)
				pointer.pressUpBtn();
			else
				super.pressUpBtn();
		}
		override public function pressDwnBtn():void
		{
			if (pointer)
				pointer.pressDwnBtn();
			else
				super.pressDwnBtn();
		}
		override public function pressLftBtn():void
		{
			if (pointer)
				pointer.pressLftBtn();
			else
				super.pressLftBtn();
		}
		override public function pressRhtBtn():void
		{
			if (pointer)
				pointer.pressRhtBtn();
			else
				super.pressRhtBtn();
		}
		override public function relUpBtn():void
		{
			if (pointer)
				pointer.relUpBtn();
			else
				super.relUpBtn();
		}
		override public function relDwnBtn():void
		{
			if (pointer)
				pointer.relDwnBtn();
			else
				super.relDwnBtn();
		}
		override public function relLftBtn():void
		{
			if (pointer)
				pointer.relLftBtn();
			else
				super.relLftBtn();
		}
		override public function relRhtBtn():void
		{
			if (pointer)
				pointer.relRhtBtn();
			else
				super.relRhtBtn();
		}
		
		override public function pressAtkBtn():void
		{
			if (pointer)
			{
				pointer.pressAtkBtn();
				return;
			}
			super.pressAtkBtn();
			if (!idle)
			{
				/*if (cState == ST_CAST_SPELL || cState == ST_PREPARE_SPELL)
				{
					createPointer();
				}*/
				return;
			}
			if (!upBtn && !dwnBtn)
				sideAttack();
			else if (upBtn && !dwnBtn)
				upAttack();
			else if (dwnBtn && !upBtn)
				downAttack();
		}
		
		override public function pressSpcBtn():void
		{
			super.pressSpcBtn();
			if (!idle)
				return;
			charPState = pState;
			/*if (isOnlyDirPressed(pressUpBtn))
				STAT_MNGR.currentWarriorType = TYPE_FIGHTER;
			else if (isOnlyDirPressed(pressRhtBtn))
				STAT_MNGR.currentWarriorType = TYPE_BLACK_MAGE;
			else if (isOnlyDirPressed(pressDwnBtn))
				STAT_MNGR.currentWarriorType = TYPE_THIEF;
			else if (isOnlyDirPressed(pressLftBtn))
				STAT_MNGR.currentWarriorType = TYPE_WHITE_MAGE;
			changeChar(CHAR_NUM);*/
		}
		
		override public function setState(_nState:String):void
		{
			if (cState == ST_ATTACK && _nState != ST_ATTACK)
			{
				if (ATK_DCT.length != 0)
					ATK_DCT.clear();
			}
			super.setState(_nState);
		}
		
		protected function createPointer(pointerType:String = null):void
		{
			if (!pointerType)
				pointerType = FinalFantasyPointer.TYPE_NORMAL;
			pointer = new FinalFantasyPointer(this,pointerType);
			pointer.initiate();
			pointer.addEventListener(FinalFantasyPointer.EVENT_SELECT, pointerSelectHandler, false, 0, true);
			pointer.addEventListener(FinalFantasyPointer.EVENT_CANCEL, pointerCancelHandler, false, 0, true);
			if (lftBtn)
				pointer.pressLftBtn();
			if (rhtBtn)
				pointer.pressRhtBtn();
			if (upBtn)
				pointer.pressUpBtn();
			if (dwnBtn)
				pointer.pressDwnBtn();
			setAllButtonsFalse();
		}
		
		override public function setPowerState(value:int):void
		{
			var skip:Boolean = firstPStateCall;
			super.setPowerState(value);
			if (skip)
				return;
			var num:int = copyPixelsOfsPnt.x;
			if (pState == PS_FIRE_FLOWER)
				copyPixelsOfsPnt.x = UPGRADE_X_OFS;
			else
				copyPixelsOfsPnt.x = 0;
			if (num != copyPixelsOfsPnt.x)
				redraw();
		}
		
		protected function pointerCancelHandler(event:Event):void
		{
			BTN_MNGR.sendPlayerBtns();
		}
		
		protected function pointerSelectHandler(event:Event):void
		{
			if (spellToCast)
				castSpell(spellToCast);
			BTN_MNGR.sendPlayerBtns();
		}
		
		protected function castSpell(spellToCast:Spell):void
		{
			removeActionTmrListeners();
			actionTmr.stop();
			actionTmr.delay = DEL_CAST_SPELL;
			actionTmr.start();
			actionTmr.addEventListener(TimerEvent.TIMER_COMPLETE, castSpellTmrHandler, false, 0, true);
			setState(ST_CAST_SPELL);
			setStopFrame(FL_CAST_SPELL);
			trace("actionTmr.delay: "+actionTmr.delay+" actoinTmr.currentCount: "+actionTmr.currentCount);
		}
		
		protected function castSpellTmrHandler(event:Event):void
		{
			trace("called");
			setState(ST_NEUTRAL);
			idle = true;
			checkState();
		}
		protected function prepareSpell():void
		{
			removeActionTmrListeners();
			actionTmr.delay = DEL_PREPARE_SPELL;
			actionTmr.addEventListener(TimerEvent.TIMER_COMPLETE, prepareSpellTmrHandler, false, 0, true);
			actionTmr.start();
			idle = false;
			setState(ST_PREPARE_SPELL);
			setStopFrame(FL_PREPARE_SPELL_START);
		}
		override public function checkFrame():void
		{
//			super.checkFrame();
			var cl:String = currentLabel;
			var cf:int = currentFrame;
			if (cState == ST_WALK && cf == getLabNum(FL_WALK_END) + 1)
				setPlayFrame(FL_WALK_START);
			else if (cState == ST_ATTACK && cf == getLabNum(flAttackEnd) + 1)
			{
				setState(ST_NEUTRAL);
				idle = true;
				animationTmr.stop();
				checkState();
			}
		}
		protected function removeAnimationTmrListeners():void
		{
			animationTmr.removeEventListener(TimerEvent.TIMER, attackTmrHandler);
		}
		protected function removeActionTmrListeners():void
		{
			actionTmr.removeEventListener(TimerEvent.TIMER_COMPLETE, prepareSpellTmrHandler);
			actionTmr.removeEventListener(TimerEvent.TIMER_COMPLETE, castSpellTmrHandler);
		}
		override protected function removeListeners():void
		{
			super.removeListeners();
			removeAnimationTmrListeners();
			removeActionTmrListeners();
		}
		
		
		override public function cleanUp():void
		{
			super.cleanUp();
			if (pointer)
				pointer.cleanUp();
		}
		
		
		public function removePointer():void
		{
			pointer.removeEventListener(FinalFantasyPointer.EVENT_SELECT, pointerSelectHandler);
			pointer.removeEventListener(FinalFantasyPointer.EVENT_CANCEL, pointerCancelHandler);
			pointer = null;
		}
	}
}