package com.smbc.data
{
	
	import com.smbc.characters.Bill;
	import com.smbc.characters.Character;
	import com.smbc.managers.StatManager;
	
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import com.explodingRabbit.cross.games.Games;

	public class CharacterInfo
	{
		/*
		to add a character
		add info here, add class in com.smbc.characters, add skin in BmdInfo, add info in GraphicsManager, add music, add to MovieClipInfo
		( don't forget to add in PickupInfo.initiate() )
		*/
		private static const CHAR_PATH:String = "com.smbc.characters.";
		private static var indCtr:int = -1;
		public static const IND_CHAR_NUM:int = indCtr+=1;
		public static const IND_CHAR_NAME:int = indCtr+=1;
		public static const IND_CHAR_NAME_CLASS:int = indCtr+=1;
		public static const IND_CHAR_NAME_CAPS:int = indCtr+=1;
		public static const IND_CHAR_NAME_MENUS:int = indCtr+=1;
		public static const IND_CHAR_NAME_FULL:int = indCtr+=1;
		public static const IND_CHAR_NAME_DIALOG:int = indCtr+=1;
		public static const IND_BASE_CLASS_NAME:int = indCtr+=1; // does not include word "base"
		public static const IND_GAMES:int = indCtr+=1;
		private static var charCtr:int = -1;
		// [ charNum, charName, charNameClass, charNameCaps, charNameMenus, charNameFull, charNameDialog, [ Games ] ];
		public static const Bass:Array = [ charCtr+=1, "bass", "Bass", "BASS", "Bass", "Bass", "Bass", "MegaManBase", 
		[ Games.megaMan10 ]];
		public static const Bill:Array = [ charCtr+=1, "bill", "Bill", "BILL", "Bill", "Bill Rizer", "Bill", null, 
		[ Games.contra, Games.superC, Games.operationC, Games.contraForce, Games.contraHardCorps, Games.contra3Gb, Games.contra3Snes ]];
		public static const Link:Array = [ charCtr+=1, "link", "Link", "LINK", "Link", "Link", "Link", "Link",
		[Games.zelda, Games.zeldaAdventureOfLink, Games.zeldaLinksAwakening, Games.zeldaLinkToThePast, Games.zeldaOracleOfAges, Games.zeldaOracleOfSeasons] ];
		public static const Luigi:Array = [ charCtr+=1, "luigi", "Luigi", "LUIGI", "Luigi", "Luigi", "Luigi", "MarioBase",
		[ Games.superMarioBrosLostLevels, Games.superMarioBros, Games.superMarioBros2, Games.superMarioBros3, Games.superMarioAllStars ] ];
		public static const Mario:Array = [ charCtr+=1, "mario", "Mario", "MARIO", "Mario", "Mario", "Mario", "MarioBase",
		[Games.superMarioBros, Games.superMarioBrosLostLevels, Games.superMarioBros2, Games.superMarioBros3, Games.superMarioLand, Games.superMarioWorld, Games.superMarioLand2, Games.superMarioAllStars] ];
		public static const MegaMan:Array = [ charCtr+=1, "megaMan", "MegaMan", "MEGA_MAN", "Mega Man", "Mega Man", "Mega Man", "MegaManBase",
		[ Games.megaMan, Games.megaMan5, Games.megaMan2, Games.megaMan3, Games.megaMan4, Games.megaMan6, Games.megaMan7, Games.megaManAndBass, Games.megaManGb, Games.megaMan2Gb, Games.megaMan3Gb, Games.megaMan4Gb, Games.megaMan5Gb, Games.megaManWilyWars, Games.megaMan9, Games.megaMan10 ] ];
//		public static const Pit:Array = [ charCtr+=1, "pit", "Pit", "PIT", "Pit", "Pit", "Pit", null,
//		[ Games.kidIcarus, Games.kidIcarusOfMythsAndMonsters ] ];
//		public static const ProtoMan:Array = [ charCtr+=1, "protoMan", "ProtoMan", "PROTO_MAN", "Proto Man", "Proto Man", "Proto Man",
//			[ Games.megaMan9, Games.megaMan5, Games.megaManAndBass ] ];
		public static const Ryu:Array = [ charCtr+=1, "ryu", "Ryu", "RYU", "Ryu", "Ryu Hayabusa", "Ryu", null,
		[ Games.ninjaGaiden, Games.ninjaGaiden2, Games.ninjaGaiden3, Games.ninjaGaidenShadow, Games.ninjaGaidenTrilogy, Games.ninjaGaidenGg, Games.ninjaGaidenSms ] ];
		public static const Samus:Array = [ charCtr+=1, "samus", "Samus", "SAMUS", "Samus", "Samus Aran", "Samus", null,
		[ Games.metroid, Games.metroid2, Games.superMetroid ] ];
		public static const Simon:Array = [ charCtr+=1, "simon", "Simon", "SIMON", "Simon", "Simon Belmont", "Simon", null,
		[ Games.castlevania, Games.castlevania2, Games.castlevania3, Games.castlevaniaBelmontsRevenge, Games.castlevaniaAdventure, Games.castlevaniaBloodlines, Games.castlevaniaDraculaX, Games.castlevaniaLegends, Games.superCastlevania4, Games.vampireKiller ] ];
		public static const Sophia:Array = [ charCtr+=1, "sophia", "Sophia", "SOPHIA", "Sophia III", "Sophia III", "Jason", null,
		[ Games.blasterMaster, Games.blasterMasterEnemyBelow ] ];
//		public static const VicViper:Array = [ charCtr+=1, "vicViper", "VicViper", "VIC_VIPER", "Vic Viper", "Vic Viper", "Vic Viper", null,
//		[ Games.gimmick ] ];
//		public static const WarriorOfLight:Array = [ charCtr+=1, "warOfLight", "WarriorOfLight", "WAR_OF_LIGHT", "L. Warriors", "Warriors of Light", "Warrior",
//		[ Games.blasterMaster, Games.blasterMasterEnemyBelow ] ];
		
		private static const _CHAR_ARR:Vector.<Array> = new Vector.<Array>(); // call CHAR_ARR instead to avoid errors
		public static function initiate():Boolean
		{
			var list:XMLList = flash.utils.describeType(CharacterInfo)..constant;
			var n:int = list.length();
			if (!n)
				throw new Error("cannot initiate");
			for (var i:int; i < n; i++)
			{
				var name:String = list[i].@name;
				var type:String = list[i].@type;
				var val:Object = CharacterInfo[name];
				if (type == "Array")
					_CHAR_ARR.push(val);
			}
			_CHAR_ARR.sort(sortCharArr);
			return true;
		}
		private static function sortCharArr(arr1:Array,arr2:Array):int
		{
			var cNum1:int = arr1[IND_CHAR_NUM];
			var cNum2:int = arr2[IND_CHAR_NUM];
			if (cNum1 < cNum2)
				return -1;
			else if (cNum1 > cNum2)
				return 1;
			else
				return 0;
		}
		public static function convNameToNum(name:String):int
		{
			var n:int = NUM_CHARACTERS;
			for (var i:int = 0; i < n; i++) 
			{
				trace("itemName: "+itemName);
				var itemName:String = CHAR_ARR[i][IND_CHAR_NAME];
				if (itemName === name)
					return i;
			}
			return -1;
		}
		public static function convNumToName(num:int):String
		{
			return CHAR_ARR[num][IND_CHAR_NAME];
		}
		public static function getCharClassName(charNum:int,useBaseClass:Boolean = false):String
		{
			var name:String;
			if (useBaseClass)
				name = CHAR_ARR[charNum][IND_BASE_CLASS_NAME];
			if (!name)
				name = CHAR_ARR[charNum][IND_CHAR_NAME_CLASS];
			return name;
		}
		public static function getCharClassFromNum(num:int,useBassClass:Boolean = false):Class
		{
			var name:String;
			if (useBassClass)
				name = CHAR_ARR[num][IND_BASE_CLASS_NAME];
			if (!name)
				name = CHAR_ARR[num][IND_CHAR_NAME_CLASS];
//			if (name == "WarriorOfLight")
//				name = StatManager.STAT_MNGR.currentWarriorType;
			return getDefinitionByName(CHAR_PATH+name) as Class;
		}
		public static function get NUM_CHARACTERS():int
		{
			return CHAR_ARR.length;
		}
		public static function get CHAR_ARR():Vector.<Array>
		{
			if (!_CHAR_ARR.length)
				initiate();
			return _CHAR_ARR;
		}
	}
}