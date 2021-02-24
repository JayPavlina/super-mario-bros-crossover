package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.MapPack;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameCastlevania extends Game
	{
		private static var instance:Game; 
		
		public function GameCastlevania(gameNum:int, skinSetNum:int)
		{
			super("Castlevania", "Konami", Consoles.nintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/nsf/Castlevania.nsf", mimeType="application/octet-stream")]
		public const Nsf:Class;
		private const VOLUME:int = 80;
		
		public const SngIntro:Song = addSong( Nsf, 1, null, VOLUME );
		public const SngVampireKiller:Song = addSong( Nsf, 2, null, VOLUME );
		public const SngArmory:Song = addSong( Nsf, 3, null, VOLUME );
		public const SngWickedChild:Song = addSong( Nsf, 4, null, VOLUME );
		public const SngOutOfTime:Song = addSong( Nsf, 5, null, VOLUME );
		public const SngPrison:Song = addSong( Nsf, 6, null, VOLUME );
		public const SngSwamp:Song = addSong( Nsf, 7, null, VOLUME );
		public const SngDraculasQuarters:Song = addSong( Nsf, 8, null, VOLUME );
		public const SngBoss:Song = addSong( Nsf, 9, null, VOLUME );
		public const SngBossFinal:Song = addSong( Nsf, 10, null, VOLUME );
		public const SngEnding:Song = addSong( Nsf, 11, null, VOLUME );
		public const SngVictory:Song = addSong( Nsf, 12, null, VOLUME );
		public const SngGameComplete:Song = addSong( Nsf, 13, null, VOLUME );
		public const SngDie:Song = addSong( Nsf, 14, null, VOLUME );
		public const SngGameOver:Song = addSong( Nsf, 15, null, VOLUME );
		public const SngChar:Song = addSong( Nsf, 54, null, VOLUME );
		
		private const TG_COURTYARD:ThemeGroup = addThemeGroup( 1, 1 );
		private const TG_ENTRYWAY:ThemeGroup = addThemeGroup( 2, 1 );
		private const TG_WATER: ThemeGroup = addThemeGroup( 2, 2 );
		private const TG_RED_PILLARS_1: ThemeGroup = addThemeGroup( 2, 3 );
		private const TG_RED_PILLARS_2:ThemeGroup = addThemeGroup( 2, 4 );
		private const TG_RED_PILLARS_3:ThemeGroup = addThemeGroup( 2, 5 );
		private const TG_BLUE_WALLS:ThemeGroup = addThemeGroup( 3, 1 );
		private const TG_CATACOMBS:ThemeGroup = addThemeGroup( 3, 2 );
		private const TG_CAVE:ThemeGroup = addThemeGroup( 4, 1 );
		private const TG_GARDEN:ThemeGroup = addThemeGroup( 5, 1 );
		private const TG_SEWER:ThemeGroup = addThemeGroup( 5, 2 );
		private const TG_BLUE_PILLARS:ThemeGroup = addThemeGroup( 5, 3 );
		private const TG_PRISON:ThemeGroup = addThemeGroup( 6, 1 );
		private const TG_GREAT_HALL:ThemeGroup = addThemeGroup( 6, 2 );
		private const TG_RUINS:ThemeGroup = addThemeGroup( 7, 1 );
		private const TG_FINAL:ThemeGroup = addThemeGroup( 8, 1 );
		
		override protected function setUpLevelThemes():void
		{
			addToThemeInfoGeneral( TG_COURTYARD, LT_NORMAL, LT_INTRO, LT_PLATFORM );
			addToThemeInfoGeneral( TG_WATER, LT_WATER );
			addToThemeInfoGeneral( TG_CAVE, LT_UNDER_GROUND, LT_PIPE_BONUS );
			addToThemeInfoGeneral( TG_ENTRYWAY, LT_CASTLE, LT_CHEEP_CHEEP );
			addToThemeInfoGeneral( TG_BLUE_WALLS, LT_COIN_HEAVEN );
						
			addToThemeInfoWorld( 2, TG_ENTRYWAY, LT_NORMAL, LT_INTRO );
			
			addToThemeInfoWorld( 3, TG_RED_PILLARS_1, LT_NORMAL, LT_INTRO );
						
			addToThemeInfoWorld( 4, TG_BLUE_WALLS, LT_NORMAL, LT_INTRO, LT_PLATFORM );
			addToThemeInfoWorld( 4, TG_CATACOMBS, LT_CASTLE );
			
			addToThemeInfoWorld( 5, TG_GARDEN, LT_NORMAL, LT_PLATFORM, LT_INTRO );
			addToThemeInfoWorld( 5, TG_BLUE_PILLARS, LT_CASTLE );
			
			addToThemeInfoWorld( 6, TG_SEWER, LT_NORMAL, LT_PLATFORM, LT_INTRO );
			addToThemeInfoWorld( 6, TG_GARDEN, LT_CHEEP_CHEEP, LT_COIN_HEAVEN );
			addToThemeInfoWorld( 6, TG_BLUE_PILLARS, LT_CASTLE );
			
			addToThemeInfoWorld( 7, TG_PRISON, LT_NORMAL, LT_INTRO, LT_CHEEP_CHEEP, LT_PLATFORM );
			addToThemeInfoWorld( 7, TG_GREAT_HALL, LT_CASTLE );
			
			addToThemeInfoWorld( 8, TG_RUINS, LT_NORMAL );
			addToThemeInfoWorld( 8, TG_FINAL, LT_CASTLE );
			
			addToThemeInfoGeneral( TG_RED_PILLARS_2, "3-3a" );
			addToThemeInfoGeneral( TG_RED_PILLARS_3, "3-4a" );
			
			themeMapPack = MapPack.Special;
			
			addToThemeInfoGeneral( TG_COURTYARD, "2-4b");
			addToThemeInfoGeneral( TG_RUINS, "8-1a", "8-2a" );
			
			themeMapPack = MapPack.LostLevels;
			
			addToThemeInfoWorld( 11, TG_ENTRYWAY, LT_NORMAL, LT_INTRO, LT_PLATFORM );
			
			addToThemeInfoWorld( 12, TG_SEWER, LT_NORMAL );
			addToThemeInfoWorld( 12, TG_GARDEN, LT_CHEEP_CHEEP, LT_PLATFORM );
			addToThemeInfoWorld( 12, TG_BLUE_PILLARS, LT_CASTLE );

			addToThemeInfoWorld( 13, TG_FINAL, LT_CASTLE );
			
			addToThemeInfoGeneral( TG_BLUE_WALLS, "8-2b", "8-3a", "10-3a" );
			addToThemeInfoGeneral( TG_RUINS, "9-3a", "13-3a", "13-4b" );
			addToThemeInfoGeneral( TG_PRISON, "13-1a" );
			addToThemeInfoGeneral( TG_GREAT_HALL, "13-2a" );
			
		}
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
				
			addToTypePlayList(LT_CASTLE, SngDraculasQuarters);
			addToTypePlayList(LT_CHEEP_CHEEP, SngOutOfTime);
			addToTypePlayList(LT_COIN_HEAVEN, SngArmory);
			addToTypePlayList(LT_INTRO, SngVampireKiller);
			addToTypePlayList(LT_NORMAL, SngVampireKiller);
			addToTypePlayList(LT_PIPE_BONUS, SngPrison);
			addToTypePlayList(LT_PLATFORM, SngOutOfTime);
			addToTypePlayList(LT_UNDER_GROUND, SngPrison);
			addToTypePlayList(LT_WATER, SngSwamp);
			addToTypePlayList(MT_DARK_EPIC, SngWickedChild);
			
			addToTypePlayList(BOSS, SngBoss);
			addToTypePlayList(CHAR_SEL, SngPrison);
			addToTypePlayList(CHOOSE_CHARACTER, SngIntro);
			addToTypePlayList(CREDITS, SngEnding);
			addToTypePlayList(DIE, SngDie);
			addToTypePlayList(FINAL_BOSS, SngBossFinal);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, SngBossFinal);
			addToTypePlayList(STAR, SngBoss);
			addToTypePlayList(TITLE_SCREEN, SngArmory);
			addToTypePlayList(WIN, SngVictory);
			addToTypePlayList(WIN_CASTLE, SngGameComplete);
			
		}
	}
}