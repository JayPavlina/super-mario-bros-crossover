package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.MapPack;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameSuperMarioBros extends Game
	{
		private static var instance:Game;
		public static const NUM_WORLDS:int = 8;
		public function GameSuperMarioBros(gameNum:int, skinSetNum:int)
		{
			super("Super Mario Bros.", "Nintendo", Consoles.nintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/nsf/SuperMarioBrosVs.nsf", mimeType="application/octet-stream")]
		public const NSF:Class;
		
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
		private const TG_CLOUDS_OVERWORLD:ThemeGroup = addThemeGroup( 6, 2 );
		private const TG_OVERWORLD_WATER:ThemeGroup = addThemeGroup( 7, 1 );
		private const TG_WATER_GRAY:ThemeGroup = addThemeGroup( 7, 2 );
		private const TG_CASTLE_OVERWORLD:ThemeGroup = addThemeGroup( 8, 1 );

		private const VOLUME:int = 60;
		public const SngOverworld:Song = addSong( NSF, 1, null, VOLUME );
		public const SngWater:Song = addSong( NSF, 2, null, VOLUME );
		public const SngUnderGround:Song = addSong( NSF, 3, null, VOLUME );
		public const SngBeatLevel:Song = addSong( NSF, 4, null, VOLUME );
		public const SngCastle:Song = addSong( NSF, 5, null, VOLUME );
		public const SngBeatWorld:Song = addSong( NSF, 6, null, VOLUME );
		public const SngInvincible:Song = addSong( NSF, 7, null, VOLUME );
		public const SngTransition:Song = addSong( NSF, 8, null, VOLUME );
		public const SngSecondsLeft:Song = addSong( NSF, 9, null, VOLUME );
		public const SngOverworldHurry:Song = addSong( NSF, 10, null, VOLUME );
		public const SngWaterHurry:Song = addSong( NSF, 11, null, VOLUME );
		public const SngUnderGroundHurry:Song = addSong( NSF, 12, null, VOLUME );
		public const SngCastleHurry:Song = addSong( NSF, 13, null, VOLUME );
		public const SngInvincibleHurry:Song = addSong( NSF, 14, null, VOLUME );
		public const SngDie:Song = addSong( NSF, 15, null, VOLUME );
		public const SngGameOver:Song = addSong( NSF, 16, null, VOLUME );
		public const SngSuperMarioBrosEnding:Song = addSong( NSF, 17, null, VOLUME );
		public const SngVsEnding:Song = addSong( NSF, 18, null, VOLUME );
		public const SngLostLevelsEnding:Song = addSong( NSF, 19, null, VOLUME );
//		public const SngNameEntry:Song = addSong( NSF, 20, null, VOLUME );
		public const SngNameEntry:Song = addSong( NSF, 21, null, VOLUME );
		
		override protected function setUpLevelThemes():void
		{
			addToThemeInfoGeneral( TG_OVERWORLD, LT_NORMAL, LT_INTRO, LT_PLATFORM, LT_CHEEP_CHEEP );
			addToThemeInfoGeneral( TG_UNDERGROUND, LT_UNDER_GROUND, LT_PIPE_BONUS );
			addToThemeInfoGeneral( TG_COIN_HEAVEN, LT_COIN_HEAVEN );
			addToThemeInfoGeneral( TG_CASTLE, LT_CASTLE );
			addToThemeInfoGeneral( TG_WATER, LT_WATER );
			
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
			
			addToThemeInfoWorld( 10, TG_MUSHROOM_PLATFORM_ORANGE, LT_NORMAL );
			addToThemeInfoWorld( 10, TG_CLOUDS, LT_PLATFORM );
			
			addToThemeInfoWorld( 12, TG_OVERWORLD_NIGHT, LT_NORMAL, LT_PLATFORM, LT_CHEEP_CHEEP );
			
			addToThemeInfoWorld( 13, TG_OVERWORLD_SNOW, LT_NORMAL );
			
			addToThemeInfoGeneral( TG_OVERWORLD, "3-2a", "3-2c", "5-2a", "5-2c", "5-2d", "10-2a", "13-4b" );
			addToThemeInfoGeneral( TG_OVERWORLD_SNOW, "8-1a", "8-1c" );
			addToThemeInfoGeneral( TG_WATER, "8-1b" );
			addToThemeInfoGeneral( TG_CASTLE, "8-4b" );
			addToThemeInfoGeneral( TG_CASTLE_OVERWORLD, "9-3a" );
			addToThemeInfoGeneral( TG_WATER_GRAY, "9-4a" );
			addToThemeInfoGeneral( TG_CLOUDS_OVERWORLD, "10-2c" );
			addToThemeInfoGeneral( TG_CLOUDS, "11-4b" );
			addToThemeInfoGeneral( TG_OVERWORLD_GRAY, "12-3a" );
		}
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL, LT_CHEEP_CHEEP, LT_PLATFORM);
			
			addToTypePlayList(LT_CASTLE, SngCastle);
			addToTypePlayList(LT_CHEEP_CHEEP, SngOverworld);
			addToTypePlayList(LT_COIN_HEAVEN, SngInvincible);
			addToTypePlayList(LT_INTRO, SngTransition);
			addToTypePlayList(LT_NORMAL, SngOverworld);
			addToTypePlayList(LT_PIPE_BONUS, SngUnderGround);
			addToTypePlayList(LT_PLATFORM, SngOverworld);
			addToTypePlayList(LT_UNDER_GROUND, SngUnderGround);
			addToTypePlayList(LT_WATER, SngWater);
			addToTypePlayList(MT_DARK_EPIC, SngOverworld);
			
			addToTypePlayList(BOSS, SngCastle);
			addToTypePlayList(CHAR_SEL, SngNameEntry);
			addToTypePlayList(CHOOSE_CHARACTER, SngTransition);
			addToTypePlayList(CREDITS, SngSuperMarioBrosEnding);
			addToTypePlayList(DIE, SngDie);
			addToTypePlayList(FINAL_BOSS, SngCastle);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, SngOverworldHurry);
			addToTypePlayList(STAR, SngInvincible);
			addToTypePlayList(TITLE_SCREEN, SngOverworld);
			addToTypePlayList(WIN, SngBeatLevel);
			addToTypePlayList(WIN_CASTLE, SngBeatWorld);
			
			addHurryVersionOfSong( SngCastle, SngCastleHurry);
			addHurryVersionOfSong( SngInvincible, SngInvincibleHurry);
			addHurryVersionOfSong( SngOverworld, SngOverworldHurry);
			addHurryVersionOfSong( SngUnderGround, SngUnderGroundHurry);
			addHurryVersionOfSong( SngWater, SngWaterHurry);
		}
	}
}