package com.smbc.data
{
	import flash.utils.Dictionary;
	import flash.utils.describeType;

	public class MusicType
	{
		public static const LT_CASTLE:String = LevelTypes.CASTLE;
		public static const LT_CHEEP_CHEEP:String = LevelTypes.CHEEP_CHEEP;
		public static const LT_COIN_HEAVEN:String = LevelTypes.COIN_HEAVEN;
		public static const LT_INTRO:String = LevelTypes.INTRO;
		public static const LT_NORMAL:String = LevelTypes.NORMAL;
		public static const LT_PIPE_BONUS:String = LevelTypes.PIPE_BONUS;
		public static const LT_PLATFORM:String = LevelTypes.PLATFORM;
		public static const LT_UNDER_GROUND:String = LevelTypes.UNDER_GROUND;
		public static const LT_WATER:String = LevelTypes.WATER;
		public static const MT_DARK_EPIC:String = "darkEpic";
		
		public static const BOSS:String = "BOSS";
		public static const CHAR_SEL:String = "CHAR_SEL";
		public static const CHOOSE_CHARACTER:String = "INTRO_LEVEL";
		public static const CREDITS:String = "CREDITS";
		public static const DIE:String = "DIE";
		public static const FINAL_BOSS:String = "FINAL_BOSS";
		public static const GAME_OVER:String = "GAME_OVER";
		public static const HURRY:String = "HURRY";
		public static const STAR:String = "STAR";
		public static const TITLE_SCREEN:String = "TITLE_SCREEN";
		public static const WIN:String = "WIN";
		public static const WIN_CASTLE:String = "WIN_CASTLE";
		
		public static const DCT:Dictionary = new Dictionary();
		
		public static function initiate():void
		{
			var list:XMLList = describeType(MusicType)..constant;
			var n:int = list.length();
			for (var i:int; i < n; i++)
			{
				var name:String = String( list[i].@name );
				var value:String = String( MusicType[name] );
				if (name != "DCT") 
					DCT[name] = value;
			}
		}
	}
}