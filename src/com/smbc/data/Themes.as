package com.smbc.data
{
	import com.explodingRabbit.cross.games.Game;
	import com.explodingRabbit.cross.games.Games;
	import com.smbc.graphics.BackgroundInfo;
	import com.smbc.graphics.ThemeGroup;
	import com.smbc.graphics.BmdSkinCont;
	import com.smbc.level.CharacterSelect;
	import com.smbc.level.Level;
	import com.smbc.level.TitleLevel;
	import com.smbc.managers.GraphicsManager;
	
	import flash.events.FullScreenEvent;
	import flash.net.getClassByAlias;
	import flash.utils.Dictionary;

	public class Themes
	{
		public static const NORMAL:int = 1;
		public static const SNOW:int = 2;
		public static const UNDER_GROUND:int = 3;
		public static const WATER:int = 4;
		public static const DUNGEON:int = 5;
		public static const PLATFORM:int = 6;
		public static const COIN_HEAVEN:int = 7;
		public static const CUSTOM_1:int = 8;
		public static const CUSTOM_2:int = 9;
		
		public static const IND_THEME:int = 0;
		public static const IND_SET:int = 1;
		public static const IND_PRIORITY:int = 2;
		
		private static const THEME_TYPE_MAP:int = 0;
		private static const THEME_TYPE_ENEMY:int = 1;
		private static const THEME_TYPE_INTERFACE:int = 2;
		private static const MIN_SKIN:int = Games.superMarioBros.skinSetNum;
		
		private static const storedThemesVec:Vector.<ThemeGroup> = new Vector.<ThemeGroup>(3,true);
		
		public static var set:int;
		public static const MIN_THEME:int = 1;
		
	/*	private static const DEF_THEMES_DCT:Dictionary = new Dictionary();
		{	
			// default level types
			DEF_THEMES_DCT[LevelTypes.CASTLE] = [ DUNGEON, 1, 10 ];
			DEF_THEMES_DCT[LevelTypes.COIN_HEAVEN] = [ 7, 1, 10 ];
			DEF_THEMES_DCT[LevelTypes.NORMAL] = [ NORMAL, 1, 0 ];
			DEF_THEMES_DCT[LevelTypes.UNDER_GROUND] = [ UNDER_GROUND, 1, 10 ];
			DEF_THEMES_DCT[LevelTypes.WATER] = [ WATER, 1, 10 ];
			
			// extra level types
			DEF_THEMES_DCT[LevelTypes.CHEEP_CHEEP] = DEF_THEMES_DCT[LevelTypes.NORMAL];
			DEF_THEMES_DCT[LevelTypes.INTRO] = DEF_THEMES_DCT[LevelTypes.NORMAL];
			DEF_THEMES_DCT[LevelTypes.PIPE_BONUS] = DEF_THEMES_DCT[LevelTypes.UNDER_GROUND];
			DEF_THEMES_DCT[LevelTypes.PLATFORM] = DEF_THEMES_DCT[LevelTypes.NORMAL];
		}*/
		
		public static const MAX_THEMES:int = 16;
		/*public static function getNum(name:String):int
		{
			var n:int = VEC.length;
			for (var i:int; i < n; i++)
			{
				var str:String = VEC[i];
				if (str == name)
					return i;
			}
			return -1;
		}
		public static function getName(num:int):String
		{
			return VEC[num];
		}*/
		public static function getMapTheme(lookUpStoredValue:Boolean = false, fullLevStr:String = null,levelType:String = null):ThemeGroup
		{
			if (lookUpStoredValue)
				return storedThemesVec[THEME_TYPE_MAP];
			if (Level.levelInstance is CharacterSelect)
				return determineTheme(CharacterSelect.instance.levelIdForTheme.fullName,CharacterSelect.instance.levTypeForTheme,THEME_TYPE_MAP);
			return determineTheme(fullLevStr,levelType,THEME_TYPE_MAP);
		}
		public static function getEnemyTheme(lookUpStoredValue:Boolean = false, fullLevStr:String = null,levelType:String = null):ThemeGroup
		{
			if (lookUpStoredValue)
				return storedThemesVec[THEME_TYPE_ENEMY];
			return determineTheme(fullLevStr,levelType,THEME_TYPE_ENEMY);
		}
		public static function getInterfaceTheme(lookUpStoredValue:Boolean = false, fullLevStr:String = null,levelType:String = null):ThemeGroup
		{
			if (lookUpStoredValue)
				return storedThemesVec[THEME_TYPE_INTERFACE];
			return determineTheme(fullLevStr,levelType,THEME_TYPE_INTERFACE);
		}
		public static function getThemeBySkinNum(skinNum:int, fullLevStr:String = null,levelType:String = null):ThemeGroup
		{
			return determineTheme(fullLevStr,levelType,-1,skinNum);
		}
		private static function determineTheme(fullLevStr:String,levelType:String,themeType:int,skinNum:int = -1):ThemeGroup
		{
			var level:Level = Level.levelInstance;
			if (level)
			{
				if (!fullLevStr)
					fullLevStr = level.id.fullName;
				if (!levelType)
					levelType = level.type;
			}
			if (themeType >= 0)
			{
				if (themeType == THEME_TYPE_MAP)
					skinNum = GameSettings.getMapSkinLimited();
				else if (themeType == THEME_TYPE_ENEMY)
					skinNum = GameSettings.getEnemySkinLimited();
				else if (themeType == THEME_TYPE_INTERFACE)
					skinNum = GameSettings.getInterfaceSkinLimited();
				else
					throw new Error("cannot get theme for this bmcType");
			}
			if (GameSettings.FORCE_THEME_GROUP)
				return GameSettings.FORCE_THEME_GROUP;
			var game:Game = Games.getGameFromSkinSetNum(skinNum);
			var infoDct:Dictionary;
			if (game)
				infoDct = game.getThemeLevelInfo();
//			if (fullLevStr != "9-1a")
//				trace("sadfasdf");
//			trace("game for theme: "+game.fullName);
			if (!infoDct)
				throw new Error("game doesn't have themeInfoDct");
//				return null;
//				return setTheme( new ThemeGroup(1,1), themeType);
			var levelId:LevelID = LevelID.Create(fullLevStr);
			var testArr:Array = [
				fullLevStr,
				levelId.world.toString() + levelType,
				levelType
			];
			var n:int = testArr.length;
			for (var i:int = 0; i < n; i++) 
			{
				var testStr:String = testArr[i];
				var themeGroup:ThemeGroup = infoDct[ testStr ]; 
				if (themeGroup)
					return setTheme( themeGroup, themeType );
			}
//			now test the version without a mappack
			infoDct = game.getThemeLevelInfo(false);
			for (i = 0; i < n; i++) 
			{
				testStr = testArr[i];
				themeGroup = infoDct[ testStr ]; 
				if (themeGroup)
					return setTheme( themeGroup, themeType );
			}
			throw new Error("Theme not found");
			return null;
				
			/*var worldTheme:int = MIN_THEME - 1;
			var worldSet:int;
			var worldPriority:int;
			var worldNum:String = fullLevStr.charAt(0);
			var worldThemeArr:Array = ovRdDct[worldNum];
			if (worldThemeArr)
			{
				worldTheme = worldThemeArr[IND_THEME];
				worldSet = worldThemeArr[IND_SET];
				worldPriority = worldThemeArr[IND_PRIORITY];
			}
			var typeTheme:int = MIN_THEME - 1;
			var typeSet:int;
			var typePriority:int;
			var typeThemeArr:Array = ovRdDct[levelType]; 
			if (typeThemeArr)
			{
				typeTheme = typeThemeArr[IND_THEME];
				typeSet = typeThemeArr[IND_SET];
				typePriority = typeThemeArr[IND_PRIORITY];
			}
			trace("worldTheme: "+worldTheme+" worldPriority: "+worldPriority+" typeTheme: "+typeTheme+" typePriority: "+typePriority);
			if (worldTheme >= MIN_THEME )
			{
				if (typeTheme >= MIN_THEME && typePriority >= worldPriority)
					return setTheme(typeTheme, typeSet, themeType);
				else
					return setTheme(worldTheme, worldSet, themeType);
			}
			if (typeTheme >= MIN_THEME)
				return setTheme(typeTheme, typeSet, themeType);
			return setTheme(MIN_THEME, BackgroundInfo.SET_MIN, themeType);*/
		}
		private static function setTheme(themeGroup:ThemeGroup,type:int):ThemeGroup
		{
			if (type >= MIN_SKIN)
				storedThemesVec[type] = themeGroup;
//			trace("set theme: "+themeGroup.theme + " set: "+themeGroup.setNum + " musicType: "+themeGroup.musicType);
			return themeGroup;
		}
	}
}