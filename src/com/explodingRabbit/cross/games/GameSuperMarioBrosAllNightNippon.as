package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.MapPack;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameSuperMarioBrosAllNightNippon extends Game
	{
		private static var instance:Game;
		
		public function GameSuperMarioBrosAllNightNippon(gameNum:int, skinSetNum:int)
		{
			super("All Night Nippon Super Mario Bros.", "Nintendo", Consoles.nintendo, gameNum, "SMB: All Night Nippon", skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		private const TG_OVERWORLD:ThemeGroup = addThemeGroup( 1, 1 );
		private const TG_OVERWORLD_NIGHT:ThemeGroup = addThemeGroup( 1, 2, MT_DARK_EPIC );
		private const TG_OVERWORLD_SNOW:ThemeGroup = addThemeGroup( 1, 3 );
		private const TG_OVERWORLD_SNOW_NIGHT:ThemeGroup = addThemeGroup( 1, 4, MT_DARK_EPIC );
		private const TG_OVERWORLD_GRAY:ThemeGroup = addThemeGroup( 1, 5, MT_DARK_EPIC );
		private const TG_UNDERGROUND:ThemeGroup = addThemeGroup( 1, 6 );
		private const TG_UNDERGROUND_WATER:ThemeGroup = addThemeGroup( 1, 7 );
		private const TG_OVERWORLD_CASTLE_WALL:ThemeGroup = addThemeGroup( 1, 8);
		private const TG_UNDERGROUND_SCENERY:ThemeGroup = addThemeGroup( 1, 9 );
		private const TG_MUSHROOM_PLATFORM:ThemeGroup = addThemeGroup( 2, 1 );
		private const TG_MUSHROOM_PLATFORM_ORANGE:ThemeGroup = addThemeGroup( 2, 2 );
		private const TG_COIN_HEAVEN:ThemeGroup = addThemeGroup( 3, 1 );  
		private const TG_COIN_HEAVEN_NIGHT:ThemeGroup = addThemeGroup( 3, 2, MT_DARK_EPIC );  
		private const TG_COIN_HEAVEN_BLUE:ThemeGroup = addThemeGroup( 3, 3 );
		private const TG_COIN_HEAVEN_GRAY:ThemeGroup = addThemeGroup( 3, 4 );
		private const TG_WATER:ThemeGroup = addThemeGroup( 4, 1 );
		private const TG_WATER_NIGHT:ThemeGroup = addThemeGroup( 4, 2 );
		private const TG_CASTLE:ThemeGroup = addThemeGroup( 5, 1 );
		private const TG_CASTLE_WATER:ThemeGroup = addThemeGroup( 5, 2 );
		private const TG_CLOUDS:ThemeGroup = addThemeGroup( 6, 1 );
		private const TG_OVERWORLD_WATER:ThemeGroup = addThemeGroup( 7, 1 );
		private const TG_WATER_GRAY:ThemeGroup = addThemeGroup( 7, 2 );
		private const TG_CASTLE_OVERWORLD:ThemeGroup = addThemeGroup( 8, 1 );

		override protected function setUpLevelThemes():void
		{
			addToThemeInfoGeneral( TG_OVERWORLD, LT_NORMAL, LT_INTRO, LT_PLATFORM, LT_CHEEP_CHEEP );
			addToThemeInfoGeneral( TG_UNDERGROUND, LT_UNDER_GROUND, LT_PIPE_BONUS );
			addToThemeInfoGeneral( TG_COIN_HEAVEN, LT_COIN_HEAVEN );
			addToThemeInfoGeneral( TG_CASTLE, LT_CASTLE );
			addToThemeInfoGeneral( TG_WATER, LT_WATER );

			addToThemeInfoWorld( 1, TG_OVERWORLD_NIGHT, LT_NORMAL, LT_INTRO, LT_PLATFORM );
			
			addToThemeInfoWorld( 3, TG_OVERWORLD_SNOW_NIGHT, LT_NORMAL );
			addToThemeInfoWorld( 3, TG_OVERWORLD_NIGHT, LT_PLATFORM );
			addToThemeInfoWorld( 3, TG_COIN_HEAVEN_NIGHT, LT_COIN_HEAVEN );

			addToThemeInfoWorld( 4, TG_MUSHROOM_PLATFORM, LT_NORMAL );
			addToThemeInfoWorld( 4, TG_MUSHROOM_PLATFORM_ORANGE, LT_PLATFORM );
			
			addToThemeInfoWorld( 5, TG_OVERWORLD_SNOW, LT_NORMAL );
			
			addToThemeInfoWorld( 6, TG_OVERWORLD_NIGHT, LT_NORMAL );
			addToThemeInfoWorld( 6, TG_COIN_HEAVEN_NIGHT, LT_COIN_HEAVEN );
			addToThemeInfoWorld( 6, TG_OVERWORLD_GRAY, LT_PLATFORM );
			
			addToThemeInfoWorld( 7, TG_OVERWORLD_SNOW, LT_NORMAL );
			
			addToThemeInfoWorld( 8, TG_CASTLE_WATER, LT_WATER );
			
			addToThemeInfoGeneral( TG_OVERWORLD, "7-2c" );
			
			themeMapPack = MapPack.Special;
			
			addToThemeInfoWorld( 8, TG_MUSHROOM_PLATFORM_ORANGE, LT_PLATFORM );
			
			addToThemeInfoGeneral( TG_UNDERGROUND_SCENERY, "2-2c" );
			addToThemeInfoGeneral( TG_WATER_NIGHT, "3-1b", "6-2e" );
			addToThemeInfoGeneral( TG_MUSHROOM_PLATFORM_ORANGE, "3-2b", "8-3c" );
			addToThemeInfoGeneral( TG_COIN_HEAVEN, "4-1b" );
			addToThemeInfoGeneral( TG_COIN_HEAVEN_BLUE, "4-3b" );
			addToThemeInfoGeneral( TG_UNDERGROUND_WATER, "6-2c" );
			addToThemeInfoGeneral( TG_WATER, "8-2b" );
			addToThemeInfoGeneral( TG_OVERWORLD_CASTLE_WALL, "8-2c" );
			
			themeMapPack = MapPack.LostLevels;
			
			addToThemeInfoWorld( 2, TG_OVERWORLD_NIGHT, LT_NORMAL, LT_CHEEP_CHEEP );
			
			addToThemeInfoWorld( 3, TG_OVERWORLD_SNOW, LT_NORMAL, LT_PLATFORM );
			addToThemeInfoWorld( 3, TG_COIN_HEAVEN, LT_COIN_HEAVEN );
			
			addToThemeInfoWorld( 4, TG_OVERWORLD, LT_PLATFORM ); 
			
			addToThemeInfoWorld( 5, TG_OVERWORLD_SNOW, LT_NORMAL );
			
			addToThemeInfoWorld( 6, TG_OVERWORLD, LT_NORMAL );
			
			addToThemeInfoWorld( 7, TG_OVERWORLD_SNOW_NIGHT, LT_NORMAL );
			addToThemeInfoWorld( 7, TG_OVERWORLD_GRAY, LT_PLATFORM );
			
			addToThemeInfoWorld( 8, TG_MUSHROOM_PLATFORM_ORANGE, LT_NORMAL );
			addToThemeInfoWorld( 8, TG_CLOUDS, LT_PLATFORM );
			
			addToThemeInfoWorld( 9, TG_OVERWORLD_WATER, LT_WATER );
			addToThemeInfoWorld( 9, TG_COIN_HEAVEN_GRAY, LT_COIN_HEAVEN );
			
			addToThemeInfoWorld( 10, TG_MUSHROOM_PLATFORM_ORANGE, LT_NORMAL, LT_PLATFORM );
			
			addToThemeInfoWorld( 12, TG_OVERWORLD_NIGHT, LT_NORMAL, LT_PLATFORM, LT_CHEEP_CHEEP );
			
			addToThemeInfoWorld( 13, TG_OVERWORLD_SNOW, LT_NORMAL );
			
			addToThemeInfoGeneral( TG_OVERWORLD, "3-2a", "3-2c", "5-2a", "5-2c", "5-2d", "10-2a", "13-4b" );
			addToThemeInfoGeneral( TG_OVERWORLD_SNOW, "8-1a", "8-1c" );
			addToThemeInfoGeneral( TG_WATER, "8-1b" );
			addToThemeInfoGeneral( TG_CASTLE, "8-4b" );
			addToThemeInfoGeneral( TG_CASTLE_OVERWORLD, "9-3a" );
			addToThemeInfoGeneral( TG_WATER_GRAY, "9-4a" );
			addToThemeInfoGeneral( TG_MUSHROOM_PLATFORM, "10-2c" );
			addToThemeInfoGeneral( TG_CLOUDS, "11-4b" );
			addToThemeInfoGeneral( TG_OVERWORLD_GRAY, "12-3a" );
		}
		override protected function createPlayList():void
		{
			setGameToUseAsPlayList(Games.superMarioBros);
		}
	}
}