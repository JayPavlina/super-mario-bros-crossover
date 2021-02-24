package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameNinjaGaidenSms extends Game
	{
		private static var instance:Game; 
		
		public function GameNinjaGaidenSms(gameNum:int, skinSetNum:int = -1)
		{
			super("Ninja Gaiden (Sega Master System)", "Tecmo", Consoles.segaMasterSystem, gameNum, "Ninja Gaiden (SMS)", skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/kss/NinjaGaidenSms.kss", mimeType="application/octet-stream")]
		public const Kss:Class;
		private const VOLUME:int = 30;
		
		public const SngTitle:Song = addSong( Kss, 1, null, VOLUME );
		public const SngIntroduction:Song = addSong( Kss, 2, null, VOLUME );
		public const SngLevelStart:Song = addSong( Kss, 3, null, VOLUME );
		public const SngStory:Song = addSong( Kss, 4, null, VOLUME );
		public const SngLevel1Forest:Song = addSong( Kss, 5, null, VOLUME );
		public const SngLevel2Tokyo:Song = addSong( Kss, 6, null, VOLUME );
		public const SngLevel3Samurai:Song = addSong( Kss, 7, null, VOLUME );
		public const SngLevel4Rescue:Song = addSong( Kss, 8, null, VOLUME );
		public const SngLevel5EnemyLand:Song = addSong( Kss, 9, null, VOLUME );
		public const SngLevel6Raid:Song = addSong( Kss, 10, null, VOLUME );
		public const SngLevel7Overcome:Song = addSong( Kss, 11, null, VOLUME );
		public const SngFinalBossDecisive:Song = addSong( Kss, 12, null, VOLUME );
		public const SngBossBattle:Song = addSong( Kss, 13, null, VOLUME );
		public const SngContinue:Song = addSong( Kss, 14, null, VOLUME );
		public const SngGameOver:Song = addSong( Kss, 15, null, VOLUME );
		public const SngCredits:Song = addSong( Kss, 16, null, VOLUME );
		public const SngDeath:Song = addSong( Kss, 17, null, VOLUME );
		
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngLevel7Overcome);
			addToTypePlayList(LT_CHEEP_CHEEP, SngLevel6Raid);
			addToTypePlayList(LT_COIN_HEAVEN, SngLevel2Tokyo);
			addToTypePlayList(LT_INTRO, SngIntroduction);
			addToTypePlayList(LT_NORMAL, SngLevel1Forest);
			addToTypePlayList(LT_PIPE_BONUS, SngLevel3Samurai);
			addToTypePlayList(LT_PLATFORM, SngLevel6Raid);
			addToTypePlayList(LT_UNDER_GROUND, SngLevel3Samurai);
			addToTypePlayList(LT_WATER, SngLevel4Rescue);
			addToTypePlayList(MT_DARK_EPIC, SngLevel5EnemyLand);
			
			addToTypePlayList(BOSS, SngBossBattle);
			addToTypePlayList(CHAR_SEL, SngStory);
			addToTypePlayList(CHOOSE_CHARACTER, SngLevelStart);
			addToTypePlayList(CREDITS, SngCredits);
			addToTypePlayList(DIE, SngDeath);
			addToTypePlayList(FINAL_BOSS, SngFinalBossDecisive);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, SngFinalBossDecisive);
			addToTypePlayList(STAR, null);
			addToTypePlayList(TITLE_SCREEN, SngTitle);
			addToTypePlayList(WIN, SngGameOver);
			addToTypePlayList(WIN_CASTLE, SngCredits);
			
		}
	}
}