package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.MapPack;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameSuperMarioWorld extends Game
	{
		private static var instance:Game; 
		
		public function GameSuperMarioWorld(gameNum:int, skinSetNum:int)
		{
			super("Super Mario World", "Nintendo", Consoles.superNintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		override public function initiate():void
		{
			super.initiate();	
			creditsGame = Games.superMarioWorld;
		}
		private const TG_BLUE_MOUNTAINS:ThemeGroup = addThemeGroup( 1, 1 );
		private const TG_CLIFFS_GREEN:ThemeGroup = addThemeGroup( 1, 2 );
		private const TG_HILLS_GREEN:ThemeGroup = addThemeGroup( 1, 3 );
		private const TG_CLIFFS_WHITE:ThemeGroup = addThemeGroup( 1, 4 );
		private const TG_TREES_AND_STARS:ThemeGroup = addThemeGroup( 1, 5, MT_DARK_EPIC );
		private const TG_CLIFFS_CHOCOLATE:ThemeGroup = addThemeGroup( 1, 6 );
		private const TG_CLIFFS_CHOCOLATE_SPIRAL:ThemeGroup = addThemeGroup( 1, 7 );
		private const TG_CLIFFS_WHITE_SPIRAL:ThemeGroup = addThemeGroup( 1, 8 );
		private const TG_HILLS_DARK_LOW:ThemeGroup = addThemeGroup( 1, 9, MT_DARK_EPIC );
		private const TG_HILLS_DARK:ThemeGroup = addThemeGroup( 1, 10, MT_DARK_EPIC );
		private const TG_HILLS_DARK_TALL:ThemeGroup = addThemeGroup( 1, 11, MT_DARK_EPIC );
		private const TG_HILLS_DARK_BLACK_SKY:ThemeGroup = addThemeGroup( 1, 12, MT_DARK_EPIC );
		private const TG_HILLS_DARK_TALL_DARK_SKY:ThemeGroup = addThemeGroup( 1, 13, MT_DARK_EPIC );
		private const TG_GREEN_GROUND_CLOUDS:ThemeGroup = addThemeGroup( 1, 14 );
		private const TG_HILLS_LIGHT_GREEN:ThemeGroup = addThemeGroup( 1, 15 );
		private const TG_CAVE_BROWN:ThemeGroup = addThemeGroup( 2, 1 );
		private const TG_CAVE_GRAY:ThemeGroup = addThemeGroup( 2, 2 );
		private const TG_CAVE_ICE:ThemeGroup = addThemeGroup( 2, 3 );
		private const TG_WATER:ThemeGroup = addThemeGroup( 2, 4 );
		private const TG_CAVE_BROWN_DARK:ThemeGroup = addThemeGroup( 2, 5 );
		private const TG_FOREST_GREEN:ThemeGroup = addThemeGroup( 3, 1 );
		private const TG_FOREST_GRAY:ThemeGroup = addThemeGroup( 3, 2 );
		private const TG_FOREST_CYAN:ThemeGroup = addThemeGroup( 3, 3 );
		private const TG_FOREST_GRAY_UNDERGROUND:ThemeGroup = addThemeGroup( 3, 4 );
		private const TG_GHOST_HOUSE_BROWN_DARK:ThemeGroup = addThemeGroup( 4, 1, MT_DARK_EPIC );
		private const TG_GHOST_HOUSE_BROWN_BLACK:ThemeGroup = addThemeGroup( 4, 2, MT_DARK_EPIC );
		private const TG_GHOST_HOUSE_DARK:ThemeGroup = addThemeGroup( 4, 3, MT_DARK_EPIC );
		private const TG_GHOST_HOUSE_WATER:ThemeGroup = addThemeGroup( 4, 4, MT_DARK_EPIC );
		private const TG_CASTLE_GRAY_PILLARS:ThemeGroup = addThemeGroup( 5, 1 );
		private const TG_CASTLE_GRAY_BLACK:ThemeGroup = addThemeGroup( 5, 2 );
		private const TG_CASTLE_GRAY_DARK:ThemeGroup = addThemeGroup( 5, 3 );
		private const TG_CASTLE_WHITE_PILLARS:ThemeGroup = addThemeGroup( 5, 4 );
		private const TG_CASTLE_BROWN_BLACK:ThemeGroup = addThemeGroup( 5, 5 );
		private const TG_CASTLE_BROWN_DARK:ThemeGroup = addThemeGroup( 5, 6 );
		private const TG_CASTLE_DARK:ThemeGroup = addThemeGroup( 5, 7 );
		private const TG_CASTLE_WATER:ThemeGroup = addThemeGroup( 5, 8 );
		private const TG_BONUS:ThemeGroup = addThemeGroup( 6, 1 );
		private const TG_SKY_PEACH:ThemeGroup = addThemeGroup( 7, 1 );
		private const TG_SKY_STARS:ThemeGroup = addThemeGroup( 7, 2 );
		private const TG_SKY_BLUE:ThemeGroup = addThemeGroup( 7, 3 );
		private const TG_ICE_CLIFFS:ThemeGroup = addThemeGroup( 8, 1 );
		private const TG_ICE_CLIFFS_SPIRAL:ThemeGroup = addThemeGroup( 8, 2 );
		
		private const VOLUME:int = 100;
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioWorld/bonus.spc", mimeType="application/octet-stream")]
		private const BonusData:Class;		public const SngBonus:Song = addSong( BonusData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioWorld/bonus_hurry.spc", mimeType="application/octet-stream")]
		private const BonusFastData:Class;	public const SngBonusFast:Song = addSong( BonusFastData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioWorld/fortress.spc", mimeType="application/octet-stream")]
		private const CastleData:Class;		public const SngCastle:Song = addSong( CastleData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioWorld/fortress_hurry.spc", mimeType="application/octet-stream")]
		private const CastleFastData:Class;	public const SngCastleFast:Song = addSong( CastleFastData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioWorld/special_world.spc", mimeType="application/octet-stream")]
		private const GameSelect:Class;		public const SngGameSelect:Song = addSong( GameSelect, -1, null, VOLUME +20 );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioWorld/course_clear.spc", mimeType="application/octet-stream")]
		private const CourseClear:Class;		public const SngCourseClear:Song = addSong( CourseClear, -1, null, VOLUME ); 
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioWorld/boss.spc", mimeType="application/octet-stream")]
		private const BossData:Class;	public const SngBoss:Song = addSong( BossData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioWorld/boss_hurry.spc", mimeType="application/octet-stream")]
		private const BossFastData:Class;	public const SngBossFast:Song = addSong( BossFastData, -1, null, VOLUME ); 
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioWorld/king_bowser.spc", mimeType="application/octet-stream")]
		private const KingBowserData:Class;		public const SngKingBowser:Song = addSong( KingBowserData, -1, null, VOLUME ); 
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioWorld/king_bowser.spc", mimeType="application/octet-stream")]
		private const KingBowserFastData:Class;	public const SngKingBowserFast:Song = addSong( KingBowserFastData, -1, null, VOLUME ); 
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioWorld/going_underground.spc", mimeType="application/octet-stream")]
		private const IntroLevelData:Class;	public const SngIntroLevel:Song = addSong( IntroLevelData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioWorld/game_over.spc", mimeType="application/octet-stream")]
		private const GameOverData:Class;	public const SngGameOver:Song = addSong( GameOverData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioWorld/overworld.spc", mimeType="application/octet-stream")]
		private const OverworldData:Class;	public const SngOverworld:Song = addSong( OverworldData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioWorld/overworld_hurry.spc", mimeType="application/octet-stream")]
		private const OverworldFastData:Class;public const SngOverworldFast:Song = addSong( OverworldFastData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioWorld/overworld_yoshi.spc", mimeType="application/octet-stream")]
		private const OverworldYoshiData:Class;	public const SngOverworldYoshi:Song = addSong( OverworldYoshiData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioWorld/overworld_yoshi_hurry.spc", mimeType="application/octet-stream")]
		private const OverworldYoshiFastData:Class;	public const SngOverworldYoshiFast:Song = addSong( OverworldYoshiFastData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioWorld/athletic.spc", mimeType="application/octet-stream")]
		private const AthleticData:Class;	public const SngAthletic:Song = addSong( AthleticData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioWorld/athletic_hurry.spc", mimeType="application/octet-stream")]
		private const AthleticFastData:Class;public const SngAthleticFast:Song = addSong( AthleticFastData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioWorld/ghost_house.spc", mimeType="application/octet-stream")]
		private const GhostHouseData:Class;	public const SngGhostHouse:Song = addSong( GhostHouseData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioWorld/ghost_house_hurry.spc", mimeType="application/octet-stream")]
		private const GhostHouseFastData:Class;public const SngGhostHouseFast:Song = addSong( GhostHouseFastData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioWorld/player_down.spc", mimeType="application/octet-stream")]
		private const DieData:Class;			public const SngDie:Song = addSong( DieData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioWorld/swimming.spc", mimeType="application/octet-stream")]
		private const WaterData:Class;		public const SngWater:Song = addSong( WaterData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioWorld/swimming_hurry.spc", mimeType="application/octet-stream")]
		private const WaterFastData:Class;	public const SngWaterFast:Song = addSong( WaterFastData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioWorld/fortress_clear.spc", mimeType="application/octet-stream")]
		private const WinCastleData:Class;	public const SngWinCastle:Song = addSong( WinCastleData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioWorld/underground.spc", mimeType="application/octet-stream")]
		private const UnderGroundData:Class;	public const SngUnderground:Song = addSong( UnderGroundData, -1, null, VOLUME + 20 );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioWorld/underground_hurry.spc", mimeType="application/octet-stream")]
		private const UnderGroundFastData:Class;	public const SngUnderGroundFast:Song = addSong( UnderGroundFastData, -1, null, VOLUME + 20 );

		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioWorld/title.spc", mimeType="application/octet-stream")]
		private const TitleData:Class;		public const SngTitle:Song = addSong( TitleData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioWorld/invincible.spc", mimeType="application/octet-stream")]
		private const Invincible:Class;		public const SngInvincible:Song = addSong( Invincible, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioWorld/invincible_hurry.spc", mimeType="application/octet-stream")]
		private const InvincibleFastData:Class;	public const SngInvincibleFast:Song = addSong( InvincibleFastData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioWorld/ending.spc", mimeType="application/octet-stream")]
		private const EndingData:Class;	public const SngEnding:Song = addSong( EndingData, -1, null, VOLUME );
		
		override protected function setUpLevelThemes():void
		{
			addToThemeInfoGeneral( TG_BLUE_MOUNTAINS, LT_NORMAL, LT_INTRO );
			addToThemeInfoGeneral( TG_CAVE_BROWN, LT_UNDER_GROUND );
			addToThemeInfoGeneral( TG_CLIFFS_GREEN, LT_PLATFORM );
			addToThemeInfoGeneral( TG_CASTLE_GRAY_PILLARS, LT_CASTLE );
			addToThemeInfoGeneral( TG_SKY_PEACH, LT_COIN_HEAVEN );
			addToThemeInfoGeneral( TG_CLIFFS_WHITE, LT_CHEEP_CHEEP );
			addToThemeInfoGeneral( TG_WATER, LT_WATER );
			addToThemeInfoGeneral( TG_BONUS, LT_PIPE_BONUS );
			
			addToThemeInfoWorld( 2, TG_HILLS_GREEN, LT_NORMAL, LT_INTRO );
			addToThemeInfoWorld( 2, TG_CASTLE_GRAY_BLACK, LT_CASTLE );

			addToThemeInfoWorld( 3, TG_CAVE_BROWN_DARK, LT_NORMAL );
			addToThemeInfoWorld( 3, TG_SKY_STARS, LT_COIN_HEAVEN );
			addToThemeInfoWorld( 3, TG_TREES_AND_STARS, LT_PLATFORM );
			addToThemeInfoWorld( 3, TG_CASTLE_GRAY_DARK, LT_CASTLE );
			
			addToThemeInfoWorld( 4, TG_ICE_CLIFFS, LT_NORMAL, LT_INTRO );
			addToThemeInfoWorld( 4, TG_CAVE_ICE, LT_UNDER_GROUND );
			addToThemeInfoWorld( 4, TG_ICE_CLIFFS_SPIRAL, LT_PLATFORM );
			addToThemeInfoWorld( 4, TG_CASTLE_WHITE_PILLARS, LT_CASTLE );
			
			addToThemeInfoWorld( 5, TG_FOREST_GREEN, LT_NORMAL );
			addToThemeInfoWorld( 5, TG_FOREST_CYAN, LT_PLATFORM );
			addToThemeInfoWorld( 5, TG_CASTLE_BROWN_BLACK, LT_CASTLE );
			
			addToThemeInfoWorld( 6, TG_CLIFFS_CHOCOLATE, LT_NORMAL );
			addToThemeInfoWorld( 6, TG_SKY_BLUE, LT_COIN_HEAVEN );
			addToThemeInfoWorld( 6, TG_CLIFFS_WHITE_SPIRAL, LT_PLATFORM );
			addToThemeInfoWorld( 6, TG_CASTLE_BROWN_DARK, LT_CASTLE );
			
			addToThemeInfoWorld( 7, TG_GHOST_HOUSE_BROWN_DARK, LT_NORMAL, LT_INTRO, LT_PIPE_BONUS );
			addToThemeInfoWorld( 7, TG_GHOST_HOUSE_WATER, LT_WATER );
			addToThemeInfoWorld( 7, TG_GHOST_HOUSE_BROWN_BLACK, LT_CHEEP_CHEEP, LT_PLATFORM );
			addToThemeInfoWorld( 7, TG_GHOST_HOUSE_DARK, LT_CASTLE );
			
			addToThemeInfoWorld( 8, TG_HILLS_DARK_LOW, LT_NORMAL );
			addToThemeInfoWorld( 8, TG_CASTLE_DARK, LT_CASTLE );
			addToThemeInfoWorld( 8, TG_CASTLE_WATER, LT_WATER );
			
			addToThemeInfoGeneral( TG_CAVE_GRAY, "3-2a" );
			addToThemeInfoGeneral( TG_FOREST_GRAY, "5-2a" );
			addToThemeInfoGeneral( TG_CLIFFS_CHOCOLATE_SPIRAL, "6-2a" );
			addToThemeInfoGeneral( TG_HILLS_DARK, "8-2a" );
			addToThemeInfoGeneral( TG_HILLS_DARK_TALL, "8-3a" );
			
			themeMapPack = MapPack.Special;
			
			addToThemeInfoGeneral( TG_CLIFFS_WHITE, "3-1a" );
			addToThemeInfoGeneral( TG_CAVE_BROWN_DARK, "3-1c" );
			addToThemeInfoGeneral( TG_CAVE_GRAY, "3-2a" );
			addToThemeInfoGeneral( TG_GREEN_GROUND_CLOUDS, "3-2b" );
			addToThemeInfoGeneral( TG_CLIFFS_CHOCOLATE_SPIRAL, "6-2d" );
			addToThemeInfoGeneral( TG_HILLS_DARK_LOW, "8-1a", "8-2a" );
			addToThemeInfoGeneral( TG_WATER, "8-2b" );
			addToThemeInfoGeneral( TG_HILLS_DARK_TALL_DARK_SKY, "8-2c", "8-3a" );
			addToThemeInfoGeneral( TG_HILLS_DARK_BLACK_SKY, "8-3c" );
			
			themeMapPack = MapPack.LostLevels;
			
			addToThemeInfoWorld( 9, TG_GHOST_HOUSE_WATER, LT_WATER );
			
			addToThemeInfoWorld( 10, TG_ICE_CLIFFS, LT_NORMAL, LT_INTRO );
			addToThemeInfoWorld( 10, TG_SKY_BLUE, LT_COIN_HEAVEN );
			addToThemeInfoWorld( 10, TG_CAVE_ICE, LT_UNDER_GROUND );
			addToThemeInfoWorld( 10, TG_ICE_CLIFFS_SPIRAL, LT_PLATFORM );
			addToThemeInfoWorld( 10, TG_CASTLE_WHITE_PILLARS, LT_CASTLE );
			
			addToThemeInfoWorld( 11, TG_FOREST_GREEN, LT_NORMAL );
			addToThemeInfoWorld( 11, TG_FOREST_CYAN, LT_PLATFORM );
			addToThemeInfoWorld( 11, TG_CASTLE_BROWN_BLACK, LT_CASTLE );
			
			addToThemeInfoWorld( 12, TG_CLIFFS_CHOCOLATE, LT_NORMAL );
			addToThemeInfoWorld( 12, TG_SKY_BLUE, LT_COIN_HEAVEN );
			addToThemeInfoWorld( 12, TG_CLIFFS_CHOCOLATE_SPIRAL, LT_CHEEP_CHEEP );
			addToThemeInfoWorld( 12, TG_CLIFFS_WHITE_SPIRAL, LT_PLATFORM );
			addToThemeInfoWorld( 12, TG_CASTLE_BROWN_DARK, LT_CASTLE );
			
			addToThemeInfoWorld( 13, TG_HILLS_DARK_LOW, LT_NORMAL );
			addToThemeInfoWorld( 13, TG_SKY_STARS, LT_COIN_HEAVEN );
			addToThemeInfoWorld( 13, TG_CASTLE_DARK, LT_CASTLE );
			
			addToThemeInfoGeneral( TG_HILLS_LIGHT_GREEN, "2-2a" );
			addToThemeInfoGeneral( TG_CAVE_BROWN_DARK, "3-1a" );
			addToThemeInfoGeneral( TG_SKY_STARS, "3-1c", "8-3b" );
			addToThemeInfoGeneral( TG_TREES_AND_STARS, "3-2c", "8-2b", "8-3a" );
			addToThemeInfoGeneral( TG_SKY_BLUE, "4-1c" );
			addToThemeInfoGeneral( TG_FOREST_GRAY_UNDERGROUND, "5-2b" );
			addToThemeInfoGeneral( TG_FOREST_GRAY, "5-2c", "5-2d" );
			addToThemeInfoGeneral( TG_CLIFFS_CHOCOLATE_SPIRAL, "6-2a", "6-2c" );
			addToThemeInfoGeneral( TG_CLIFFS_WHITE_SPIRAL, "6-3a" );
			addToThemeInfoGeneral( TG_WATER, "8-1b" );
			addToThemeInfoGeneral( TG_HILLS_DARK_LOW, "8-1c" );
			addToThemeInfoGeneral( TG_HILLS_DARK, "8-2a" );
			addToThemeInfoGeneral( TG_GHOST_HOUSE_DARK, "9-3a" );
			addToThemeInfoGeneral( TG_GHOST_HOUSE_BROWN_DARK, "9-3b" );
			addToThemeInfoGeneral( TG_FOREST_GRAY, "11-2a", "11-2c" );
			addToThemeInfoGeneral( TG_FOREST_CYAN, "11-4b" );
			addToThemeInfoGeneral( TG_HILLS_DARK, "13-2a" );
			addToThemeInfoGeneral( TG_HILLS_DARK_TALL, "13-3a", "13-4b" );
		}
		override protected function createPlayList():void
		{
			addOverridableMusicTypes( LT_NORMAL, LT_CHEEP_CHEEP, LT_PLATFORM );
			
			addToTypePlayList(LT_CASTLE, SngCastle);
			addToTypePlayList(LT_CHEEP_CHEEP, SngAthletic);
			addToTypePlayList(LT_COIN_HEAVEN, SngBonus);
			addToTypePlayList(LT_INTRO, SngIntroLevel);
			addToTypePlayList(LT_NORMAL, SngOverworld);
			addToTypePlayList(LT_PIPE_BONUS, SngBonus);
			addToTypePlayList(LT_PLATFORM, SngAthletic);
			addToTypePlayList(LT_UNDER_GROUND, SngUnderground);
			addToTypePlayList(LT_WATER, SngWater);
			addToTypePlayList(MT_DARK_EPIC, SngOverworldYoshi);
			
			addToTypePlayList(BOSS, SngBoss);
			addToTypePlayList(CHAR_SEL, SngGameSelect);
			addToTypePlayList(CHOOSE_CHARACTER, SngIntroLevel);
			addToTypePlayList(CREDITS, SngEnding);
			addToTypePlayList(DIE, SngDie);
			addToTypePlayList(FINAL_BOSS, SngKingBowser);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, SngAthleticFast);
			addToTypePlayList(STAR, SngInvincible);
			addToTypePlayList(TITLE_SCREEN, SngTitle);
			addToTypePlayList(WIN, SngCourseClear);
			addToTypePlayList(WIN_CASTLE, SngWinCastle);
			
			addHurryVersionOfSong( SngBoss, SngBossFast );
			addHurryVersionOfSong( SngKingBowser, SngKingBowserFast );
			addHurryVersionOfSong( SngBonus, SngBonusFast );
			addHurryVersionOfSong( SngInvincible, SngInvincibleFast );
			addHurryVersionOfSong( SngCastle, SngCastleFast );
			addHurryVersionOfSong( SngOverworld, SngOverworldFast );
			addHurryVersionOfSong( SngAthletic, SngAthleticFast );
			addHurryVersionOfSong( SngUnderground, SngUnderGroundFast );
			addHurryVersionOfSong( SngWater, SngWaterFast );
			addHurryVersionOfSong( SngGhostHouse, SngGhostHouseFast );
			addHurryVersionOfSong( SngOverworldYoshi, SngOverworldYoshiFast );
			
			addToThemePlayList( TG_CAVE_BROWN_DARK, SngUnderground, [ LT_NORMAL ] );
			addToThemePlayList( TG_CAVE_GRAY, SngUnderground, [ LT_NORMAL ] );
			addToThemePlayList( TG_GHOST_HOUSE_BROWN_DARK, SngGhostHouse, [ LT_NORMAL, LT_INTRO, LT_PIPE_BONUS, LT_COIN_HEAVEN ] );
			addToThemePlayList( TG_GHOST_HOUSE_WATER, SngGhostHouse, [ LT_WATER ] );
			addToThemePlayList( TG_GHOST_HOUSE_BROWN_BLACK, SngGhostHouse, [ LT_CHEEP_CHEEP] );
			addToThemePlayList( TG_GHOST_HOUSE_DARK, SngGhostHouse, [ LT_CASTLE, LT_NORMAL ] );
			addToThemePlayList( TG_CASTLE_WATER, SngCastle, [ LT_WATER ] );
		}
	}
}