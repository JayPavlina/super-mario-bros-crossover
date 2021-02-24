package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.MapPack;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameBlasterMaster extends Game
	{
		private static var instance:Game; 
		
		public function GameBlasterMaster(gameNum:int, skinSetNum:int)
		{
			super("Blaster Master", "Sunsoft", Consoles.nintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/nsf/BlasterMaster.nsf", mimeType="application/octet-stream")]
		public const Nsf:Class;
		[Embed(source="../../../../../assets/audio/seq/nsf/BlasterMasterSfx.nsf", mimeType="application/octet-stream")]
		public const NsfSfx:Class;
		private const VOLUME:int = 70;
		
		private const TG_AREA_1_1:ThemeGroup = addThemeGroup( 1, 1 );
		private const TG_AREA_1_4:ThemeGroup = addThemeGroup( 1, 2 );
		private const TG_AREA_1_2:ThemeGroup = addThemeGroup( 2, 1 );
		private const TG_AREA_1_3:ThemeGroup = addThemeGroup( 2, 2 );
		private const TG_AREA_2_2:ThemeGroup = addThemeGroup( 2, 3 );
		private const TG_AREA_2_2_B:ThemeGroup = addThemeGroup( 2, 4 );
		private const TG_AREA_2_1:ThemeGroup = addThemeGroup( 3, 1 );
		private const TG_AREA_2_3:ThemeGroup = addThemeGroup( 4, 1 );
		private const TG_AREA_2_4:ThemeGroup = addThemeGroup( 4, 2 );
		private const TG_AREA_3_1:ThemeGroup = addThemeGroup( 5, 1 );
		private const TG_AREA_3_2:ThemeGroup = addThemeGroup( 5, 2 );
		private const TG_AREA_3_4:ThemeGroup = addThemeGroup( 5, 3 );
		private const TG_AREA_3_3:ThemeGroup = addThemeGroup( 6, 1 );
		private const TG_AREA_4_1:ThemeGroup = addThemeGroup( 7, 1 );
		private const TG_AREA_4_2:ThemeGroup = addThemeGroup( 7, 2 );
		private const TG_AREA_4_3:ThemeGroup = addThemeGroup( 8, 1 );
		private const TG_AREA_4_4:ThemeGroup = addThemeGroup( 8, 2 );
		private const TG_AREA_7_1:ThemeGroup = addThemeGroup( 9, 1 );
		private const TG_AREA_7_2:ThemeGroup = addThemeGroup( 9, 2 );
		private const TG_AREA_7_3:ThemeGroup = addThemeGroup( 10, 1 );
		private const TG_AREA_7_4:ThemeGroup = addThemeGroup( 10, 2 );
		private const TG_AREA_6_1:ThemeGroup = addThemeGroup( 11, 1 );
		private const TG_AREA_6_2:ThemeGroup = addThemeGroup( 11, 2 );
		private const TG_AREA_6_3:ThemeGroup = addThemeGroup( 12, 1 );
		private const TG_AREA_6_4:ThemeGroup = addThemeGroup( 12, 2 );
		private const TG_AREA_5_1:ThemeGroup = addThemeGroup( 13, 1 );
		private const TG_AREA_5_2:ThemeGroup = addThemeGroup( 13, 2 );
		private const TG_AREA_5_3:ThemeGroup = addThemeGroup( 13, 3 );
		private const TG_AREA_5_4:ThemeGroup = addThemeGroup( 13, 4 );
		private const TG_AREA_8_4_WATER:ThemeGroup = addThemeGroup( 13, 5 );
		private const TG_AREA_8_1:ThemeGroup = addThemeGroup( 14, 1 );
		private const TG_AREA_8_2:ThemeGroup = addThemeGroup( 15, 1 );
		private const TG_AREA_8_3:ThemeGroup = addThemeGroup( 15, 2 );
		private const TG_AREA_8_4:ThemeGroup = addThemeGroup( 16, 1 );
		
		public const SngArea1OverworldNoIntro:Song = addSong( Nsf, 1, null, VOLUME );
		public const SngIntro:Song = addSong( Nsf, 2, null, VOLUME );
		public const SngArea1Overworld:Song = addSong( Nsf, 3, null, VOLUME );
		public const SngArea2UnderGround:Song = addSong( Nsf, 4, null, VOLUME );
		public const SngArea3Robots:Song = addSong( Nsf, 5, null, VOLUME );
		public const SngArea4Frog:Song = addSong( Nsf, 6, null, VOLUME );
		public const SngArea5Water:Song = addSong( Nsf, 7, null, VOLUME );
		public const SngArea6:Song = addSong( Nsf, 8, null, VOLUME );
		public const SngArea8Final:Song = addSong( Nsf, 9, null, VOLUME );
		public const SngBossAlarm:Song = addSong( Nsf, 10, null, VOLUME );
		public const SngBossEasy:Song = addSong( Nsf, 12, null, VOLUME );
		public const SngBossHard:Song = addSong( Nsf, 13, null, VOLUME );
		public const SngArea7:Song = addSong( Nsf, 14, null, VOLUME );
		public const SngVictory:Song = addSong( Nsf, 15, null, VOLUME );
		public const SngEnding:Song = addSong( Nsf, 16, null, VOLUME );
		public const SngGameOver:Song = addSong( Nsf, 17, null, VOLUME );
		
		override protected function setUpLevelThemes():void
		{
			addToThemeInfoGeneral( TG_AREA_1_1, LT_NORMAL, LT_INTRO );
			addToThemeInfoGeneral( TG_AREA_1_2, LT_UNDER_GROUND, LT_PIPE_BONUS );
			addToThemeInfoGeneral( TG_AREA_1_3, LT_COIN_HEAVEN, LT_PLATFORM, LT_CHEEP_CHEEP );
			addToThemeInfoGeneral( TG_AREA_1_4, LT_CASTLE );
			addToThemeInfoGeneral( TG_AREA_2_2, LT_WATER );
			
			addToThemeInfoWorld( 2, TG_AREA_2_1, LT_NORMAL, LT_INTRO );
			addToThemeInfoWorld( 2, TG_AREA_2_3, LT_CHEEP_CHEEP, LT_PIPE_BONUS, LT_UNDER_GROUND, LT_COIN_HEAVEN, LT_PLATFORM );
			addToThemeInfoWorld( 2, TG_AREA_2_4, LT_CASTLE );

			addToThemeInfoWorld( 3, TG_AREA_3_1, LT_NORMAL, LT_INTRO );
			addToThemeInfoWorld( 3, TG_AREA_3_2, LT_PLATFORM, LT_COIN_HEAVEN );
			addToThemeInfoWorld( 3, TG_AREA_3_3, LT_PIPE_BONUS, LT_UNDER_GROUND );
			addToThemeInfoWorld( 3, TG_AREA_3_4, LT_CASTLE );
			
			addToThemeInfoWorld( 4, TG_AREA_4_1, LT_NORMAL, LT_INTRO );
			addToThemeInfoWorld( 4, TG_AREA_4_2, LT_UNDER_GROUND, LT_PIPE_BONUS );
			addToThemeInfoWorld( 4, TG_AREA_4_3, LT_PLATFORM, LT_COIN_HEAVEN );
			addToThemeInfoWorld( 4, TG_AREA_4_4, LT_CASTLE );
			
			addToThemeInfoWorld( 5, TG_AREA_7_1, LT_NORMAL, LT_INTRO );
			addToThemeInfoWorld( 5, TG_AREA_7_2, LT_PIPE_BONUS, LT_UNDER_GROUND );
			addToThemeInfoWorld( 5, TG_AREA_7_3, LT_PLATFORM, LT_COIN_HEAVEN );
			addToThemeInfoWorld( 5, TG_AREA_7_4, LT_CASTLE );
			addToThemeInfoWorld( 5, TG_AREA_5_2, LT_WATER );
			
			addToThemeInfoWorld( 6, TG_AREA_6_1, LT_NORMAL, LT_INTRO );
			addToThemeInfoWorld( 6, TG_AREA_6_3, LT_PLATFORM, LT_PIPE_BONUS, LT_UNDER_GROUND );
			addToThemeInfoWorld( 6, TG_AREA_6_4, LT_CASTLE, LT_COIN_HEAVEN );
			addToThemeInfoWorld( 6, TG_AREA_5_2, LT_WATER );
			
			addToThemeInfoWorld( 7, TG_AREA_5_1, LT_NORMAL, LT_INTRO );
			addToThemeInfoWorld( 7, TG_AREA_5_2, LT_WATER );
			addToThemeInfoWorld( 7, TG_AREA_5_3, LT_CHEEP_CHEEP, LT_PIPE_BONUS, LT_UNDER_GROUND, LT_PLATFORM );
			addToThemeInfoWorld( 7, TG_AREA_5_4, LT_CASTLE );
			
			addToThemeInfoWorld( 8, TG_AREA_8_1, LT_NORMAL, LT_INTRO, LT_PLATFORM, LT_COIN_HEAVEN );
			addToThemeInfoWorld( 8, TG_AREA_8_3, LT_PIPE_BONUS, LT_UNDER_GROUND );
			addToThemeInfoWorld( 8, TG_AREA_8_4, LT_CASTLE );
			addToThemeInfoWorld( 8, TG_AREA_8_4_WATER, LT_WATER );

			addToThemeInfoGeneral( TG_AREA_1_3, "1-2c" );
			addToThemeInfoGeneral( TG_AREA_2_3, "2-2c" );
			addToThemeInfoGeneral( TG_AREA_3_3, "3-2a" );
			addToThemeInfoGeneral( TG_AREA_7_2, "5-2a" );
			addToThemeInfoGeneral( TG_AREA_6_2, "6-2a" );
			addToThemeInfoGeneral( TG_AREA_8_2, "8-2a" );
			addToThemeInfoGeneral( TG_AREA_8_3, "8-3a" );
			
			themeMapPack = MapPack.Special;
			
			addToThemeInfoGeneral( TG_AREA_2_3, "2-2d" );
			addToThemeInfoGeneral( TG_AREA_2_2_B, "3-1b" );
			addToThemeInfoGeneral( TG_AREA_3_2, "3-2a" );
			addToThemeInfoGeneral( TG_AREA_3_3, "3-2b" );
			addToThemeInfoGeneral( TG_AREA_4_3, "4-2c" );
			addToThemeInfoGeneral( TG_AREA_8_2, "8-2c", "8-3a", "8-3c" );
			addToThemeInfoGeneral( TG_AREA_8_3, "8-3b" );
			addToThemeInfoGeneral( TG_AREA_8_4_WATER, "8-2b" );
			
			themeMapPack = MapPack.LostLevels;
			
			addToThemeInfoGeneral( TG_AREA_1_3, "1-2d", "10-2c" );
			addToThemeInfoGeneral( TG_AREA_3_1, "3-2a", "11-1a", "11-2a" );
			addToThemeInfoGeneral( TG_AREA_2_2_B, "3-2b", "11-2b" );
			addToThemeInfoGeneral( TG_AREA_3_2, "3-3a", "11-1b", "11-2c", "11-3a", "11-4b" );
			addToThemeInfoGeneral( TG_AREA_3_4, "11-4a" );
			addToThemeInfoGeneral( TG_AREA_4_3, "4-2a" );
			addToThemeInfoGeneral( TG_AREA_5_2, "4-1b", "9-1b" );
			addToThemeInfoGeneral( TG_AREA_7_1, "5-2a", "12-1a" );
			addToThemeInfoGeneral( TG_AREA_7_2, "12-1b", "12-2a" );
			addToThemeInfoGeneral( TG_AREA_7_3, "5-2c", "12-1c", "12-3a" );
			addToThemeInfoGeneral( TG_AREA_7_4, "12-4a" );
			addToThemeInfoGeneral( TG_AREA_6_1, "6-2a" );
			addToThemeInfoGeneral( TG_AREA_6_3, "6-2c", "6-3a" );
			addToThemeInfoGeneral( TG_AREA_8_1, "13-1a", "13-2c" );
			addToThemeInfoGeneral( TG_AREA_8_2, "9-3a", "13-2a", "13-4b" );
			addToThemeInfoGeneral( TG_AREA_8_3, "8-2b", "8-3a", "9-3b", "13-1b", "13-2b", "13-3a", "13-4c" );
			addToThemeInfoGeneral( TG_AREA_8_4, "9-1a", "13-4a", "13-4d" );
			addToThemeInfoGeneral( TG_AREA_8_4_WATER, "9-2a", "9-4a" );
			
		}
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngArea4Frog);
			addToTypePlayList(LT_CHEEP_CHEEP, SngArea5Water);
			addToTypePlayList(LT_COIN_HEAVEN, SngArea3Robots);
			addToTypePlayList(LT_INTRO, SngArea8Final);
			addToTypePlayList(LT_NORMAL, SngArea1Overworld);
			addToTypePlayList(LT_PIPE_BONUS, SngArea2UnderGround);
			addToTypePlayList(LT_PLATFORM, SngArea3Robots);
			addToTypePlayList(LT_UNDER_GROUND, SngArea2UnderGround);
			addToTypePlayList(LT_WATER, SngArea5Water);
			addToTypePlayList(MT_DARK_EPIC, SngArea6);
			
			
			addToTypePlayList(BOSS, SngBossEasy);
			addToTypePlayList(CHAR_SEL, SngIntro);
			addToTypePlayList(CHOOSE_CHARACTER, SngArea1Overworld);
			addToTypePlayList(CREDITS, SngEnding);
			addToTypePlayList(DIE, null);
			addToTypePlayList(FINAL_BOSS, SngArea7);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, SngArea7);
			addToTypePlayList(STAR, SngBossHard);
			addToTypePlayList(TITLE_SCREEN, SngIntro);
			addToTypePlayList(WIN, SngVictory);
			addToTypePlayList(WIN_CASTLE, SngEnding);

			
			addToThemePlayList( TG_AREA_1_1, SngArea1Overworld, [ LT_CASTLE, LT_CHEEP_CHEEP, LT_COIN_HEAVEN, LT_NORMAL, LT_PLATFORM, LT_UNDER_GROUND, LT_WATER ] );
			addToThemePlayList( TG_AREA_1_1, SngArea1OverworldNoIntro, [ LT_PIPE_BONUS ] );
			addToThemePlayList( TG_AREA_1_2, SngArea1OverworldNoIntro, [ LT_CASTLE, LT_CHEEP_CHEEP, LT_COIN_HEAVEN, LT_NORMAL, LT_PIPE_BONUS, LT_PLATFORM, LT_UNDER_GROUND, LT_WATER ] );
			addToThemePlayList( TG_AREA_1_3, SngArea1OverworldNoIntro, [ LT_CASTLE, LT_CHEEP_CHEEP, LT_COIN_HEAVEN, LT_NORMAL, LT_PIPE_BONUS, LT_PLATFORM, LT_UNDER_GROUND, LT_WATER ] );
			addToThemePlayList( TG_AREA_1_4, SngArea1OverworldNoIntro, [ LT_CASTLE, LT_CHEEP_CHEEP, LT_COIN_HEAVEN, LT_NORMAL, LT_PIPE_BONUS, LT_PLATFORM, LT_UNDER_GROUND, LT_WATER ] );
			addToThemePlayList( TG_AREA_2_1, SngArea2UnderGround, [ LT_CASTLE, LT_CHEEP_CHEEP, LT_COIN_HEAVEN, LT_NORMAL, LT_PIPE_BONUS, LT_PLATFORM, LT_UNDER_GROUND, LT_WATER ] );
			addToThemePlayList( TG_AREA_2_2, SngArea2UnderGround, [ LT_CASTLE, LT_CHEEP_CHEEP, LT_COIN_HEAVEN, LT_NORMAL, LT_PIPE_BONUS, LT_PLATFORM, LT_UNDER_GROUND, LT_WATER ] );
			addToThemePlayList( TG_AREA_2_3, SngArea2UnderGround, [ LT_CASTLE, LT_CHEEP_CHEEP, LT_COIN_HEAVEN, LT_NORMAL, LT_PIPE_BONUS, LT_PLATFORM, LT_UNDER_GROUND, LT_WATER ] );
			addToThemePlayList( TG_AREA_2_4, SngArea2UnderGround, [ LT_CASTLE, LT_CHEEP_CHEEP, LT_COIN_HEAVEN, LT_NORMAL, LT_PIPE_BONUS, LT_PLATFORM, LT_UNDER_GROUND, LT_WATER ] );
			addToThemePlayList( TG_AREA_3_1, SngArea3Robots, [ LT_CASTLE, LT_CHEEP_CHEEP, LT_COIN_HEAVEN, LT_NORMAL, LT_PIPE_BONUS, LT_PLATFORM, LT_UNDER_GROUND, LT_WATER ] );
			addToThemePlayList( TG_AREA_3_2, SngArea3Robots, [ LT_CASTLE, LT_CHEEP_CHEEP, LT_COIN_HEAVEN, LT_NORMAL, LT_PIPE_BONUS, LT_PLATFORM, LT_UNDER_GROUND, LT_WATER ] );
			addToThemePlayList( TG_AREA_3_3, SngArea3Robots, [ LT_CASTLE, LT_CHEEP_CHEEP, LT_COIN_HEAVEN, LT_NORMAL, LT_PIPE_BONUS, LT_PLATFORM, LT_UNDER_GROUND, LT_WATER ] );
			addToThemePlayList( TG_AREA_3_4, SngArea3Robots, [ LT_CASTLE, LT_CHEEP_CHEEP, LT_COIN_HEAVEN, LT_NORMAL, LT_PIPE_BONUS, LT_PLATFORM, LT_UNDER_GROUND, LT_WATER ] );
			addToThemePlayList( TG_AREA_4_1, SngArea4Frog, [ LT_CASTLE, LT_CHEEP_CHEEP, LT_COIN_HEAVEN, LT_NORMAL, LT_PIPE_BONUS, LT_PLATFORM, LT_UNDER_GROUND, LT_WATER ] );
			addToThemePlayList( TG_AREA_4_2, SngArea4Frog, [ LT_CASTLE, LT_CHEEP_CHEEP, LT_COIN_HEAVEN, LT_NORMAL, LT_PIPE_BONUS, LT_PLATFORM, LT_UNDER_GROUND, LT_WATER ] );
			addToThemePlayList( TG_AREA_4_3, SngArea4Frog, [ LT_CASTLE, LT_CHEEP_CHEEP, LT_COIN_HEAVEN, LT_NORMAL, LT_PIPE_BONUS, LT_PLATFORM, LT_UNDER_GROUND, LT_WATER ] );
			addToThemePlayList( TG_AREA_4_4, SngArea4Frog, [ LT_CASTLE, LT_CHEEP_CHEEP, LT_COIN_HEAVEN, LT_NORMAL, LT_PIPE_BONUS, LT_PLATFORM, LT_UNDER_GROUND, LT_WATER ] );
			addToThemePlayList( TG_AREA_5_1, SngArea5Water, [ LT_CASTLE, LT_CHEEP_CHEEP, LT_COIN_HEAVEN, LT_NORMAL, LT_PIPE_BONUS, LT_PLATFORM, LT_UNDER_GROUND, LT_WATER ] );
			addToThemePlayList( TG_AREA_5_2, SngArea5Water, [ LT_CASTLE, LT_CHEEP_CHEEP, LT_COIN_HEAVEN, LT_NORMAL, LT_PIPE_BONUS, LT_PLATFORM, LT_UNDER_GROUND, LT_WATER ] );
			addToThemePlayList( TG_AREA_5_3, SngArea5Water, [ LT_CASTLE, LT_CHEEP_CHEEP, LT_COIN_HEAVEN, LT_NORMAL, LT_PIPE_BONUS, LT_PLATFORM, LT_UNDER_GROUND, LT_WATER ] );
			addToThemePlayList( TG_AREA_5_4, SngArea5Water, [ LT_CASTLE, LT_CHEEP_CHEEP, LT_COIN_HEAVEN, LT_NORMAL, LT_PIPE_BONUS, LT_PLATFORM, LT_UNDER_GROUND, LT_WATER ] );
			addToThemePlayList( TG_AREA_6_1, SngArea6, [ LT_CASTLE, LT_CHEEP_CHEEP, LT_COIN_HEAVEN, LT_NORMAL, LT_PIPE_BONUS, LT_PLATFORM, LT_UNDER_GROUND, LT_WATER ] );
			addToThemePlayList( TG_AREA_6_2, SngArea6, [ LT_CASTLE, LT_CHEEP_CHEEP, LT_COIN_HEAVEN, LT_NORMAL, LT_PIPE_BONUS, LT_PLATFORM, LT_UNDER_GROUND, LT_WATER ] );
			addToThemePlayList( TG_AREA_6_3, SngArea6, [ LT_CASTLE, LT_CHEEP_CHEEP, LT_COIN_HEAVEN, LT_NORMAL, LT_PIPE_BONUS, LT_PLATFORM, LT_UNDER_GROUND, LT_WATER ] );
			addToThemePlayList( TG_AREA_6_4, SngArea6, [ LT_CASTLE, LT_CHEEP_CHEEP, LT_COIN_HEAVEN, LT_NORMAL, LT_PIPE_BONUS, LT_PLATFORM, LT_UNDER_GROUND, LT_WATER ] );
			addToThemePlayList( TG_AREA_7_1, SngArea7, [ LT_CASTLE, LT_CHEEP_CHEEP, LT_COIN_HEAVEN, LT_NORMAL, LT_PIPE_BONUS, LT_PLATFORM, LT_UNDER_GROUND, LT_WATER ] );
			addToThemePlayList( TG_AREA_7_2, SngArea7, [ LT_CASTLE, LT_CHEEP_CHEEP, LT_COIN_HEAVEN, LT_NORMAL, LT_PIPE_BONUS, LT_PLATFORM, LT_UNDER_GROUND, LT_WATER ] );
			addToThemePlayList( TG_AREA_7_3, SngArea7, [ LT_CASTLE, LT_CHEEP_CHEEP, LT_COIN_HEAVEN, LT_NORMAL, LT_PIPE_BONUS, LT_PLATFORM, LT_UNDER_GROUND, LT_WATER ] );
			addToThemePlayList( TG_AREA_7_4, SngArea7, [ LT_CASTLE, LT_CHEEP_CHEEP, LT_COIN_HEAVEN, LT_NORMAL, LT_PIPE_BONUS, LT_PLATFORM, LT_UNDER_GROUND, LT_WATER ] );
			addToThemePlayList( TG_AREA_8_1, SngArea8Final, [ LT_CASTLE, LT_CHEEP_CHEEP, LT_COIN_HEAVEN, LT_NORMAL, LT_PIPE_BONUS, LT_PLATFORM, LT_UNDER_GROUND, LT_WATER ] );
			addToThemePlayList( TG_AREA_8_2, SngArea8Final, [ LT_CASTLE, LT_CHEEP_CHEEP, LT_COIN_HEAVEN, LT_NORMAL, LT_PIPE_BONUS, LT_PLATFORM, LT_UNDER_GROUND, LT_WATER ] );
			addToThemePlayList( TG_AREA_8_3, SngArea8Final, [ LT_CASTLE, LT_CHEEP_CHEEP, LT_COIN_HEAVEN, LT_NORMAL, LT_PIPE_BONUS, LT_PLATFORM, LT_UNDER_GROUND, LT_WATER ] );
			addToThemePlayList( TG_AREA_8_4, SngArea8Final, [ LT_CASTLE, LT_CHEEP_CHEEP, LT_COIN_HEAVEN, LT_NORMAL, LT_PIPE_BONUS, LT_PLATFORM, LT_UNDER_GROUND, LT_WATER ] );
			addToThemePlayList( TG_AREA_8_4_WATER, SngArea8Final, [ LT_CASTLE, LT_CHEEP_CHEEP, LT_COIN_HEAVEN, LT_NORMAL, LT_PIPE_BONUS, LT_PLATFORM, LT_UNDER_GROUND, LT_WATER ] );
		}
	}
}