package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.MapPack;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameZeldaAdventureOfLink extends Game
	{
		private static var instance:Game; 
		
		public function GameZeldaAdventureOfLink(gameNum:int, skinSetNum:int = -1)
		{
			super("Zelda II: The Adventure of Link", "Nintendo", Consoles.nintendo, gameNum, "Zelda II", skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		override public function initiate():void
		{
			super.initiate();	
			creditsGame = Games.zeldaAdventureOfLink;
		}
		private const TG_GRASS:ThemeGroup = addThemeGroup( 1, 1 );
		private const TG_GRASS_PILLARS:ThemeGroup = addThemeGroup( 1, 2 );
		private const TG_SWAMP:ThemeGroup = addThemeGroup( 1, 3 );
		private const TG_CAVE_DARK:ThemeGroup = addThemeGroup( 2, 1 ); 
		private const TG_CAVE_LIGHT:ThemeGroup = addThemeGroup( 2, 2 ); 
		private const TG_CAVE_LAVA:ThemeGroup = addThemeGroup( 2, 3, MT_DARK_EPIC ); 
		private const TG_SEA:ThemeGroup = addThemeGroup( 2, 4 ); 
		private const TG_SKY:ThemeGroup = addThemeGroup( 2, 5 );
		private const TG_SKY_NIGHT:ThemeGroup = addThemeGroup( 2, 6 ); 
		private const TG_WATER:ThemeGroup = addThemeGroup( 3, 1 );
		private const TG_WATER_NIGHT:ThemeGroup = addThemeGroup( 3, 2 );
		private const TG_FOREST_TREES:ThemeGroup = addThemeGroup( 4, 1, MT_DARK_EPIC ); 
		private const TG_FOREST_LEAVES:ThemeGroup = addThemeGroup( 5, 1, MT_DARK_EPIC ); 
		private const TG_DESERT_GREEN_CACTI:ThemeGroup = addThemeGroup( 6, 1 );
		private const TG_DESERT_BROWN_CACTI:ThemeGroup = addThemeGroup( 6, 2 );
		private const TG_PALACE_1:ThemeGroup = addThemeGroup( 7, 1 );  
		private const TG_PALACE_2:ThemeGroup = addThemeGroup( 8, 1 );  
		private const TG_PALACE_3:ThemeGroup = addThemeGroup( 9, 1 );  
		private const TG_PALACE_4:ThemeGroup = addThemeGroup( 10, 1 );  
		private const TG_PALACE_5:ThemeGroup = addThemeGroup( 11, 1 );
		private const TG_PALACE_6:ThemeGroup = addThemeGroup( 12, 1 );
		private const TG_PALACE_7:ThemeGroup = addThemeGroup( 13, 1 );
		private const TG_PALACE_8:ThemeGroup = addThemeGroup( 14, 1 );
		private const TG_PALACE_8_WATER:ThemeGroup = addThemeGroup( 15, 1 );
		
		[Embed(source="../../../../../assets/audio/seq/nsf/Zelda2.nsf", mimeType="application/octet-stream")]
		public const Nsf:Class;
		
		private const VOLUME:int = 60;
		
		public const SngTitle:Song = addSong( Nsf, 1, null, VOLUME );
		public const SngGrass:Song = addSong( Nsf, 2, null, VOLUME );
		public const SngAction1:Song = addSong( Nsf, 4, null, VOLUME );
		public const SngAction2:Song = addSong( Nsf, 5, null, VOLUME );
		public const SngEnterPipe:Song = addSong( Nsf, 6, null, VOLUME );
		public const SngWater:Song = addSong( Nsf, 10, null, VOLUME );
		public const SngPalace:Song = addSong( Nsf, 12, null, VOLUME );
		public const SngStar:Song = addSong( Nsf, 14, null, 80 );
		public const SngBoss:Song = addSong( Nsf, 15, null, VOLUME );
		public const SngLevelWin:Song = addSong( Nsf, 17, null, VOLUME );
		public const SngPalace8:Song = addSong( Nsf, 18, null, VOLUME );
		public const SngPalace8c:Song = addSong( Nsf, 19, null, VOLUME );
		public const SngCharacterSelect:Song = addSong( Nsf, 9, null, VOLUME + 20 );
		public const SngCredits:Song = addSong( Nsf, 21, null, VOLUME );
		public const SngPalaceWin:Song = addSong( Nsf, 22, null, VOLUME );
		public const SngBowser:Song = addSong( Nsf, 23, null, VOLUME );
		
		override protected function setUpLevelThemes():void
		{
			addToThemeInfoGeneral(TG_GRASS, LT_NORMAL, LT_INTRO);
			addToThemeInfoGeneral(TG_CAVE_DARK, LT_UNDER_GROUND);
			addToThemeInfoGeneral(TG_SEA, LT_PLATFORM, LT_CHEEP_CHEEP);
			addToThemeInfoGeneral(TG_PALACE_1, LT_CASTLE);
			addToThemeInfoGeneral(TG_SKY, LT_COIN_HEAVEN);
			addToThemeInfoGeneral(TG_WATER, LT_WATER);
			addToThemeInfoGeneral(TG_CAVE_LIGHT, LT_PIPE_BONUS);
			
			addToThemeInfoGeneral(TG_SEA, "1-2d", "2-2c", "4-2c", "4-2e", "7-2c");
			
			addToThemeInfoWorld( 2, TG_SWAMP, LT_NORMAL, LT_INTRO );
			addToThemeInfoWorld( 2, TG_PALACE_2, LT_CASTLE );
			
			addToThemeInfoWorld( 3, TG_FOREST_TREES, LT_NORMAL, LT_PLATFORM );
			addToThemeInfoWorld( 3, TG_SKY_NIGHT, LT_COIN_HEAVEN );
			addToThemeInfoWorld( 3, TG_WATER_NIGHT, LT_WATER );
			addToThemeInfoWorld( 3, TG_PALACE_3, LT_CASTLE );
			
			addToThemeInfoWorld( 4, TG_GRASS_PILLARS, LT_NORMAL, LT_INTRO );
			addToThemeInfoWorld( 4, TG_PALACE_4, LT_CASTLE );
			
			addToThemeInfoWorld( 5, TG_DESERT_GREEN_CACTI, LT_NORMAL );
			addToThemeInfoWorld( 5, TG_PALACE_5, LT_CASTLE );
			
			addToThemeInfoWorld( 6, TG_FOREST_LEAVES, LT_NORMAL, LT_PLATFORM );
			addToThemeInfoWorld( 6, TG_SKY_NIGHT, LT_COIN_HEAVEN );
			addToThemeInfoWorld( 6, TG_WATER_NIGHT, LT_WATER );
			addToThemeInfoWorld( 6, TG_PALACE_6, LT_CASTLE );
			
			addToThemeInfoWorld( 7, TG_DESERT_BROWN_CACTI, LT_NORMAL, LT_INTRO );
			addToThemeInfoWorld( 7, TG_PALACE_7, LT_CASTLE );
			
			addToThemeInfoWorld( 8, TG_CAVE_LAVA, LT_NORMAL );
			addToThemeInfoWorld( 8, TG_PALACE_8, LT_CASTLE );
			addToThemeInfoWorld( 8, TG_PALACE_8_WATER, LT_WATER );
			
			themeMapPack = MapPack.Special;
			
			addToThemeInfoGeneral(TG_GRASS_PILLARS, "4-2a");
			addToThemeInfoGeneral(TG_SWAMP, "3-2b" );
			addToThemeInfoGeneral(TG_CAVE_DARK, "2-2c");
			addToThemeInfoGeneral(TG_SEA, "1-2d", "2-2d", "2-4b");
			addToThemeInfoGeneral(TG_SKY, "4-1b");
			addToThemeInfoGeneral(TG_FOREST_LEAVES, "6-2d");
			addToThemeInfoGeneral(TG_CAVE_LAVA, "8-1a", "8-2a", "8-3b");
			addToThemeInfoGeneral(TG_WATER_NIGHT, "8-2b");
			
			themeMapPack = MapPack.LostLevels;
			
			addToThemeInfoWorld( 2, TG_FOREST_TREES, LT_NORMAL, LT_CHEEP_CHEEP );
			addToThemeInfoWorld( 2, TG_SKY_NIGHT, LT_COIN_HEAVEN );
			addToThemeInfoWorld( 2, TG_PALACE_2, LT_CASTLE );
			
			addToThemeInfoWorld( 3, TG_SWAMP, LT_NORMAL, LT_INTRO );
			addToThemeInfoWorld( 3, TG_WATER, LT_WATER );
			addToThemeInfoWorld( 3, TG_SKY, LT_COIN_HEAVEN );
			addToThemeInfoWorld( 3, TG_PALACE_3, LT_CASTLE );
			
			addToThemeInfoWorld( 4, TG_DESERT_GREEN_CACTI, LT_NORMAL );
			addToThemeInfoWorld( 4, TG_PALACE_4, LT_CASTLE );
			
			addToThemeInfoWorld( 5, TG_DESERT_BROWN_CACTI, LT_NORMAL, LT_INTRO );
			addToThemeInfoWorld( 5, TG_PALACE_5, LT_CASTLE );
			
			addToThemeInfoWorld( 6, TG_GRASS_PILLARS, LT_NORMAL, LT_INTRO );
			addToThemeInfoWorld( 6, TG_WATER, LT_WATER );
			addToThemeInfoWorld( 6, TG_PALACE_6, LT_CASTLE );
			
			addToThemeInfoWorld( 7, TG_FOREST_LEAVES, LT_NORMAL );
			addToThemeInfoWorld( 7, TG_PALACE_7, LT_CASTLE );
			
			addToThemeInfoWorld( 8, TG_CAVE_LAVA, LT_NORMAL );
			addToThemeInfoWorld( 8, TG_SKY, LT_PLATFORM, LT_COIN_HEAVEN );
			addToThemeInfoWorld( 8, TG_PALACE_8, LT_CASTLE );
			
			addToThemeInfoWorld( 10, TG_SWAMP, LT_NORMAL, LT_INTRO );
			addToThemeInfoWorld( 10, TG_PALACE_2, LT_CASTLE );
			
			addToThemeInfoWorld( 11, TG_FOREST_LEAVES, LT_NORMAL, LT_INTRO, LT_PLATFORM );
			addToThemeInfoWorld( 11, TG_PALACE_7, LT_CASTLE );
			
			addToThemeInfoWorld( 12, TG_DESERT_BROWN_CACTI, LT_NORMAL, LT_CHEEP_CHEEP, LT_PLATFORM );
			addToThemeInfoWorld( 12, TG_PALACE_6, LT_CASTLE );
			
			addToThemeInfoWorld( 13, TG_CAVE_LAVA, LT_NORMAL );
			addToThemeInfoWorld( 13, TG_PALACE_8, LT_CASTLE );
			
			addToThemeInfoGeneral( TG_SEA, "1-2d", "3-2c", "5-2c", "6-2c", "10-2c" );
			addToThemeInfoGeneral( TG_WATER, "8-1b" );
			addToThemeInfoGeneral( TG_GRASS_PILLARS, "9-3a" );
			addToThemeInfoGeneral( TG_SKY_NIGHT, "11-1b", "13-2c" );
			addToThemeInfoGeneral( TG_WATER_NIGHT, "9-4a", "B-2b" );
		}
		
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL, LT_PLATFORM);
			
			addToTypePlayList(LT_CASTLE, SngPalace);
			addToTypePlayList(LT_CHEEP_CHEEP, SngAction2);
			addToTypePlayList(LT_COIN_HEAVEN, SngWater);
			addToTypePlayList(LT_INTRO, SngEnterPipe);
			addToTypePlayList(LT_NORMAL, SngGrass);
			addToTypePlayList(LT_PIPE_BONUS, SngWater);
			addToTypePlayList(LT_PLATFORM, SngAction2);
			addToTypePlayList(LT_UNDER_GROUND, SngAction1);
			addToTypePlayList(LT_WATER, SngWater);
			addToTypePlayList(MT_DARK_EPIC, SngAction2);
			
			
			addToTypePlayList(BOSS, SngBoss);
			addToTypePlayList(CHAR_SEL, SngCharacterSelect);
			addToTypePlayList(CHOOSE_CHARACTER, SngEnterPipe);
			addToTypePlayList(CREDITS, SngCredits);
			addToTypePlayList(DIE, null);
			addToTypePlayList(FINAL_BOSS, SngBowser);
			addToTypePlayList(GAME_OVER, SngCharacterSelect);
			addToTypePlayList(HURRY, null);
			addToTypePlayList(STAR, SngBowser);
			addToTypePlayList(TITLE_SCREEN, SngTitle);
			addToTypePlayList(WIN, SngLevelWin);
			addToTypePlayList(WIN_CASTLE, SngPalaceWin);
			
			addToThemePlayList( TG_GRASS_PILLARS, SngAction2, [ LT_NORMAL ] );
			addToThemePlayList( TG_FOREST_TREES, SngAction1, [ LT_NORMAL, LT_PLATFORM ] );
			addToThemePlayList( TG_FOREST_LEAVES, SngAction2, [ LT_NORMAL, LT_PLATFORM ] );
			addToThemePlayList( TG_DESERT_GREEN_CACTI, SngAction1, [ LT_NORMAL ] );
			addToThemePlayList( TG_DESERT_BROWN_CACTI, SngAction2, [ LT_NORMAL ] );
			addToThemePlayList( TG_CAVE_LAVA, SngAction2, [ LT_NORMAL ] );
			addToThemePlayList( TG_PALACE_8, SngPalace8, [ LT_CASTLE ] );
			addToThemePlayList( TG_PALACE_8_WATER, SngPalace8c, [ LT_WATER ] );
			
		}
	}
}