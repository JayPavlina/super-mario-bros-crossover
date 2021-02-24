package com.explodingRabbit.cross.games
{
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameKrionConquest extends Game
	{
		private static var instance:Game; 
		
		public function GameKrionConquest(gameNum:int, skinSetNum:int = -1)
		{
			super("The Krion Conquest", "Vic Tokai", Consoles.nintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/nsf/KrionConquest.nsf", mimeType="application/octet-stream")]
		public const Nsf:Class;
		
		private const VOLUME:int = 55;
		
		public const SngIntro2:Song = addSong( Nsf, 1, null, VOLUME );
		public const SngTitle:Song = addSong( Nsf, 2, null, VOLUME );
		public const SngPipeIntro:Song = addSong( Nsf, 3, null, VOLUME );
		public const SngStage2:Song = addSong( Nsf, 4, null, VOLUME );
		public const SngStage1:Song = addSong( Nsf, 5, null, VOLUME );
		public const SngStage3:Song = addSong( Nsf, 6, null, VOLUME );
		public const SngStage4:Song = addSong( Nsf, 7, null, VOLUME );
		public const SngBossTheme2:Song = addSong( Nsf, 9, null, VOLUME );
		public const SngBossTheme3:Song = addSong( Nsf, 10, null, VOLUME );
		public const SngDarkEpic:Song = addSong( Nsf, 11, null, VOLUME );
		public const SngCastleComplete:Song = addSong( Nsf, 12, null, VOLUME );
		public const SngGameOver:Song = addSong( Nsf, 13, null, VOLUME );
		public const SngStaffRoll:Song = addSong( Nsf, 14, null, VOLUME );
		public const SngStageComplete:Song = addSong( Nsf, 16, null, VOLUME );
		public const SngCharacterChosen:Song = addSong( Nsf, 17, null, VOLUME );
		public const SngBossTheme1:Song = addSong( Nsf, 20, null, VOLUME );
		public const SngPipeBonus:Song = addSong( Nsf, 21, null, VOLUME );
		public const SngCoinHeaven:Song = addSong( Nsf, 22, null, VOLUME );
		public const SngStage5:Song = addSong( Nsf, 25, null, VOLUME );
		
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngStage5);
			addToTypePlayList(LT_CHEEP_CHEEP, SngStage2);
			addToTypePlayList(LT_COIN_HEAVEN, SngCoinHeaven);
			addToTypePlayList(LT_INTRO, SngPipeIntro);
			addToTypePlayList(LT_NORMAL, SngStage1);
			addToTypePlayList(LT_PIPE_BONUS, SngPipeBonus);
			addToTypePlayList(LT_PLATFORM, SngStage2);
			addToTypePlayList(LT_UNDER_GROUND, SngStage4);
			addToTypePlayList(LT_WATER, SngStage3);
			addToTypePlayList(MT_DARK_EPIC, SngStage5);

			addToTypePlayList(BOSS, SngBossTheme2);
			addToTypePlayList(CHAR_SEL, SngPipeIntro);
			addToTypePlayList(CHOOSE_CHARACTER, SngCharacterChosen);
			addToTypePlayList(CREDITS, SngStaffRoll);
			addToTypePlayList(DIE, null);
			addToTypePlayList(FINAL_BOSS, SngBossTheme3);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, SngBossTheme1);
			addToTypePlayList(STAR, SngTitle);
			addToTypePlayList(TITLE_SCREEN, SngTitle);
			addToTypePlayList(WIN, SngStageComplete);
			addToTypePlayList(WIN_CASTLE, SngCastleComplete);
		}
	}
}