package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.MapPack;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameSuperMarioBrosAtari extends Game
	{
		private static var instance:Game;
//		public static const NUM_WORLDS:int = 8;
		public function GameSuperMarioBrosAtari(gameNum:int, skinSetNum:int)
		{
			super("Super Mario Bros.", "Nintendo", Consoles.atari, gameNum, "SMB (Atari)", skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		[Embed(source="../../../../../assets/audio/seq/nsf/SuperMarioBrosVs.nsf", mimeType="application/octet-stream")]
		public const NSF:Class;
		[Embed(source="../../../../../assets/audio/seq/sap/SuperMarioBrosOverworld.sap", mimeType="application/octet-stream")]
		public const SuperMarioBrosOverworld:Class;
		[Embed(source="../../../../../assets/audio/seq/sap/SuperMarioBros2Overworld.sap", mimeType="application/octet-stream")]
		public const SuperMarioBros2Overworld:Class;
		[Embed(source="../../../../../assets/audio/seq/sap/DrMario.sap", mimeType="application/octet-stream")]
		public const DrMario:Class;
		[Embed(source="../../../../../assets/audio/seq/sap/MarioBros.sap", mimeType="application/octet-stream")]
		public const MarioBros:Class;
		
		private const VOLUME:int = 50;
		private static const VOLUME_DR_MARIO:int = 60;
		public const SngOverworld:Song = addSong( SuperMarioBrosOverworld, 1, null, 30 );
		public const SngOverworldMario2:Song = addSong( SuperMarioBros2Overworld, 1, null, VOLUME );
		public const SngDrMarioIntro:Song = addSong( DrMario, 1, null, VOLUME_DR_MARIO + 20 );
		public const SngDrMarioMain:Song = addSong( DrMario, 2, null, VOLUME_DR_MARIO );
		public const SngDrMarioUnderground:Song = addSong( DrMario, 3, null, VOLUME_DR_MARIO - 10 );
		public const SngDrMarioSlow:Song = addSong( DrMario, 4, null, VOLUME_DR_MARIO );
		public const SngDrMarioHappy:Song = addSong( DrMario, 5, null, VOLUME_DR_MARIO );
		public const SngDrMarioCredits:Song = addSong( DrMario, 6, null, VOLUME_DR_MARIO );
		public const SngMarioBrosIntro:Song = addSong( MarioBros, 1, null, VOLUME );
		public const SngMarioBrosWin:Song = addSong( MarioBros, 2, null, VOLUME );
		public const SngMarioBrosGameOver:Song = addSong( MarioBros, 3, null, VOLUME );
		public const SngMarioBrosRespawn:Song = addSong( MarioBros, 4, null, VOLUME );
		public const SngMarioBrosJingle:Song = addSong( MarioBros, 5, null, VOLUME );
		
		private const TG_OVERWORLD:ThemeGroup = addThemeGroup( 1, 1 );
		private const TG_OVERWORLD_NIGHT:ThemeGroup = addThemeGroup( 1, 2, MT_DARK_EPIC );
		private const TG_OVERWORLD_SNOW:ThemeGroup = addThemeGroup( 1, 3 );
		private const TG_OVERWORLD_SNOW_NIGHT:ThemeGroup = addThemeGroup( 1, 4, MT_DARK_EPIC );
		private const TG_OVERWORLD_GRAY:ThemeGroup = addThemeGroup( 1, 5, MT_DARK_EPIC );
		private const TG_UNDERGROUND:ThemeGroup = addThemeGroup( 1, 6 );
		private const TG_UNDERGROUND_WATER:ThemeGroup = addThemeGroup( 1, 7 );
		private const TG_UNDERGROUND_SCENERY:ThemeGroup = addThemeGroup( 1, 8 );
		private const TG_MUSHROOM_PLATFORM:ThemeGroup = addThemeGroup( 2, 1 );
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
			
			addToThemeInfoWorld( 3, TG_OVERWORLD_SNOW_NIGHT, LT_NORMAL );
			addToThemeInfoWorld( 3, TG_OVERWORLD_NIGHT, LT_PLATFORM );
			addToThemeInfoWorld( 3, TG_COIN_HEAVEN_NIGHT, LT_COIN_HEAVEN );
			
			addToThemeInfoWorld( 4, TG_MUSHROOM_PLATFORM, LT_NORMAL, LT_PLATFORM );
			
			addToThemeInfoWorld( 5, TG_OVERWORLD_SNOW, LT_NORMAL );
			
			addToThemeInfoWorld( 6, TG_OVERWORLD_NIGHT, LT_NORMAL );
			addToThemeInfoWorld( 6, TG_COIN_HEAVEN_NIGHT, LT_COIN_HEAVEN );
			addToThemeInfoWorld( 6, TG_OVERWORLD_GRAY, LT_PLATFORM );
			
			addToThemeInfoWorld( 7, TG_OVERWORLD_SNOW, LT_NORMAL );
			
			addToThemeInfoWorld( 8, TG_CASTLE_WATER, LT_WATER );
			
			addToThemeInfoGeneral( TG_OVERWORLD, "7-2c" );
			
			themeMapPack = MapPack.Special;
			
			addToThemeInfoGeneral( TG_UNDERGROUND_SCENERY, "2-2c" );
			addToThemeInfoGeneral( TG_WATER_NIGHT, "3-1b", "6-2e" );
			addToThemeInfoGeneral( TG_MUSHROOM_PLATFORM, "3-2b" );
			addToThemeInfoGeneral( TG_COIN_HEAVEN, "4-1b" );
			addToThemeInfoGeneral( TG_COIN_HEAVEN_BLUE, "4-3b" );
			addToThemeInfoGeneral( TG_UNDERGROUND_WATER, "6-2c" );
			addToThemeInfoGeneral( TG_MUSHROOM_PLATFORM, "8-1a", "8-2a" );
			addToThemeInfoGeneral( TG_WATER, "8-2b" );
			
			themeMapPack = MapPack.LostLevels;
			
			addToThemeInfoWorld( 2, TG_OVERWORLD_NIGHT, LT_NORMAL, LT_CHEEP_CHEEP );
			
			addToThemeInfoWorld( 3, TG_OVERWORLD_SNOW, LT_NORMAL, LT_PLATFORM );
			addToThemeInfoWorld( 3, TG_COIN_HEAVEN, LT_COIN_HEAVEN );
			
			addToThemeInfoWorld( 4, TG_MUSHROOM_PLATFORM, LT_NORMAL, LT_PLATFORM );
			
			addToThemeInfoWorld( 5, TG_OVERWORLD_SNOW, LT_NORMAL );
			
			addToThemeInfoWorld( 6, TG_OVERWORLD, LT_NORMAL, LT_INTRO, LT_CHEEP_CHEEP );
			
			addToThemeInfoWorld( 7, TG_OVERWORLD_SNOW_NIGHT, LT_NORMAL ); 
			addToThemeInfoWorld( 7, TG_OVERWORLD_GRAY, LT_PLATFORM );
			
			addToThemeInfoWorld( 8, TG_MUSHROOM_PLATFORM, LT_NORMAL );
			addToThemeInfoWorld( 8, TG_CLOUDS, LT_PLATFORM );
			
			addToThemeInfoWorld( 9, TG_OVERWORLD_WATER, LT_WATER );
			addToThemeInfoWorld( 9, TG_COIN_HEAVEN_GRAY, LT_COIN_HEAVEN );
			
			addToThemeInfoWorld( 10, TG_MUSHROOM_PLATFORM, LT_NORMAL, LT_PLATFORM );
			
			addToThemeInfoWorld( 12, TG_OVERWORLD_NIGHT, LT_NORMAL, LT_PLATFORM, LT_CHEEP_CHEEP );
			
			addToThemeInfoWorld( 13, TG_OVERWORLD_SNOW, LT_NORMAL );
			
			addToThemeInfoGeneral( TG_OVERWORLD, "3-2a", "3-2c", "5-2a", "5-2c", "5-2d", "10-2a", "13-4b" );
			addToThemeInfoGeneral( TG_OVERWORLD_SNOW, "8-1a", "8-1c" );
			addToThemeInfoGeneral( TG_CASTLE, "8-4b" );
			addToThemeInfoGeneral( TG_CASTLE_OVERWORLD, "9-3a" );
			addToThemeInfoGeneral( TG_WATER_GRAY, "9-4a" );
			addToThemeInfoGeneral( TG_CLOUDS, "10-2c" );
			addToThemeInfoGeneral( TG_OVERWORLD_GRAY, "12-3a" );
		}
		override protected function createPlayList():void
		{
			addToTypePlayList(LT_CASTLE, SngDrMarioSlow);
			addToTypePlayList(LT_CHEEP_CHEEP, SngOverworld);
			addToTypePlayList(LT_COIN_HEAVEN, SngDrMarioMain);
			addToTypePlayList(LT_INTRO, SngMarioBrosIntro);
			addToTypePlayList(LT_NORMAL, SngOverworld);
			addToTypePlayList(LT_PIPE_BONUS, SngDrMarioUnderground);
			addToTypePlayList(LT_PLATFORM, SngOverworld);
			addToTypePlayList(LT_UNDER_GROUND, SngDrMarioUnderground);
			addToTypePlayList(LT_WATER, SngDrMarioHappy);
			addToTypePlayList(MT_DARK_EPIC, SngOverworld);
			
			addToTypePlayList(BOSS, SngDrMarioMain);
			addToTypePlayList(CHAR_SEL, SngDrMarioIntro);
			addToTypePlayList(CHOOSE_CHARACTER, SngMarioBrosRespawn);
			addToTypePlayList(CREDITS, SngDrMarioCredits);
			addToTypePlayList(DIE, SngMarioBrosJingle);
			addToTypePlayList(FINAL_BOSS, SngDrMarioMain);
			addToTypePlayList(GAME_OVER, SngMarioBrosGameOver);
			addToTypePlayList(HURRY, SngDrMarioSlow);	
			addToTypePlayList(STAR, SngDrMarioMain);
			addToTypePlayList(TITLE_SCREEN, SngOverworld);
			addToTypePlayList(WIN, SngMarioBrosWin);
			addToTypePlayList(WIN_CASTLE, SngMarioBrosGameOver);
			
			addToThemePlayList( TG_CASTLE_WATER, SngDrMarioSlow, [ LT_WATER ] );

		}
	}
}