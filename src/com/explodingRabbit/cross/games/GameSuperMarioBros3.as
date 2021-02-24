package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.MapPack;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;

	public class GameSuperMarioBros3 extends Game
	{
		private static var instance:Game; 
	
		public function GameSuperMarioBros3(gameNum:int, skinSetNum:int)
		{
			super("Super Mario Bros. 3", "Nintendo", Consoles.nintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/nsf/SuperMarioBros3.nsf", mimeType="application/octet-stream")]
		public const Nsf:Class;
		[Embed(source="../../../../../assets/audio/seq/nsf/SuperMarioBros3.nsfe", mimeType="application/octet-stream")]
		public const Nsfe:Class;
		private const VOLUME:int = 55;
		
		private const TG_OVERWORLD:ThemeGroup = addThemeGroup( 1, 1 );
		private const TG_OVERWORLD_NIGHT:ThemeGroup = addThemeGroup( 1, 2, MT_DARK_EPIC );
		private const TG_ICE:ThemeGroup = addThemeGroup( 2, 1 );
		private const TG_UNDERGROUND:ThemeGroup = addThemeGroup( 3, 1 );
		private const TG_UNDERGROUND_ICE:ThemeGroup = addThemeGroup( 3, 2 );
		private const TG_WATER_SWIMMING:ThemeGroup = addThemeGroup( 4, 1 );
		private const TG_WATER_SWIMMING_ICE:ThemeGroup = addThemeGroup( 4, 2 );
		private const TG_WATER_SWIMMING_MUD:ThemeGroup = addThemeGroup( 4, 3 );
		private const TG_WATER_OVERWORLD:ThemeGroup = addThemeGroup( 5, 1 ); 
		private const TG_BONUS:ThemeGroup = addThemeGroup( 5, 2 ); 
		private const TG_CASTLE_NORMAL:ThemeGroup = addThemeGroup( 5, 3 ); 
		private const TG_CASTLE_WATER:ThemeGroup = addThemeGroup( 5, 4 ); 
		private const TG_CASTLE_PIPE:ThemeGroup = addThemeGroup( 5, 5 ); 
		private const TG_CASTLE_CLOUD:ThemeGroup = addThemeGroup( 5, 6 );  
		private const TG_CASTLE_DARK:ThemeGroup = addThemeGroup( 5, 7 );
		private const TG_BONUS_BLUE:ThemeGroup = addThemeGroup( 5, 8 );
		private const TG_BONUS_ICE:ThemeGroup = addThemeGroup( 5, 9 );
		private const TG_BONUS_PIPE:ThemeGroup = addThemeGroup( 5, 10 );
		private const TG_PIPES:ThemeGroup = addThemeGroup( 6, 1, MT_DARK_EPIC );
		private const TG_CLOUDS:ThemeGroup = addThemeGroup( 7, 1 ); 
		private const TG_DESERT_BLUE_SKY:ThemeGroup = addThemeGroup( 8, 1 );
		private const TG_DESERT_PINK_SKY:ThemeGroup = addThemeGroup( 8, 2 );
		private const TG_AIRSHIP:ThemeGroup = addThemeGroup( 9, 1, MT_DARK_EPIC ); 
		private const TG_GRASS:ThemeGroup = addThemeGroup( 10, 1 ); 
		private const TG_GRASS_NIGHT:ThemeGroup = addThemeGroup( 10, 2, MT_DARK_EPIC );
		private const TG_GRASS_DESERT:ThemeGroup = addThemeGroup( 10, 3 );
		private const TG_BOWSER_CASTLE:ThemeGroup = addThemeGroup( 11, 1 ); 
		private const TG_BOWSER_CASTLE_WATER:ThemeGroup = addThemeGroup( 11, 2 );
		private const TG_AIRSHIP_INNER:ThemeGroup = addThemeGroup( 12, 1, MT_DARK_EPIC );
		private const TG_CASTLE_ICE:ThemeGroup = addThemeGroup( 13, 1 );
		private const TG_CASTLE_DESERT:ThemeGroup = addThemeGroup( 14, 1 );
		private const TG_BONUS_DESERT:ThemeGroup = addThemeGroup( 15, 1 );
		
		public const SngGrassLand:Song = addSong( Nsfe, 1, null, VOLUME );
		public const SngDesertLand:Song = addSong( Nsfe, 2, null, VOLUME );
		public const SngWaterWorld:Song = addSong( Nsfe, 3, null, VOLUME );
		public const SngGiantsWorld:Song = addSong( Nsfe, 4, null, VOLUME );
		public const SngCloudWorld:Song = addSong( Nsfe, 5, null, VOLUME );
		public const SngIceWorld:Song = addSong( Nsfe, 6, null, VOLUME );
		public const SngPipeWorld:Song = addSong( Nsfe, 7, null, VOLUME );
		public const SngDarkWorld:Song = addSong( Nsfe, 8, null, VOLUME );
		public const SngOverWorld:Song = addSong( Nsfe, 9, null, VOLUME );
		public const SngAthletic:Song = addSong( Nsfe, 10, null, VOLUME );
		public const SngSwimming:Song = addSong( Nsfe, 11, null, VOLUME );
		public const SngUnderground:Song = addSong( Nsfe, 12, null, VOLUME );
		public const SngUpAbove:Song = addSong( Nsfe, 13, null, VOLUME );
		public const SngInvincible:Song = addSong( Nsfe, 14, null, VOLUME );
		public const SngWarpWhistle:Song = addSong( Nsfe, 15, null, VOLUME );
		public const SngMusicBox:Song = addSong( Nsfe, 16, null, VOLUME );
		public const SngCardGame:Song = addSong( Nsfe, 17, null, VOLUME );
		public const SngChestGame:Song = addSong( Nsfe, 18, null, VOLUME );
		public const SngHammerBros:Song = addSong( Nsfe, 19, null, VOLUME );
		public const SngSaveTheKing:Song = addSong( Nsfe, 20, null, VOLUME );
		public const SngAirship:Song = addSong( Nsfe, 21, null, VOLUME );
		public const SngBossFight:Song = addSong( Nsfe, 22, null, VOLUME );
		public const SngCastle:Song = addSong( Nsfe, 23, null, VOLUME );
		public const SngBowserBattle:Song = addSong( Nsfe,24, null, VOLUME );
		public const SngSaveThePrincess:Song = addSong( Nsfe,25, null, VOLUME );
		public const SngOverWorldHurry:Song = addSong( Nsfe, 27, null, VOLUME );
		public const SngAthleticHurry:Song = addSong( Nsfe, 28, null, VOLUME );
		public const SngSwimmingHurry:Song = addSong( Nsfe, 29, null, VOLUME );
		public const SngUnderGroundHurry:Song = addSong( Nsfe, 30, null, VOLUME );
		public const SngInvincibleHurry:Song = addSong( Nsfe, 31, null, VOLUME );
		public const SngChestGameHurry:Song = addSong( Nsfe, 32, null, VOLUME );
		public const SngHammerBrosHurry:Song = addSong( Nsfe, 33, null, VOLUME );
		public const SngAirshipHurry:Song = addSong( Nsfe, 34, null, VOLUME );
		public const SngBossHurry:Song = addSong( Nsfe, 35, null, VOLUME );
		public const SngCastleHurry:Song = addSong( Nsfe, 36, null, VOLUME );
		public const SngBowserBattleHurry:Song = addSong( Nsfe, 37, null, VOLUME );
		public const SngBeatLevel:Song = addSong( Nsfe, 38, null, VOLUME );
		public const SngBeatAirship:Song = addSong( Nsfe, 40, null, VOLUME );
		public const SngBeatBoomBoom:Song = addSong( Nsfe, 41, null, VOLUME );
		public const SngGameOver:Song = addSong( Nsfe, 42, null, VOLUME );
		public const SngDie:Song = addSong( Nsfe, 43, null, VOLUME );
		
		override protected function setUpLevelThemes():void
		{
			addToThemeInfoGeneral( TG_OVERWORLD, LT_NORMAL, LT_INTRO, LT_CHEEP_CHEEP );
			addToThemeInfoGeneral( TG_GRASS, LT_PLATFORM );
			addToThemeInfoGeneral( TG_UNDERGROUND, LT_UNDER_GROUND );
			addToThemeInfoGeneral( TG_BONUS_BLUE, LT_PIPE_BONUS );
			addToThemeInfoGeneral( TG_CLOUDS, LT_COIN_HEAVEN );
			addToThemeInfoGeneral( TG_CASTLE_NORMAL, LT_CASTLE );
			addToThemeInfoGeneral( TG_WATER_SWIMMING, LT_WATER );
			
			addToThemeInfoWorld( 2, TG_WATER_OVERWORLD, LT_NORMAL, LT_INTRO, LT_CHEEP_CHEEP );
			addToThemeInfoWorld( 2, TG_CASTLE_WATER, LT_CASTLE );
			addToThemeInfoWorld( 2, TG_BONUS, LT_PIPE_BONUS );

			addToThemeInfoWorld( 3, TG_DESERT_BLUE_SKY, LT_NORMAL, LT_INTRO );
			addToThemeInfoWorld( 3, TG_DESERT_PINK_SKY, LT_PLATFORM );
			addToThemeInfoWorld( 3, TG_CASTLE_DESERT, LT_CASTLE );
			addToThemeInfoWorld( 3, TG_BONUS_DESERT, LT_PIPE_BONUS );
			
			addToThemeInfoWorld( 4, TG_ICE, LT_NORMAL, LT_INTRO, LT_PLATFORM );
			addToThemeInfoWorld( 4, TG_UNDERGROUND_ICE, LT_UNDER_GROUND );
			addToThemeInfoWorld( 4, TG_CASTLE_ICE, LT_CASTLE );
			addToThemeInfoWorld( 4, TG_BONUS_ICE, LT_PIPE_BONUS );
			
			addToThemeInfoWorld( 5, TG_OVERWORLD_NIGHT, LT_NORMAL, LT_INTRO, LT_PLATFORM );
			addToThemeInfoWorld( 5, TG_CASTLE_DARK, LT_CASTLE );
			addToThemeInfoWorld( 5, TG_BONUS, LT_PIPE_BONUS );

			addToThemeInfoWorld( 6, TG_PIPES, LT_NORMAL, LT_INTRO, LT_PLATFORM, LT_CHEEP_CHEEP );
			addToThemeInfoWorld( 6, TG_CASTLE_PIPE, LT_CASTLE );
			addToThemeInfoWorld( 6, TG_BONUS_PIPE, LT_PIPE_BONUS );

			addToThemeInfoWorld( 7, TG_CLOUDS, LT_NORMAL, LT_INTRO, LT_PLATFORM, LT_CHEEP_CHEEP );
			addToThemeInfoWorld( 7, TG_CASTLE_CLOUD, LT_CASTLE );
			addToThemeInfoWorld( 7, TG_BONUS, LT_PIPE_BONUS );
			
			addToThemeInfoWorld( 8, TG_AIRSHIP, LT_NORMAL);
			addToThemeInfoWorld( 8, TG_BOWSER_CASTLE, LT_CASTLE );
			addToThemeInfoWorld( 8, TG_BOWSER_CASTLE_WATER, LT_WATER );
			addToThemeInfoWorld( 8, TG_BONUS_BLUE, LT_PIPE_BONUS );

			addToThemeInfoGeneral( TG_GRASS, "1-2d" );
			addToThemeInfoGeneral( TG_GRASS_DESERT, "3-2a" );
			addToThemeInfoGeneral( TG_GRASS_NIGHT, "8-1a" );
			addToThemeInfoGeneral( TG_AIRSHIP_INNER, "8-2b" );
			
			themeMapPack = MapPack.Special;
			
			addToThemeInfoGeneral( TG_DESERT_BLUE_SKY, "3-2a" );
			addToThemeInfoGeneral( TG_GRASS_DESERT, "3-2b" );
			addToThemeInfoGeneral( TG_WATER_SWIMMING_ICE, "6-2c" );
			addToThemeInfoGeneral( TG_GRASS_NIGHT, "8-2a" );
			addToThemeInfoGeneral( TG_WATER_SWIMMING_MUD, "8-2b" );
			addToThemeInfoGeneral( TG_AIRSHIP_INNER, "8-3b" );
			
			themeMapPack = MapPack.LostLevels;
			
			addToThemeInfoWorld( 2, TG_DESERT_BLUE_SKY, LT_NORMAL );
			addToThemeInfoWorld( 2, TG_GRASS_DESERT, LT_CHEEP_CHEEP );
			addToThemeInfoWorld( 2, TG_BONUS_DESERT, LT_PIPE_BONUS );
			addToThemeInfoWorld( 2, TG_CASTLE_DESERT, LT_CASTLE );
			
			addToThemeInfoWorld( 3, TG_WATER_OVERWORLD, LT_NORMAL, LT_INTRO, LT_PLATFORM );
			addToThemeInfoWorld( 3, TG_BONUS, LT_PIPE_BONUS );
			addToThemeInfoWorld( 3, TG_CASTLE_WATER, LT_CASTLE );
			
			addToThemeInfoWorld( 4, TG_OVERWORLD_NIGHT, LT_NORMAL, LT_PLATFORM );
			addToThemeInfoWorld( 4, TG_CASTLE_DARK, LT_CASTLE );
			addToThemeInfoWorld( 4, TG_BONUS, LT_PIPE_BONUS );
			
			addToThemeInfoWorld( 5, TG_ICE, LT_NORMAL, LT_INTRO, LT_PLATFORM );
			addToThemeInfoWorld( 5, TG_UNDERGROUND_ICE, LT_UNDER_GROUND );
			addToThemeInfoWorld( 5, TG_BONUS_ICE, LT_PIPE_BONUS );
			addToThemeInfoWorld( 5, TG_CASTLE_ICE, LT_CASTLE );
			
			addToThemeInfoWorld( 8, TG_CLOUDS, LT_PLATFORM );
			
			addToThemeInfoWorld( 9, TG_WATER_OVERWORLD, LT_NORMAL, LT_CASTLE );
			
			addToThemeInfoWorld( 10, TG_OVERWORLD, LT_PLATFORM );
			
			addToThemeInfoWorld( 11, TG_WATER_OVERWORLD, LT_NORMAL, LT_INTRO, LT_PLATFORM );
			addToThemeInfoWorld( 11, TG_CASTLE_WATER, LT_CASTLE );
			
			addToThemeInfoWorld( 12, TG_PIPES, LT_NORMAL, LT_PLATFORM, LT_CHEEP_CHEEP );
			addToThemeInfoWorld( 12, TG_BONUS_PIPE, LT_PIPE_BONUS );
			addToThemeInfoWorld( 12, TG_CASTLE_PIPE, LT_CASTLE );
			
			addToThemeInfoWorld( 13, TG_OVERWORLD_NIGHT, LT_NORMAL );
			addToThemeInfoWorld( 13, TG_BOWSER_CASTLE, LT_CASTLE );
			addToThemeInfoWorld( 13, TG_BONUS_BLUE, LT_PIPE_BONUS );
			
			addToThemeInfoGeneral( TG_DESERT_PINK_SKY, "2-2a" );
			addToThemeInfoGeneral( TG_OVERWORLD, "7-1c" );
			addToThemeInfoGeneral( TG_WATER_SWIMMING_MUD, "8-1b" );
			addToThemeInfoGeneral( TG_AIRSHIP_INNER, "8-2c");
			addToThemeInfoGeneral( TG_GRASS_NIGHT, "13-2a" );
			addToThemeInfoGeneral( TG_AIRSHIP, "13-3a" );
		}
		override protected function createPlayList():void
		{
			addOverridableMusicTypes( LT_NORMAL );
			
			addToTypePlayList( LT_CASTLE, SngCastle );
			addToTypePlayList( LT_CHEEP_CHEEP, SngAthletic );
			addToTypePlayList( LT_COIN_HEAVEN, SngUpAbove );
			addToTypePlayList( LT_INTRO, SngChestGame );
			addToTypePlayList( LT_NORMAL, SngOverWorld );
			addToTypePlayList( LT_PIPE_BONUS, SngUnderground );
			addToTypePlayList( LT_PLATFORM, SngAthletic );
			addToTypePlayList( LT_UNDER_GROUND, SngUnderground );
			addToTypePlayList( LT_WATER, SngSwimming );
			addToTypePlayList( MT_DARK_EPIC, SngUnderground );

			addToTypePlayList( BOSS, SngBossFight );
			addToTypePlayList( CHAR_SEL, SngGrassLand );
			addToTypePlayList( CHOOSE_CHARACTER, SngWarpWhistle );
			addToTypePlayList( CREDITS, SngSaveThePrincess );
			addToTypePlayList( DIE, SngDie );
			addToTypePlayList( FINAL_BOSS, SngBowserBattle );
			addToTypePlayList( GAME_OVER, SngGameOver );
			addToTypePlayList( HURRY, SngAthleticHurry );
			addToTypePlayList( STAR, SngInvincible );
			addToTypePlayList( TITLE_SCREEN, SngOverWorld );
			addToTypePlayList( WIN, SngBeatLevel );
			addToTypePlayList( WIN_CASTLE, SngBeatAirship );

			addHurryVersionOfSong( SngAirship, SngAirshipHurry );
			addHurryVersionOfSong( SngAthletic, SngAthleticHurry );
			addHurryVersionOfSong( SngBossFight, SngBossHurry );
			addHurryVersionOfSong( SngBowserBattle, SngBowserBattleHurry );
			addHurryVersionOfSong( SngCastle, SngCastleHurry );
			addHurryVersionOfSong( SngHammerBros, SngHammerBrosHurry );
			addHurryVersionOfSong( SngInvincible, SngInvincibleHurry );
			addHurryVersionOfSong( SngOverWorld, SngOverWorldHurry );
			addHurryVersionOfSong( SngSwimming, SngSwimmingHurry );
			addHurryVersionOfSong( SngUnderground, SngUnderGroundHurry );

			addToThemePlayList( TG_AIRSHIP, SngAirship, [ LT_NORMAL ] );
			addToThemePlayList( TG_OVERWORLD_NIGHT, SngUnderground, [ LT_NORMAL, LT_PLATFORM, ] );
			addToThemePlayList( TG_PIPES, SngUnderground, [ LT_NORMAL ] );
			addToThemePlayList( TG_GRASS_NIGHT, SngUnderground, [ LT_NORMAL ] );
			addToThemePlayList( TG_BOWSER_CASTLE_WATER, SngCastle, [ LT_WATER ] );
		}
	}
}