package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameTetrisGb extends Game
	{
		private static var instance:Game;
		public function GameTetrisGb( gameNum:int, skinSetNum:int = -1 )
		{
			super("Tetris (GB)", "Nintendo", Consoles.gameBoy, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/gbs/Tetris.gbs", mimeType="application/octet-stream")]
		public const Gbs:Class;
		
		private const VOLUME:int = 60;
		public const SngTitle:Song = addSong( Gbs, 1, null, VOLUME );
		public const SngMusic1:Song = addSong( Gbs, 2, null, VOLUME );
		public const SngMusic2:Song = addSong( Gbs, 3, null, VOLUME );
		public const SngMusic3:Song = addSong( Gbs, 4, null, VOLUME );
		public const SngSuccess:Song = addSong( Gbs, 5, null, VOLUME );
		public const SngRapid:Song = addSong( Gbs, 6, null, VOLUME );
		public const SngGameOver:Song = addSong( Gbs, 8, null, VOLUME );
		public const SngEnding1:Song = addSong( Gbs, 15, null, VOLUME );
		public const SngEnding2:Song = addSong( Gbs, 16, null, VOLUME );
		public const SngEnding3:Song = addSong( Gbs, 17, null, VOLUME );

		override protected function setUpLevelThemes():void
		{
			
		}
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngMusic3);
			addToTypePlayList(LT_CHEEP_CHEEP, SngMusic2);
			addToTypePlayList(LT_COIN_HEAVEN, SngRapid);
			addToTypePlayList(LT_INTRO, SngEnding3);
			addToTypePlayList(LT_NORMAL, SngMusic1);
			addToTypePlayList(LT_PIPE_BONUS, SngMusic3);
			addToTypePlayList(LT_PLATFORM, SngMusic2);
			addToTypePlayList(LT_UNDER_GROUND, SngMusic3);
			addToTypePlayList(LT_WATER, SngMusic3);
			addToTypePlayList(MT_DARK_EPIC, SngMusic2);
			
			addToTypePlayList(BOSS, SngMusic2);
			addToTypePlayList(CHAR_SEL, SngEnding3);
			addToTypePlayList(CHOOSE_CHARACTER, SngSuccess);
			addToTypePlayList(CREDITS, SngEnding2);
			addToTypePlayList(DIE, null);
			addToTypePlayList(FINAL_BOSS, SngMusic2);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, SngRapid);
			addToTypePlayList(STAR, SngRapid);
			addToTypePlayList(TITLE_SCREEN, SngTitle);
			addToTypePlayList(WIN, SngSuccess);
			addToTypePlayList(WIN_CASTLE, SngEnding1);
		}
	}
}