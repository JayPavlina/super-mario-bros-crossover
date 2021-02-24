package com.smbc.messageBoxes
{
	import com.explodingRabbit.cross.games.Game;
	import com.explodingRabbit.display.CustomMovieClip;
	import com.explodingRabbit.utils.CustomDictionary;
	import com.explodingRabbit.utils.SortingFunctions;
	import com.smbc.characters.*;
	import com.smbc.data.CampaignModes;
	import com.smbc.data.CharacterInfo;
	import com.smbc.data.GameSettings;
	import com.smbc.data.GameStates;
	import com.smbc.data.MusicType;
	import com.smbc.data.SoundNames;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.CharacterPortrait;
	import com.smbc.graphics.PortraitSelector;
	import com.smbc.interfaces.IKeyPressable;
	import com.smbc.interfaces.ISingleton;
	import com.smbc.level.CharacterSelect;
	import com.smbc.level.Level;
	import com.smbc.level.TitleLevel;
	import com.smbc.managers.GameStateManager;
	import com.smbc.managers.GraphicsManager;
	import com.smbc.managers.SoundManager;
	import com.smbc.managers.StatManager;
	import com.smbc.managers.TutorialManager;
	import com.snesSpc.SnesSpc;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import flash.text.TextFormatAlign;
	import flash.utils.Dictionary;
	import flash.utils.setInterval;

	public class CharacterSelectBox extends MessageBox implements ISingleton, IKeyPressable
	{
		public static var instance:CharacterSelectBox;
		public static var lastChosenInd:int = 0;
		private static const PORTRAIT_SIZE:int = 52;
		private static const SPACE_BETWEEN_PORTRAITS:int = 4;
		private static const SN_REVIVE_CHARACTER:String = SoundNames.SFX_GAME_POWER_UP;
		private static const Y_POS:int = 160;
		private var unpauseGameOnDestroy:Boolean;
		private static const AXIS_HORZ:String = "x";
		private static const AXIS_VERT:String = "y";
		private static var TOP_ROW_Y:int;
		private static var BOT_ROW_Y:int;
		private static const NAME_BOX_WIDTH:int = 400;
		private static const NAME_BOX_HEIGHT:int = 150;
		public static const NAME_BOX_Y_POS:int = 290;
		private static const MIN_LIVES_FOR_ALLOW_REVIVAL:int = 1;
		public static const RANDOM_CHAR_NUM:int = -1;
		public static const MAP_SKIN_CHAR_NUM:int = -2;
		public static const FL_RANDOM:String = "random";
		public static const RANDOM_CHAR_NAME:String = "Random";
		public static const MAP_SKIN_CHAR_NAME:String = "Change Map Skin";
		public static const MODE_REVIVE:String = "revive";
		public static const MODE_CHARACTER_SELECT:String = "characterSelect";
		private static const SELECT0R_OFS:int = 0;
		private static const PS_FALLEN:int = Character.PS_FALLEN;
		private static const SELECTOR_SND_STR:String = SoundNames.SFX_GAME_CHARACTER_SELECT_CURSOR;
		private static const DIR_UP:String = "up";
		private static const DIR_DOWN:String = "down";
		private static const DIR_LEFT:String = "left";
		private static const DIR_RIGHT:String = "right";
		private static const DIR_NEUTRAL:String = "neutral";
		
		private static const NUM_PORTS_PER_ROW_ARR:Array = [6,6];
		private const ORDER_VEC:Vector.<int> = Vector.<int>([
			Mario.CHAR_NUM, Luigi.CHAR_NUM, Link.CHAR_NUM, Samus.CHAR_NUM, Simon.CHAR_NUM, MAP_SKIN_CHAR_NUM,
			MegaMan.CHAR_NUM, Bass.CHAR_NUM, Bill.CHAR_NUM,  Ryu.CHAR_NUM, Sophia.CHAR_NUM, RANDOM_CHAR_NUM
		]);
		private const CS_SCRN:CharacterSelect = CharacterSelect.instance;
		public var cCharNum:int;
		private var PORT_VEC:Vector.<CharacterPortrait> = new Vector.<CharacterPortrait>(ORDER_VEC.length,true); // contains portraits by ind
		private var PORT_DCT:Dictionary = new Dictionary(); // gets ind from portraits; port is key, ind is value
		private var CHAR_NUM_DCT:Dictionary = new Dictionary(); // gets charNum from ind
		private var SELECTOR:PortraitSelector = new PortraitSelector();
		private var SELECTABLE_CHARS_VEC:Vector.<int> = new Vector.<int>(); // contains indexes, not charNums
		private var selectableCharsRowArr:Array = []; // contains local indexes of each row
		private const C_SEL_MAX:int = ORDER_VEC.length - 1;
		private static const C_SEL_MIN:int = 0;
		private static const STAT_MNGR:StatManager = StatManager.STAT_MNGR;
		private var randomPortInd:int = ORDER_VEC.length - 1;
		private var mapSkinPortInd:int = randomPortInd - NUM_PORTS_PER_ROW_ARR[NUM_PORTS_PER_ROW_ARR.length - 1];
		private var sortDir:String;
		private var cSelInd:int = lastChosenInd;
		private var cSelPort:CharacterPortrait;
		private var cRow:int;
		private var NUM_ROWS:int = NUM_PORTS_PER_ROW_ARR.length;
		private const ROW_Y_POS:Vector.<int> = new Vector.<int>(NUM_ROWS,true);
		private var nameBox:CharNameBox;
		public var mode:String;
		private const LEVEL:Level = Level.levelInstance;
		private var allowRevival:Boolean;
		private var survivalMode:Boolean;
		private var lastY:Number; // the last portrait that was selected for up or down press, used for determining which portrait to select
		private static const SND_MNGR:SoundManager = SoundManager.SND_MNGR;
		private var selectCharNumOnStart:int;

		public var portContainer:Sprite;
		
		public function CharacterSelectBox(allowRevival:Boolean = false, selectCharNumOnStart:int = -1)
		{
			this.selectCharNumOnStart = selectCharNumOnStart;
			super();
//			if (instance)
//				throw new SingletonError();
			this.allowRevival = allowRevival;
			endYPos = Y_POS;
			ORDER_VEC.fixed = true;
			for (var i:int = 0; i < NUM_ROWS; i++) 
			{
				selectableCharsRowArr.push( [] );
			}
			if (CS_SCRN)
				instantGrow = true;
		}
		override public function initiate():void
		{
			super.initiate();
			instance = this;
			nameBox = new CharNameBox("test\\ntest",NAME_BOX_WIDTH,NaN,NAME_BOX_Y_POS,TextFormatAlign.CENTER,instantGrow);
			nameBox.initiate();
			setAllIconVisibility(GameSettings.charSelIconsVisible);
			if (GameSettings.campaignMode === CampaignModes.SURVIVAL)
				survivalMode = true;
			if (survivalMode && allowRevival && STAT_MNGR.numLives >= MIN_LIVES_FOR_ALLOW_REVIVAL)
			{
				changeMode(MODE_REVIVE); // might still be char select if no selectable chars
				if (mode == MODE_REVIVE && !STAT_MNGR.checkPStateVecForAllZeroes() )
				{
					var reviveMsgBx:PlainMessageBox = new PlainMessageBox(MessageBoxMessages.YOU_CAN_NOW_REVIVE);
					reviveMsgBx.nextMsgBxToFocus = this;
					reviveMsgBx.initiate();
				}
			}
			else
			{
				if (isDisableMenu && selectCharNumOnStart >= 0)
					cSelInd = convCharNumToInd(selectCharNumOnStart);
				changeMode(MODE_CHARACTER_SELECT);
			}
//			setSelection(convCharNumToInd(STAT_MNGR.curCharNum));
		}
		override protected function setUpText():void // sets up character portraits
		{
			portContainer = new Sprite();
			var n:int = ORDER_VEC.length;
			var cCol:int;
			for (var i:int; i < n; i++)
			{
				var charNum:int = ORDER_VEC[i];
				var portrait:CharacterPortrait = new CharacterPortrait(charNum);
				if (charNum >= 0)
					portrait.setIconPState(STAT_MNGR.getCharPState(charNum));
//				portrait.setType(charNum);
				CHAR_NUM_DCT[charNum] = i;
				PORT_VEC[i] = portrait;
				PORT_DCT[portrait] = i;
				
				portrait.x = cCol*PORTRAIT_SIZE + cCol*SPACE_BETWEEN_PORTRAITS + SPACE_BETWEEN_PORTRAITS;
				portrait.y = cRow*PORTRAIT_SIZE + cRow*SPACE_BETWEEN_PORTRAITS + SPACE_BETWEEN_PORTRAITS;
				ROW_Y_POS[cRow] = portrait.y;
				cCol++;
				if (cCol == NUM_PORTS_PER_ROW_ARR[cRow])
				{
					cCol = 0;
					cRow++;
				}
				portContainer.addChild( portrait );	
			}
			TOP_ROW_Y = ROW_Y_POS[0];
			BOT_ROW_Y = ROW_Y_POS[1];
			TXT_CONT.addChild(portContainer);
			portContainer.addChild(SELECTOR);
			TXT_CONT.x = CONTAINER_PADDING;
			TXT_CONT.y = CONTAINER_PADDING;
		}
		private function alignPortraits(selectCurInd:Boolean = false):void
		{
			var n:int = PORT_VEC.length;
			var numPortraits:int;
			var portVecTemp:Vector.<CharacterPortrait> = new Vector.<CharacterPortrait>();
			for (var i:int = 0; i < n; i++) 
			{
				var portrait:CharacterPortrait = PORT_VEC[i];
				if (SELECTABLE_CHARS_VEC.indexOf(i) != -1 || (i == randomPortInd && CS_SCRN != null) )
				{
					portContainer.addChildAt(portrait,portContainer.getChildIndex(SELECTOR) - 1);
					portVecTemp[numPortraits] = portrait;
					numPortraits++;
				}
				else if (portContainer.contains(portrait) )
					portContainer.removeChild(portrait);
			}
			n = numPortraits;
			if (mode != MODE_REVIVE)
				n++;
			var numTopRow:int;
			var numBotRow:int;
			if ( n % 2 == 0 )
			{
				numTopRow = n / 2;
				numBotRow = numTopRow;
//				numTopRow--; // for map selection
//				trace("even");
			}
			else
			{
				numTopRow = Math.ceil(n/2);
				numBotRow = numTopRow;
				if (mode == MODE_REVIVE)
				{
					numTopRow--;
					numBotRow++;
				}
			}
			if (mode != MODE_REVIVE)
				n--;
			var col:int;
			var row:int = 0;
			for (i = 0; i < n; i++) 
			{
				portrait = portVecTemp[i];
//				if (portrait.
				portrait.x = col*PORTRAIT_SIZE + col*SPACE_BETWEEN_PORTRAITS + SPACE_BETWEEN_PORTRAITS;
				portrait.y = row*PORTRAIT_SIZE + row*SPACE_BETWEEN_PORTRAITS + SPACE_BETWEEN_PORTRAITS;
//				trace("portrait.x: "+portrait.x+" portrait.y: "+portrait.y);
				col++;
				if (row == 0 && ( (col == numTopRow && CS_SCRN) || (col == numTopRow - 1 && (CS_SCRN == null || StatManager.enabledSkinSetCount == 1) ) ) )
				{
					if (mode != MODE_REVIVE && CS_SCRN != null && StatManager.enabledSkinSetCount > 1)
					{
						portrait = getMapSkinPortrait();
						col--;
						portrait.x = col*PORTRAIT_SIZE + col*SPACE_BETWEEN_PORTRAITS + SPACE_BETWEEN_PORTRAITS;
						portrait.y = row*PORTRAIT_SIZE + row*SPACE_BETWEEN_PORTRAITS + SPACE_BETWEEN_PORTRAITS;
						portContainer.addChildAt(portrait,portContainer.getChildIndex(SELECTOR) - 1);
						i--; // makes it repeat for previous portrait since it was overwritten
					}
					col = 0;
					row++;
				}
//				getMapSkinPortrait().x = getChooseRandomPortrait().x;
//				getChooseRandomPortrait().x = getMapSkinPortrait().x;
			}
//			trace("txt_cont.width: "+TXT_CONT.width);
			if (selectCurInd && SELECTABLE_CHARS_VEC.indexOf(cSelInd) != -1)
				setSelection(cSelInd);
			else
				setSelection( getNearestPortrait(DIR_NEUTRAL) );
			resizeBox(true,false,4);
		}
		
		private function getMapSkinPortrait():CharacterPortrait
		{
			return convIndToPort( convCharNumToInd(MAP_SKIN_CHAR_NUM) );
		}
		
		private function getChooseRandomPortrait():CharacterPortrait
		{
			return convIndToPort( convCharNumToInd(RANDOM_CHAR_NUM) );
		}
		
		private function changeMode(newMode:String):void
		{
			mode = newMode;
			clearSelectableChars();
			var psCheck:int;
			var pStateVec:Vector.<int> = STAT_MNGR.pStateVec;
			var n:int = pStateVec.length;
			var i:int;
			var pState:int;
			if (mode == MODE_CHARACTER_SELECT)
			{
				SELECTOR.gotoAndStop(PortraitSelector.FL_NORMAL_START);
				for (i; i < n; i++) // i is charNum
				{
					pState = pStateVec[i];
					if (pState != PS_FALLEN && ( CS_SCRN == null || StatManager.characterIsEnabled(i) ) )
					{
						addSelectableChar( convCharNumToInd(i), true ); // i is charNum
						if ( isCharacterDisableScreen && !StatManager.characterIsEnabled(i) )
							markPortraitFallen(PORT_VEC[convCharNumToInd(i)]);
					}
//					else
//						markPortraitFallen(PORT_VEC[convCharNumToInd(i)]);
				}
				if (CS_SCRN != null)
					addSelectableChar(randomPortInd, true);
				setSelection(cSelInd);
				/*if (cSelInd != randomPortInd)
				{
					setSelection(cSelInd);
					
					if (SELECTABLE_CHARS_VEC.indexOf(cSelInd) == -1) // not sure about this
					{
//						moveCursor = true;
//						fakeKeyPress = true;
						pressRhtBtn();
//						fakeKeyPress = false;
					}
				}*/
				var tm:TutorialManager = TutorialManager.TUT_MNGR;
				tm.checkTutorial(tm.CHARACTER_SELECT,true);
			}
			else if (mode == MODE_REVIVE)
			{
				SELECTOR.gotoAndStop(PortraitSelector.FL_REVIVE_START);
				for (i; i < n; i++) 
				{
					pState = pStateVec[i];
					if (!STAT_MNGR.charIsFullyUpgraded(i) && StatManager.characterIsEnabled(i) )
						addSelectableChar( convCharNumToInd(i), true ); // i is charNum
				}
				if (!SELECTABLE_CHARS_VEC.length) // changes to character select if there are no selectable chars
				{
					changeMode(MODE_CHARACTER_SELECT);
					return;
				}
				else
				{
					n = SELECTABLE_CHARS_VEC.length;
					for (i = 0; i < n; i++) 
					{
						var ind:int = SELECTABLE_CHARS_VEC[i];
						pState = pStateVec[ convIndToCharNum(ind) ];
						if (pState == PS_FALLEN)
							markPortraitFallen( PORT_VEC[ind] );
					}
					addSelectableChar( randomPortInd, true );
					setSelection(cSelInd)
					if (PORT_VEC.indexOf(cSelInd) == -1)
						setSelection( getNearestPortrait(DIR_NEUTRAL) );
				}
			}
			alignPortraits(true);
		}
		private function setAllIconVisibility(visibility:Boolean):void
		{
			var n:int = PORT_VEC.length;
			for (var i:int = 0; i < n; i++) 
			{
				var port:CharacterPortrait = PORT_VEC[i];
				port.setIconVisibility(visibility);
			}
		}
		private function setSelection(obj:Object, playSound:Boolean = false):void
		{
			if (obj == null)
				return;
			// accepts both indexes and portraits as selection
			if (obj is int)
			{
				cSelPort = PORT_DCT[ int(obj) ];
				cSelInd = int(obj);
			}
			else
			{
				cSelPort = obj as CharacterPortrait;
				cSelInd = convPortToInd(cSelPort);
			}
			if (cSelInd < C_SEL_MIN)
				cSelInd = C_SEL_MAX;
			else if (cSelInd > C_SEL_MAX)
				cSelInd = C_SEL_MIN;
			cRow = getIndRowNum(cSelInd);
			cCharNum = convIndToCharNum(cSelInd);
			cSelPort = PORT_VEC[cSelInd];
			SELECTOR.x = cSelPort.x + SELECT0R_OFS;
			SELECTOR.y = cSelPort.y + SELECT0R_OFS;
			if (CS_SCRN != null)
			{
				CS_SCRN.setSelection(cCharNum);
			}
				changeNameBoxText();
			if (playSound)
				SND_MNGR.playSoundNow(SELECTOR_SND_STR);
		}
		private function markPortraitFallen(portrait:CharacterPortrait):void
		{
			var portSprite:Sprite = portrait.getPortraitBmpSprite();
			if (portSprite)
				desaturate(portSprite);
		}
		private function unmarkPortraitFallen(portrait:CharacterPortrait):void
		{
			if (portrait.recoloredSprite)
				portrait.recoloredSprite.filters = [];
		}
		private function reviveCharacter(ind:int):void
		{
//			removeSelectableChar(ind);
//			return;
			STAT_MNGR.loseLife();
			if (cSelInd == randomPortInd)
			{
				setSelection(ind,false);
				setSelection(randomPortInd,false);
			}
			var charNum:int = convIndToCharNum(ind);
			var currentPState:int = STAT_MNGR.getCharPState(charNum);
			var portrait:CharacterPortrait = PORT_VEC[ind];
			var strengthened:Boolean = false;
			var newPState:int = Character.PS_NORMAL;
			if (currentPState != PS_FALLEN)
			{
//				newPState = Character.PS_FIRE_FLOWER;
				Character.hitRandomUpgrade(charNum,false);
				Character.hitRandomUpgrade(charNum,false);
				strengthened = true;
				if (CS_SCRN && CS_SCRN.player)
					CS_SCRN.player.revivalBoost();
				portrait.update();
			}
//			changeCharPState(revivedChar,nps);
			if (currentPState != newPState)
			{
				STAT_MNGR.updatePStateVec(charNum,newPState);
				unmarkPortraitFallen( portrait );
			}
//			portrait.setIconPState(newPState);
			if ( strengthened && STAT_MNGR.charIsFullyUpgraded(charNum) )
			{
				var selInd:int = SELECTABLE_CHARS_VEC.indexOf(ind);
				if (selInd != -1)
					removeSelectableChar( selInd );
//				selector.gotoAndStop(FL_SELECTOR_SELECT);
			}
			if (cSelInd != randomPortInd)
				setSelection(cSelInd);
			SND_MNGR.playSoundNow(SN_REVIVE_CHARACTER);
			if (STAT_MNGR.numLives < MIN_LIVES_FOR_ALLOW_REVIVAL || SELECTABLE_CHARS_VEC.length == 1)
				changeMode(MODE_CHARACTER_SELECT);
			/*var lives:String = STAT_MNGR.numLives.toString();
			if (lives.length == 1)
				LIVES_TFC.text = "0"+lives;
			else
				LIVES_TFC.text = lives;*/
		}
		/*private function charCanBeStrengthened(char:MovieClip):Boolean
		{
			if (char.pState == Character.PS_NORMAL || char.pState == Character.PS_MUSHROOM)
				return true;
			else
				return false;
		}*/
		public function desaturate(mc:Sprite):void
		{
			var matrix:Array = [];
			matrix = matrix.concat([0.3, 0.59, 0.11, 0, -10]);  // red
			matrix = matrix.concat([0.3, 0.59, 0.11, 0, -10]);  // green
			matrix = matrix.concat([0.3, 0.59, 0.11, 0, -10]);  // blue
			matrix = matrix.concat([0,   0,    0,    1, 0]);  // alpha
			
			var cmFilter:ColorMatrixFilter = new ColorMatrixFilter(matrix);
			mc.filters = [cmFilter];
		}
		private function changeNameBoxText():void
		{
			var charArr:Array;
			var name:String;
			var skinName:String;
			var game:String;
			if (cCharNum >= 0)
			{
				charArr = CharacterInfo.CHAR_ARR[cCharNum];
				name = charArr[CharacterInfo.IND_CHAR_NAME_FULL];
				skinName = STAT_MNGR.getSkinName(true);
				game = Game(charArr[CharacterInfo.IND_GAMES][0]).fullName;
			}
			else if (cCharNum == MAP_SKIN_CHAR_NUM)
				name = MAP_SKIN_CHAR_NAME;
			else
				name = RANDOM_CHAR_NAME;
				
			if (mode == MODE_REVIVE)
			{
				if (cCharNum != RANDOM_CHAR_NUM && cCharNum != MAP_SKIN_CHAR_NUM)
				{
					if (STAT_MNGR.getCharPState(cCharNum) == PS_FALLEN)
						skinName = "Revive";
					else
						skinName = "Power up";
				}
				var numLives:int = STAT_MNGR.numLives;
				if (numLives > 1)
					game = numLives + " lives remaining";
				else
					game = numLives + " life remaining";
			}
			nameBox.changeText(name,game,skinName);
		}
		/*private function getRandomCharacter(selectableCharsOnly:Boolean = true):String
		{			
			var num:int;
			if (selectableCharsOnly)
			{
				var arr:Array = [];
				for each (var mc:MovieClip in SELECTABLE_CHARS_VEC)
				{
					if (mc != itemBlockStg)
						arr.push(mc.charNum);
				}
				if (!arr.length)
					return null;
				num = int( Math.random() * arr.length);
				num = arr[num];
			}
			else
				num = STAT_MNGR.getRandomCharNum();
			var name:String = STAT_MNGR.convNumToName(num);
			return name;
		}*/
		private function convCharNumToInd(charNum:int):int
		{
			return CHAR_NUM_DCT[charNum];
		}
		private function convIndToCharNum(ind:int):int
		{
			return ORDER_VEC[ind];
		}
		private function getRandomCharInd():int
		{			
//			if (selectableCharsOnly)
//			{
				var rNum:int = int( Math.random() * (SELECTABLE_CHARS_VEC.length-1)); // doesn't include random block
				return SELECTABLE_CHARS_VEC[rNum];
//			}
//			else
//				return convCharNumToInd( STAT_MNGR.getRandomCharNum() );
		}
		public function getPortraitArr():Array
		{
			var arr:Array = [];
			for each (var mainThing:CharacterPortrait in PORT_VEC)
			{
//				if (!mainThing)
//					continue;
				var portrait:CustomMovieClip = mainThing.portrait;
				var portParent:DisplayObjectContainer;
				if (portrait)
					portParent = portrait.parent;
				if (portParent)
				{
//					portrait.drawnFramesDct = null;
//					portrait.drawnFramesDct = new Dictionary();
					arr.push(portParent);
				}
			}
			return arr;
		}
		private function addSelectableChar(ind:int,cancelAlignment:Boolean = false):void
		{
			SELECTABLE_CHARS_VEC.push(ind);
			var n:int = SELECTABLE_CHARS_VEC.length;
			var cRowArr:Array = selectableCharsRowArr[ getIndRowNum(ind) ];
			cRowArr.push( convGlobalIndToRowInd( ind ) );
			cRowArr.sort(Array.NUMERIC);
			SELECTABLE_CHARS_VEC.sort(SortingFunctions.sortNums);
			if (!cancelAlignment)
				alignPortraits();
		}
		/*private function removeSelectableChar(ind:int):void
		{
			SELECTABLE_CHARS_VEC.splice(ind,1);
//			selectableCharsRowArr[ getIndRowNum(ind) ].removeItem( convGlobalIndToRowInd(ind) );
			var cRowArr:Array = selectableCharsRowArr[ getIndRowNum(ind) ];
			var cRowInd:int = cRowArr.indexOf( convGlobalIndToRowInd(ind) );
			cRowArr.splice(cRowInd,1);
			trace("selectableCharsVec: "+SELECTABLE_CHARS_VEC);
		}*/
		private function removeSelectableChar(ind:int,cancelAlignment:Boolean = false):void
		{
			SELECTABLE_CHARS_VEC.splice(ind,1);
//			selectableCharsRowArr[ getIndRowNum(ind) ].removeItem( convGlobalIndToRowInd(ind) );
			var cRowArr:Array = selectableCharsRowArr[ getIndRowNum(ind) ];
			var cRowInd:int = cRowArr.indexOf( convGlobalIndToRowInd(ind) );
			cRowArr.splice(cRowInd,1);
//			trace("selectableCharsVec: "+SELECTABLE_CHARS_VEC);
			if (!cancelAlignment)
				alignPortraits();
		}
		private function clearSelectableChars():void
		{
			SELECTABLE_CHARS_VEC.length = 0;
			for (var i:int = 0; i < NUM_ROWS; i++) 
			{
				var arr:Array = selectableCharsRowArr[i];
				arr.length = 0;
			}
		}
		override public function pressAtkBtn():void
		{
			if (mode == MODE_CHARACTER_SELECT && CS_SCRN == null)
			{
				cancel();
				nameBox.cancel();
				SND_MNGR.playSoundNow(SoundNames.SFX_GAME_HIT_CEILING);
			}
			else if (mode == MODE_REVIVE && !STAT_MNGR.checkPStateVecForAllZeroes())
			{
				var strVec:Vector.<String> = new Vector.<String>();
				strVec.push(MenuBoxItems.NO);
				strVec.push(MenuBoxItems.YES);
				var msgBx:PlainMessageMenuBox = new PlainMessageMenuBox(MessageBoxMessages.CANCEL_REVIVE,strVec);
				msgBx.nextMsgBxToFocus = this;
				msgBx.initiate();
			}
		}
		public function confirmCancelRevive():void
		{
			changeMode(MODE_CHARACTER_SELECT);
		}
		
		override public function pressJmpBtn():void
		{
			pressedSelectCharacterButton(false);
		}
		
		override public function pressSpcBtn():void
		{
			if (CS_SCRN != null && cSelInd != mapSkinPortInd)
				pressedSelectCharacterButton(true);
			
		}
		
		private function pressedSelectCharacterButton(randomCharacterSkin:Boolean):void
		{
			if (mode == MODE_CHARACTER_SELECT)
			{
				if (CS_SCRN != null)
					lastChosenInd = cSelInd;
				if (cSelInd == mapSkinPortInd)
				{
					if (GameSettings.randomMapSkin)
					{
						nextMsgBxToCreate = new PlainMessageBox(MessageBoxMessages.CANNOT_CHANGE_MAP_SKIN);
						nextMsgBxToCreate.nextMsgBxToCreate = new CharacterSelectBox();
					}
					else
						nextMsgBxToCreate = new MapSkinMenu();	
					SND_MNGR.playSound(SoundNames.SFX_GAME_COIN);
				}
				else
				{
					if (cSelInd == randomPortInd)
					{
						cSelInd = getRandomCharInd();
						setSelection( cSelInd, false );
						
						if (CS_SCRN)
						{
							if (randomCharacterSkin)
								GraphicsManager.INSTANCE.changeCharacterSkin(CS_SCRN.player, GraphicsManager.CHAR_SKIN_NUM_RANDOM);
							CS_SCRN.chooseCharacter( cCharNum );
						}
					}
					else
					{
						if (CS_SCRN != null)
						{
							if (StatManager.getEnabledCharacterSkinCount(cCharNum) == 1 || randomCharacterSkin )
							{
								if (randomCharacterSkin)
									GraphicsManager.INSTANCE.changeCharacterSkin(CS_SCRN.player, GraphicsManager.CHAR_SKIN_NUM_RANDOM);
								CS_SCRN.chooseCharacter( cCharNum );
								
							}
							else
							{
								nextMsgBxToCreate = new CharacterSkinMenu(cCharNum, isCharacterSkinDisableScreen);
								SND_MNGR.playSoundNow(SoundNames.SFX_GAME_COIN);
							}
						}
						else if (isCharacterSkinDisableScreen)
						{
							nextMsgBxToCreate = new CharacterSkinMenu(cCharNum, isCharacterSkinDisableScreen);
							SND_MNGR.playSoundNow(SoundNames.SFX_GAME_COIN);
						}
						else // disable characters
						{
							if ( StatManager.characterIsEnabled(cCharNum) && StatManager.enabledCharacterCount <= StatManager.MINIMUM_ENABLED_CHARACTER_COUNT)
								return; // don't allow disabling all characters 
							
							StatManager.toggleCharacterIsEnabled(cCharNum);
							if ( StatManager.characterIsEnabled(cCharNum) )
								unmarkPortraitFallen(cSelPort);
							else
								markPortraitFallen(cSelPort);
							SND_MNGR.playSoundNow(SoundNames.SFX_GAME_COIN);
						}
					}
				}
				if (!isCharacterDisableScreen)
				{
					cancel();
					nameBox.cancel();
				}
			}
			else if (mode == MODE_REVIVE)
			{
				if (cSelInd == randomPortInd)
					reviveCharacter( getRandomCharInd() );
				else
					reviveCharacter(cSelInd);
			}
		}
		
		private function get isDisableMenu():Boolean
		{
			return CS_SCRN == null;
		}
		
		private function get isCharacterDisableScreen():Boolean
		{
			return CS_SCRN == null && nextMsgBxToCreate is GeneralOptions;
		}
		
		private function get isCharacterSkinDisableScreen():Boolean
		{
			return CS_SCRN == null && nextMsgBxToCreate is DisableSkinsMenu;
		}
		
		override public function pressUpBtn():void
		{
			/*if (cRow == 0)
				cSelInd = cSelInd + NUM_PORTS_PER_ROW_ARR[0]; // makes it move to left instead of right
			else
			{
				if (cSelInd == C_SEL_MAX)
					cSelInd = NUM_PORTS_PER_ROW_ARR[0] - 1;
				else
					cSelInd = cSelInd - NUM_PORTS_PER_ROW_ARR[0];
			}
			cRow = getNextRow();
			cSelInd--;
			pressRhtBtn();*/
			setSelection( getNearestPortrait(DIR_UP), true );
			lastY = ROW_Y_POS[cRow];
		}
		override public function pressDwnBtn():void
		{
			/*if (cRow == 0)
				cSelInd = cSelInd + NUM_PORTS_PER_ROW_ARR[0];
			else
			{
				if (cSelInd == C_SEL_MAX)
					cSelInd = C_SEL_MIN;
				else
					cSelInd = cSelInd - NUM_PORTS_PER_ROW_ARR[0];
			}
			cRow = getNextRow();
			cSelInd++;
			pressLftBtn();*/
			setSelection( getNearestPortrait(DIR_DOWN), true );
			lastY = ROW_Y_POS[cRow];
		}
		private function getIndRowNum(ind:int):int
		{
			var rowStartInd:int;
			for (var i:int = 0; i < NUM_ROWS; i++) 
			{
				var curRowLength:int = NUM_PORTS_PER_ROW_ARR[i];
				rowStartInd += curRowLength;
				if (ind < rowStartInd)
					return i;
			}
			return -1;
		}
		
		override public function cancel():void
		{
			super.cancel();
			if (isCharacterSkinDisableScreen && !(Level is TitleLevel) )
			{
				var player:Character = LEVEL.player;
				if (!GraphicsManager.INSTANCE.skinIsActive(player.currentBmdSkin))
					GraphicsManager.INSTANCE.changeCharacterSkin(player);
			}
		}
		
		private function convGlobalIndToRowInd(ind:int):int
		{
			var rowNum:int = getIndRowNum(ind);
			var localInd:int = ind;
			for (var i:int = 0; i < rowNum; i++) 
			{
				var curRowLength:int = NUM_PORTS_PER_ROW_ARR[i];
				localInd -= curRowLength;
			}
			return localInd;
		}
		private function convRowIndToGlobal(ind:int,rowNum:int = -1):int
		{
			var globalInd:int = ind;
			if (rowNum == -1)
				rowNum = cRow;
			for (var i:int = 0; i < rowNum; i++) 
			{
				var curRowLength:int = NUM_PORTS_PER_ROW_ARR[i];
				globalInd += curRowLength;
			}
			return globalInd;
		}
		private function getNearestPortrait(dir:String,startInd:int = -1,limitToRow:int = -1):CharacterPortrait
		{
//			if (startInd == -1)
//				startInd == cSelInd;
			var portraitToMoveFrom:CharacterPortrait;
			var limitX:int;
			var limitY:int;
			var axis:String;
			var oppAxis:String;
			var xMax:int;
			var xMin:int;
			var startPnt:Point = new Point(SELECTOR.x - SELECT0R_OFS,SELECTOR.y - SELECT0R_OFS);
			if (dir == DIR_UP || dir == DIR_DOWN)
			{
				axis = AXIS_VERT;
				oppAxis = AXIS_HORZ;
				limitX = startPnt.x;
				if (startPnt.y ==	 TOP_ROW_Y)
					limitY = BOT_ROW_Y;
				else
					limitY = TOP_ROW_Y;
			}
			else // assumes horizontal
			{
				axis = AXIS_HORZ;
				oppAxis = AXIS_VERT;
				limitY = startPnt.y;
			}
			var limitedVec:Vector.<CharacterPortrait> = new Vector.<CharacterPortrait>();
			var n:int = PORT_VEC.length;
			for (var i:int = 0; i < n; i++) 
			{
				var portrait:CharacterPortrait = PORT_VEC[i];
				if (!portrait.parent)
					continue;
				if (startPnt.x == portrait.x && startPnt.y == portrait.y)
					portraitToMoveFrom = portrait;
				if (axis == AXIS_HORZ && portrait.y == limitY)
					limitedVec.push(portrait);
				else if (axis == AXIS_VERT && portrait.y == limitY)
				{
					limitedVec.push(portrait);
				}
			}
			n = limitedVec.length;
			if (!portraitToMoveFrom || axis == AXIS_VERT)
			{
				for (i = 0; i < n; i++) 
				{
					portrait = limitedVec[i];
					if (axis == AXIS_HORZ)
					{
						if (i == 0)
							xMin = portrait.x;
						else if (i == n - 1)
							xMax = portrait.x;
					}
					else
					{
						if (portrait.x == portraitToMoveFrom.x) // if bottom row and top have the same number
							return portrait;
					}
//					trace("portrait.x: "+portrait.x+" portrait.y: "+portrait.y);
				}
				if (axis == AXIS_HORZ)
				{
					if (x < xMin)
						portraitToMoveFrom = limitedVec[0];
					else if (x > xMin)
						portraitToMoveFrom = limitedVec[n - 1];
				}
				else
					return limitedVec[n - 1]; // if bottom row is longer than top
			}
			else if (axis == AXIS_HORZ)
				limitedVec.sort(sortByX);
			if (dir == DIR_NEUTRAL)
				return portraitToMoveFrom;
			else
				return determineSelection(dir,limitedVec,portraitToMoveFrom);
//			limitedVec.sort(sortPortVecHorz);
			return portrait;
		}
		private function determineSelection(dir:String,vec:Vector.<CharacterPortrait>,portraitToMoveFrom:CharacterPortrait):CharacterPortrait
		{
			var ind:int = vec.indexOf(portraitToMoveFrom);
			var indMin:int = 0;
			var indMax:int = vec.length - 1;
			if (dir == DIR_LEFT)
			{
				ind--;
				if (ind < indMin)
					ind = indMax;
			}
			else if (dir == DIR_RIGHT)
			{
				ind++;
				if (ind > indMax)
					ind = indMin;
			}
			return vec[ind];
		}
//		private function getNearestPortrait(dir:String,startInd:int = -1,limitToRow:int = -1):CharacterPortrait
//		{
//			// -1 looks at lower index, 0 looks at same index, 1 looks at greater index
//			if (startInd == -1)
//				startInd == cSelInd;
//			if (limitToRow != -1)
//				throw new Error("not set up to work vertically yet");
//			sortDir = dir;
//			if (isNaN(lastY))
//				lastY = ROW_Y_POS[cRow];
//			var selectablePortraitsVec:Vector.<CharacterPortrait> = new Vector.<CharacterPortrait>();
//			var portrait:CharacterPortrait;
//			var axis:String = "x";
//			var oppAxis:String = "y";
//			var reversed:Boolean;
//			if (dir == DIR_UP || dir == DIR_DOWN)
//			{
//				axis = "y";
//				oppAxis = "x";
//			}
//			var port:CharacterPortrait = convIndToPort(SELECTABLE_CHARS_VEC[0]);
//			var portMinPnt:Point = new Point(port.x,port.y);
//			var portMaxPnt:Point = new Point(port.x,port.y);
//			var limitXMaxMinToCurRow:Boolean;
//			if (dir == DIR_LEFT || dir == DIR_RIGHT)
//				limitXMaxMinToCurRow = true;
//			var n:int = SELECTABLE_CHARS_VEC.length;
//			for (var i:int = 0; i < n; i++) // gets selectable portraits and sets max and min
//			{
//				port = convIndToPort(SELECTABLE_CHARS_VEC[i]);
//				selectablePortraitsVec[i] = port;
//				if (port.x < portMinPnt.x)
//				{
//					if (!limitXMaxMinToCurRow || port.y == cSelPort.y)
//						portMinPnt.x = port.x;
//				}
//				if (port.y < portMinPnt.y)
//					portMinPnt.y = port.y;
//				if (port.x > portMaxPnt.x)
//				{
//					if (!limitXMaxMinToCurRow || port.y == cSelPort.y)
//						portMaxPnt.x = port.x;
//				}
//				if (port.x > portMaxPnt.y)
//					portMaxPnt.y = port.y;
//			}
//			var posToTest:int = cSelPort[axis];
//			// check if selector needs to switch sides, like if all the way on the left
//			var lastPosToTest:Number = posToTest;
//			var changeLastY:Boolean;
//			if (dir == DIR_LEFT && cSelPort.x == portMinPnt.x)
//				posToTest = portMaxPnt.x + 1;
//			else if (dir == DIR_RIGHT && cSelPort.x == portMaxPnt.x)
//				posToTest = portMinPnt.x - 1;
//			else if (dir == DIR_UP && cSelPort.y == portMinPnt.y)
//				posToTest = portMaxPnt.x + 1;
//			else if (dir == DIR_DOWN && cSelPort.y == portMaxPnt.y)
//				posToTest = portMinPnt.y - 1;
//			if (lastPosToTest != posToTest)
//			{
//				changeLastY = true;
//				lastY = ROW_Y_POS[cRow];
//			}
//			trace("lastPosToTest: "+lastPosToTest+" postToTest: "+posToTest);
////			if (dir == DIR_LEFT || dir == DIR_RIGHT)
////				selectablePortraitsVec = sortSeparateRows(selectablePortraitsVec);
////			else
//				selectablePortraitsVec.sort(sortPortVecHorz);
//			/*if (!portMinPnt)
//			{
//				var portMin:CharacterPortrait = selectablePortraitsVec[0];
//				var portMax:CharacterPortrait = selectablePortraitsVec[n-1];
//				portMinPnt = new Point(portMin.x,portMin.y);
//				portMaxPnt = new Point(portMax.x,portMax.y);
//			}*/
//			trace("max: "+portMaxPnt+" min: "+ portMinPnt);
//			
//			if (dir == DIR_LEFT || dir == DIR_UP)
//			{
//				selectablePortraitsVec.reverse();
//				reversed = true;
//			}
//			var cPos:int;
//			trace("cx: "+cSelPort.x+" cy: "+cSelPort.y+" axis: "+axis+" dir: "+dir); 
////			if (dir == DIR_RIGHT || dir == DIR_UP)
////			{
//				for (i = 0; i < n; i++)
//				{
//					portrait = selectablePortraitsVec[i];
//					trace("nx: "+portrait.x+" ny: "+portrait.y);
//					if ( (!reversed && portrait[axis] > posToTest ) || (reversed && portrait[axis] < posToTest) )
//					{
//						if (changeLastY)
//							lastY = portrait.y;
//						return portrait;
//					}
//				}
////			}
//			/*else if (dir == DIR_LEFT || dir == DIR_DOWN)
//			{
//				for (i = n-1; i >= 0; i--)
//				{
//					portrait = selectablePortraitsVec[i];
//					trace("nx: "+portrait.x+" ny: "+portrait.y);
//					if (portrait[axis] < posToTest)
//					{
//						trace("cx: "+cSelPort.x+" cy: "+cSelPort.y);
//						return portrait;
//					}
//				}
//			}*/
//			/*else if (dir == 0)
//			{
//				for (i = 0; i < n; i++)
//				{
//					ind = cRowArr[i];
//					if (ind == localStartInd)
//						return convRowIndToGlobal(ind,limitToRow);
//				}
//			}*/
//			return null;
//		}
		
		private function setOppositeLastY():void
		{
			if (lastY == ROW_Y_POS[0])
				lastY = ROW_Y_POS[1];
			else
				lastY = ROW_Y_POS[0];
			
		}
		private function sortSeparateRows(vec:Vector.<CharacterPortrait>):Vector.<CharacterPortrait>
		{
			vec = vec.concat();
			var cRowVec:Vector.<CharacterPortrait> = new Vector.<CharacterPortrait>(); // current Row
			var oRowVec:Vector.<CharacterPortrait> = new Vector.<CharacterPortrait>(); // opposite row
			var n:int = vec.length;
			for (var i:int = 0; i < n; i++) 
			{
				var port:CharacterPortrait = vec[i];
				if (port.y == cSelPort.y)
					cRowVec.push(port);
				else
					oRowVec.push(port);
			}
			cRowVec.sort(sortRows);
			oRowVec.sort(sortRows);
			function sortRows(port1:CharacterPortrait,port2:CharacterPortrait):int
			{
				var num1:Number = port1.x;
				var num2:Number = port2.x;
				if (num1 < num2)
					return -1;
				if (num1 > num2)
					return 1;
				return 0;
			}
			if (sortDir == DIR_RIGHT)
				return cRowVec.concat(oRowVec);
			else
				return oRowVec.concat(cRowVec);
		}
		
		private function sortByX(port1:CharacterPortrait,port2:CharacterPortrait):int
		{
			var n1:Number = port1.x;
			var n2:Number = port2.x;
			if (n1 < n2)
				return -1;
			else if (n1 > n2)
				return 1;
			else
				return 0;
		}
		
		private function sortPortVecHorz(port1:CharacterPortrait,port2:CharacterPortrait):int
		{
			var num1:Number;
			var num2:Number;
			if (sortDir == DIR_LEFT || sortDir == DIR_RIGHT)
			{
				num1 = port1.x;
				num2 = port2.x;
			}
			if (sortDir == DIR_LEFT || sortDir == DIR_RIGHT)
			{
				num1 = port1.x;
				num2 = port2.x;
			}
			else if (sortDir == DIR_DOWN || sortDir == DIR_UP)
			{
				num1 = port1.y;
				num2 = port2.y;
			}
			if (num1 < num2)
				return -1;
			if (num1 > num2)
				return 1;
			// sort by lastRow pressed button on
			if (sortDir == DIR_LEFT || sortDir == DIR_RIGHT)
			{
				// port1.x == port1.y (same column)
				if (port1.y == lastY)
				{
					if (sortDir == DIR_RIGHT)
						return -1;
					return 1;
				}
				if (sortDir == DIR_RIGHT)
					return 1;
				return -1;
			}
			// sort by distance
			var dist1:Number = getDistance(cSelPort.x,cSelPort.y,port1.x,port1.y);
			var dist2:Number = getDistance(cSelPort.x,cSelPort.y,port2.x,port2.y);
			if (sortDir == DIR_RIGHT || sortDir == DIR_DOWN)
			{
				num1 = dist1
				num2 = dist2
			}
			else if (sortDir == DIR_LEFT || sortDir == DIR_UP)
			{
				num1 = dist2
				num2 = dist1
			}
			if (num1 < num2)
				return -1;
			if (num1 > num2)
				return 1;
			return 0;
		}
		private function getDistance(x1:Number,y1:Number,x2:Number,y2:Number):Number
		{
			var dx:Number = x1 - x2;
			var dy:Number = y1 - y2;
			return Math.sqrt(dx * dx + dy * dy);
		}
		/*private function searchRow(rowNum:int,orderArr:Array = null,startInd:int = -1):int
		{
			if (startInd == -1)
				startInd = cSelInd;
			if (!orderArr)
				orderArr = [1,-1,0];
			var n:int = orderArr.length;
			for (var i:int = 0; i < n; i++) 
			{
				var num:int = getNearestInd(rowNum,orderArr[i],startInd);
				if (num != -1)
					return num;
			}
			return -1;
			
		}*/
		private function getNextRow():int
		{
			if (cRow == 0)
				return 1;
			return 0;
		}
		private function convIndToPort(ind:int):CharacterPortrait
		{
			return PORT_VEC[ind];
		}
		private function convPortToInd(portrait:CharacterPortrait):int
		{
			return PORT_DCT[portrait];
		}
		private function getLowestRowIndLocal(row:int = -1):int
		{
			if (row == -1)
				row = cRow;
			return selectableCharsRowArr[row][0];
		}
		private function getHighestRowIndLocal(row:int = -1):int
		{
			if (row == -1)
				row = cRow;
			var arr:Array = selectableCharsRowArr[row];
//			trace("cRowArr: "+arr);
			return arr[arr.length - 1];
		}
		override public function pressLftBtn():void
		{
			/*var startInd:int = cSelInd;
			var searchOrder:Array = [-1,1,0];
			if ( convGlobalIndToRowInd(cSelInd) == getLowestRowIndLocal())
			{
				trace("lowest");
				startInd = convRowIndToGlobal(getHighestRowIndLocal());
				trace("startInd: "+startInd);
				searchOrder = [0,-1,1];
			}
			if (selectableCharsRowArr[cRow].length)
				cSelInd = searchRow(cRow,searchOrder,startInd);
			else
				cSelInd = searchRow(getNextRow(),searchOrder,startInd);
			setSelection(cSelInd);*/
			setSelection( getNearestPortrait(DIR_LEFT), true );
//			trace("lowest: "+getLowestRowIndLocal() + " highest: "+getHighestRowIndLocal() +" cSel: "+cSelInd);
		}
		override public function pressRhtBtn():void
		{
			/*var startInd:int = cSelInd;
			var searchOrder:Array = [1,-1,0];
			if ( convGlobalIndToRowInd(cSelInd) == getHighestRowIndLocal())
			{
				startInd = convRowIndToGlobal(getLowestRowIndLocal());
				searchOrder = [0,1,-1];
			}
			if (selectableCharsRowArr[cRow].length)
				cSelInd = searchRow(cRow,searchOrder,startInd);
			else
				cSelInd = searchRow(getNextRow(),searchOrder,startInd);
			setSelection(cSelInd);*/
			setSelection( getNearestPortrait(DIR_RIGHT), true );
		}
		override public function pressPseBtn():void
		{
			if (CS_SCRN)
				SND_MNGR.pauseResumeBgm();
			else if (GameStateManager.GS_MNGR.gameState == GameStates.PAUSE)
			{
				cancel();
				nameBox.cancel();
				nextMsgBxToCreate = null;
				unpauseGameOnDestroy = true;
			}
		}
		
		override protected function destroy():void
		{
			super.destroy();
			instance = null;
			if (unpauseGameOnDestroy)
				EVENT_MNGR.unpauseGame();
		}
		
		
	}
}