package com.explodingRabbit.cross.games
{
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameGradius2 extends Game
	{
		private static var instance:Game; 
		
		public function GameGradius2(gameNum:int, skinSetNum:int = -1)
		{
			super("Gradius II", "Konami", Consoles.nintendo, gameNum, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		[Embed(source="../../../../../assets/audio/seq/nsf/Gradius2.nsfe", mimeType="application/octet-stream")]
		public const Nsfe:Class;
		
		private const VOLUME:int = 65; 
		
		public const SngPowerMeterSelect:Song = addSong( Nsfe, 1, null, VOLUME );
		public const SngStageInterlude:Song = addSong( Nsfe, 2, null, VOLUME );
		public const SngBoss:Song = addSong( Nsfe, 3, null, VOLUME );
		public const SngStage1:Song = addSong( Nsfe, 4, null, VOLUME );
		public const SngStage2:Song = addSong( Nsfe, 5, null, VOLUME );
		public const SngStage3a:Song = addSong( Nsfe, 6, null, VOLUME );
		public const SngStage3b:Song = addSong( Nsfe, 7, null, VOLUME );
		public const SngStage4:Song = addSong( Nsfe, 8, null, VOLUME );
		public const SngStage5a:Song = addSong( Nsfe, 9, null, VOLUME );
		public const SngStage5b:Song = addSong( Nsfe, 10, null, VOLUME );
		public const SngStage6:Song = addSong( Nsfe, 11, null, VOLUME );
		public const SngStage7:Song = addSong( Nsfe, 12, null, VOLUME );
		public const SngFinalBoss:Song = addSong( Nsfe, 13, null, VOLUME );
		public const SngCredits:Song = addSong( Nsfe, 14, null, VOLUME );
		public const SngGameOver:Song = addSong( Nsfe, 15, null, VOLUME );
		public const SngPlaySelect:Song = addSong( Nsfe, 17, null, VOLUME );

		override protected function setUpLevelThemes():void
		{
			
		}
		override protected function createPlayList():void
		{
//			addOverridableMusicTypes(LT_NORMAL);
//			
//			addToTypePlayList(LT_CASTLE, SngStage7);
//			addToTypePlayList(LT_CHEEP_CHEEP, SngStage6);
//			addToTypePlayList(LT_COIN_HEAVEN, SngStage5a);
//			addToTypePlayList(LT_INTRO, SngStageInterlude);
//			addToTypePlayList(LT_NORMAL, SngStage1);
//			addToTypePlayList(LT_PIPE_BONUS, SngStage5a);
//			addToTypePlayList(LT_PLATFORM, SngStage3a);
//			addToTypePlayList(LT_UNDER_GROUND, SngStage4);
//			addToTypePlayList(LT_WATER, SngStage3b);
//			addToTypePlayList(MT_DARK_EPIC, SngStage2);
//			
//			addToTypePlayList(BOSS, SngBoss);
//			addToTypePlayList(CHAR_SEL, SngPowerMeterSelect);
//			addToTypePlayList(CHOOSE_CHARACTER, SngPlaySelect);
//			addToTypePlayList(CREDITS, SngCredits);
//			addToTypePlayList(DIE, null);
//			addToTypePlayList(FINAL_BOSS, SngFinalBoss);
//			addToTypePlayList(GAME_OVER, SngGameOver);
//			addToTypePlayList(HURRY, null);
//			addToTypePlayList(STAR, SngStage5a);
//			addToTypePlayList(TITLE_SCREEN, null);
//			addToTypePlayList(WIN, null);
//			addToTypePlayList(WIN_CASTLE, null);
			
		}
	}
}