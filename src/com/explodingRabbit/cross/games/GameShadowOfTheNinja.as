package com.explodingRabbit.cross.games
{
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameShadowOfTheNinja extends Game
	{
		private static var instance:Game; 
		
		public function GameShadowOfTheNinja(gameNum:int, skinSetNum:int = -1)
		{
			super("Shadow of the Ninja", "Natsume", Consoles.nintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		[Embed(source="../../../../../assets/audio/seq/nsf/ShadowOfTheNinja.nsf", mimeType="application/octet-stream")]
		public const Nsf:Class;
		
		private const VOLUME:int = 65; 
		
		public const SngIntro:Song = addSong( Nsf, 1, null, VOLUME );
		public const SngStageIntro:Song = addSong( Nsf, 2, null, VOLUME );
		public const SngStage1:Song = addSong( Nsf, 3, null, VOLUME );
		public const SngStage2:Song = addSong( Nsf, 4, null, VOLUME );
		public const SngStage3:Song = addSong( Nsf, 5, null, VOLUME );
		public const SngStage4:Song = addSong( Nsf, 6, null, VOLUME );
		public const SngStage5:Song = addSong( Nsf, 7, null, VOLUME );
		public const SngBoss:Song = addSong( Nsf, 8, null, VOLUME );
		public const SngStageClear:Song = addSong( Nsf, 9, null, VOLUME );
		public const SngGameOver:Song = addSong( Nsf, 10, null, VOLUME );
		public const SngEnding:Song = addSong( Nsf, 11, null, VOLUME );
		public const SngFinalBoss:Song = addSong( Nsf, 12, null, VOLUME );

		override protected function setUpLevelThemes():void
		{
			
		}
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngStage5);
			addToTypePlayList(LT_CHEEP_CHEEP, SngStage4);
			addToTypePlayList(LT_COIN_HEAVEN, SngStage2);
			addToTypePlayList(LT_INTRO, SngStage2);
			addToTypePlayList(LT_NORMAL, SngStage1);
			addToTypePlayList(LT_PIPE_BONUS, SngStage3);
			addToTypePlayList(LT_PLATFORM, SngStage2);
			addToTypePlayList(LT_UNDER_GROUND, SngStage3);
			addToTypePlayList(LT_WATER, SngStage4);
			addToTypePlayList(MT_DARK_EPIC, SngStage5);
			
			addToTypePlayList(BOSS, SngBoss);
			addToTypePlayList(CHAR_SEL, SngStage1);
			addToTypePlayList(CHOOSE_CHARACTER, SngStageIntro);
			addToTypePlayList(CREDITS, SngEnding);
			addToTypePlayList(DIE, Games.ninjaGaiden.SngGameOver);
			addToTypePlayList(FINAL_BOSS, SngFinalBoss);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, Games.ninjaGaiden.SngSwiftNinjaCutscene);
			addToTypePlayList(STAR, null);
			addToTypePlayList(TITLE_SCREEN, SngStage1);
			addToTypePlayList(WIN, SngStageClear);
			addToTypePlayList(WIN_CASTLE, SngStageClear);
		}
	}
}