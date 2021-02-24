package com.explodingRabbit.cross.games
{
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.MapPack;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameSuperMarioBros3Snes extends Game
	{
		private static var instance:Game; 
		public function GameSuperMarioBros3Snes(gameNum:int, skinSetNum:int = -1)
		{
			super("Super Mario Bros. 3 SNES", "Nintendo", Consoles.superNintendo, gameNum, "SMB3 (SNES)", skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		override public function initiate():void
		{
			super.initiate();	
			creditsGame = Games.superMarioAllStars;
		}
		private const TG_BLOCKS:ThemeGroup = addThemeGroup( 1, 1 );
		private const TG_FOREST:ThemeGroup = addThemeGroup( 1, 2, MT_DARK_EPIC ); 
		private const TG_FOREST_TREETOPS:ThemeGroup = addThemeGroup( 1, 3 ); 
		private const TG_SNOW_FOREST:ThemeGroup = addThemeGroup( 2, 1 ); 
		private const TG_SNOW_HILLS:ThemeGroup = addThemeGroup( 2, 2 ); 
		private const TG_CAVE:ThemeGroup = addThemeGroup( 3, 1 ); 
		private const TG_CAVE_ICE:ThemeGroup = addThemeGroup( 3, 2 ); 
		private const TG_CAVE_BONUS:ThemeGroup = addThemeGroup( 3, 3 );
		private const TG_WATER:ThemeGroup = addThemeGroup( 4, 1 ); 
		private const TG_WATERFALLS_WAVES:ThemeGroup = addThemeGroup( 5, 1 ); 
		private const TG_PIPES:ThemeGroup = addThemeGroup( 6, 1, MT_DARK_EPIC );
		private const TG_PIPES_WATER:ThemeGroup = addThemeGroup( 6, 2, MT_DARK_EPIC );
		private const TG_SKY:ThemeGroup = addThemeGroup( 7, 1 ); 
		private const TG_SKY_HILLS:ThemeGroup = addThemeGroup( 7, 2 ); 
		private const TG_DESERT_PYRAMIDS:ThemeGroup = addThemeGroup( 8, 1 ); 
		private const TG_DESERT_DUNES:ThemeGroup = addThemeGroup( 8, 2 );  
		private const TG_DESERT_CASTLE:ThemeGroup = addThemeGroup( 8, 3 );  
		private const TG_TANKS_VOLCANOS:ThemeGroup = addThemeGroup( 9, 1, MT_DARK_EPIC );
		private const TG_CASTLE_WALL:ThemeGroup = addThemeGroup( 9, 2, MT_DARK_EPIC );
		private const TG_FOREST_HILLS:ThemeGroup = addThemeGroup( 10, 1 );
		private const TG_NIGHT_HILLS:ThemeGroup = addThemeGroup( 10, 2, MT_DARK_EPIC );
		private const TG_DESERT_HILLS:ThemeGroup = addThemeGroup( 10, 3 );
		private const TG_BOWSER_CASTLE:ThemeGroup = addThemeGroup( 11, 1 );
		private const TG_BOWSER_CASTLE_WATER:ThemeGroup = addThemeGroup( 11, 2 );
		private const TG_BOWSER_CASTLE_FINAL:ThemeGroup = addThemeGroup( 11, 3 );
		private const TG_BONUS_BLUE:ThemeGroup = addThemeGroup( 12, 1 );
		private const TG_BONUS_GREEN:ThemeGroup = addThemeGroup( 12, 2 );
		private const TG_CASTLE_BLUE:ThemeGroup = addThemeGroup( 13, 1 );
		private const TG_CASTLE_GRAY:ThemeGroup = addThemeGroup( 13, 2 );
		private const TG_CASTLE_WATER:ThemeGroup = addThemeGroup( 13, 3 );
		private const TG_CASTLE_ICE:ThemeGroup = addThemeGroup( 14, 1 );
		private const TG_BONUS_ICE:ThemeGroup = addThemeGroup( 14, 2 );
		private const TG_TANK_INNER:ThemeGroup = addThemeGroup( 15, 1);
		
		private const VOLUME:int = 80;
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros3Snes/Airship.spc", mimeType="application/octet-stream")]
		private const AirshipData:Class;		public const SngAirship:Song = addSong( AirshipData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros3Snes/Airship (Hurry Up).spc", mimeType="application/octet-stream")]
		private const AirshipFastData:Class;		public const SngAirshipFast:Song = addSong( AirshipFastData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros3Snes/Athletic.spc", mimeType="application/octet-stream")]
		private const AthleticData:Class;		public const SngAthletic:Song = addSong( AthleticData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros3Snes/Athletic (Hurry Up).spc", mimeType="application/octet-stream")]
		private const AthleticFastData:Class;		public const SngAthleticFast:Song = addSong( AthleticFastData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros3Snes/Bonus Game.spc", mimeType="application/octet-stream")]
		private const BonusGameData:Class;		public const SngBonusGame:Song = addSong( BonusGameData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros3Snes/Bonus Win.spc", mimeType="application/octet-stream")]
		private const BonusWinData:Class;		public const SngBonusWin:Song = addSong( BonusWinData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros3Snes/Boss Battle.spc", mimeType="application/octet-stream")]
		private const BossData:Class;		public const SngBoss:Song = addSong( BossData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros3Snes/Boss Battle (Hurry Up).spc", mimeType="application/octet-stream")]
		private const BossFastData:Class;		public const SngBossFast:Song = addSong( BossFastData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros3Snes/Course Clear.spc", mimeType="application/octet-stream")]
		private const CourseClearData:Class;		public const SngCourseClear:Song = addSong( CourseClearData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros3Snes/Ending.spc", mimeType="application/octet-stream")]
		private const EndingData:Class;		public const SngEnding:Song = addSong( EndingData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros3Snes/Fortress.spc", mimeType="application/octet-stream")]
		private const FortressData:Class;	public const SngFortress:Song = addSong( FortressData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros3Snes/Fortress (Hurry Up).spc", mimeType="application/octet-stream")]
		private const FortressFastData:Class;	public const SngFortressFast:Song = addSong( FortressFastData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros3Snes/Game Over.spc", mimeType="application/octet-stream")]
		private const GameOverData:Class;	public const SngGameOver:Song = addSong( GameOverData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros3Snes/Grass Land.spc", mimeType="application/octet-stream")]
		private const GrassLandData:Class;	public const SngGrassLand:Song = addSong( GrassLandData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros3Snes/In the Clouds.spc", mimeType="application/octet-stream")]
		private const InTheCloudsData:Class;		public const SngInTheClouds:Song = addSong( InTheCloudsData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros3Snes/In the Clouds (Hurry Up).spc", mimeType="application/octet-stream")]
		private const InTheCloudsFastData:Class;		public const SngInTheCloudsFast:Song = addSong( InTheCloudsFastData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros3Snes/Invincible.spc", mimeType="application/octet-stream")]
		private const InvincibleData:Class;		public const SngInvincible:Song = addSong( InvincibleData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros3Snes/Invincible (Hurry Up).spc", mimeType="application/octet-stream")]
		private const InvincibleFastData:Class;		public const SngInvincibleFast:Song = addSong( InvincibleFastData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros3Snes/Player Down.spc", mimeType="application/octet-stream")]
		private const PlayerDownData:Class;		public const SngPlayerDown:Song = addSong( PlayerDownData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros3Snes/Swimming.spc", mimeType="application/octet-stream")]
		private const SwimmingData:Class;		public const SngSwimming:Song = addSong( SwimmingData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros3Snes/Swimming (Hurry Up).spc", mimeType="application/octet-stream")]
		private const SwimmingFastData:Class;	public const SngSwimmingFast:Song = addSong( SwimmingFastData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros3Snes/Title.spc", mimeType="application/octet-stream")]
		private const TitleData:Class;		public const SngTitle:Song = addSong( TitleData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros3Snes/The Evil King Bowser.spc", mimeType="application/octet-stream")]
		private const TheEvilKingBowserData:Class;	public const SngTheEvilKingBowser:Song = addSong( TheEvilKingBowserData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros3Snes/The Evil King Bowser (Hurry Up).spc", mimeType="application/octet-stream")]
		private const TheEvilKingBowserFastData:Class;	public const SngTheEvilKingBowserFast:Song = addSong( TheEvilKingBowserFastData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros3Snes/World Clear.spc", mimeType="application/octet-stream")]
		private const WorldClearData:Class;	public const SngWorldClear:Song = addSong( WorldClearData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros3Snes/Overworld.spc", mimeType="application/octet-stream")]
		private const OverworldData:Class;	public const SngOverworld:Song = addSong( OverworldData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros3Snes/Overworld (Hurry Up).spc", mimeType="application/octet-stream")]
		private const OverworldFastData:Class;	public const SngOverworldFast:Song = addSong( OverworldFastData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros3Snes/Underworld.spc", mimeType="application/octet-stream")]
		private const UnderworldData:Class;		public const SngUnderworld:Song = addSong( UnderworldData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBros3Snes/Underworld (Hurry Up).spc", mimeType="application/octet-stream")]
		private const UnderworldFastData:Class;		public const SngUnderworldFast:Song = addSong( UnderworldFastData, -1, null, VOLUME );

		override protected function setUpLevelThemes():void
		{
			addToThemeInfoGeneral( TG_BLOCKS, LT_NORMAL, LT_INTRO );
			addToThemeInfoGeneral( TG_CAVE, LT_UNDER_GROUND );
			addToThemeInfoGeneral( TG_FOREST_HILLS, LT_PLATFORM );
			addToThemeInfoGeneral( TG_CASTLE_BLUE, LT_CASTLE );
			addToThemeInfoGeneral( TG_SKY, LT_COIN_HEAVEN );
			addToThemeInfoGeneral( TG_WATERFALLS_WAVES, LT_CHEEP_CHEEP );
			addToThemeInfoGeneral( TG_WATER, LT_WATER );
			addToThemeInfoGeneral( TG_BONUS_BLUE, LT_PIPE_BONUS );

			addToThemeInfoGeneral( TG_CAVE_BONUS, "1-2c", "4-2d" );
			addToThemeInfoGeneral( TG_BONUS_ICE, "4-1b" );
			addToThemeInfoGeneral( TG_DESERT_HILLS, "3-2a" );
			addToThemeInfoGeneral( TG_TANKS_VOLCANOS, "8-2a" );
			addToThemeInfoGeneral( TG_CASTLE_WALL, "8-3a" );
			addToThemeInfoGeneral( TG_BOWSER_CASTLE_FINAL, "8-4c" );

			addToThemeInfoWorld( 2, TG_WATERFALLS_WAVES, LT_NORMAL, LT_INTRO );
			addToThemeInfoWorld( 2, TG_BONUS_GREEN, LT_PIPE_BONUS );
			addToThemeInfoWorld( 2, TG_CASTLE_WATER, LT_CASTLE );

			addToThemeInfoWorld( 3, TG_DESERT_PYRAMIDS, LT_NORMAL );
			addToThemeInfoWorld( 3, TG_DESERT_DUNES, LT_PLATFORM );
			addToThemeInfoWorld( 3, TG_DESERT_CASTLE, LT_CASTLE );
			
			addToThemeInfoWorld( 4, TG_SNOW_FOREST, LT_NORMAL, LT_INTRO );
			addToThemeInfoWorld( 4, TG_SNOW_HILLS, LT_PLATFORM );
			addToThemeInfoWorld( 4, TG_CAVE_ICE, LT_UNDER_GROUND );
			addToThemeInfoWorld( 4, TG_CASTLE_ICE, LT_CASTLE );
			
			addToThemeInfoWorld( 5, TG_FOREST, LT_NORMAL );
			addToThemeInfoWorld( 5, TG_FOREST_TREETOPS, LT_PLATFORM );

			addToThemeInfoWorld( 6, TG_PIPES, LT_NORMAL, LT_PLATFORM, LT_INTRO, LT_CHEEP_CHEEP );
			addToThemeInfoWorld( 6, TG_CASTLE_GRAY, LT_CASTLE );
			addToThemeInfoWorld( 6, TG_BONUS_GREEN, LT_PIPE_BONUS );

			addToThemeInfoWorld( 7, TG_SKY, LT_NORMAL, LT_INTRO );
			addToThemeInfoWorld( 7, TG_SKY_HILLS, LT_CHEEP_CHEEP, LT_PLATFORM );
			addToThemeInfoWorld( 7, TG_BONUS_GREEN, LT_PIPE_BONUS );
			addToThemeInfoWorld( 7, TG_CASTLE_GRAY, LT_CASTLE );
			
			addToThemeInfoWorld( 8, TG_NIGHT_HILLS, LT_NORMAL );
			addToThemeInfoWorld( 8, TG_BOWSER_CASTLE, LT_CASTLE );
			addToThemeInfoWorld( 8, TG_BOWSER_CASTLE_WATER, LT_WATER );
			
			themeMapPack = MapPack.Special;
			
			addToThemeInfoGeneral( TG_CAVE_BONUS, "1-2c", "4-2d" );
			addToThemeInfoGeneral( TG_SKY, "4-3b" );
			addToThemeInfoGeneral( TG_FOREST_HILLS, "1-2d" );
			addToThemeInfoGeneral( TG_DESERT_PYRAMIDS, "3-2a" );
			addToThemeInfoGeneral( TG_DESERT_HILLS, "3-2b" );
			addToThemeInfoGeneral( TG_PIPES_WATER, "6-2c" );
			addToThemeInfoGeneral( TG_NIGHT_HILLS, "8-1a", "8-2a" );
			addToThemeInfoGeneral( TG_WATER, "8-2b" );
			addToThemeInfoGeneral( TG_CASTLE_WALL, "8-2c" );
			addToThemeInfoGeneral( TG_TANK_INNER, "8-3b" );
			addToThemeInfoGeneral( TG_TANKS_VOLCANOS, "8-3c" );
			
			themeMapPack = MapPack.LostLevels;
			
			addToThemeInfoWorld( 2, TG_DESERT_PYRAMIDS, LT_NORMAL );
			addToThemeInfoWorld( 2, TG_DESERT_HILLS, LT_CHEEP_CHEEP );
			addToThemeInfoWorld( 2, TG_DESERT_CASTLE, LT_CASTLE );
			
			addToThemeInfoWorld( 3, TG_WATERFALLS_WAVES, LT_NORMAL, LT_INTRO, LT_PLATFORM );
			addToThemeInfoWorld( 3, TG_CASTLE_WATER, LT_CASTLE );
			addToThemeInfoWorld( 3, TG_BONUS_GREEN, LT_PIPE_BONUS );
			
			addToThemeInfoWorld( 4, TG_FOREST, LT_NORMAL );
			addToThemeInfoWorld( 4, TG_FOREST_TREETOPS, LT_PLATFORM );
			addToThemeInfoWorld( 4, TG_CASTLE_BLUE, LT_CASTLE );
			
			addToThemeInfoWorld( 5, TG_SNOW_FOREST, LT_NORMAL, LT_INTRO );
			addToThemeInfoWorld( 5, TG_SNOW_HILLS, LT_PLATFORM );
			addToThemeInfoWorld( 5, TG_CAVE_ICE, LT_UNDER_GROUND );
			addToThemeInfoWorld( 5, TG_CASTLE_ICE, LT_CASTLE );
			addToThemeInfoWorld( 5, TG_BONUS_ICE, LT_PIPE_BONUS );
			
			addToThemeInfoWorld( 8, TG_SKY, LT_PLATFORM );
			addToThemeInfoWorld( 8, TG_WATER, LT_WATER );
			
			addToThemeInfoWorld( 9, TG_WATERFALLS_WAVES, LT_NORMAL, LT_CASTLE );
			
			addToThemeInfoWorld( 10, TG_BLOCKS, LT_PLATFORM );
			
			addToThemeInfoWorld( 11, TG_WATERFALLS_WAVES, LT_NORMAL, LT_INTRO, LT_PLATFORM );
			addToThemeInfoWorld( 11, TG_CASTLE_WATER, LT_CASTLE );
			
			addToThemeInfoWorld( 12, TG_PIPES, LT_NORMAL, LT_CHEEP_CHEEP, LT_PLATFORM );
			addToThemeInfoWorld( 12, TG_CASTLE_GRAY, LT_CASTLE );
			addToThemeInfoWorld( 12, TG_BONUS_GREEN, LT_PIPE_BONUS );
			
			addToThemeInfoWorld( 13, TG_FOREST, LT_NORMAL );
			addToThemeInfoWorld( 13, TG_BOWSER_CASTLE, LT_CASTLE );
			
			addToThemeInfoGeneral( TG_DESERT_DUNES, "2-2a" );
			addToThemeInfoGeneral( TG_WATER, "4-1b" );
			addToThemeInfoGeneral( TG_BLOCKS, "7-1c" );
			addToThemeInfoGeneral( TG_TANK_INNER, "8-2c" );
			addToThemeInfoGeneral( TG_BOWSER_CASTLE_WATER, "8-4b" );
			addToThemeInfoGeneral( TG_NIGHT_HILLS, "13-2a" );
			addToThemeInfoGeneral( TG_CASTLE_WALL, "13-3a" );
		}
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);

			addToTypePlayList(LT_CASTLE, SngFortress);
			addToTypePlayList(LT_CHEEP_CHEEP, SngAthletic);
			addToTypePlayList(LT_COIN_HEAVEN, SngInTheClouds);
			addToTypePlayList(LT_INTRO, SngBonusGame);
			addToTypePlayList(LT_NORMAL, SngOverworld);
			addToTypePlayList(LT_PIPE_BONUS, SngUnderworld);
			addToTypePlayList(LT_PLATFORM, SngAthletic);
			addToTypePlayList(LT_UNDER_GROUND, SngUnderworld);
			addToTypePlayList(LT_WATER, SngSwimming);
			addToTypePlayList(MT_DARK_EPIC, SngUnderworld);

			addToTypePlayList(BOSS, SngBoss);
			addToTypePlayList(CHAR_SEL, SngGrassLand);
			addToTypePlayList(CHOOSE_CHARACTER, SngBonusWin);
			addToTypePlayList(CREDITS, SngEnding);
			addToTypePlayList(DIE, SngPlayerDown);
			addToTypePlayList(FINAL_BOSS, SngTheEvilKingBowser);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, SngOverworldFast);
			addToTypePlayList(STAR, SngInvincible);
			addToTypePlayList(TITLE_SCREEN, SngTitle);
			addToTypePlayList(WIN, SngCourseClear);
			addToTypePlayList(WIN_CASTLE, SngWorldClear);

			addHurryVersionOfSong( SngAirship, SngAirshipFast);
			addHurryVersionOfSong( SngAthletic, SngAthleticFast );
			addHurryVersionOfSong( SngBoss, SngBossFast );
			addHurryVersionOfSong( SngTheEvilKingBowser, SngTheEvilKingBowserFast );
			addHurryVersionOfSong( SngFortress, SngFortressFast );
			addHurryVersionOfSong( SngInTheClouds, SngInTheCloudsFast );
			addHurryVersionOfSong( SngInvincible, SngInvincibleFast );
			addHurryVersionOfSong( SngOverworld, SngOverworldFast );
			addHurryVersionOfSong( SngSwimming, SngSwimmingFast );
			addHurryVersionOfSong( SngUnderworld, SngUnderworldFast );
			
			addToThemePlayList( TG_TANKS_VOLCANOS, SngAirship, [ LT_NORMAL ] );
			addToThemePlayList( TG_CASTLE_WALL, SngAirship, [ LT_NORMAL ] );
			addToThemePlayList( TG_PIPES, SngUnderworld, [ LT_NORMAL, LT_PLATFORM ] );
			addToThemePlayList( TG_FOREST, SngUnderworld, [ LT_NORMAL, LT_INTRO ] );
			addToThemePlayList( TG_FOREST_TREETOPS, SngUnderworld, [ LT_COIN_HEAVEN ] );
			addToThemePlayList( TG_NIGHT_HILLS, SngUnderworld, [ LT_NORMAL, LT_PLATFORM ] );
			addToThemePlayList( TG_BOWSER_CASTLE_WATER, SngFortress, [ LT_WATER ] );
		}
	}
}