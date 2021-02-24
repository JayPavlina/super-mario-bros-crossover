package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.characters.Luigi;
	import com.smbc.data.MapPack;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	import flxmp.Player;
	
	public class GameSuperMarioBrosSnes extends Game
	{
		private static var instance:Game; 
		
		public function GameSuperMarioBrosSnes(gameNum:int, skinSetNum:int)
		{
			super("Super Mario Bros. (SNES)", "Nintendo", Consoles.superNintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		override public function initiate():void
		{
			super.initiate();	
			creditsGame = Games.superMarioAllStars;
		}
		private const TG_OVERWORLD_BIG_HILLS:ThemeGroup = addThemeGroup( 1, 1 );
		private const TG_OVERWORLD_WATER_FALL:ThemeGroup = addThemeGroup( 1, 2 );
		private const TG_OVERWORLD_SMALL_GREEN_HILLS:ThemeGroup = addThemeGroup( 1, 3 );
		private const TG_OVERWORLD_GOOMBA_STATUES:ThemeGroup = addThemeGroup( 1, 4 );
		private const TG_OVERWORLD_FOREST:ThemeGroup = addThemeGroup( 1, 5 );
		private const TG_OVERWORLD_SMALL_BROWN_HILLS:ThemeGroup = addThemeGroup( 1, 6 );
		private const TG_OVERWORLD_CASTLE_WALLS:ThemeGroup = addThemeGroup( 1, 7 );
		private const TG_OVERWORLD_NIGHT_WITHOUT_TREES:ThemeGroup = addThemeGroup( 1, 8, MT_DARK_EPIC );
		private const TG_OVERWORLD_NIGHT_WITH_TREES:ThemeGroup = addThemeGroup( 1, 9, MT_DARK_EPIC );
		private const TG_OVERWORLD_SKY:ThemeGroup = addThemeGroup( 1, 10 );
		private const TG_OVERWORLD_SNOW:ThemeGroup = addThemeGroup( 2, 1 );
		private const TG_OVERWORLD_SNOW_NIGHT:ThemeGroup = addThemeGroup( 2, 2, MT_DARK_EPIC );
		private const TG_UNDERGROUND:ThemeGroup = addThemeGroup( 3, 1 );
		private const TG_UNDERGROUND_BONUS:ThemeGroup = addThemeGroup( 3, 2 );
		private const TG_UNDERGROUND_WATER:ThemeGroup = addThemeGroup( 3, 3 );
		private const TG_UNDERGROUND_SCENERY:ThemeGroup = addThemeGroup( 3, 4 );
		private const TG_WATER:ThemeGroup = addThemeGroup( 4, 1 );
		private const TG_WATER_NIGHT:ThemeGroup = addThemeGroup( 4, 2 );
		private const TG_CASTLE:ThemeGroup = addThemeGroup( 5, 1 );
		private const TG_CASTLE_WATER:ThemeGroup = addThemeGroup( 5, 2 );
		private const TG_CASTLE_BOWSER:ThemeGroup = addThemeGroup( 5, 3 );
		private const TG_MUSHROOM_PLATFORMS:ThemeGroup = addThemeGroup( 6, 1 );
		private const TG_MUSHROOM_PLATFORMS_OVERWORLD:ThemeGroup = addThemeGroup( 6, 2 );
		private const TG_COIN_HEAVEN:ThemeGroup = addThemeGroup( 7, 1 );
		private const TG_COIN_HEAVEN_NIGHT:ThemeGroup = addThemeGroup( 7, 2, MT_DARK_EPIC );
		private const TG_CLOUDS:ThemeGroup = addThemeGroup( 8, 1 );
		private const TG_CLOUDS_BRIGHT:ThemeGroup = addThemeGroup( 8, 2 );
		private const TG_CLOUDS_GOOMBA_STATUES:ThemeGroup = addThemeGroup( 8, 3 );
		private const TG_CLOUDS_OVERWORLD:ThemeGroup = addThemeGroup( 8, 4 );
		private const TG_OVERWORLD_CASTLE:ThemeGroup = addThemeGroup( 9, 1 );
		private const TG_WATER_DARK_GROUND_GREEN:ThemeGroup = addThemeGroup( 10, 1 );
		private const TG_WATER_DARK_GROUND_BROWN:ThemeGroup = addThemeGroup( 11, 1 );
		
		private const VOLUME:int = 80;
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBrosSnes/Bonus.spc", mimeType="application/octet-stream")]
		private const BonusData:Class;		public const SngBonus:Song = addSong( BonusData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBrosSnes/Bonus (Hurry Up).spc", mimeType="application/octet-stream")]
		private const BonusFastData:Class;	public const SngBonusFast:Song = addSong( BonusFastData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBrosSnes/Castle.spc", mimeType="application/octet-stream")]
		private const CastleData:Class;		public const SngCastle:Song = addSong( CastleData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBrosSnes/Castle (Hurry Up).spc", mimeType="application/octet-stream")]
		private const CastleFastData:Class;	public const SngCastleFast:Song = addSong( CastleFastData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioAllStars/Game Select.spc", mimeType="application/octet-stream")]
		private const GameSelect:Class;		public const SngGameSelect:Song = addSong( GameSelect, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBrosSnes/Course Clear.spc", mimeType="application/octet-stream")]
		private const CourseClear:Class;		public const SngCourseClear:Song = addSong( CourseClear, -1, null, VOLUME ); 
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBrosSnes/King Bowser.spc", mimeType="application/octet-stream")]
		private const KingBowserData:Class;	public const SngKingBowser:Song = addSong( KingBowserData, -1, null, VOLUME ); 

		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBrosSnes/King Bowser (Hurry Up).spc", mimeType="application/octet-stream")]
		private const KingBowserFastData:Class;	public const SngKingBowserFast:Song = addSong( KingBowserFastData, -1, null, VOLUME ); 
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBrosSnes/Last Battle (Hurry Up).spc", mimeType="application/octet-stream")]
		private const LastBattleFastData:Class;	public const SngLastBattleFast:Song = addSong( LastBattleFastData, -1, null, VOLUME ); 
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBrosSnes/Last Battle.spc", mimeType="application/octet-stream")]
		private const LastBattleData:Class;		public const SngLastBattle:Song = addSong( LastBattleData, -1, null, VOLUME ); 
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBrosSnes/Going Underground.spc", mimeType="application/octet-stream")]
		private const IntroLevelData:Class;	public const SngIntroLevel:Song = addSong( IntroLevelData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBrosSnes/Game Over.spc", mimeType="application/octet-stream")]
		private const GameOverData:Class;	public const SngGameOver:Song = addSong( GameOverData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBrosSnes/Overworld.spc", mimeType="application/octet-stream")]
		private const OverworldData:Class;	public const SngOverworld:Song = addSong( OverworldData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBrosSnes/Overworld (Hurry Up).spc", mimeType="application/octet-stream")]
		private const OverworldFastData:Class;public const SngOverworldFast:Song = addSong( OverworldFastData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBrosSnes/Player Down.spc", mimeType="application/octet-stream")]
		private const DieData:Class;			public const SngDie:Song = addSong( DieData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBrosSnes/Swimming.spc", mimeType="application/octet-stream")]
		private const WaterData:Class;		public const SngWater:Song = addSong( WaterData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBrosSnes/Swimming (Hurry Up).spc", mimeType="application/octet-stream")]
		private const WaterFastData:Class;	public const SngWaterFast:Song = addSong( WaterFastData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBrosSnes/World Clear.spc", mimeType="application/octet-stream")]
		private const WinCastleData:Class;	public const SngWinCastle:Song = addSong( WinCastleData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBrosSnes/Underworld.spc", mimeType="application/octet-stream")]
		private const UnderGroundData:Class;	public const SngUnderGround:Song = addSong( UnderGroundData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBrosSnes/Title.spc", mimeType="application/octet-stream")]
		private const TitleData:Class;		public const SngTitle:Song = addSong( TitleData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBrosSnes/Underworld (Hurry Up).spc", mimeType="application/octet-stream")]
		private const UndergroundFastData:Class;	public const SngUndergroundFast:Song = addSong( UndergroundFastData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBrosSnes/Invincible.spc", mimeType="application/octet-stream")]
		private const Invincible:Class;		public const SngInvincible:Song = addSong( Invincible, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBrosSnes/Invincible (Hurry Up).spc", mimeType="application/octet-stream")]
		private const InvincibleFastData:Class;	public const SngInvincibleFast:Song = addSong( InvincibleFastData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBrosSnes/Ending.spc", mimeType="application/octet-stream")]
		private const EndingData:Class;	public const SngEnding:Song = addSong( EndingData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMarioBrosSnes/Time Up Warning.spc", mimeType="application/octet-stream")]
		private const TimeUpWarningData:Class;	public const SngTimeUpWarning:Song = addSong( TimeUpWarningData, -1, null, VOLUME );
		
		
		
		override protected function setUpLevelThemes():void
		{
			addToThemeInfoGeneral( TG_OVERWORLD_BIG_HILLS, LT_NORMAL, LT_INTRO );
			addToThemeInfoGeneral( TG_UNDERGROUND, LT_UNDER_GROUND );
			addToThemeInfoGeneral( TG_UNDERGROUND_BONUS, LT_PIPE_BONUS );
			addToThemeInfoGeneral( TG_COIN_HEAVEN, LT_COIN_HEAVEN );
			addToThemeInfoGeneral( TG_CASTLE, LT_CASTLE );
			addToThemeInfoGeneral( TG_WATER, LT_WATER );
			addToThemeInfoGeneral( TG_OVERWORLD_WATER_FALL, LT_PLATFORM );
			addToThemeInfoGeneral( TG_OVERWORLD_GOOMBA_STATUES, LT_CHEEP_CHEEP );
			
			addToThemeInfoWorld( 3, TG_COIN_HEAVEN_NIGHT, LT_COIN_HEAVEN );
			addToThemeInfoWorld( 3, TG_OVERWORLD_SNOW_NIGHT, LT_NORMAL );
			
			addToThemeInfoWorld( 4, TG_MUSHROOM_PLATFORMS, LT_PLATFORM );
			
			addToThemeInfoWorld( 5, TG_OVERWORLD_SNOW, LT_NORMAL );
			
			addToThemeInfoWorld( 6, TG_COIN_HEAVEN_NIGHT, LT_COIN_HEAVEN );
			addToThemeInfoWorld( 6, TG_OVERWORLD_NIGHT_WITH_TREES, LT_NORMAL );

			addToThemeInfoWorld( 7, TG_OVERWORLD_SNOW, LT_NORMAL );
			
			addToThemeInfoWorld( 8, TG_CASTLE_BOWSER, LT_CASTLE );
			addToThemeInfoWorld( 8, TG_CASTLE_WATER, LT_WATER );

			addToThemeInfoGeneral( TG_OVERWORLD_SMALL_GREEN_HILLS, "2-1a" );
			addToThemeInfoGeneral( TG_OVERWORLD_NIGHT_WITHOUT_TREES, "3-3a", "6-3a" );
			addToThemeInfoGeneral( TG_MUSHROOM_PLATFORMS_OVERWORLD, "4-1a", "4-2e" );
			addToThemeInfoGeneral( TG_COIN_HEAVEN_NIGHT, "6-2d" );
			addToThemeInfoGeneral( TG_OVERWORLD_BIG_HILLS, "7-2c" );
			addToThemeInfoGeneral( TG_OVERWORLD_SMALL_BROWN_HILLS,"8-2a" );
			addToThemeInfoGeneral( TG_OVERWORLD_CASTLE_WALLS,"8-3a" );
			
			themeMapPack = MapPack.Special;
			
			addToThemeInfoWorld( 4, TG_MUSHROOM_PLATFORMS_OVERWORLD, LT_NORMAL );
			addToThemeInfoWorld( 4, TG_COIN_HEAVEN, LT_COIN_HEAVEN );
			
			addToThemeInfoWorld( 8, TG_MUSHROOM_PLATFORMS, LT_PLATFORM );
			
			addToThemeInfoGeneral( TG_UNDERGROUND_SCENERY, "2-2c" );
			addToThemeInfoGeneral( TG_WATER_NIGHT, "3-1b", "6-2e" );
			addToThemeInfoGeneral( TG_MUSHROOM_PLATFORMS_OVERWORLD, "3-2b", "4-2a" );
			addToThemeInfoGeneral( TG_UNDERGROUND_WATER, "6-2c" );
			addToThemeInfoGeneral( TG_OVERWORLD_NIGHT_WITHOUT_TREES, "6-2d" );
			addToThemeInfoGeneral( TG_WATER, "8-2b" );
			addToThemeInfoGeneral( TG_OVERWORLD_CASTLE_WALLS, "8-2c" );
			addToThemeInfoGeneral( TG_OVERWORLD_SMALL_BROWN_HILLS, "8-3a", "8-3c" );
			
			themeMapPack = MapPack.LostLevels;
			
			addToThemeInfoWorld( 2, TG_OVERWORLD_NIGHT_WITH_TREES, LT_NORMAL );
			addToThemeInfoWorld( 2, TG_COIN_HEAVEN_NIGHT, LT_COIN_HEAVEN );
			addToThemeInfoWorld( 2, TG_OVERWORLD_NIGHT_WITHOUT_TREES, LT_CHEEP_CHEEP );
			
			addToThemeInfoWorld( 4, TG_MUSHROOM_PLATFORMS_OVERWORLD, LT_NORMAL );
			addToThemeInfoWorld( 4, TG_OVERWORLD_WATER_FALL, LT_PLATFORM );
			
			addToThemeInfoWorld( 6, TG_OVERWORLD_SMALL_GREEN_HILLS, LT_NORMAL );
			addToThemeInfoWorld( 6, TG_OVERWORLD_GOOMBA_STATUES, LT_CHEEP_CHEEP);
			
			addToThemeInfoWorld( 7, TG_OVERWORLD_NIGHT_WITH_TREES, LT_NORMAL );
			addToThemeInfoWorld( 7, TG_OVERWORLD_NIGHT_WITHOUT_TREES, LT_PLATFORM );
			
			addToThemeInfoWorld( 8, TG_CASTLE_BOWSER, LT_CASTLE );
			
			addToThemeInfoWorld( 9, TG_WATER_DARK_GROUND_BROWN, LT_WATER );
			
			addToThemeInfoWorld( 10, TG_CLOUDS_OVERWORLD, LT_NORMAL );
			
			addToThemeInfoWorld( 12, TG_OVERWORLD_NIGHT_WITHOUT_TREES, LT_CHEEP_CHEEP, LT_PLATFORM );
			
			addToThemeInfoWorld( 13, TG_OVERWORLD_SMALL_GREEN_HILLS, LT_NORMAL );
			addToThemeInfoWorld( 13, TG_CASTLE_BOWSER, LT_CASTLE );
			
			addToThemeInfoGeneral( TG_OVERWORLD_SNOW, "3-1a", "5-1a", "8-1c" );
			addToThemeInfoGeneral( TG_OVERWORLD_BIG_HILLS, "3-2c", "5-2d", "6-2c" );
			addToThemeInfoGeneral( TG_OVERWORLD_WATER_FALL, "3-3a", "5-2c" );
			addToThemeInfoGeneral( TG_OVERWORLD_SMALL_GREEN_HILLS, "8-1a" );
			addToThemeInfoGeneral( TG_WATER, "8-1b" );
			addToThemeInfoGeneral( TG_OVERWORLD_SMALL_BROWN_HILLS, "8-2a" );
			addToThemeInfoGeneral( TG_CLOUDS, "8-2b" );
			addToThemeInfoGeneral( TG_CLOUDS_BRIGHT, "8-3a" );
			addToThemeInfoGeneral( TG_CASTLE_WATER, "8-4b" );
			addToThemeInfoGeneral( TG_OVERWORLD_CASTLE, "9-3a" );
			addToThemeInfoGeneral( TG_WATER_DARK_GROUND_GREEN, "9-4a" );
			addToThemeInfoGeneral( TG_CLOUDS_GOOMBA_STATUES, "10-3a" );
			addToThemeInfoGeneral( TG_OVERWORLD_FOREST, "11-1a" );
			addToThemeInfoGeneral( TG_OVERWORLD_SKY, "11-4b" );
			addToThemeInfoGeneral( TG_OVERWORLD_SNOW_NIGHT, "12-1a" );
			addToThemeInfoGeneral( TG_OVERWORLD_CASTLE_WALLS, "13-3a" );
			addToThemeInfoGeneral( TG_OVERWORLD_FOREST, "13-4b" );
		}
		override protected function createPlayList():void
		{
			addToTypePlayList(LT_CASTLE, SngCastle);
			addToTypePlayList(LT_CHEEP_CHEEP, SngOverworld);
			addToTypePlayList(LT_COIN_HEAVEN, SngBonus);
			addToTypePlayList(LT_INTRO, SngIntroLevel);
			addToTypePlayList(LT_NORMAL, SngOverworld);
			addToTypePlayList(LT_PIPE_BONUS, SngBonus);
			addToTypePlayList(LT_PLATFORM, SngOverworld);
			addToTypePlayList(LT_UNDER_GROUND, SngUnderGround);
			addToTypePlayList(LT_WATER, SngWater);
			addToTypePlayList(MT_DARK_EPIC, SngOverworld);
			
			addToTypePlayList(BOSS, SngKingBowser);
			addToTypePlayList(CHAR_SEL, SngGameSelect);
			addToTypePlayList(CHOOSE_CHARACTER, SngIntroLevel);
			addToTypePlayList(CREDITS, SngEnding);
			addToTypePlayList(DIE, SngDie);
			addToTypePlayList(FINAL_BOSS, SngLastBattle);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, SngOverworldFast);
//			addToTypePlayList(LAKITU, null);			
			addToTypePlayList(STAR, SngInvincible);
			addToTypePlayList(TITLE_SCREEN, SngTitle);
			addToTypePlayList(WIN, SngCourseClear);
			addToTypePlayList(WIN_CASTLE, SngWinCastle);
			
			addHurryVersionOfSong( SngKingBowser, SngKingBowserFast);
			addHurryVersionOfSong( SngLastBattle, SngLastBattleFast);
			addHurryVersionOfSong( SngBonus, SngBonusFast);
			addHurryVersionOfSong( SngInvincible, SngInvincibleFast);
			addHurryVersionOfSong( SngCastle, SngCastleFast);
			addHurryVersionOfSong( SngOverworld, SngOverworldFast);
			addHurryVersionOfSong( SngUnderGround, SngUndergroundFast);
			addHurryVersionOfSong( SngWater, SngWaterFast);
			
			addToThemePlayList( TG_CASTLE_WATER, SngCastle, [ LT_WATER ] );
		}
	}
}