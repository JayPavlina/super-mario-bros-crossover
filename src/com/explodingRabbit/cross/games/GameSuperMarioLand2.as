package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.MapPack;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameSuperMarioLand2 extends Game
	{
		private static var instance:Game;
		public static const NUM_WORLDS:int = 8;
		public function GameSuperMarioLand2(gameNum:int, skinSetNum:int)
		{
			super("Super Mario Land 2: 6 Golden Coins", "Nintendo", Consoles.gameBoy, gameNum, "Super Mario Land 2", skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/gbs/SuperMarioLand2.gbs", mimeType="application/octet-stream")]
		public const Gbs:Class;
		
		private const TG_OVERWORLD:ThemeGroup = addThemeGroup( 1, 1 );
		private const TG_OVERWORLD_TREES:ThemeGroup = addThemeGroup( 1, 2 );
		private const TG_OVERWORLD_NIGHT:ThemeGroup = addThemeGroup( 1, 3, MT_DARK_EPIC );
		private const TG_OVERWORLD_NIGHT_FENCE:ThemeGroup = addThemeGroup( 1, 4, MT_DARK_EPIC );
		private const TG_UNDERGROUND:ThemeGroup = addThemeGroup( 2, 1 );
		private const TG_WARIO_CASTLE:ThemeGroup = addThemeGroup( 3, 1 );
		private const TG_WARIO_CASTLE_WATER:ThemeGroup = addThemeGroup( 3, 2 );
		private const TG_WATER:ThemeGroup = addThemeGroup( 4, 1 );
		private const TG_JUNGLE:ThemeGroup = addThemeGroup( 5, 1 );
		private const TG_MOON:ThemeGroup = addThemeGroup( 6, 1, MT_DARK_EPIC );
		private const TG_GHOST_HOUSE:ThemeGroup = addThemeGroup( 7, 1, MT_DARK_EPIC );
		private const TG_BEE_HIVE:ThemeGroup = addThemeGroup( 8, 1 );
		private const TG_LIBRARY:ThemeGroup = addThemeGroup( 9, 1 );
		private const TG_CASTLE:ThemeGroup = addThemeGroup( 10, 1 );
		private const TG_SUB:ThemeGroup = addThemeGroup( 11, 1 );
		private const TG_CHECKER_BOARD:ThemeGroup = addThemeGroup( 12, 1 );
		
		private const VOLUME:int = 60;
		public const SngAthletic:Song = addSong( Gbs, 1, null, VOLUME );
		public const SngDie:Song = addSong( Gbs, 2, null, VOLUME );
		public const SngLevelClear:Song = addSong( Gbs, 3, null, VOLUME );
		public const SngInvincible:Song = addSong( Gbs, 4, null, VOLUME );
		public const SngMacroZone:Song = addSong( Gbs, 5, null, VOLUME );
		public const SngOverworldMap:Song = addSong( Gbs, 6, null, VOLUME );
		public const SngGameOver:Song = addSong( Gbs, 7, null, VOLUME );
		public const SngBonusAttempted:Song = addSong( Gbs, 8, null, VOLUME );
		public const SngTimeRunningOut:Song = addSong( Gbs, 9, null, VOLUME );
		public const SngWarioCastle:Song = addSong( Gbs, 11, null, VOLUME );
		public const SngBossDefeated:Song = addSong( Gbs, 12, null, VOLUME );
		public const SngFileSelect:Song = addSong( Gbs, 13, null, VOLUME + 20 );
		public const SngCastleGates:Song = addSong( Gbs, 14, null, VOLUME );
		public const SngUnknown:Song = addSong( Gbs, 15, null, VOLUME );
		public const SngTreeZone:Song = addSong( Gbs, 16, null, VOLUME );
		public const SngGraveyard:Song = addSong( Gbs, 17, null, VOLUME );
		public const SngUnknown2:Song = addSong( Gbs, 18, null, VOLUME );
		public const SngMoon:Song = addSong( Gbs, 19, null, VOLUME );
		public const SngTreeTop:Song = addSong( Gbs, 20, null, VOLUME );
		public const SngBonusChance:Song = addSong( Gbs, 21, null, VOLUME );
		public const SngBonusComplete:Song = addSong( Gbs, 22, null, VOLUME );
		public const SngSeaShore:Song = addSong( Gbs, 23, null, VOLUME );
		public const SngWarioDefeated:Song = addSong( Gbs, 24, null, VOLUME );
		public const SngCredits:Song = addSong( Gbs, 24, null, VOLUME, 45 );
		public const SngUknownSelection:Song = addSong( Gbs, 25, null, VOLUME );
		public const SngUnknownLevelIntro:Song = addSong( Gbs, 26, null, VOLUME );
		public const SngMarioZone:Song = addSong( Gbs, 27, null, VOLUME );
		public const SngSpaceZone:Song = addSong( Gbs, 28, null, VOLUME );
		public const SngStarMaze:Song = addSong( Gbs, 29, null, VOLUME );
		public const SngPumpkinZone:Song = addSong( Gbs, 30, null, VOLUME );
		public const SngHauntedHouse:Song = addSong( Gbs, 31, null, VOLUME );
		public const SngBossBattle:Song = addSong( Gbs, 32, null, VOLUME );
		public const SngWarioBattle:Song = addSong( Gbs, 33, null, VOLUME );
		public const SngWarioBattle2:Song = addSong( Gbs, 34, null, VOLUME );
		public const SngWarioBattle3:Song = addSong( Gbs, 35, null, VOLUME );
		public const SngBossBattleNoIntro:Song = addSong( Gbs, 36, null, VOLUME );
		public const SngWarioBattleNoIntro:Song = addSong( Gbs, 37, null, VOLUME );
		public const SngWarioBattle2NoIntro:Song = addSong( Gbs, 38, null, VOLUME );
		public const SngWarioBattle3NoIntro:Song = addSong( Gbs, 39, null, VOLUME );
		public const SngMachine:Song = addSong( Gbs, 40, null, VOLUME );
		public const SngLevelStart:Song = addSong( Gbs, 61, null, VOLUME );
		
		override protected function setUpLevelThemes():void
		{
			addToThemeInfoGeneral( TG_OVERWORLD, LT_NORMAL, LT_INTRO, LT_PLATFORM, LT_CHEEP_CHEEP );
			addToThemeInfoGeneral( TG_UNDERGROUND, LT_UNDER_GROUND );
			addToThemeInfoGeneral( TG_CHECKER_BOARD, LT_COIN_HEAVEN, LT_PIPE_BONUS );
			addToThemeInfoGeneral( TG_CASTLE, LT_CASTLE );
			addToThemeInfoGeneral( TG_WATER, LT_WATER );
			
			addToThemeInfoWorld( 1, TG_OVERWORLD_TREES, LT_PLATFORM );
			addToThemeInfoWorld( 2, TG_LIBRARY, LT_NORMAL, LT_INTRO, LT_CHEEP_CHEEP, LT_PLATFORM );
			addToThemeInfoWorld( 3, TG_GHOST_HOUSE, LT_NORMAL, LT_INTRO, LT_CHEEP_CHEEP, LT_PLATFORM );
			addToThemeInfoWorld( 4, TG_OVERWORLD_NIGHT, LT_NORMAL, LT_INTRO, LT_CHEEP_CHEEP );
			addToThemeInfoWorld( 4, TG_OVERWORLD_NIGHT_FENCE, LT_PLATFORM );
			addToThemeInfoWorld( 5, TG_JUNGLE, LT_NORMAL, LT_INTRO, LT_CHEEP_CHEEP, LT_PLATFORM );
			addToThemeInfoWorld( 6, TG_SUB, LT_NORMAL, LT_INTRO, LT_CHEEP_CHEEP, LT_PLATFORM );
			addToThemeInfoWorld( 7, TG_BEE_HIVE, LT_NORMAL, LT_INTRO, LT_CHEEP_CHEEP, LT_PLATFORM );
			addToThemeInfoWorld( 8, TG_MOON, LT_NORMAL, LT_PLATFORM );
			addToThemeInfoWorld( 8, TG_WARIO_CASTLE, LT_CASTLE );
			addToThemeInfoWorld( 8, TG_WARIO_CASTLE_WATER, LT_WATER );
			
			themeMapPack = MapPack.Special;
			
			addToThemeInfoGeneral( TG_WATER, "8-2b" );
			
			themeMapPack = MapPack.LostLevels;
			
			addToThemeInfoWorld( 2, TG_OVERWORLD_NIGHT, LT_NORMAL );
			addToThemeInfoWorld( 2, TG_OVERWORLD_NIGHT_FENCE, LT_CHEEP_CHEEP );
			
			addToThemeInfoWorld( 3, TG_LIBRARY, LT_NORMAL, LT_INTRO, LT_PLATFORM );
			
			addToThemeInfoWorld( 4, TG_GHOST_HOUSE, LT_NORMAL, LT_PLATFORM );
			
			addToThemeInfoWorld( 5, TG_JUNGLE, LT_NORMAL, LT_INTRO, LT_PLATFORM );
			
			addToThemeInfoWorld( 6, TG_SUB, LT_NORMAL, LT_INTRO, LT_CHEEP_CHEEP );
			
			addToThemeInfoWorld( 7, TG_BEE_HIVE, LT_NORMAL, LT_PLATFORM );
			
			addToThemeInfoWorld( 8, TG_MOON, LT_NORMAL, LT_PLATFORM );
			
			addToThemeInfoWorld( 9, TG_SUB, LT_NORMAL, LT_CASTLE );
			
			addToThemeInfoWorld( 10, TG_BEE_HIVE, LT_NORMAL, LT_INTRO, LT_PLATFORM );
			
			addToThemeInfoWorld( 12, TG_GHOST_HOUSE, LT_NORMAL, LT_CHEEP_CHEEP, LT_PLATFORM );
			
			addToThemeInfoWorld( 13, TG_MOON, LT_NORMAL );
			addToThemeInfoWorld( 13, TG_WARIO_CASTLE, LT_CASTLE );
			
			addToThemeInfoGeneral( TG_WATER, "8-1b" );
			addToThemeInfoGeneral( TG_WARIO_CASTLE_WATER, "8-4b" );
		}
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngWarioCastle);
			addToTypePlayList(LT_CHEEP_CHEEP, SngTreeTop);
			addToTypePlayList(LT_COIN_HEAVEN, SngMoon);
			addToTypePlayList(LT_INTRO, SngOverworldMap);
			addToTypePlayList(LT_NORMAL, SngAthletic);
			addToTypePlayList(LT_PIPE_BONUS, SngMachine);
			addToTypePlayList(LT_PLATFORM, SngTreeTop);
			addToTypePlayList(LT_UNDER_GROUND, SngHauntedHouse);
			addToTypePlayList(LT_WATER, SngSeaShore);
			addToTypePlayList(MT_DARK_EPIC, SngStarMaze);
			
			addToTypePlayList(BOSS, SngBossBattle);
			addToTypePlayList(CHAR_SEL, SngFileSelect);
			addToTypePlayList(CHOOSE_CHARACTER, SngLevelStart);
			addToTypePlayList(CREDITS, SngCredits);
			addToTypePlayList(DIE, SngDie);
			addToTypePlayList(FINAL_BOSS, SngWarioBattle);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, SngWarioBattle2NoIntro);	
			addToTypePlayList(STAR, SngInvincible);
			addToTypePlayList(TITLE_SCREEN, SngAthletic);
			addToTypePlayList(WIN, SngLevelClear);
			addToTypePlayList(WIN_CASTLE, SngBossDefeated);
			
//			addToTypePlayList(LT_CASTLE, SngWarioCastle);
//			addToTypePlayList(LT_CHEEP_CHEEP, SngTreeTop);
//			addToTypePlayList(LT_COIN_HEAVEN, SngSeaShore);
//			addToTypePlayList(LT_INTRO, SngOverworldMap);
//			addToTypePlayList(LT_NORMAL, SngAthletic);
//			addToTypePlayList(LT_PIPE_BONUS, SngMachine);
//			addToTypePlayList(LT_PLATFORM, SngTreeTop);
//			addToTypePlayList(LT_UNDER_GROUND, SngGraveyard);
//			addToTypePlayList(LT_WATER, SngMoon);
//			addToTypePlayList(MT_DARK_EPIC, SngStarMaze);
			
			addToThemePlayList( TG_GHOST_HOUSE, SngGraveyard, [ LT_NORMAL, LT_PLATFORM ] );
			addToThemePlayList( TG_OVERWORLD_NIGHT, SngStarMaze, [ LT_NORMAL, LT_PLATFORM ] );
			addToThemePlayList( TG_OVERWORLD_NIGHT_FENCE, SngStarMaze, [ LT_NORMAL, LT_PLATFORM ] );
			addToThemePlayList( TG_MOON, SngStarMaze, [ LT_NORMAL, LT_PLATFORM ] );
			addToThemePlayList( TG_LIBRARY, SngSeaShore, [ LT_NORMAL ] );
			addToThemePlayList( TG_SUB, SngSeaShore, [ LT_NORMAL ] );
			addToThemePlayList( TG_WARIO_CASTLE_WATER, SngWarioCastle, [ LT_WATER ] );
//			addToThemePlayList( TG_PIPES, SngUnderGround, [ LT_NORMAL, LT_PLATFORM ] );
//			addToThemePlayList( TG_OVERWORLD_NIGHT, SngUnderGround, [ LT_NORMAL, LT_PLATFORM ] );
//			addToThemePlayList( TG_GRASS_NIGHT, SngUnderGround, [ LT_NORMAL, LT_PLATFORM ] );
		}
	}
}