package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameZeldaOracleOfSeasons extends Game
	{
		private static var instance:Game; 
		
		public function GameZeldaOracleOfSeasons(gameNum:int, skinSetNum:int = -1)
		{
			super("The Legend of Zelda: Oracle of Seasons", "Nintendo", Consoles.gameBoy, gameNum, "LoZ: Oracle of Seasons", skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/gbs/ZeldaOracleOfSeasons.gbs", mimeType="application/octet-stream")]
		public const Gbs:Class;
		
		private const VOLUME:int = 70; 
		
		public const SngTitle:Song = addSong( Gbs, 1, null, VOLUME );
		public const SngOverworld:Song = addSong( Gbs, 3, null, VOLUME );
		public const SngLostWoods:Song = addSong( Gbs, 5, null, VOLUME );
		public const SngWinLevel:Song = addSong( Gbs, 6, null, VOLUME );
		public const SngPlatform:Song = addSong( Gbs, 7, null, VOLUME );
		public const SngGameOver:Song = addSong( Gbs, 9, null, VOLUME );
		public const SngFileSelect:Song = addSong( Gbs, 17, null, VOLUME );
		public const SngHerosCave:Song = addSong( Gbs, 18, null, VOLUME );
		public const SngDungeon:Song = addSong( Gbs, 19, null, VOLUME );
		public const SngCastle:Song = addSong( Gbs, 26, null, VOLUME );
		public const SngMarch:Song = addSong( Gbs, 32, null, VOLUME );
		public const SngSneak:Song = addSong( Gbs, 38, null, VOLUME );
		public const SngCredits:Song = addSong( Gbs, 40, null, VOLUME );
		public const SngHurry:Song = addSong( Gbs, 43, null, VOLUME );
		public const SngBoss:Song = addSong( Gbs, 44, null, VOLUME );
		public const SngFinalBoss:Song = addSong( Gbs, 45, null, VOLUME );
		public const SngWinCastle:Song = addSong( Gbs, 59, null, VOLUME );
		public const SngSolveTune:Song = addSong( Gbs, 77, null, VOLUME );
		public const SngDie:Song = addSong( Gbs, 86, null, VOLUME );
		public const SngFlute:Song = addSong( Gbs, 144, null, VOLUME );
		
		override protected function setUpLevelThemes():void
		{
			
		}
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL); // song types that will switch to DARK_EPIC song if the theme is dark
			
			addToTypePlayList(LT_CASTLE, SngCastle); //82
			addToTypePlayList(LT_CHEEP_CHEEP, SngPlatform); //
			addToTypePlayList(LT_COIN_HEAVEN, SngSneak); //96
			addToTypePlayList(LT_INTRO, SngSolveTune); //99
			addToTypePlayList(LT_NORMAL, SngOverworld); //5
			addToTypePlayList(LT_PIPE_BONUS, SngHerosCave); //11
			addToTypePlayList(LT_PLATFORM, SngPlatform); //9
			addToTypePlayList(LT_UNDER_GROUND, SngDungeon); //38
			addToTypePlayList(LT_WATER, SngLostWoods); //29
			addToTypePlayList(MT_DARK_EPIC, SngMarch); //6
			
			addToTypePlayList(BOSS, SngBoss); //25
			addToTypePlayList(CHAR_SEL, SngFileSelect); //17
			addToTypePlayList(CHOOSE_CHARACTER, SngFlute); //170
			addToTypePlayList(CREDITS, SngCredits); //61
			addToTypePlayList(DIE, SngDie); //169
			addToTypePlayList(FINAL_BOSS, SngFinalBoss); //35
			addToTypePlayList(GAME_OVER, SngGameOver); //3
			addToTypePlayList(HURRY, SngHurry); //62
			addToTypePlayList(STAR, Games.zeldaLinksAwakening.SngAdrenaline); //73
			addToTypePlayList(TITLE_SCREEN, SngTitle); //1
			addToTypePlayList(WIN, SngWinLevel); //27
			addToTypePlayList(WIN_CASTLE, SngWinCastle); //27
		}
	}
}