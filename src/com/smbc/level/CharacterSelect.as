package com.smbc.level
{
	import com.explodingRabbit.utils.CustomTimer;
	import com.gme.GameMusicEmu;
	import com.smbc.characters.Character;
	import com.smbc.characters.Jason;
	import com.smbc.characters.Mario;
	import com.smbc.characters.Sophia;
	import com.smbc.data.GameStates;
	import com.smbc.data.LevelID;
	import com.smbc.data.LevelTypes;
	import com.smbc.data.MapPack;
	import com.smbc.data.MusicType;
	import com.smbc.data.SoundNames;
	import com.smbc.graphics.Scenery;
	import com.smbc.graphics.fontChars.FontCharHud;
	import com.smbc.graphics.fontChars.FontCharMenu;
	import com.smbc.interfaces.IKeyPressable;
	import com.smbc.main.GlobVars;
	import com.smbc.managers.EventManager;
	import com.smbc.managers.GameStateManager;
	import com.smbc.managers.LevelDataManager;
	import com.smbc.managers.SoundManager;
	import com.smbc.messageBoxes.CharacterSelectBox;
	import com.smbc.messageBoxes.GridMenuBox;
	import com.smbc.sound.MusicInfo;
	import com.smbc.text.TextFieldContainer;
	import com.smbc.utils.GameLoopTimer;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.text.TextField;

	public class CharacterSelect extends Level implements IKeyPressable
	{
		public static var instance:CharacterSelect;
		public static const FULL_LEVEL_STR:String = "9-1a";
		public static const PLAYER_X_POS:Number = GLOB_STG_RHT/2; 
		public static const BGM_STR:String = SoundNames.BGM_GAME_CHARACTER_SELECT;
		public static var lastChosenChar:String = Mario.CHAR_NAME;
		private static const SN_REVIVE_CHARACTER:String = SoundNames.SFX_GAME_POWER_UP;
		private static const WALK_SPEED:int = 90;
		private static const FL_SELECTOR_REVIVE:String = "revive";
		private static const FL_SELECTOR_STRENGTHEN_START:String = "strengthenStart";
		private static const FL_SELECTOR_STRENGTHEN_END:String = "strengthenEnd";
		private static const FL_SELECTOR_SELECT:String = "select";
		private static const PS_FALLEN:int = Character.PS_FALLEN;
		private static const MODE_REVIVE:String = "revive";
		private static const MODE_CHARACTER_SELECT:String = "characterSelect";
		private static const SOPHIA_CHAR_NUM:int = Sophia.CHAR_NUM;
		private static const CHAR_NUM_MIN:int = Character.CHAR_NUM_MIN;
		private static const END_TMR_DUR_VAR_NAME:String = "CHAR_SEL_END_DUR";
		public var numLives:Sprite;
		public var livesTxt:TextField;
		public var selector:MovieClip;
		private const LIVES_TFC:TextFieldContainer = new TextFieldContainer(FontCharHud.FONT_NUM);
		private const GS_MNGR:GameStateManager = GameStateManager.GS_MNGR;
		private const STAGE_HEIGHT:int = GlobVars.STAGE_HEIGHT;
		private const STAGE_WIDTH:int = GlobVars.STAGE_WIDTH;
		private const STAGE:Stage = GlobVars.STAGE;
		private const EVENT_MNGR:EventManager = EventManager.EVENT_MNGR;
//		private const SND_MNGR:SoundManager = SoundManager.SND_MNGR;
		private var fakeKeyPress:Boolean;
		private var cSel:String; 
		public var choseChar:int = CHAR_NUM_MIN - 1;
		private var endTmr:GameLoopTimer;
		private var teamSurvival:Boolean;
		private var allowRevival:Boolean;
		private var mode:String = MODE_CHARACTER_SELECT;
		private var SELECTABLE_CHARS_VEC:Vector.<MovieClip> = new Vector.<MovieClip>();
		private var selBox:CharacterSelectBox;
		public var levelIdForTheme:LevelID;
		public var levTypeForTheme:String;
		public var lockPlayerPosition:Point;
		
		public function CharacterSelect(allowRevival:Boolean)
		{
			super( LevelID.Create(FULL_LEVEL_STR), LevelDataManager.getLevelData(MapPack.Smb), [], true);
			instance = this;
			this.allowRevival = allowRevival;
		}
		
		public function setCurLevStr():void
		{
			var mainArea:String = LevelDataManager.currentLevelData.getMainArea(STAT_MNGR.currentLevelID);
			levelIdForTheme = LevelID.Create(STAT_MNGR.currentLevelID.nameWithoutArea + mainArea);
			levTypeForTheme = LevelDataManager.currentLevelData.getType(levelIdForTheme);
			trace("levStrForTheme: "+levelIdForTheme);
			if (levTypeForTheme == LevelTypes.WATER)
				addWaterToTop();
//			background.setBackgrounds();
//			foreground.setBackgrounds();
		}
		
		private function addWaterToTop():void
		{
			var yNum:int = GLOB_STG_TOP + TILE_SIZE*2;
			var tileName:String = Scenery.WAVE_BASE_STR;
			var curX:int = GLOB_STG_LFT;
			while (curX < GLOB_STG_RHT)
			{
				var scenery:Scenery = new Scenery(tileName);
				scenery.x = curX;
				scenery.originalX = curX;
				scenery.y = yNum;
				addToLevel(scenery);
				curX += TILE_SIZE;
			}
			addObj();
		}
		
		override public function initiateLevel():void
		{
			super.initiateLevel();
			selBox = new CharacterSelectBox(allowRevival);
			selBox.initiate();
			GS_MNGR.gameState = GameStates.CHARACTER_SELECT;
			player.charSelectInitiate();
			EVENT_MNGR.characterSelectStart();
			SND_MNGR.changeMusic(MusicType.CHAR_SEL);
		}
		public function setSelection(charNum:int):void
		{
			choseChar = CHAR_NUM_MIN - 1;
			if (charNum == CharacterSelectBox.RANDOM_CHAR_NUM || charNum == CharacterSelectBox.MAP_SKIN_CHAR_NUM)
				player.visible = false;
			else
			{
				player.visible = true;
				player.changeChar(charNum);
				player.charSelectInitiate();
				if (STAT_MNGR.getCharPState(charNum) == Character.PS_FALLEN)
				{
					markCharacterFallen(player);
					player.fallenCharSelScrn();
				}
			}
		}
		private function markCharacterFallen(char:Character):void
		{
			selBox.desaturate(char);
		}
		private function unmarkCharacterFallen(char:Character):void
		{
			char.filters = [];
		}
		override protected function gameLoop(evt:TimerEvent):void
		{
			super.gameLoop(evt);
			if (choseChar < CHAR_NUM_MIN)
			{
				if (lockPlayerPosition != null)
				{
					player.x = lockPlayerPosition.x;
					player.y = lockPlayerPosition.y;
					player.onGround = true;
				}
				else if (player.x > PLAYER_X_POS)
					resetPlayerPosition();
			}
			else if (choseChar == SOPHIA_CHAR_NUM) // temporary fix puts Jason in front of Sophia
			{
				var jason:Jason = Sophia(player).jason;
				var indSophia:int = getChildIndex(player);
				var indJason:int = getChildIndex(jason);
				if (indJason < indSophia)
					swapChildren(player,jason);
			}
			if (choseChar >= CHAR_NUM_MIN && !endTmr.running)
				destroyLevel();
		}
		
		public function resetPlayerPosition():void
		{
			player.x = PLAYER_X_POS;
			player.y = GLOB_STG_BOT - TILE_SIZE*2;
			player.nx = player.x;
			player.ny = player.y;
		}
		
		public function chooseCharacter(charNum:int):void
		{
			choseChar = charNum;
			trace("chose character: "+STAT_MNGR.convNumToName(charNum));
			player.relRhtBtn();
			player.chooseCharacter();
			var endDur:int = player.classObj[END_TMR_DUR_VAR_NAME];
			SND_MNGR.changeMusic( MusicType.CHOOSE_CHARACTER );
//			SND_MNGR.musicPlayer.setFade(endDur);
			endTmr = new GameLoopTimer(endDur,1);
			endTmr.addEventListener(TimerEvent.TIMER_COMPLETE,endTmrHandler);
			endTmr.start();
			trace("end timer dur: "+endDur);
		}
		
//		override protected function setIndexOfStgObjs():void
//		{
//			super.setIndexOfStgObjs();
//			if (GridMenuBox.instance != null && contains(GridMenuBox.instance))
//			{
//				setChildIndex( GridMenuBox.instance, getChildIndex(player) - 1 );
//			}
//		}
		
		private function endTmrHandler(event:TimerEvent):void
		{
			trace("end timer");
			endTmr.stop();
		}
		
		override public function destroyLevel():void
		{
			super.destroyLevel();
			if (endTmr)
				endTmr.removeEventListener(TimerEvent.TIMER_COMPLETE,endTmrHandler);
			instance = null;
			trace("charSelDone numChildren: "+GAME.getChildrenArr());
			EVENT_MNGR.selectedCharacter(player.charNum);
		}
		override protected function removeAllSounds():void
		{
			// don't remove sounds
		}
		public function pressAtkBtn():void
		{
			
		}
		public function pressJmpBtn():void
		{
			
		}
		public function pressUpBtn():void
		{
			
		}
		public function pressDwnBtn():void
		{
			
		}
		public function pressLftBtn():void
		{
			
		}
		public function pressRhtBtn():void
		{
			
		}
		public function pressPseBtn():void
		{
			
		}
		public function pressSpcBtn():void
		{
			
		}
	}
}