package com.explodingRabbit.cross.games
{
	import com.adobe.protocols.dict.Dict;
	import com.explodingRabbit.cross.sound.Song;
	import com.explodingRabbit.utils.ArrayUtils;
	import com.explodingRabbit.utils.CustomDictionary;
	import com.smbc.data.GameSettings;
	import com.smbc.data.LevelTypes;
	import com.smbc.data.MapPack;
	import com.smbc.data.MusicType;
	import com.smbc.graphics.ThemeGroup;
	import com.smbc.graphics.SkinNames;
	import com.smbc.level.Level;
	import com.smbc.managers.StatManager;
	
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	public class Game
	{
		public static var numSongs:int;
		protected static const IND_TG_THEME:int = 0; // TG is short for THEME_GROUP
		protected static const IND_TG_SET:int = 1;
		public static const IND_THEME_PL_SONG:int = 0;
		public static const IND_THEME_PL_LEVEL_TYPES:int = 1;
		public var creditsGame:Game;
		private var _publisher:String;
		
		protected static const LT_CASTLE:String = MusicType.LT_CASTLE;
		protected static const LT_CHEEP_CHEEP:String = MusicType.LT_CHEEP_CHEEP;
		protected static const LT_COIN_HEAVEN:String = MusicType.LT_COIN_HEAVEN;
		protected static const LT_INTRO:String = MusicType.LT_INTRO;
		protected static const LT_NORMAL:String = MusicType.LT_NORMAL;
		protected static const LT_PIPE_BONUS:String = MusicType.LT_PIPE_BONUS;
		protected static const LT_PLATFORM:String = MusicType.LT_PLATFORM;
		protected static const LT_UNDER_GROUND:String = MusicType.LT_UNDER_GROUND;
		protected static const LT_WATER:String = MusicType.LT_WATER;
		protected static const MT_DARK_EPIC:String = MusicType.MT_DARK_EPIC;
		
		protected static const BOSS:String = MusicType.BOSS;
		protected static const CHAR_SEL:String = MusicType.CHAR_SEL;
		protected static const CHOOSE_CHARACTER:String = MusicType.CHOOSE_CHARACTER;
		protected static const CREDITS:String = MusicType.CREDITS;
		protected static const DIE:String = MusicType.DIE;
		protected static const FINAL_BOSS:String = MusicType.FINAL_BOSS;
		protected static const GAME_OVER:String = MusicType.GAME_OVER;
//		protected static const LAKITU:String = MusicType.LAKITU;
		protected static const HURRY:String = MusicType.HURRY;
		protected static const STAR:String = MusicType.STAR;
		protected static const TITLE_SCREEN:String = MusicType.TITLE_SCREEN;
		protected static const WIN:String = MusicType.WIN;
		protected static const WIN_CASTLE:String = MusicType.WIN_CASTLE;
		
		private var _fullName:String;
		private var _shortName:String;
		private var _console:String;
		private var songDct:Dictionary;
		private var _gameNum:int;
		private var _skinSetNum:int;
		private var typePlayListDct:Dictionary;
		private var themePlayListArr:Array;
		private var themeLevelInfo:Dictionary;
		public var gameToUseAsPlayList:Game;
		private var overridableMusicTypes:CustomDictionary;
		private var themeGroupDct:CustomDictionary;
		private var hurrySongsDct:Dictionary;
//		private static const THEME_MAP_PACK_NONE:int = -1;
		protected var themeMapPack:MapPack = null;
		
		public function Game(name:String, publisher:String, console:String, gameNum:int, shortName:String = null, skinSetNum:int = -1)
		{
			this._fullName = name;
			this._shortName = shortName;
			this._publisher = publisher;
			this._console = console;
			this._gameNum = gameNum;
			this._skinSetNum = skinSetNum;
			creditsGame = this;
		}

		final protected function addSong(songClass:Class, track:int = -1, game:Game = null, volume:int = 100, start:int = 0, loop:int = 0, fadeStart:int = 0, fadeDur:int = 0):Song
		{ 
			if (!songDct)
				songDct = new Dictionary();
			var song:Song = new Song(songClass, track, game, volume, start, loop, fadeStart, fadeDur);
			songDct[song] = song;
			numSongs++;
			return song;
		}
		public function initiate():void
		{
			var classObj:Object = getDefinitionByName( getQualifiedClassName(this) );
			var list:XMLList = describeType(this)..constant;
			var n:int = list.length();
			for (var i:int; i < n; i++)
			{
				var nameVal:String = String( list[i].@name );
				var val:Object = this[nameVal];
				if (nameVal.indexOf("Sng") != -1)
					songDct[val] = nameVal;
			}
			for (var songObj:Object in songDct)
			{
				var song:Song = songObj as Song;
				song.name = songDct[songObj];
				song.game = this;
			}
			for each (var themeGroup:ThemeGroup in themeGroupDct)
			{
				themeGroup.game = this;
			}
			songDct = null;
			setUpLevelThemes();
			createPlayList();
			if (typePlayListDct && !gameToUseAsPlayList)
				verifyTypePlayList();
			else
				overridableMusicTypes = null; // no need to have it if it won't be used
		}
		protected function setUpLevelThemes():void
		{
			
		}
		protected function createPlayList():void
		{
			
		}
		private function verifyTypePlayList():void
		{
			for (var key:Object in typePlayListDct)
			{
				if (typePlayListDct[key] == null)
					typePlayListDct[key] = Song.EMPTY_SONG;
			}
			var musicTypeDct:Dictionary = MusicType.DCT;
			for each (var musicType:String in musicTypeDct)
			{
				if (!typePlayListDct[musicType])
					throw new Error("MusicType "+musicType+" is missing from "+fullName+" playlist");
			}
		}
		protected function addToTypePlayList(type:String, ... songs):void
		{
			if (!typePlayListDct)
				typePlayListDct = new Dictionary();
			typePlayListDct[type] = songs;
		}
//		public function isCompatibleWithGame(otherGame:Game):Boolean
//		{
//			
//			return false;
//		}
		
		public function getSongFromTypePlayList(str:String):Song
		{
			if (typePlayListDct && typePlayListDct[str])
				return typePlayListDct[str][0];
			return null;
		}
		protected function addToThemePlayList(themeGroup:ThemeGroup, song:Song, levelTypes:Array):void
		{
			if (!themePlayListArr)
				themePlayListArr = [];
			var valueArr:Array = [];
			valueArr[IND_THEME_PL_SONG] = song;
			valueArr[IND_THEME_PL_LEVEL_TYPES] = ArrayUtils.convArrayToDct(levelTypes);
			ArrayUtils.writeNestedArray( themePlayListArr, valueArr, themeGroup.theme, themeGroup.setNum );
		}
		public function getSongFromThemePlayList(theme:int, set:int, levelType:String):Song
		{
			if (!themePlayListArr)
				return null;
			var arr:Array = ArrayUtils.readNestedArr(themePlayListArr, theme, set);
			if (!arr)
				return null;
			var levelTypeDct:Dictionary = arr[IND_THEME_PL_LEVEL_TYPES];
			if (!levelTypeDct[levelType])
				return null;
			return arr[IND_THEME_PL_SONG];
		}
		public function getHurryVersionOfSong(sngToCheck:Song	):Song
		{
			if (hurrySongsDct)
				return hurrySongsDct[sngToCheck];
			return null;
		}
		protected function addHurryVersionOfSong(song:Song,hurryVersion:Song):void
		{
			if (!hurrySongsDct)
				hurrySongsDct = new Dictionary();
			hurrySongsDct[song] = hurryVersion;
		}
		protected function setGameToUseAsPlayList(game:Game):void
		{
			if (!game.typePlayListDct)
				game.typePlayListDct = new Dictionary();
			if (!game.hurrySongsDct)
				game.hurrySongsDct = new Dictionary();
			hurrySongsDct = game.hurrySongsDct;
			typePlayListDct = game.typePlayListDct;
			if (!game.themePlayListArr)
				game.themePlayListArr = [];
			themePlayListArr = game.themePlayListArr;
			gameToUseAsPlayList = game;
		}
		public function getThemeLevelInfo(useMapPack:Boolean = true):Dictionary
		{
			var dct:Dictionary = themeLevelInfo[GameSettings.mapPack];
//			trace("mapPack: "+GameSettings.mapPack + " something: "+ dct);
			if (dct == null || !useMapPack)
				dct = themeLevelInfo;
			return dct;
		}
		protected function addOverridableMusicTypes(... musicTypes):void
		{
			if (!overridableMusicTypes)
				overridableMusicTypes = new CustomDictionary();
			for each (var type:String in musicTypes)
			{
				overridableMusicTypes.addItem(type);
			}
		}
		/**
		 *Checks if music type is overrided. If so, it returns the new type. 
		 * @param themeGroup - Theme group containing music override
		 * @param musicType - Music type to check
		 * @return 
		 * 
		 */				
		public function getOverridedMusicType(themeGroup:ThemeGroup, musicType:String):String
		{
			if (!overridableMusicTypes || !overridableMusicTypes[musicType] || !themeGroup.musicType || themeGroup.game == this)
				return musicType;
			return themeGroup.musicType;	
		}
		protected function addThemeGroup(theme:int,set:int,musicType:String = null):ThemeGroup
		{
			if (!themeGroupDct)
				themeGroupDct = new CustomDictionary();
			var themeGroup:ThemeGroup = new ThemeGroup(theme,set,musicType);
			themeGroupDct.addItem(themeGroup);
			return themeGroup;
		}
		protected function addToThemeInfoGeneral(themeGroup:ThemeGroup, ... keys):void
		{
			if (!themeLevelInfo)
				themeLevelInfo = new Dictionary();
			if (!keys || !keys.length)
				throw new Error("no keys specified");
			for each (var str:String in keys)
			{
				var dct:Dictionary = themeLevelInfo;
				if (themeMapPack != null)
					dct = addDictionaryIfNull(themeLevelInfo, themeMapPack);
				if (dct[str])
					throw new Error(str + " is already set as a key");
				dct[str] = themeGroup;
			}
		}
		
		private function addDictionaryIfNull(dictionaryToCheck:Dictionary, key:MapPack):Dictionary
		{
				var dictionaryToReturn:Dictionary = dictionaryToCheck[key];
				if (dictionaryToReturn == null)
				{
					dictionaryToReturn = new Dictionary();
					dictionaryToCheck[key] = dictionaryToReturn;
				}
				return dictionaryToReturn;
		}
		
		protected function addToThemeInfoWorld(worldNum:int, themeGroup:ThemeGroup, ... keys):void
		{
			if (worldNum < 0 || worldNum > GameSuperMarioBrosLostLevels.NUM_WORLDS)
				throw new Error("invalid world number");
			var n:int = keys.length;
			var worldStr:String = worldNum.toString();
			for (var i:int = 0; i < n; i++) 
			{
				var str:String = keys[i];
				addToThemeInfoGeneral(themeGroup, worldStr + str);
			}
		}
		public function get console():String
		{
			return _console;
		}

		public function get fullName():String
		{
			return _fullName;
		}
		
		public function get shortName():String
		{
			return _shortName;
		}

		public function get gameNum():int
		{
			return _gameNum;
		}

		public function get skinSetNum():int
		{
			return _skinSetNum;
		}

		public function get publisher():String
		{
			return _publisher;
		}


	}
}