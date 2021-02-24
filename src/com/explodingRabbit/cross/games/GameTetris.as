package com.explodingRabbit.cross.games
{
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameTetris extends Game
	{
		private static var instance:Game; 
		
		public function GameTetris(gameNum:int, skinSetNum:int = -1)
		{
			super("Tetris", "Nintendo", Consoles.nintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		[Embed(source="../../../../../assets/audio/seq/nsf/Tetris.nsfe", mimeType="application/octet-stream")]
		public const Nsfe:Class;

		private const VOLUME:int = 65;

		public const SngMusic1:Song = addSong( Nsfe, 1, null, VOLUME );
		public const SngMusic2:Song = addSong( Nsfe, 2, null, VOLUME );
		public const SngMusic3:Song = addSong( Nsfe, 3, null, VOLUME );
		public const SngSuccess:Song = addSong( Nsfe, 4, null, VOLUME );
		public const SngEnding:Song = addSong( Nsfe, 5, null, VOLUME );
		public const SngHighScore:Song = addSong( Nsfe, 6, null, VOLUME );
		public const SngUnknown:Song = addSong( Nsfe, 7, null, VOLUME );

		override protected function setUpLevelThemes():void
		{
			
		}
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngMusic1);
			addToTypePlayList(LT_CHEEP_CHEEP, SngMusic2);
			addToTypePlayList(LT_COIN_HEAVEN, SngEnding);
			addToTypePlayList(LT_INTRO, SngHighScore);
			addToTypePlayList(LT_NORMAL, SngMusic1);
			addToTypePlayList(LT_PIPE_BONUS, SngMusic3);
			addToTypePlayList(LT_PLATFORM, SngMusic2);
			addToTypePlayList(LT_UNDER_GROUND, SngMusic3);
			addToTypePlayList(LT_WATER, SngMusic3);
			addToTypePlayList(MT_DARK_EPIC, SngMusic2);
			
			addToTypePlayList(BOSS, SngMusic2);
			addToTypePlayList(CHAR_SEL, SngHighScore);
			addToTypePlayList(CHOOSE_CHARACTER, SngSuccess);
			addToTypePlayList(CREDITS, SngEnding);
			addToTypePlayList(DIE, null);
			addToTypePlayList(FINAL_BOSS, SngMusic2);
			addToTypePlayList(GAME_OVER, SngUnknown);
			addToTypePlayList(HURRY, null);
			addToTypePlayList(STAR, SngEnding);
			addToTypePlayList(TITLE_SCREEN, SngHighScore);
			addToTypePlayList(WIN, SngSuccess);
			addToTypePlayList(WIN_CASTLE, SngSuccess);
			
		}
	}
}