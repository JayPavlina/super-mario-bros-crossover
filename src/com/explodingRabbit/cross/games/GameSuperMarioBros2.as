package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.MapPack;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameSuperMarioBros2 extends Game
	{
		private static var instance:Game; 
		
		public function GameSuperMarioBros2(gameNum:int, skinSetNum:int)
		{
			super("Super Mario Bros. 2", "Nintendo", Consoles.nintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/nsf/SuperMarioBros2.nsfe", mimeType="application/octet-stream")]
		public const Nsfe:Class;
		private const VOLUME:int = 50;
		
		public const SngTitleScreen:Song = addSong( Nsfe, 1, null, VOLUME );
		public const SngCharacterSelect:Song = addSong( Nsfe, 2, null, VOLUME );
		public const SngOverworld:Song = addSong( Nsfe, 3, null, VOLUME );
		public const SngUnderGround:Song = addSong( Nsfe, 4, null, VOLUME );
		public const SngInvincible:Song = addSong( Nsfe, 5, null, VOLUME );
		public const SngPotionLand:Song = addSong( Nsfe, 6, null, VOLUME );
		public const SngBoss:Song = addSong( Nsfe, 7, null, VOLUME );
		public const SngBonusGameStart:Song = addSong( Nsfe, 8, null, VOLUME );
		public const SngBonusGameWin:Song = addSong( Nsfe, 9, null, VOLUME );
		public const SngBonusGameLose:Song = addSong( Nsfe, 10, null, VOLUME );
		public const SngFightWart:Song = addSong( Nsfe, 11, null, VOLUME );
		public const SngBeatWorld:Song = addSong( Nsfe, 12, null, VOLUME );
		public const SngGameOver:Song = addSong( Nsfe, 13, null, VOLUME );
		public const SngEnding:Song = addSong( Nsfe, 14, null, VOLUME );
		
		private const TG_GRASS:ThemeGroup = addThemeGroup( 1, 1 );
		private const TG_GRASS_NIGHT:ThemeGroup = addThemeGroup( 1, 2, MT_DARK_EPIC );
		private const TG_SUB_SPACE: ThemeGroup = addThemeGroup( 1, 3 );
		private const TG_WATERFALL: ThemeGroup = addThemeGroup( 1, 4 );
		private const TG_CAVE:ThemeGroup = addThemeGroup( 2, 1 );
		private const TG_PLATFORM_NIGHT:ThemeGroup = addThemeGroup( 2, 2 );
		private const TG_CASTLE:ThemeGroup = addThemeGroup( 3, 1 );
		private const TG_CASTLE_SUB_SPACE:ThemeGroup = addThemeGroup( 3, 2 );
		private const TG_DESERT:ThemeGroup = addThemeGroup( 4, 1 );
		private const TG_DESERT_NIGHT:ThemeGroup = addThemeGroup( 5, 1 );
		private const TG_CASTLE_DESERT:ThemeGroup = addThemeGroup( 6, 1 );
		private const TG_ICE:ThemeGroup = addThemeGroup( 7, 1 );
		private const TG_CAVE_ICE:ThemeGroup = addThemeGroup( 8, 1 );
		private const TG_CASTLE_ICE:ThemeGroup = addThemeGroup( 9, 1 );
		private const TG_CASTLE_TREE:ThemeGroup = addThemeGroup( 10, 1 );
		private const TG_CASTLE_RED:ThemeGroup = addThemeGroup( 11, 1 );
		private const TG_SKY:ThemeGroup = addThemeGroup( 12, 1 );
		private const TG_CASTLE_SKY:ThemeGroup = addThemeGroup( 13, 1 );
		private const TG_CASTLE_SKY_WATER:ThemeGroup = addThemeGroup( 13, 2 );
		private const TG_BONUS:ThemeGroup = addThemeGroup( 14, 1 );
		private const TG_COIN_HEAVEN:ThemeGroup = addThemeGroup( 15, 1 );
		private const TG_COIN_HEAVEN_NIGHT:ThemeGroup = addThemeGroup( 15, 2 );
		private const TG_COIN_HEAVEN_SUB_SPACE:ThemeGroup = addThemeGroup( 15, 3 );
		private const TG_WATER:ThemeGroup = addThemeGroup( 16, 1 );
		private const TG_WATER_SUB_SPACE:ThemeGroup = addThemeGroup( 16, 2 );
		
		override protected function setUpLevelThemes():void
		{
			addToThemeInfoGeneral( TG_GRASS, LT_NORMAL, LT_INTRO, LT_CHEEP_CHEEP );
			addToThemeInfoGeneral( TG_WATERFALL, LT_PLATFORM );
			addToThemeInfoGeneral( TG_CAVE, LT_UNDER_GROUND );
			addToThemeInfoGeneral( TG_WATER, LT_WATER );
			addToThemeInfoGeneral( TG_CASTLE, LT_CASTLE );
			addToThemeInfoGeneral( TG_BONUS, LT_PIPE_BONUS );
			addToThemeInfoGeneral( TG_COIN_HEAVEN, LT_COIN_HEAVEN );
			
			addToThemeInfoWorld( 3, TG_DESERT, LT_NORMAL );
			addToThemeInfoWorld( 3, TG_DESERT_NIGHT, LT_PLATFORM );
			addToThemeInfoWorld( 3, TG_CASTLE_DESERT, LT_CASTLE );
			
			addToThemeInfoWorld( 4, TG_ICE, LT_NORMAL, LT_INTRO, LT_PLATFORM, LT_COIN_HEAVEN );
			addToThemeInfoWorld( 4, TG_CAVE_ICE, LT_UNDER_GROUND );
			addToThemeInfoWorld( 4, TG_CASTLE_ICE, LT_CASTLE );
			
			addToThemeInfoWorld( 5, TG_GRASS_NIGHT, LT_NORMAL, LT_INTRO );
			addToThemeInfoWorld( 5, TG_PLATFORM_NIGHT, LT_PLATFORM );
			addToThemeInfoWorld( 5, TG_CASTLE_TREE, LT_CASTLE );
			addToThemeInfoWorld( 5, TG_COIN_HEAVEN_NIGHT, LT_COIN_HEAVEN );
			
			addToThemeInfoWorld( 6, TG_DESERT, LT_NORMAL );
			addToThemeInfoWorld( 6, TG_DESERT_NIGHT, LT_PLATFORM );
			addToThemeInfoWorld( 6, TG_CASTLE_RED, LT_CASTLE );
			
			addToThemeInfoWorld( 7, TG_SUB_SPACE, LT_NORMAL, LT_INTRO, LT_CHEEP_CHEEP, LT_PLATFORM );
			addToThemeInfoWorld( 7, TG_WATER_SUB_SPACE,  LT_WATER );
			addToThemeInfoWorld( 7, TG_CASTLE_SUB_SPACE, LT_CASTLE );
			
			addToThemeInfoWorld( 8, TG_SKY, LT_NORMAL, LT_PLATFORM );
			addToThemeInfoWorld( 8, TG_CASTLE_SKY, LT_CASTLE );
			addToThemeInfoWorld( 8, TG_CASTLE_SKY_WATER, LT_WATER );
			
			themeMapPack = MapPack.Special;
			
			addToThemeInfoGeneral( TG_COIN_HEAVEN, "4-3b" );
			addToThemeInfoGeneral( TG_DESERT, "6-2d" );
			addToThemeInfoGeneral( TG_WATER, "8-2b" );
			
			themeMapPack = MapPack.LostLevels;
			
			addToThemeInfoWorld( 2, TG_DESERT, LT_NORMAL, LT_CHEEP_CHEEP );
			addToThemeInfoWorld( 2, TG_CASTLE_DESERT, LT_CASTLE );
			
			addToThemeInfoWorld( 3, TG_GRASS, LT_NORMAL );
			addToThemeInfoWorld( 3, TG_WATERFALL, LT_PLATFORM );
			addToThemeInfoWorld( 3, TG_CASTLE, LT_CASTLE );
			
			addToThemeInfoWorld( 6, TG_GRASS, LT_NORMAL );
			addToThemeInfoWorld( 6, TG_WATERFALL, LT_CHEEP_CHEEP );
			addToThemeInfoWorld( 6, TG_CASTLE, LT_CASTLE );
			
			addToThemeInfoWorld( 7, TG_DESERT, LT_NORMAL, LT_PLATFORM );
			addToThemeInfoWorld( 7, TG_CASTLE_RED, LT_CASTLE );
			
			addToThemeInfoWorld( 9, TG_SUB_SPACE, LT_NORMAL, LT_CASTLE );
			addToThemeInfoWorld( 9, TG_WATER_SUB_SPACE, LT_WATER );
			addToThemeInfoWorld( 9, TG_COIN_HEAVEN_SUB_SPACE, LT_COIN_HEAVEN );
			
			addToThemeInfoWorld( 10, TG_DESERT, LT_NORMAL, LT_INTRO, LT_PLATFORM)
			addToThemeInfoWorld( 10, TG_CASTLE_RED, LT_CASTLE );
			
			addToThemeInfoWorld( 12, TG_GRASS_NIGHT, LT_NORMAL );
			addToThemeInfoWorld( 12, TG_PLATFORM_NIGHT, LT_CHEEP_CHEEP, LT_PLATFORM );
			addToThemeInfoWorld( 12, TG_CASTLE_TREE, LT_CASTLE );
			
			addToThemeInfoWorld( 13, TG_SKY, LT_NORMAL );
			addToThemeInfoWorld( 13, TG_CASTLE_SKY, LT_CASTLE );
			
			addToThemeInfoGeneral( TG_WATER, "8-1b" );
			addToThemeInfoGeneral( TG_COIN_HEAVEN_NIGHT, "12-1c" );
			addToThemeInfoGeneral( TG_CASTLE_SKY, "13-4c" );
		}
		
		override protected function createPlayList():void
		{
			addToTypePlayList(LT_CASTLE, SngUnderGround);
			addToTypePlayList(LT_CHEEP_CHEEP, SngOverworld);
			addToTypePlayList(LT_COIN_HEAVEN, SngPotionLand);
			addToTypePlayList(LT_INTRO, SngPotionLand);
			addToTypePlayList(LT_NORMAL, SngOverworld);
			addToTypePlayList(LT_PIPE_BONUS, SngUnderGround);
			addToTypePlayList(LT_PLATFORM, SngOverworld);
			addToTypePlayList(LT_UNDER_GROUND, SngUnderGround);
			addToTypePlayList(LT_WATER, SngPotionLand);
			addToTypePlayList(MT_DARK_EPIC, SngOverworld);
			
			addToTypePlayList(BOSS, SngBoss);
			addToTypePlayList(CHAR_SEL, SngCharacterSelect);
			addToTypePlayList(CHOOSE_CHARACTER, SngBonusGameStart);
			addToTypePlayList(CREDITS, SngEnding);
			addToTypePlayList(DIE, SngBonusGameLose);
			addToTypePlayList(FINAL_BOSS, SngFightWart);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, SngBoss);
//			addToTypePlayList(LAKITU, null);
			addToTypePlayList(TITLE_SCREEN, SngOverworld);			
			addToTypePlayList(STAR, SngInvincible);
			addToTypePlayList(WIN, SngBonusGameWin);
			addToTypePlayList(WIN_CASTLE, SngBeatWorld);

			addToThemePlayList( TG_SUB_SPACE, SngPotionLand, [ LT_NORMAL ] );
			addToThemePlayList( TG_CASTLE_SUB_SPACE, SngPotionLand, [LT_CASTLE ] );
//			addToThemePlayList( TG_WATER_SUB_SPACE, SngPotionLand, [ LT_WATER ] );
			addToThemePlayList( TG_DESERT_NIGHT, SngUnderGround, [ LT_PLATFORM ] );
			addToThemePlayList( TG_CASTLE_SKY_WATER, SngUnderGround, [ LT_WATER ] );
		}
	}
}