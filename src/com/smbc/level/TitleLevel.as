package com.smbc.level
{
	import com.explodingRabbit.display.CustomMovieClip;
	import com.explodingRabbit.utils.CustomDictionary;
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.SuperMarioBrosCrossover;
	import com.smbc.characters.Bass;
	import com.smbc.characters.Bill;
	import com.smbc.characters.Character;
	import com.smbc.characters.Link;
	import com.smbc.characters.Luigi;
	import com.smbc.characters.Mario;
	import com.smbc.characters.MegaMan;
	import com.smbc.characters.Ryu;
	import com.smbc.characters.Samus;
	import com.smbc.characters.Simon;
	import com.smbc.characters.Sophia;
	import com.smbc.characters.base.MarioBase;
	import com.smbc.data.CharacterInfo;
	import com.smbc.data.Cheats;
	import com.smbc.data.Difficulties;
	import com.smbc.data.GameSettings;
	import com.smbc.data.GameStates;
	import com.smbc.data.LevelID;
	import com.smbc.data.MapDifficulty;
	import com.smbc.data.MapPack;
	import com.smbc.data.OnlineData;
	import com.smbc.data.PickupInfo;
	import com.smbc.data.SoundNames;
	import com.smbc.data.Versions;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.TitleBmp;
	import com.smbc.graphics.fontChars.FontChar;
	import com.smbc.graphics.fontChars.FontCharHud;
	import com.smbc.graphics.fontChars.FontCharMenu;
	import com.smbc.graphics.BmdInfo;
	import com.smbc.graphics.BmdSkinCont;
	import com.smbc.ground.Ground;
	import com.smbc.interfaces.IKeyPressable;
	import com.smbc.main.GlobVars;
	import com.smbc.managers.EventManager;
	import com.smbc.managers.GameStateManager;
	import com.smbc.managers.GraphicsManager;
	import com.smbc.managers.LevelDataManager;
	import com.smbc.managers.MessageBoxManager;
	import com.smbc.managers.SoundManager;
	import com.smbc.managers.StatManager;
	import com.smbc.messageBoxes.DisclaimerMessageBox;
	import com.smbc.messageBoxes.FundingBox;
	import com.smbc.messageBoxes.MessageBox;
	import com.smbc.messageBoxes.MessageBoxTitleContainer;
	import com.smbc.messageBoxes.NewsTicker;
	import com.smbc.messageBoxes.StartMenu;
	import com.smbc.sound.MusicInfo;
	import com.smbc.text.TextFieldContainer;
	import com.smbc.utils.CharacterSequencer;
	import com.smbc.utils.GameLoopTimer;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;

	public class TitleLevel extends Level implements IKeyPressable
	{
		public static var instance:TitleLevel;
		public static var allowRestart:Boolean = true;
//		public static const FULL_LEVEL_STR:String = "9-8a";
		private static const STATIC_DATA_DCT:CustomDictionary = new CustomDictionary();
		private static const IND_CHAR_CLASS:int = 0;
		private static const IND_UPGRADES:int = 1;
		private static const IND_START_POS:int = 2;
		private static const IND_ACTIVATE_POS:int = 3;
		private static const IND_SEQ:int = 4;
		private static const IND_CHAR_NUM:int = 5;
		private static const TITLE_Y_POS:int = 60;
		private static const CLICK_SCREEN_TXT_Y_POS:int = GlobVars.STAGE_HEIGHT/2; //GlobVars.STAGE_HEIGHT - 52;
		private static const VERSION_TFC_PNT:Point = new Point(16,GlobVars.STAGE_HEIGHT - 26);
		private const GS_MNGR:GameStateManager = GameStateManager.GS_MNGR;
		private const EVENT_MNGR:EventManager = EventManager.EVENT_MNGR;
		private var marioWaitTmr:GameLoopTimer;
		private static const NEW_VERSION_AVAILABLE:String = " (New version available)";
		private static const MARIO_WAIT_TMR_DEL:int = 5000;
		private var clickScreenTxt:TextFieldContainer;
		private var clickScreenTxtTmr:CustomTimer = new CustomTimer(500);
		{(function():void {
			var arr:Array = [];

			//			Bass
			arr[IND_CHAR_CLASS] = Bass;
			arr[IND_CHAR_NUM] = Bass.CHAR_NUM;
			arr[IND_UPGRADES] = Bass.TITLE_SCREEN_UPGRADES;
			arr[IND_START_POS] = new Point(1094,416);
			arr[IND_ACTIVATE_POS] = new Point(1094,416);
			arr[IND_SEQ] = [
				[1500,"pressRhtBtn"], [367,"pressJmpBtn"], [434,"relJmpBtn"], [267,"pressDwnBtn"], [67,"pressAtkBtn"], [800,"relAtkBtn"], [18,"relRhtBtn"], [33,"relDwnBtn"], [316,"pressLftBtn"], [33,"pressDwnBtn"], [67,"pressJmpBtn"], [84,"relJmpBtn"], [20,"relDwnBtn"], [65,"pressJmpBtn"], [817,"relJmpBtn"], [50,"relLftBtn"]	
			];
			STATIC_DATA_DCT.addItem(arr.concat());
			
//			Bill
			arr[IND_CHAR_CLASS] = Bill;
			arr[IND_CHAR_NUM] = Bill.CHAR_NUM;
			arr[IND_UPGRADES] = Bill.TITLE_SCREEN_UPGRADES;
			arr[IND_START_POS] = new Point(4633,416);
			arr[IND_ACTIVATE_POS] = new Point(4633,416);
			arr[IND_SEQ] = [
				[4000,"pressRhtBtn"], [534,"pressJmpBtn"], [347,"relJmpBtn"], [800,"pressJmpBtn"], [152,"relJmpBtn"], [1568,"pressJmpBtn"], [99,"relJmpBtn"], [1400,"pressDwnBtn"], [21,"relRhtBtn"], [450,"pressAtkBtn"], [66,"relAtkBtn"], [86,"pressAtkBtn"], [81,"relAtkBtn"], [84,"pressAtkBtn"], [82,"relAtkBtn"], [86,"pressAtkBtn"], [82,"relAtkBtn"], [85,"pressAtkBtn"], [101,"relAtkBtn"], [80,"pressAtkBtn"], [118,"relAtkBtn"], [81,"pressAtkBtn"], [100,"relAtkBtn"], [87,"pressAtkBtn"], [99,"relAtkBtn"], [367,"relDwnBtn"], [98,"pressRhtBtn"], [184,"pressUpBtn"], [133,"pressAtkBtn"], [66,"relAtkBtn"], [85,"pressAtkBtn"], [101,"relAtkBtn"], [67,"pressAtkBtn"], [14,"relRhtBtn"], [84,"relAtkBtn"], [82,"pressAtkBtn"], [0,"pressLftBtn"], [86,"relAtkBtn"], [48,"relLftBtn"], [34,"pressAtkBtn"], [99,"relAtkBtn"], [0,"pressLftBtn"], [85,"pressAtkBtn"], [82,"relAtkBtn"], [19,"relLftBtn"], [80,"pressAtkBtn"], [86,"relAtkBtn"], [82,"pressAtkBtn"], [99,"relAtkBtn"], [34,"pressLftBtn"], [33,"pressAtkBtn"], [100,"relAtkBtn"], [34,"relLftBtn"], [51,"pressAtkBtn"], [99,"relAtkBtn"], [82,"pressAtkBtn"], [100,"relAtkBtn"], [134,"pressLftBtn"], [66,"relUpBtn"], [401,"pressJmpBtn"], [166,"relJmpBtn"]	
			];
			STATIC_DATA_DCT.addItem(arr.concat());
			
//			Link
			arr[IND_CHAR_CLASS] = Link;
			arr[IND_CHAR_NUM] = Link.CHAR_NUM;
			arr[IND_UPGRADES] = Link.TITLE_SCREEN_UPGRADES;
			arr[IND_START_POS] = new Point(1514,288);
			arr[IND_ACTIVATE_POS] = new Point(1514,288);
			arr[IND_SEQ] = [
				[1100,"pressRhtBtn"], [31,"pressJmpBtn"], [269,"relJmpBtn"], [252,"pressDwnBtn"], [150,"relRhtBtn"], [900,"pressRhtBtn"], [52,"relDwnBtn"], [182,"relRhtBtn"], [84,"pressLftBtn"], [118,"pressSpcBtn"], [13,"relLftBtn"], [118,"relSpcBtn"], [680,"pressLftBtn"], [200,"pressJmpBtn"], [600,"relJmpBtn"], [567,"relLftBtn"]
			];
			STATIC_DATA_DCT.addItem(arr.concat());
			
//			Luigi
			arr[IND_CHAR_CLASS] = Luigi;
			arr[IND_CHAR_NUM] = Luigi.CHAR_NUM;
			arr[IND_UPGRADES] = Luigi.TITLE_SCREEN_UPGRADES;
			arr[IND_START_POS] = new Point(2066,416);
			arr[IND_ACTIVATE_POS] = new Point(2066,416);
			arr[IND_SEQ] = [
				[1500,"pressJmpBtn"], [421,"relJmpBtn"], [512,"pressLftBtn"], [574,"pressAtkBtn"], [257,"pressJmpBtn"], [158,"relLftBtn"], [167,"pressLftBtn"], [374,"relJmpBtn"], [26,"relLftBtn"], [134,"relAtkBtn"], 
			];
			STATIC_DATA_DCT.addItem(arr.concat());
			
			
//			Mega Man
			arr[IND_CHAR_CLASS] = MegaMan;
			arr[IND_CHAR_NUM] = MegaMan.CHAR_NUM;
			arr[IND_UPGRADES] = MegaMan.TITLE_SCREEN_UPGRADES;
			arr[IND_START_POS] = new Point(567,161);
			arr[IND_ACTIVATE_POS] = new Point(567,161);
			arr[IND_SEQ] = [
				[1,"pressLftBtn"], [665,"relLftBtn"], [49,"pressRhtBtn"], [266,"relRhtBtn"], [300,"pressAtkBtn"], [67,"relAtkBtn"], [81,"pressAtkBtn"], [84,"relAtkBtn"], [234,"pressAtkBtn"], [133,"pressRhtBtn"], [649,"relRhtBtn"], [752,"pressRhtBtn"], [48,"pressJmpBtn"], [133,"relJmpBtn"], [53,"relAtkBtn"], [32,"relRhtBtn"], [335,"pressLftBtn"], [247,"pressDwnBtn"], [52,"pressJmpBtn"], [133,"relJmpBtn"], [66,"pressJmpBtn"], [116,"relJmpBtn"], [84,"pressJmpBtn"], [116,"relJmpBtn"], [66,"pressJmpBtn"], [134,"relJmpBtn"], [45,"relLftBtn"], [0,"relDwnBtn"]
			];
			STATIC_DATA_DCT.addItem(arr.concat());
			
//			Ryu
			arr[IND_CHAR_CLASS] = Ryu;
			arr[IND_CHAR_NUM] = Ryu.CHAR_NUM;
			arr[IND_UPGRADES] = Ryu.TITLE_SCREEN_UPGRADES;
			arr[IND_START_POS] = new Point(2766,496);
			arr[IND_ACTIVATE_POS] = new Point(2766,496);
			arr[IND_SEQ] = [
				[1,"pressLftBtn"], [2,"relLftBtn"], [500,"pressRhtBtn"], [73,"pressJmpBtn"], [127,"relJmpBtn"], [1000,"relRhtBtn"], [67,"pressRhtBtn"], [28,"pressUpBtn"], [351,"relRhtBtn"], [0,"relUpBtn"], [900,"pressSpcBtn"], [140,"relSpcBtn"], [860,"pressSpcBtn"], [171,"relSpcBtn"], [649,"pressLftBtn"], [0,"pressUpBtn"], [33,"pressJmpBtn"], [152,"relJmpBtn"], [466,"pressJmpBtn"], [114,"relJmpBtn"], [151,"relUpBtn"], [249,"relLftBtn"] 
			];
			STATIC_DATA_DCT.addItem(arr.concat());

//			Samus
			arr[IND_CHAR_CLASS] = Samus;
			arr[IND_CHAR_NUM] = Samus.CHAR_NUM;
			arr[IND_UPGRADES] = Samus.TITLE_SCREEN_UPGRADES;
			arr[IND_START_POS] = new Point(3248,288);
			arr[IND_ACTIVATE_POS] = new Point(3248,288);
			arr[IND_SEQ] = [
				[200,"pressDwnBtn"], [128,"relDwnBtn"], [100,"pressDwnBtn"], [133,"relDwnBtn"], [67,"pressAtkBtn"], [133,"relAtkBtn"], [34,"pressLftBtn"], [200,"pressAtkBtn"], [100,"relLftBtn"], [33,"relAtkBtn"], [34,"pressUpBtn"], [100,"pressRhtBtn"], [33,"relUpBtn"], [100,"relRhtBtn"], [134,"pressJmpBtn"], [333,"pressRhtBtn"], [103,"relJmpBtn"], [64,"relRhtBtn"], [505,"pressRhtBtn"], [800,"pressUpBtn"], [230,"pressAtkBtn"], [136,"relAtkBtn"], [466,"pressAtkBtn"], [166,"relAtkBtn"], [535,"pressAtkBtn"], [133,"relAtkBtn"], [382,"relRhtBtn"], [51,"pressLftBtn"], [66,"relUpBtn"], [3000,"relLftBtn"] 
			];
			STATIC_DATA_DCT.addItem(arr.concat());
			
//			Simon
			arr[IND_CHAR_CLASS] = Simon;
			arr[IND_CHAR_NUM] = Simon.CHAR_NUM;
			arr[IND_UPGRADES] = Simon.TITLE_SCREEN_UPGRADES;
			arr[IND_START_POS] = new Point(2154,416);
			arr[IND_ACTIVATE_POS] = new Point(2154,416);
			arr[IND_SEQ] = [
				[2500,"pressRhtBtn"], [244,"pressJmpBtn"], [123,"relJmpBtn"], [809,"pressJmpBtn"], [99,"relJmpBtn"], [168,"pressAtkBtn"], [167,"relAtkBtn"], [100,"relRhtBtn"], [534,"pressSpcBtn"], [133,"relSpcBtn"], [559,"pressSpcBtn"], [174,"relSpcBtn"], [693,"pressSpcBtn"], [174,"relSpcBtn"], [1428,"pressLftBtn"], [734,"pressJmpBtn"], [105,"relJmpBtn"], [595,"relLftBtn"]
			];
			STATIC_DATA_DCT.addItem(arr.concat());
			
//			Sophia
			arr[IND_CHAR_CLASS] = Sophia;
			arr[IND_CHAR_NUM] = Sophia.CHAR_NUM;
			arr[IND_UPGRADES] = Sophia.TITLE_SCREEN_UPGRADES;
			arr[IND_START_POS] = new Point(3808,416);
			arr[IND_ACTIVATE_POS] = new Point(3808,416);
			arr[IND_SEQ] = [
				[1200,"pressAtkBtn"], [81,"relAtkBtn"], [85,"pressAtkBtn"], [82,"relAtkBtn"], [85,"pressAtkBtn"], [81,"relAtkBtn"], [86,"pressAtkBtn"], [101,"relAtkBtn"], [99,"pressAtkBtn"], [99,"relAtkBtn"], [66,"pressAtkBtn"], [101,"relAtkBtn"], [48,"pressAtkBtn"], [101,"relAtkBtn"], [66,"pressAtkBtn"], [53,"pressRhtBtn"], [47,"relAtkBtn"], [651,"pressAtkBtn"], [84,"relAtkBtn"], [66,"pressAtkBtn"], [84,"relAtkBtn"], [66,"pressAtkBtn"], [84,"relAtkBtn"], [84,"pressAtkBtn"], [82,"relAtkBtn"], [67,"pressAtkBtn"], [84,"relAtkBtn"], [67,"pressAtkBtn"], [83,"relAtkBtn"], [250,"pressJmpBtn"], [283,"relJmpBtn"], [216,"pressUpBtn"], [101,"relRhtBtn"], [167,"pressLftBtn"], [184,"relUpBtn"], [50,"relLftBtn"], [199,"pressJmpBtn"], [251,"pressLftBtn"], [50,"relJmpBtn"], [99,"relLftBtn"], [234,"pressRhtBtn"], [167,"relRhtBtn"], [115,"pressLftBtn"], [433,"pressJmpBtn"], [967,"relJmpBtn"], [320,"relLftBtn"]
			];
			STATIC_DATA_DCT.addItem(arr.concat());
			
		}());}
		private var dataDct:CustomDictionary = STATIC_DATA_DCT.clone();

		private var versionTfc:TextFieldContainer;
		
		
		public function TitleLevel()
		{
//			lastMapDifficulty = GameSettings.mapDifficulty;
//			lastMapPack = GameSettings.mapPack;
//			GameSettings.changeDifficulty(Difficulties.NORMAL);
//			GameSettings.changeMapDifficulty(MapDifficulty.NORMAL);
//			GameSettings.changeMapPack(MapPack.Smb);
//			GameSettings.mapPack = MapPack.Smb;
			var n:int = Character.NUM_CHARACTERS;
			var statMngr:StatManager = StatManager.STAT_MNGR;
			for (var i:int = 0; i < n; i++) 
			{
				statMngr.removeAllUpgradesForChar(i, false, true);
			}
			for each (var arr:Array in STATIC_DATA_DCT)
			{
				var charNum:int = arr[IND_CHAR_NUM];
				var upgradeArr:Array = arr[IND_UPGRADES];
				var n2:int = upgradeArr.length;
				for (var j:int = 0; j < n2; j++) 
				{
					statMngr.addCharUpgrade(charNum,upgradeArr[j]);
				}
			}
			statMngr.curCharNum = Mario.CHAR_NUM;
			super(LevelID.Create("1-1a"), LevelDataManager.getLevelData(MapPack.Smb), [], true);
			STAT_MNGR.passedHw = false;
			if (instance != null)
				throw new SingletonError();
			instance = this;
//			if (parent != null)
//				parent.setChildIndex(this,0); // set it to bottom so menu will be on top
		}
		override public function initiateLevel():void
		{
			super.initiateLevel();
			screenScrollsLeft = false;
			charDct = new CustomDictionary(true);
			removeEventListener(MouseEvent.CLICK, clickLsr);
//			selBox = new CharacterSelectBox(allowRevival);
//			selBox.initiate();
//			EVENT_MNGR.characterSelectStart();
//			player.charSelectInitiate();
//			GS_MNGR.gameState = GameStates.TITLE_SCREEN;
//			SND_MNGR.playMusic(MusicInfo.GAME_CHARACTER_SELECT);
			if (MessageBox.activeInstance)
				GAME.setChildIndex(MessageBox.activeInstance,GAME.numChildren - 1);
//			MessageBoxManager.INSTANCE.resetLastMenuPosition(); // sets cursor to "start game"
			EVENT_MNGR.titleLevelInitiate();
			var title:CustomMovieClip = new TitleBmp();
			title.x = GlobVars.STAGE_WIDTH/2 - title.width/2;
			title.y = TITLE_Y_POS;
			addChild(title);
			versionTfc = new TextFieldContainer(FontCharMenu.FONT_NUM,FontCharMenu.TYPE_NORMAL);
			versionTfc.text = "Ver " + Versions.toString(GameSettings.VERSION_NUMBER);
			if (OnlineData.newVersionAvailable)
				versionTfc.text += NEW_VERSION_AVAILABLE;
			addChild(versionTfc);
//			versionTfc.x = title.x + VERSION_TFC_PNT.x;
//			versionTfc.y = title.y + title.height + versionTfc.height + VERSION_TFC_PNT.y;
			versionTfc.x = VERSION_TFC_PNT.x;
			versionTfc.y = VERSION_TFC_PNT.y;
			
			marioWaitTmr = new GameLoopTimer(MARIO_WAIT_TMR_DEL,1);
			marioWaitTmr.addEventListener(TimerEvent.TIMER_COMPLETE,marioWaitTmrHandler,false,0,true);
			marioWaitTmr.start();
			setCorrectCharSkin(player);
			for each (var arr:Array in dataDct)
			{
//				var activatePnt:Point = arr[IND_ACTIVATE_POS];
				var startPnt:Point = arr[IND_START_POS];
				var charClass:Class = arr[IND_CHAR_CLASS] as Class;
				var char:Character = new charClass();
				char.x = startPnt.x;
				char.y = startPnt.y;
				char.setPowerState(arr[IND_UPGRADES]);
				char.initiate();
				char.takeNoDamage = true;
				char.stopUpdate = true;
				charDct.addItem(arr[IND_CHAR_NUM],char);
				setCorrectCharSkin(char);
			}
			stage.addEventListener(MouseEvent.CLICK,clickHandler,false,0,true);
			clickScreenTxt = new TextFieldContainer(FontCharHud.FONT_NUM);
			clickScreenTxt.multiline = true;
			clickScreenTxt.text = "Click screen or press\\nany key to begin";
			clickScreenTxt.x = GlobVars.STAGE_WIDTH/2 - clickScreenTxt.width/2;
			clickScreenTxt.y = CLICK_SCREEN_TXT_Y_POS;
			clickScreenTxtTmr.addEventListener(TimerEvent.TIMER,clickScreenTxtTmrHandler,false,0,true);
			player.relUpBtn();
			player.relRhtBtn();
			player.relAtkBtn();
			
			NewsTicker.getInstance().initiateLevelHandler();
			if (OnlineData.displayFundingBox)
				FundingBox.getInstance().initiateLevelHandler();
//			setUpChars();
//			luigi = new Luigi();
//			luigi.initiate();
//			var seq:CharacterSequencer = new CharacterSequencer();
//			seq.startNewSequence([ [1,"pressRhtBtn"], [5200,"pressJmpBtn"], [784,"relJmpBtn"], [1066,"pressJmpBtn"], [786,"relJmpBtn"], [814,"pressJmpBtn"], [685,"relJmpBtn"], [1649,"pressJmpBtn"], [651,"relJmpBtn"], [2149,"pressJmpBtn"], [866,"relJmpBtn"], [2834,"pressJmpBtn"], [785,"relJmpBtn"], [9481,"pressJmpBtn"], [667,"relJmpBtn"], [167,"pressJmpBtn"], [851,"relJmpBtn"], [282,"pressJmpBtn"], [651,"relJmpBtn"], [1482,"pressJmpBtn"], [558,"relJmpBtn"], [227,"pressJmpBtn"], [115,"relJmpBtn"], [618,"pressJmpBtn"], [816,"relJmpBtn"], [917,"pressJmpBtn"], [201,"relJmpBtn"], [3383,"pressJmpBtn"], [216,"relJmpBtn"], [484,"pressJmpBtn"], [701,"relJmpBtn"], [149,"pressJmpBtn"], [601,"relJmpBtn"], [251,"pressJmpBtn"], [633,"relJmpBtn"], [1781,"relRhtBtn"] ],player);
		}
		
		protected function clickScreenTxtTmrHandler(event:TimerEvent):void
		{
			if (GAME.contains(clickScreenTxt))
				GAME.removeChild(clickScreenTxt);
			else if (!MessageBox.activeInstance)
			{
				if (versionTfc.visible)
					versionTfc.visible = false;
				GAME.addChild(clickScreenTxt);
			}
		}
		
		protected function marioWaitTmrHandler(event:Event):void
		{
			marioWaitTmr.stop();
			marioWaitTmr = null;
			clickScreenTxtTmr.start();
		}
		override public function clickLsr(e:MouseEvent):void // this is for overriding debug mode
		{
			
		}
		override protected function gameLoop(evt:TimerEvent):void
		{
			super.gameLoop(evt);
			
//			trace("gamestate: "+GS_MNGR.gameState);
			player.takeNoDamage = true;
			if (marioWaitTmr || GS_MNGR.gameState != GS_PLAY || flagPole.activated || _beatLevel)
				return;
			player.relDwnBtn();
			player.relLftBtn();
			player.rhtBtn = true;
			player.vxMax = 110;
			if (player.vx > player.vxMax)
				player.vx = player.vxMax;
//			if (player.vy > 0)
//				player.canStomp = true;
//			else
//				player.canStomp = false;
			checkForJump();
			for each (var arr:Array in dataDct)
			{
				var activatePnt:Point = arr[IND_ACTIVATE_POS];
				if (locStgRht + 20 > activatePnt.x)
				{
					var startPnt:Point = arr[IND_START_POS];
//					var charClass:Class = arr[IND_CHAR_CLASS] as Class;
					var char:Character = charDct[ arr[IND_CHAR_NUM] ];
					if (!char)
						continue;
					char.x = startPnt.x;
					char.y = startPnt.y;
					char.stopUpdate = false;
//					char.setPowerState(arr[IND_UPGRADES]);
//					char.initiate();
//					char.takeNoDamage = true;
//					charDct.addItem(IND_CHAR_NUM,char);
//					setCorrectCharSkin(char);
					/*for each (var cmc:CustomMovieClip in char.subMcDct)
					{
						cmc.redraw();
					}*/
					var seq:CharacterSequencer = new CharacterSequencer();
					seq.startNewSequence(arr[IND_SEQ],char);
					dataDct.removeItem(arr);
				}
			}
			
		}
		
		override public function resizeScenery():void
		{
			super.resizeScenery();
			if (!StatManager.STAT_MNGR.loadingData)
			{
				for each (var char:Character in charDct)
				{
					setCorrectCharSkin(char);
				}
				setCorrectCharSkin(player);
			}
		}
		private function setCorrectCharSkin(char:Character):void
		{
			var gm:GraphicsManager = GraphicsManager.INSTANCE;
			var mapSkin:int = GameSettings.getMapSkinLimited();
			var skinToSet:int = gm.getCurrentMapConsoleType();
			switch(mapSkin)
			{
				case BmdInfo.SKIN_NUM_SMB3_NES:
				{
					if (char is Mario)
						skinToSet = Mario.SKIN_MARIO_SMB3_NES;
					else if (char is Luigi)
						skinToSet = Luigi.SKIN_LUIGI_SMB3_NES;
					break;
				}
				case BmdInfo.SKIN_NUM_SMB3_SNES:
				{
					if (char is Mario)
						skinToSet = Mario.SKIN_MARIO_SMB3_SNES;
					else if (char is Luigi)
						skinToSet = Luigi.SKIN_LUIGI_SMB3_SNES;
					break;
				}
				case BmdInfo.SKIN_NUM_SMW:
				{
					if (char is Mario)
						skinToSet = Mario.SKIN_MARIO_SMW_SNES;
					else if (char is Luigi)
						skinToSet = Luigi.SKIN_LUIGI_SMW_SNES;
					break;
				}
				case BmdInfo.SKIN_NUM_DEMON_RETURNS:
				{
					if (char is Mario)
						skinToSet = Mario.SKIN_DEMON_NES;
					break;
				}
				case BmdInfo.SKIN_NUM_SMB_ATARI:
				{
					skinToSet = Character.getAtariSkinNumber(char.charNum);
					break;
				}
				case BmdInfo.SKIN_NUM_SMB_SPECIAL:
				{
					skinToSet = Character.getSpecialSkinNumber(char.charNum);
					break;
				}
				case BmdInfo.SKIN_NUM_SMB2_NES:
				{
					if (char is Mario)
						skinToSet = Mario.SKIN_MARIO_SMB2_NES;
					else if (char is Luigi)
						skinToSet = Luigi.SKIN_LUIGI_SMB2_NES;
					break;
				}
				case BmdInfo.SKIN_NUM_SMB2_SNES:
				{
					if (char is Mario)
						skinToSet = Mario.SKIN_MARIO_SMB2_SNES;
					else if (char is Luigi)
						skinToSet = Luigi.SKIN_LUIGI_SMB2_SNES;
					break;
				}
			}
			gm.changeCharacterSkin(char,skinToSet);
//			char.redraw();	
		}
		private function checkForJump():void
		{
			if (player.onGround || (waterLevel && player.vy >= 0 ) )
			{
				var groundLevel:int = GLOB_STG_BOT - TILE_SIZE*2;
				if (player.jmpBtn)
					player.relJmpBtn();
				var nx:Number = player.nx;
				var ny:Number = player.ny;
				var num:int = getNearestGrid(nx,1);
				if ( getGroundAt(num + TILE_SIZE, ny - TILE_SIZE) || getGroundAt(num, ny - TILE_SIZE) )
				{
					player.pressJmpBtn();
					return;
				}
				if (!getGroundAt(num - TILE_SIZE, ny) && !getGroundAt(num,GLOB_STG_BOT - TILE_SIZE) )
				{
					player.pressJmpBtn();
					return;
				}
				else if (waterLevel && player.wallOnRight)
					player.pressJmpBtn();
			}
		}
		public function clickHandler(me:MouseEvent):void
		{
			if (MessageBox.activeInstance)
				return;
			var startMenu:StartMenu = new StartMenu();
			startMenu.initiate();
		}
		public function pressAtkBtn():void
		{
			
		}
		public function pressJmpBtn():void
		{
			if (MessageBox.activeInstance)
				return;
			var startMenu:StartMenu = new StartMenu();
			startMenu.initiate();
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
		override protected function completeLevel():void
		{
			destroyLevel();
			if (allowRestart)
				GAME.addChild( new TitleLevel() );
		}
		override public function changeScreenScrollsLeftSetting():void
		{
			screenScrollsLeft = false;
//			rightScrollPos = DEFAULT_RIGHT_SCROLL_POS_NO_LEFT_SCROLL;
		}
		override public function destroyLevel():void
		{
			GlobVars.STAGE.removeEventListener(MouseEvent.CLICK,clickHandler);
			for each (var char:Character in charDct)
			{
				char.destroy();
			}
			super.destroyLevel();
			if (!allowRestart)
			{
				NewsTicker.getInstance().kill();
				if (OnlineData.displayFundingBox)
					FundingBox.getInstance().kill();
			}
			EVENT_MNGR.titleLevelDestroy();
			instance = null;
			if (GAME.contains(clickScreenTxt))
				GAME.removeChild(clickScreenTxt);
			clickScreenTxtTmr.removeEventListener(TimerEvent.TIMER,clickScreenTxtTmrHandler);
		}
	}
}