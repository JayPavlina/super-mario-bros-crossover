package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameOperationC extends Game
	{
		private static var instance:Game; 
		
		public function GameOperationC(gameNum:int, skinSetNum:int = -1)
		{
			super("Operation C", "Konami", Consoles.gameBoy, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/gbs/OperationC.gbs", mimeType="application/octet-stream")]
		public const Gbs:Class;
		private const VOLUME:int = 50;
		
		public const SngTitle:Song = addSong( Gbs, 1, null, VOLUME );
		public const SngJungle:Song = addSong( Gbs, 2, null, VOLUME );
		public const SngStage2:Song = addSong( Gbs, 3, null, VOLUME );
		public const SngWaterfall:Song = addSong( Gbs, 4, null, VOLUME );
		public const SngWaterfallNoIntro:Song = addSong( Gbs, 5, null, VOLUME );
		public const SngSnowField:Song = addSong( Gbs, 6, null, VOLUME );
		public const SngEnergyZone:Song = addSong( Gbs, 7, null, VOLUME );
		public const SngGameOver:Song = addSong( Gbs, 8, null, VOLUME );
		public const SngVictory:Song = addSong( Gbs, 9, null, VOLUME );
		public const SngVictoryBeatGame:Song = addSong( Gbs, 10, null, VOLUME );
		public const SngBossBattle:Song = addSong( Gbs, 11, null, VOLUME );
		public const SngBossMinor:Song = addSong( Gbs, 12, null, VOLUME );
		public const SngEnding:Song = addSong( Gbs, 13, null, VOLUME );
		public const SngAlienLairFinalBoss:Song = addSong( Gbs, 14, null, VOLUME );
		
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngAlienLairFinalBoss);
			addToTypePlayList(LT_CHEEP_CHEEP, SngStage2);
			addToTypePlayList(LT_COIN_HEAVEN, SngWaterfall);
			addToTypePlayList(LT_INTRO, SngBossMinor);
			addToTypePlayList(LT_NORMAL, SngJungle);
			addToTypePlayList(LT_PIPE_BONUS, SngEnergyZone);
			addToTypePlayList(LT_PLATFORM, SngStage2);
			addToTypePlayList(LT_UNDER_GROUND, SngEnergyZone);
			addToTypePlayList(LT_WATER, SngWaterfall);
			addToTypePlayList(MT_DARK_EPIC, SngSnowField);
			
			addToTypePlayList(BOSS, SngBossBattle);
			addToTypePlayList(CHAR_SEL, SngTitle);
			addToTypePlayList(CHOOSE_CHARACTER, SngGameOver);
			addToTypePlayList(CREDITS, SngEnding);
			addToTypePlayList(DIE, null);
			addToTypePlayList(FINAL_BOSS, SngBossBattle);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, SngBossMinor);
			addToTypePlayList(STAR, null);
			addToTypePlayList(TITLE_SCREEN, SngJungle);
			addToTypePlayList(WIN, SngVictory);
			addToTypePlayList(WIN_CASTLE, SngVictoryBeatGame);
			
		}
	}
}