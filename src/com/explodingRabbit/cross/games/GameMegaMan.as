package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameMegaMan extends Game
	{
		private static var instance:Game; 
		
		public function GameMegaMan(gameNum:int, skinSetNum:int = -1)
		{
			super("Mega Man", "Capcom", Consoles.nintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/nsf/MegaMan.nsf", mimeType="application/octet-stream")]
		public const Nsf:Class;
		
		private const VOLUME:int = 55;
		
		public const SngWilyDefeated:Song = addSong( Nsf, 1, null, VOLUME );
		public const SngLevelSelect:Song = addSong( Nsf, 2, null, VOLUME );
		public const SngEnemyChosen:Song = addSong( Nsf, 3, null, VOLUME );
		public const SngGameOver:Song = addSong( Nsf, 4, null, VOLUME );
		public const SngVictory:Song = addSong( Nsf, 5, null, VOLUME );
		public const SngCutMan:Song = addSong( Nsf, 6, null, VOLUME );
		public const SngFireMan:Song = addSong( Nsf, 7, null, VOLUME );
		public const SngBombMan:Song = addSong( Nsf, 9, null, VOLUME );
		public const SngElecMan:Song = addSong( Nsf, 10, null, VOLUME );
		public const SngGutsMan:Song = addSong( Nsf, 11, null, VOLUME );
		public const SngFinalBoss:Song = addSong( Nsf, 12, null, VOLUME );
		public const SngWilyCastle:Song = addSong( Nsf, 13, null, VOLUME );
		public const SngBossBattle:Song = addSong( Nsf, 14, null, VOLUME );
		public const SngEnding:Song = addSong( Nsf, 15, null, VOLUME );
		public const SngIceMan:Song = addSong( Nsf, 16, null, VOLUME );
		public const SngWilyCastle2:Song = addSong( Nsf, 17, null, VOLUME );

		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngWilyCastle2);
			addToTypePlayList(LT_CHEEP_CHEEP, SngGutsMan);
			addToTypePlayList(LT_COIN_HEAVEN, SngCutMan);
			addToTypePlayList(LT_INTRO, SngLevelSelect);
			addToTypePlayList(LT_NORMAL, SngElecMan);
			addToTypePlayList(LT_PIPE_BONUS, SngFireMan);
			addToTypePlayList(LT_PLATFORM, SngBombMan);
			addToTypePlayList(LT_UNDER_GROUND, SngFireMan);
			addToTypePlayList(LT_WATER, SngIceMan);
			addToTypePlayList(MT_DARK_EPIC, SngWilyCastle);
			
			addToTypePlayList(BOSS, SngBossBattle);
			addToTypePlayList(CHAR_SEL, SngLevelSelect);
			addToTypePlayList(CHOOSE_CHARACTER, SngEnemyChosen);
			addToTypePlayList(CREDITS, SngEnding);
			addToTypePlayList(DIE, null);
			addToTypePlayList(FINAL_BOSS, SngFinalBoss);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, SngFinalBoss);
			addToTypePlayList(STAR, Games.megaMan2.SngTitleScreen);
			addToTypePlayList(TITLE_SCREEN, SngElecMan);
			addToTypePlayList(WIN, SngVictory);
			addToTypePlayList(WIN_CASTLE, SngWilyDefeated);
		}
	}
}