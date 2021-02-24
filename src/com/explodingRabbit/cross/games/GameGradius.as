package com.explodingRabbit.cross.games
{
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameGradius extends Game
	{
		private static var instance:Game; 
		
		public function GameGradius(gameNum:int, skinSetNum:int = -1)
		{
			super("Gradius", "Konami", Consoles.nintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		[Embed(source="../../../../../assets/audio/seq/nsf/Gradius.nsfe", mimeType="application/octet-stream")]
		public const Nsfe:Class;
		
		private const VOLUME:int = 65; 
		
		public const SngStart:Song = addSong( Nsfe, 1, null, VOLUME );
		public const SngBeginning:Song = addSong( Nsfe, 2, null, VOLUME );
		public const SngStage1Mountains:Song = addSong( Nsfe, 3, null, VOLUME );
		public const SngStage2Rocks:Song = addSong( Nsfe, 4, null, VOLUME );
		public const SngStage3MoaiIslands:Song = addSong( Nsfe, 5, null, VOLUME );
		public const SngStage4MirroredMountains:Song = addSong( Nsfe, 6, null, VOLUME );
		public const SngStage5GravityOfLives:Song = addSong( Nsfe, 7, null, VOLUME );
		public const SngStage6Cells:Song = addSong( Nsfe, 8, null, VOLUME );
		public const SngStage7ControlCenter:Song = addSong( Nsfe, 9, null, VOLUME );
		public const SngBoss:Song = addSong( Nsfe, 10, null, VOLUME );
		public const SngTaskAccomplished:Song = addSong( Nsfe, 13, null, VOLUME );
		public const SngGameOver:Song = addSong( Nsfe, 15, null, VOLUME );

		override protected function setUpLevelThemes():void
		{
			
		}
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngStage5GravityOfLives);
			addToTypePlayList(LT_CHEEP_CHEEP, SngStage4MirroredMountains);
			addToTypePlayList(LT_COIN_HEAVEN, SngStage7ControlCenter);
			addToTypePlayList(LT_INTRO, SngBeginning);
			addToTypePlayList(LT_NORMAL, SngStage1Mountains);
			addToTypePlayList(LT_PIPE_BONUS, SngStage3MoaiIslands);
			addToTypePlayList(LT_PLATFORM, SngStage6Cells);
			addToTypePlayList(LT_UNDER_GROUND, SngStage2Rocks);
			addToTypePlayList(LT_WATER, SngStage7ControlCenter);
			addToTypePlayList(MT_DARK_EPIC, SngStage4MirroredMountains);
			
			addToTypePlayList(BOSS, SngBoss);
			addToTypePlayList(CHAR_SEL, SngStage3MoaiIslands);
			addToTypePlayList(CHOOSE_CHARACTER, SngStart);
			addToTypePlayList(CREDITS, SngStage6Cells);
			addToTypePlayList(DIE, null);
			addToTypePlayList(FINAL_BOSS, SngBoss);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, null);
			addToTypePlayList(STAR, SngStage1Mountains);
			addToTypePlayList(TITLE_SCREEN, SngBeginning);
			addToTypePlayList(WIN, SngTaskAccomplished);
			addToTypePlayList(WIN_CASTLE, SngTaskAccomplished);
			
		}
	}
}