package com.smbc.data
{
	import com.explodingRabbit.utils.CustomDictionary;
	import com.smbc.SuperMarioBrosCrossover;
	import com.smbc.characters.Samus;
	import com.smbc.characters.Simon;
	import com.smbc.events.CustomEvents;
	import com.smbc.level.Level;
	import com.smbc.managers.GameStateManager;
	import com.smbc.managers.MessageBoxManager;
	import com.smbc.managers.SoundManager;
	import com.smbc.managers.StatManager;
	import com.smbc.managers.TutorialManager;
	import com.smbc.messageBoxes.MenuBoxItems;
	import com.smbc.messageBoxes.MessageBoxMessages;
	import com.smbc.sound.MusicInfo;
	
	import flash.events.Event;
	import flash.utils.describeType;

	public class Cheats
	{
		// [ value, locked, name]
		private static const IND_VALUE:int = 0;
		private static const IND_LOCKED:int = 1;
		private static const IND_NAME:int = 2;
		private static const IND_UNLOCK_CONDITIONS_MESSAGE:int = 3;
		private static const PRE_CHAR:String = "_";
		public static const SN_ACTIVATE_CHEAT:String = SoundNames.SFX_GAME_NEW_LIFE;
		private static const _allHammerBros:Array = [false, true, MenuBoxItems.ALL_HAMMER_BROS, MessageBoxMessages.LOCKED_CHEAT_ALL_HAMMER_BROS];
//		private static const _allPiranhasRed:Array = [false, false, MenuBoxItems.ALL_PIRANHAS_RED, null];
		private static const _allWeaponsPierce:Array = [false, true, MenuBoxItems.ALL_WEAPONS_PIERCE, MessageBoxMessages.LOCKED_CHEAT_ALL_WEAPONS_PIERCE];
		private static const _allGroundIsBricks:Array = [false, true, MenuBoxItems.ALL_GROUND_IS_BRICKS, MessageBoxMessages.LOCKED_CHEAT_ALL_GROUND_IS_BRICKS];
		private static const _alwaysBreakBricks:Array = [false, true, MenuBoxItems.ALWAYS_BREAK_BRICKS, MessageBoxMessages.LOCKED_CHEAT_ALWAYS_BREAK_BRICKS];
		private static const _bouncyPits:Array = [false, true, MenuBoxItems.BOUNCY_PITS, MessageBoxMessages.LOCKED_CHEAT_BOUNCY_PITS];
		private static const _classicSamus:Array = [false, false, MenuBoxItems.CLASSIC_SAMUS, null];
		private static const _classicScreenScroll:Array = [false, false, MenuBoxItems.CLASSIC_SCREEN_SCROLL, null];
		private static const _classicSimon:Array = [false, false, MenuBoxItems.CLASSIC_SIMON, null];
		private static const _everyoneCanStomp:Array = [false, false, MenuBoxItems.EVERYONE_CAN_STOMP, null];
		private static const _evilHammerBros:Array = [false, true, MenuBoxItems.EVIL_HAMMER_BROS, MessageBoxMessages.LOCKED_CHEAT_EVIL_HAMMER_BROS];
		private static const _extraCheckpoints:Array = [false, true, MenuBoxItems.EXTRA_CHECKPOINTS, MessageBoxMessages.LOCKED_CHEAT_EXTRA_CHECKPOINTS];
		private static const _infiniteAmmo:Array = [false, true, MenuBoxItems.INFINITE_AMMO, MessageBoxMessages.LOCKED_CHEAT_INFINITE_AMMO];
//		private static const _infiniteHover:Array = [false, true, MenuBoxItems.INFINITE_HOVER, MessageBoxMessages.LOCKED_CHEAT_INFINITE_HOVER];
		private static const _infiniteLives:Array = [false, true, MenuBoxItems.INFINITE_LIVES, MessageBoxMessages.LOCKED_CHEAT_INFINITE_LIVES];
		private static const _infiniteTime:Array = [false, true, MenuBoxItems.INFINITE_TIME, MessageBoxMessages.LOCKED_CHEAT_INFINITE_TIME];
		private static const _invincible:Array = [false, true, MenuBoxItems.INVINCIBLE, MessageBoxMessages.LOCKED_CHEAT_INVINCIBLE];
		private static const _levelSelect:Array = [false, true, MenuBoxItems.LEVEL_SELECT, MessageBoxMessages.LOCKED_CHEAT_LEVEL_SELECT];
//		private static const _megaManHighJump:Array = [false, false, MenuBoxItems.MEGA_MAN_HIGH_JUMP, null];
//		private static const _piranhasInAllPipes:Array = [false, false, MenuBoxItems.PIRANHAS_IN_ALL_PIPES, null];
//		private static const _quietCoins:Array = [false, false, MenuBoxItems.QUIET_COINS, null];
		private static const _waterMode:Array = [false, true, MenuBoxItems.WATER_MODE, MessageBoxMessages.LOCKED_CHEAT_WATER_MODE];
		private static const LOCK_DCT:CustomDictionary = new CustomDictionary(); // contains array, name is key, array is value
		private static var strVec:Vector.<String>;
		private static var numCheats:int;
		
		/*public static function setLockStatus(cheatName:String,value:Boolean):void
		{
			var curLockStatus:Boolean = getLockStatus(cheatName);
			LOCK_DCT[cheatName][IND_LOCKED] = value;
			if (GameSettings.cheatMessages && curLockStatus == true && value == false)
			{
				MessageBoxManager.INSTANCE.createTutorialMessagebox("You unlocked "+cheatName+" cheat!");
			}
		}*/
		public static function activateDebugCheats():void
		{
			var num:int = IND_VALUE;
//			_allWeaponsPierce[num] = true;
//			_allGroundIsBricks[num] = true;
//			_allHammerBros[num] = true;
//			_allPiranhasRed[num] = true;
//			_bouncyPits[num] = true;
//			_classicSamus[num] = true;
//			_classicScreenScroll[num] = true;
//			_classicSimon[num] = true;
//			_everyoneCanStomp[num] = true;
//			_evilHammerBros[num] = true;
//			_extraCheckpoints[num] = true;
//			_infiniteAmmo[num] = true;
//			_infiniteHover[num] = true;
//			_infiniteLives[num] = true;
//			_infiniteTime[num] = true;
			_invincible[num] = true;
//			_piranhasInAllPipes[num] = true;
//			_quietCoins[num] = true;
//			_waterMode[num] = true;
		}
		public static function unlockCheat(singleCheatName:String,cheatNames:Array = null):Vector.<String>
		{
			if (!cheatNames)
				cheatNames = [];
			if (singleCheatName)
				cheatNames.push(singleCheatName);
			var vec:Vector.<String> = new Vector.<String>();
			var n:int = cheatNames.length;
			for (var i:int; i < n; i++)
			{
				var name:String = cheatNames[i] as String;
				var curLockStatus:Boolean = getLockStatus(name);
				LOCK_DCT[name][IND_LOCKED] = false;
				if (GameSettings.cheatNotify && curLockStatus == true)
					vec.push(MessageBoxMessages.UNLOCKED_CHEAT_PRETEXT + name+MessageBoxMessages.UNLOCKED_CHEAT_POSTTEXT);
			}
			if (vec.length)
			{
				var level:Level = Level.levelInstance;
				var tm:TutorialManager = TutorialManager.TUT_MNGR;
				if ( tm.checkTutorial(tm.TYPE_CHEAT) )
				{
					vec = vec.concat( tm.getStoredMessages() );
				}
				if (level && level.LOOP_TMR.running)
				{
					if (!strVec)
						strVec = new Vector.<String>();
					strVec = strVec.concat(vec);
					level.addEventListener(CustomEvents.GAME_LOOP_END,gameLoopEndHandler,false,0,true);					
				}
				else
					MessageBoxManager.INSTANCE.createMessageBoxSeries(vec,false,true);
			}
			return vec;
		}
		private static function gameLoopEndHandler(event:Event):void
		{
			var level:Level = Level.levelInstance;
			if (level)
				level.removeEventListener(CustomEvents.GAME_LOOP_END,gameLoopEndHandler);
			if (strVec)
				MessageBoxManager.INSTANCE.createMessageBoxSeries(strVec,true,true);
			strVec = null;
		}
		public static function getLockStatus(cheatName:String):Boolean
		{
			return LOCK_DCT[cheatName][IND_LOCKED];
		}
		public static function getUnlockConditionsMessage(cheatName:String):String
		{
			var str:String = LOCK_DCT[cheatName][IND_UNLOCK_CONDITIONS_MESSAGE];
			var ind:int = str.lastIndexOf(MessageBoxMessages.LOCKED_CHEAT_COUNT_VAR_KEY);
			if (ind != -1)
			{
				var varName:String = str.substring(ind + MessageBoxMessages.LOCKED_CHEAT_COUNT_VAR_KEY_LEN);
				str = str.substr(0,ind) + StatManager.STAT_MNGR[varName].toString();
			}
			return str;
		}
		public static function unlockAllCheats():void
		{
			for each (var arr:Array in LOCK_DCT)
			{
				arr[IND_LOCKED] = false;
			}
		}
		
		public static function setUpCheats():void
		{
			var lst:XMLList = describeType(Cheats)..accessor;
			var n:int = lst.length();
			for (var i:int; i < n; i++)
			{
				var nameVal:Object = lst[i].@name;
				var val:Object = Cheats[PRE_CHAR+nameVal]
				if (val)
				{
					var arr:Array = val as Array;
					LOCK_DCT.addItem(arr[IND_NAME],arr);
				}
			}
			numCheats = LOCK_DCT.length;
		}
		public static function prepareLoadSave():Vector.<Array>
		{
			var vec:Vector.<Array> = new Vector.<Array>();
			for each (var arr:Array in LOCK_DCT)
			{
				vec.push(arr);
			}
			vec.sort(sortArrAlphabet);
			return vec;
			function sortArrAlphabet(arr1:Array,arr2:Array):int
			{
				var s1:String = arr1[IND_NAME];
				var s2:String = arr2[IND_NAME];
				if (s1 < s2)
					return -1;
				else if (s1 > s2)
					return 1;
				else
					return 0;
			}
		}
		public static function loadData(data:Array):void
		{
			var vec:Vector.<Array> = prepareLoadSave();
			var n:int = vec.length;
			if (data.length != numCheats*2)
				throw new Error("incorrect number of data for cheats");
			for (var i:int; i < n; i++)
			{
				var arr:Array = vec[i];
				arr[IND_VALUE] = Boolean( data.shift() );
				arr[IND_LOCKED] = Boolean( data.shift() );
			}
		}
		public static function saveData():Array
		{
			var vec:Vector.<Array> = prepareLoadSave();
			var n:int = vec.length;
			var returnArr:Array = [];
			for (var i:int; i < n; i++)
			{
				var arr:Array = vec[i];
				returnArr.push( int(arr[IND_VALUE]).toString() );
				returnArr.push( int(arr[IND_LOCKED]).toString() );
			}
			return returnArr;
		}
		public static function get waterMode():Boolean
		{
			return _waterMode[IND_VALUE];
		}
		public static function set waterMode(value:Boolean):void
		{
			_waterMode[IND_VALUE] = value;
		}
		public static function get invincible():Boolean
		{
			return _invincible[IND_VALUE];
		}
		public static function set invincible(value:Boolean):void
		{
			_invincible[IND_VALUE] = value;
		}

		public static function get infiniteLives():Boolean
		{
			return _infiniteLives[IND_VALUE];
		}
		public static function set infiniteLives(value:Boolean):void
		{
			_infiniteLives[IND_VALUE] = value;
		}

//		public static function get infiniteHover():Boolean
//		{
//			return _infiniteHover[IND_VALUE];
//		}
//		public static function set infiniteHover(value:Boolean):void
//		{
//			_infiniteHover[IND_VALUE] = value;
//		}

		public static function get infiniteAmmo():Boolean
		{
			return _infiniteAmmo[IND_VALUE];
		}
		public static function set infiniteAmmo(value:Boolean):void
		{
			_infiniteAmmo[IND_VALUE] = value;
		}

		public static function get infiniteTime():Boolean
		{
			return _infiniteTime[IND_VALUE];
		}
		public static function set infiniteTime(value:Boolean):void
		{
			_infiniteTime[IND_VALUE] = value;
			StatManager.STAT_MNGR.setTimeLeftVisibility(value);
		}
		
		public static function get extraCheckpoints():Boolean
		{
			return _extraCheckpoints[IND_VALUE];
		}
		public static function set extraCheckpoints(value:Boolean):void
		{
			_extraCheckpoints[IND_VALUE] = value;
		}

		public static function get allHammerBros():Boolean
		{
			return _allHammerBros[IND_VALUE];
		}
		public static function set allHammerBros(value:Boolean):void
		{
			_allHammerBros[IND_VALUE] = value;
		}

		public static function get evilHammerBros():Boolean
		{
			return _evilHammerBros[IND_VALUE];
		}

		public static function set evilHammerBros(value:Boolean):void
		{
			_evilHammerBros[IND_VALUE] = value;
		}

/*		public static function get megaManHighJump():Boolean
		{
			return _megaManHighJump[IND_VALUE];
		}

		public static function set megaManHighJump(value:Boolean):void
		{
			_megaManHighJump[IND_VALUE] = value;
		}*/

		public static function get bouncyPits():Boolean
		{
			return _bouncyPits[IND_VALUE];
		}
		public static function set bouncyPits(value:Boolean):void
		{
			_bouncyPits[IND_VALUE] = value;
		}
		
		public static function get classicSimon():Boolean
		{
			return _classicSimon[IND_VALUE];
		}
		public static function set classicSimon(value:Boolean):void
		{
			_classicSimon[IND_VALUE] = value;
			Simon.classicMode = value;
		}
		
		public static function get classicSamus():Boolean
		{
			return _classicSamus[IND_VALUE];
		}
		public static function set classicSamus(value:Boolean):void
		{
			_classicSamus[IND_VALUE] = value;
			Samus.classicMode = value;
		}
		
//		public static function get allPiranhasRed():Boolean
//		{
//			return _allPiranhasRed[IND_VALUE];
//		}
//		
//		public static function set allPiranhasRed(value:Boolean):void
//		{
//			_allPiranhasRed[IND_VALUE] = value;
//		}
		
		public static function get everyoneCanStomp():Boolean
		{
			return _everyoneCanStomp[IND_VALUE];
		}
		
		public static function set everyoneCanStomp(value:Boolean):void
		{
			_everyoneCanStomp[IND_VALUE] = value;
		}
		
//		public static function get piranhasInAllPipes():Boolean
//		{
//			return _piranhasInAllPipes[IND_VALUE];
//		}
//		
//		public static function set piranhasInAllPipes(value:Boolean):void
//		{
//			_piranhasInAllPipes[IND_VALUE] = value;
//		}
		
//		public static function get quietCoins():Boolean
//		{
//			return _quietCoins[IND_VALUE];
//		}
//		
//		public static function set quietCoins(value:Boolean):void
//		{
//			_quietCoins[IND_VALUE] = value;
//			if (value)
//				MusicInfo.SFX_GameCoinSnd[MusicInfo.IND_VOLUME] = 20;
//			else
//				MusicInfo.SFX_GameCoinSnd[MusicInfo.IND_VOLUME] = MusicInfo.VOL_SUPER_MARIO_BROS_SFX;
//		}
		
		public static function get classicScreenScroll():Boolean
		{
			return _classicScreenScroll[IND_VALUE];
		}
		
		public static function get allWeaponsPierce():Boolean
		{
			return _allWeaponsPierce[IND_VALUE];
		}
		
		public static function set allWeaponsPierce(value:Boolean):void
		{
			_allWeaponsPierce[IND_VALUE] = value;
		}
		
		public static function get alwaysBreakBricks():Boolean
		{
			return _alwaysBreakBricks[IND_VALUE];
		}
		
		public static function set alwaysBreakBricks(value:Boolean):void
		{
			_alwaysBreakBricks[IND_VALUE] = value;
		}
		
		public static function get allGroundIsBricks():Boolean
		{
			return _allGroundIsBricks[IND_VALUE];
		}
		
		public static function set allGroundIsBricks(value:Boolean):void
		{
			_allGroundIsBricks[IND_VALUE] = value;
		}
		
		public static function set classicScreenScroll(value:Boolean):void
		{
			_classicScreenScroll[IND_VALUE] = value;
			var level:Level = Level.levelInstance;
			if (level)
				level.changeScreenScrollsLeftSetting();
		}
		
		public static function get levelSelect():Boolean
		{
			return _levelSelect[IND_VALUE];
		}
		public static function set levelSelect(value:Boolean):void
		{
			_levelSelect[IND_VALUE] = value;
		}
		public static function get allUnlocked():Boolean
		{
			for each (var arr:Array in LOCK_DCT)
			{
				if (arr[IND_LOCKED])
					return false;
			}
			if (!GameSettings.DEBUG_MODE && SoundManager.SND_MNGR.sfxPlayer != null)
			{
				SoundManager.SND_MNGR.sfxPlayer.freeEmu(true);
				SoundManager.SND_MNGR.sfxPlayer = null;
			}
			return true;
		}


	}
}