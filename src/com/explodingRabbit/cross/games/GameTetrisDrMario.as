package com.explodingRabbit.cross.games
{
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameTetrisDrMario extends Game
	{
		private static var instance:Game; 
		
		public function GameTetrisDrMario(gameNum:int, skinSetNum:int = -1)
		{
			super("Tetris & Dr. Mario", "Nintendo", Consoles.superNintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		private const VOLUME:int = 80;
		
		[Embed(source="../../../../../assets/audio/seq/spc/TetrisDrMario/03 Tetris Theme.spc", mimeType="application/octet-stream")]
		private const TetrisThemeData:Class;		public const SngTetrisTheme:Song = addSong( TetrisThemeData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/TetrisDrMario/04a Tetris Music 1.spc", mimeType="application/octet-stream")]
		private const Music1Data:Class;		public const SngMusic1:Song = addSong( Music1Data, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/TetrisDrMario/04b Tetris Music 1 (Critical).spc", mimeType="application/octet-stream")]
		private const Music1HurryData:Class;		public const SngMusic1Hurry:Song = addSong( Music1HurryData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/TetrisDrMario/05a Tetris Music 2.spc", mimeType="application/octet-stream")]
		private const Music2Data:Class;		public const SngMusic2:Song = addSong( Music2Data, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/TetrisDrMario/05b Tetris Music 2 (Critical).spc", mimeType="application/octet-stream")]
		private const Music2HurryData:Class;		public const SngMusic2Hurry:Song = addSong( Music2HurryData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/TetrisDrMario/06a Tetris Music 3.spc", mimeType="application/octet-stream")]
		private const Music3Data:Class;		public const SngMusic3:Song = addSong( Music3Data, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/TetrisDrMario/06b Tetris Music 3 (Critical).spc", mimeType="application/octet-stream")]
		private const Music3HurryData:Class;		public const SngMusic3Hurry:Song = addSong( Music3HurryData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/TetrisDrMario/07 Tetris Game Over.spc", mimeType="application/octet-stream")]
		private const GameOverData:Class;		public const SngGameOver:Song = addSong( GameOverData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/TetrisDrMario/08 Tetris High Score.spc", mimeType="application/octet-stream")]
		private const HighScoreData:Class;		public const SngHighScore:Song = addSong( HighScoreData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/TetrisDrMario/19a Mixed Match Music 1.spc", mimeType="application/octet-stream")]
		private const MixedMusic1Data:Class;		public const SngMixedMusic1:Song = addSong( MixedMusic1Data, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/TetrisDrMario/19b Mixed Match Music 1 (Critical).spc", mimeType="application/octet-stream")]
		private const MixedMusic1HurryData:Class;		public const SngMixedMusic1Hurry:Song = addSong( MixedMusic1HurryData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/TetrisDrMario/20a Mixed Match Music 2.spc", mimeType="application/octet-stream")]
		private const MixedMusic2Data:Class;		public const SngMixedMusic2:Song = addSong( MixedMusic2Data, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/TetrisDrMario/20b Mixed Match Music 2 (Critical).spc", mimeType="application/octet-stream")]
		private const MixedMusic2HurryData:Class;		public const SngMixedMusic2Hurry:Song = addSong( MixedMusic2HurryData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/TetrisDrMario/21a Mixed Match Music 3.spc", mimeType="application/octet-stream")]
		private const MixedMusic3Data:Class;		public const SngMixedMusic3:Song = addSong( MixedMusic3Data, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/TetrisDrMario/21b Mixed Match Music 3 (Critical).spc", mimeType="application/octet-stream")]
		private const MixedMusic3HurryData:Class;		public const SngMixedMusic3Hurry:Song = addSong( MixedMusic3HurryData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/TetrisDrMario/99 Mixed Match Game Over.spc", mimeType="application/octet-stream")]
		private const MixedGameOverData:Class;		public const SngMixedGameOver:Song = addSong( MixedGameOverData, -1, null, VOLUME );

		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngMixedMusic3);
			addToTypePlayList(LT_CHEEP_CHEEP, SngMusic2);
			addToTypePlayList(LT_COIN_HEAVEN, SngMixedMusic2);
			addToTypePlayList(LT_INTRO, SngHighScore);
			addToTypePlayList(LT_NORMAL, SngMusic1);
			addToTypePlayList(LT_PIPE_BONUS, SngMixedMusic2);
			addToTypePlayList(LT_PLATFORM, SngMusic2);
			addToTypePlayList(LT_UNDER_GROUND, SngMixedMusic1);
			addToTypePlayList(LT_WATER, SngMusic3);
			addToTypePlayList(MT_DARK_EPIC, SngMusic2);
			
			addToTypePlayList(BOSS, SngMixedMusic3);
			addToTypePlayList(CHAR_SEL, SngHighScore);
			addToTypePlayList(CHOOSE_CHARACTER, SngTetrisTheme);
			addToTypePlayList(CREDITS, SngMusic1);
			addToTypePlayList(DIE, SngMixedGameOver);
			addToTypePlayList(FINAL_BOSS, SngMixedMusic3);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, null);
			addToTypePlayList(STAR, SngTetrisTheme);
			addToTypePlayList(TITLE_SCREEN, SngHighScore);
			addToTypePlayList(WIN, SngHighScore);
			addToTypePlayList(WIN_CASTLE, SngHighScore);
			
			addHurryVersionOfSong( SngMusic1, SngMusic1Hurry );
			addHurryVersionOfSong( SngMusic2, SngMusic2Hurry );
			addHurryVersionOfSong( SngMusic3, SngMusic3Hurry );
			addHurryVersionOfSong( SngMixedMusic1, SngMixedMusic1Hurry );
			addHurryVersionOfSong( SngMixedMusic2, SngMixedMusic2Hurry );
			addHurryVersionOfSong( SngMixedMusic3, SngMixedMusic3Hurry );
		}
	}
}