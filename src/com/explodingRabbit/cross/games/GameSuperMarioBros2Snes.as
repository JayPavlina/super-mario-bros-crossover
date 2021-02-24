package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.MapPack;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameSuperMarioBros2Snes extends Game
	{
		private static var instance:Game; 
		
		public function GameSuperMarioBros2Snes(gameNum:int, skinSetNum:int)
		{
			super("Super Mario Bros. 2 SNES", "Nintendo", Consoles.superNintendo, gameNum, "SMB2 (SNES)", skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		override public function initiate():void
		{
			super.initiate();	
			creditsGame = Games.superMarioAllStars;
		}

		private const VOLUME:int = 80;
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros2Snes/Birdo.spc", mimeType="application/octet-stream")]
		private const BirdoData:Class;		public const SngBirdo:Song = addSong( BirdoData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros2Snes/Bonus Game.spc", mimeType="application/octet-stream")]
		private const BonusGameData:Class;		public const SngBonusGame:Song = addSong( BonusGameData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros2Snes/Ending.spc", mimeType="application/octet-stream")]
		private const EndingData:Class;		public const SngEnding:Song = addSong( EndingData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros2Snes/Game Over.spc", mimeType="application/octet-stream")]
		private const GameOverData:Class;		public const SngGameOver:Song = addSong( GameOverData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros2Snes/Overworld.spc", mimeType="application/octet-stream")]
		private const OverworldData:Class;		public const SngOverworld:Song = addSong( OverworldData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros2Snes/Player Down.spc", mimeType="application/octet-stream")]
		private const PlayerDownData:Class;		public const SngPlayerDown:Song = addSong( PlayerDownData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros2Snes/Player Select.spc", mimeType="application/octet-stream")]
		private const PlayerSelectData:Class;		public const SngPlayerSelect:Song = addSong( PlayerSelectData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros2Snes/Power Up Fanfare.spc", mimeType="application/octet-stream")]
		private const PowerUpFanfareData:Class;		public const SngPowerUpFanfare:Song = addSong( PowerUpFanfareData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros2Snes/Subspace.spc", mimeType="application/octet-stream")]
		private const SubspaceData:Class;		public const SngSubspace:Song = addSong( SubspaceData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros2Snes/Title.spc", mimeType="application/octet-stream")]
		private const TitleData:Class;		public const SngTitle:Song = addSong( TitleData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros2Snes/Underworld.spc", mimeType="application/octet-stream")]
		private const UnderworldData:Class;		public const SngUnderworld:Song = addSong( UnderworldData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros2Snes/Victory.spc", mimeType="application/octet-stream")]
		private const VictoryData:Class;		public const SngVictory:Song = addSong( VictoryData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros2Snes/Wart.spc", mimeType="application/octet-stream")]
		private const WartData:Class;		public const SngWart:Song = addSong( WartData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros2Snes/World Clear.spc", mimeType="application/octet-stream")]
		private const WorldClearData:Class;		public const SngWorldClear:Song = addSong( WorldClearData, -1, null, VOLUME );
		
		private const TG_GRASS:ThemeGroup = addThemeGroup( 1, 1 );
		private const TG_PLATFORM:ThemeGroup = addThemeGroup( 1, 2 );
		private const TG_WATERFALL: ThemeGroup = addThemeGroup( 1, 3 );
		private const TG_NIGHT: ThemeGroup = addThemeGroup( 1, 4, MT_DARK_EPIC );
		private const TG_SUB_SPACE:ThemeGroup = addThemeGroup( 1, 5 );
		private const TG_SUB_SPACE_CHEEP_CHEEP:ThemeGroup = addThemeGroup( 1, 6 );

		private const TG_CAVE:ThemeGroup = addThemeGroup( 2, 1 );
		private const TG_PLATFORM_NIGHT:ThemeGroup = addThemeGroup( 2, 2, MT_DARK_EPIC );
		private const TG_WATER:ThemeGroup = addThemeGroup( 2, 3 );
		private const TG_SUB_SPACE_WATER:ThemeGroup = addThemeGroup( 2, 4 );

		private const TG_CASTLE_RED:ThemeGroup = addThemeGroup( 3, 1 );
		private const TG_SUB_SPACE_CASTLE:ThemeGroup = addThemeGroup( 3, 2 );
		
		private const TG_DESERT:ThemeGroup = addThemeGroup( 4, 1 );
		private const TG_DESERT_DAY:ThemeGroup = addThemeGroup( 4, 2 );
		
		private const TG_CAVE_DESERT:ThemeGroup = addThemeGroup( 5, 1 );
		private const TG_CASTLE_DESERT:ThemeGroup = addThemeGroup( 6, 1 );
		
		private const TG_ICE:ThemeGroup = addThemeGroup( 7, 1 );
		private const TG_ICE_HILLS:ThemeGroup = addThemeGroup( 7, 2 );
		
		private const TG_CAVE_ICE:ThemeGroup = addThemeGroup( 8, 1 );
		private const TG_CASTLE_ICE:ThemeGroup = addThemeGroup( 9, 1 );
		private const TG_CASTLE_TREE:ThemeGroup = addThemeGroup( 10, 1 );
		private const TG_CASTLE_DESERT_2:ThemeGroup = addThemeGroup( 11, 1 );
		private const TG_SKY:ThemeGroup = addThemeGroup( 12, 1 );
		
		private const TG_CASTLE_SKY:ThemeGroup = addThemeGroup( 13, 1 );
		private const TG_CASTLE_WATER:ThemeGroup = addThemeGroup( 13, 2 );
		
		private const TG_BONUS_CAVE:ThemeGroup = addThemeGroup( 14, 1 );
		private const TG_BONUS_DESERT:ThemeGroup = addThemeGroup( 14, 2 );
		private const TG_BONUS_ICE:ThemeGroup = addThemeGroup( 14, 3 );
		private const TG_BONUS_SUB_SPACE:ThemeGroup = addThemeGroup( 14, 4 );
		private const TG_BONUS_SKY:ThemeGroup = addThemeGroup( 14, 5 );
		
		private const TG_COIN_HEAVEN:ThemeGroup = addThemeGroup( 15, 1 );
		private const TG_COIN_HEAVEN_NIGHT:ThemeGroup = addThemeGroup( 15, 2 );
		private const TG_COIN_HEAVEN_SUB_SPACE:ThemeGroup = addThemeGroup( 15, 3 );
		
		override protected function setUpLevelThemes():void
		{
			addToThemeInfoGeneral( TG_GRASS, LT_NORMAL, LT_INTRO );
			addToThemeInfoGeneral( TG_PLATFORM, LT_PLATFORM );
			addToThemeInfoGeneral( TG_WATERFALL, LT_CHEEP_CHEEP );
			addToThemeInfoGeneral( TG_CAVE, LT_UNDER_GROUND );
			addToThemeInfoGeneral( TG_WATER, LT_WATER );
			addToThemeInfoGeneral( TG_CASTLE_RED, LT_CASTLE );
			addToThemeInfoGeneral( TG_BONUS_CAVE, LT_PIPE_BONUS );
			addToThemeInfoGeneral( TG_COIN_HEAVEN, LT_COIN_HEAVEN );
			
			addToThemeInfoWorld( 3, TG_DESERT, LT_NORMAL );
			addToThemeInfoWorld( 3, TG_CAVE_DESERT, LT_PLATFORM );
			addToThemeInfoWorld( 3, TG_CASTLE_DESERT, LT_CASTLE );
			addToThemeInfoWorld( 3, TG_COIN_HEAVEN_NIGHT, LT_COIN_HEAVEN );
			addToThemeInfoWorld( 3, TG_BONUS_DESERT, LT_PIPE_BONUS );
			
			addToThemeInfoWorld( 4, TG_ICE_HILLS, LT_NORMAL, LT_INTRO );
			addToThemeInfoWorld( 4, TG_ICE, LT_PLATFORM, LT_COIN_HEAVEN );
			addToThemeInfoWorld( 4, TG_CAVE_ICE, LT_UNDER_GROUND );
			addToThemeInfoWorld( 4, TG_CASTLE_ICE, LT_CASTLE );
			addToThemeInfoWorld( 4, TG_BONUS_ICE, LT_PIPE_BONUS );
			
			addToThemeInfoWorld( 5, TG_NIGHT, LT_NORMAL, LT_INTRO );
			addToThemeInfoWorld( 5, TG_PLATFORM_NIGHT, LT_PLATFORM );
			addToThemeInfoWorld( 5, TG_CASTLE_TREE, LT_CASTLE );
			addToThemeInfoWorld( 5, TG_COIN_HEAVEN_NIGHT, LT_COIN_HEAVEN );
			
			addToThemeInfoWorld( 6, TG_DESERT, LT_NORMAL );
			addToThemeInfoWorld( 6, TG_DESERT_DAY, LT_PLATFORM );
			addToThemeInfoWorld( 6, TG_CASTLE_DESERT_2, LT_CASTLE );
			addToThemeInfoWorld( 6, TG_BONUS_DESERT, LT_PIPE_BONUS );
			
			addToThemeInfoWorld( 7, TG_SUB_SPACE, LT_NORMAL, LT_INTRO );
			addToThemeInfoWorld( 7, TG_SUB_SPACE_CHEEP_CHEEP, LT_CHEEP_CHEEP );
			addToThemeInfoWorld( 7, TG_SUB_SPACE_WATER,  LT_WATER );
			addToThemeInfoWorld( 7, TG_SUB_SPACE_CASTLE, LT_CASTLE );
			addToThemeInfoWorld( 7, TG_BONUS_SUB_SPACE, LT_PIPE_BONUS );
			
			addToThemeInfoWorld( 8, TG_SKY, LT_NORMAL, LT_PLATFORM );
			addToThemeInfoWorld( 8, TG_CASTLE_SKY, LT_CASTLE );
			addToThemeInfoWorld( 8, TG_CASTLE_WATER, LT_WATER );
			addToThemeInfoWorld( 8, TG_BONUS_SKY, LT_PIPE_BONUS );
			
			addToThemeInfoGeneral( TG_DESERT_DAY, "3-2a", "6-2a" );
			
			themeMapPack = MapPack.Special;
			
			addToThemeInfoGeneral( TG_COIN_HEAVEN, "4-3b" );
			addToThemeInfoGeneral( TG_DESERT_DAY, "6-2d" );
			addToThemeInfoGeneral( TG_WATER, "8-2b" );
			
			themeMapPack = MapPack.LostLevels;
			
			addToThemeInfoWorld( 2, TG_DESERT, LT_NORMAL );
			addToThemeInfoWorld( 2, TG_DESERT_DAY, LT_CHEEP_CHEEP );
			addToThemeInfoWorld( 2, TG_CASTLE_DESERT, LT_CASTLE );
			addToThemeInfoWorld( 2, TG_BONUS_DESERT, LT_PIPE_BONUS );
			addToThemeInfoWorld( 2, TG_COIN_HEAVEN_NIGHT, LT_COIN_HEAVEN );
			
			addToThemeInfoWorld( 3, TG_GRASS, LT_NORMAL, LT_INTRO );
			addToThemeInfoWorld( 3, TG_PLATFORM, LT_PLATFORM );
			addToThemeInfoWorld( 3, TG_CASTLE_RED, LT_CASTLE );
			addToThemeInfoWorld( 3, TG_BONUS_CAVE, LT_PIPE_BONUS );
			
			addToThemeInfoWorld( 6, TG_GRASS, LT_NORMAL, LT_INTRO );
			addToThemeInfoWorld( 6, TG_WATERFALL, LT_CHEEP_CHEEP );
			addToThemeInfoWorld( 6, TG_CASTLE_RED, LT_CASTLE );
			
			addToThemeInfoWorld( 7, TG_DESERT_DAY, LT_NORMAL );
			addToThemeInfoWorld( 7, TG_DESERT, LT_PLATFORM );
			addToThemeInfoWorld( 7, TG_CASTLE_DESERT_2, LT_CASTLE );
			addToThemeInfoWorld( 7, TG_BONUS_DESERT, LT_PIPE_BONUS );
			
			addToThemeInfoWorld( 9, TG_SUB_SPACE, LT_NORMAL );
			addToThemeInfoWorld( 9, TG_SUB_SPACE_CASTLE, LT_CASTLE );
			addToThemeInfoWorld( 9, TG_SUB_SPACE_WATER, LT_WATER );
			addToThemeInfoWorld( 9, TG_COIN_HEAVEN_SUB_SPACE, LT_COIN_HEAVEN );
			
			addToThemeInfoWorld( 10, TG_DESERT, LT_NORMAL, LT_INTRO );
			addToThemeInfoWorld( 10, TG_DESERT_DAY, LT_PLATFORM );
			addToThemeInfoWorld( 10, TG_CASTLE_DESERT_2, LT_CASTLE );
			addToThemeInfoWorld( 10, TG_BONUS_DESERT, LT_PIPE_BONUS );
			addToThemeInfoWorld( 10, TG_COIN_HEAVEN_NIGHT, LT_COIN_HEAVEN );
			
			addToThemeInfoWorld( 12, TG_NIGHT, LT_NORMAL );
			addToThemeInfoWorld( 12, TG_PLATFORM_NIGHT, LT_CHEEP_CHEEP, LT_PLATFORM );
			addToThemeInfoWorld( 12, TG_CASTLE_TREE, LT_CASTLE );
			addToThemeInfoWorld( 12, TG_COIN_HEAVEN_NIGHT, LT_COIN_HEAVEN );
			
			addToThemeInfoWorld( 13, TG_SKY, LT_NORMAL );
			addToThemeInfoWorld( 13, TG_BONUS_SKY, LT_PIPE_BONUS );
			addToThemeInfoWorld( 13, TG_CASTLE_SKY, LT_CASTLE );
			
			addToThemeInfoGeneral( TG_PLATFORM, "1-2d", "3-2c", "11-2c" );
			addToThemeInfoGeneral( TG_DESERT_DAY, "2-2a", "10-2c" );
			addToThemeInfoGeneral( TG_PLATFORM_NIGHT, "5-2d", "7-2a" );
			addToThemeInfoGeneral( TG_WATERFALL, "6-2c" );
			addToThemeInfoGeneral( TG_WATER, "8-1b" );
			addToThemeInfoGeneral( TG_CAVE, "8-1c" );
			addToThemeInfoGeneral( TG_CASTLE_SKY, "13-4c" );
		}
		
		override protected function createPlayList():void
		{
			addToTypePlayList(LT_CASTLE, SngUnderworld);
			addToTypePlayList(LT_CHEEP_CHEEP, SngOverworld);
			addToTypePlayList(LT_COIN_HEAVEN, SngSubspace);
			addToTypePlayList(LT_INTRO, SngBonusGame);
			addToTypePlayList(LT_NORMAL, SngOverworld);
			addToTypePlayList(LT_PIPE_BONUS, SngUnderworld);
			addToTypePlayList(LT_PLATFORM, SngOverworld);
			addToTypePlayList(LT_UNDER_GROUND, SngUnderworld);
			addToTypePlayList(LT_WATER, SngSubspace);
			addToTypePlayList(MT_DARK_EPIC, SngOverworld);
			
			addToTypePlayList(BOSS, SngBirdo);
			addToTypePlayList(CHAR_SEL, SngPlayerSelect);
			addToTypePlayList(CHOOSE_CHARACTER, SngPowerUpFanfare);
			addToTypePlayList(CREDITS, SngEnding);
			addToTypePlayList(DIE, SngPlayerDown);
			addToTypePlayList(FINAL_BOSS, SngWart);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, SngBirdo);
			addToTypePlayList(TITLE_SCREEN, SngOverworld);			
			addToTypePlayList(STAR, Games.superMarioBrosSnes.SngInvincible);
			addToTypePlayList(WIN, SngVictory);
			addToTypePlayList(WIN_CASTLE, SngWorldClear);
			
			addToThemePlayList( TG_CASTLE_WATER, SngUnderworld, [ LT_WATER ] );
		}
	}
}