package com.explodingRabbit.cross.games
{
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;

	public class GameKidIcarus extends Game
	{
		private static var instance:Game; 
		
		public function GameKidIcarus(gameNum:int)
		{
			super("Kid Icarus", "Nintendo", Consoles.nintendo, gameNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/nsf/KidIcarus.nsf", mimeType="application/octet-stream")]
		public const Nsf:Class;
		
		private const VOLUME:int = 65; 
		
		public const SngIntro:Song = addSong( Nsf, 1, null, VOLUME );
		public const SngUnderworld:Song = addSong( Nsf, 2, null, VOLUME );
		public const SngReaper:Song = addSong( Nsf, 3, null, VOLUME );
		public const SngDeath:Song = addSong( Nsf, 4, null, VOLUME );
		public const SngOverworld:Song = addSong( Nsf, 5, null, VOLUME );
		public const SngBossBattle:Song = addSong( Nsf, 6, null, VOLUME );
		public const SngStageComplete:Song = addSong( Nsf, 7, null, VOLUME );
		public const SngFortress:Song = addSong( Nsf, 8, null, VOLUME );
		public const SngSkyWorld:Song = addSong( Nsf, 9, null, VOLUME );
		public const SngPalaceInTheSky:Song = addSong( Nsf, 10, null, VOLUME );
		public const SngMedusa:Song = addSong( Nsf, 11, null, VOLUME );
		public const SngCredits:Song = addSong( Nsf, 12, null, VOLUME );
		
		override protected function setUpLevelThemes():void
		{
			
		}
		
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngFortress);
			addToTypePlayList(LT_CHEEP_CHEEP, SngSkyWorld);
			addToTypePlayList(LT_COIN_HEAVEN, SngPalaceInTheSky);
			addToTypePlayList(LT_INTRO, SngSkyWorld);
			addToTypePlayList(LT_NORMAL, SngUnderworld);
			addToTypePlayList(LT_PIPE_BONUS, SngPalaceInTheSky);
			addToTypePlayList(LT_PLATFORM, SngSkyWorld);
			addToTypePlayList(LT_UNDER_GROUND, SngOverworld);
			addToTypePlayList(LT_WATER, SngOverworld);
			addToTypePlayList(MT_DARK_EPIC, SngOverworld);
			
			addToTypePlayList(BOSS, SngBossBattle);
			addToTypePlayList(CHAR_SEL, SngPalaceInTheSky);
			addToTypePlayList(CHOOSE_CHARACTER, SngSkyWorld);
			addToTypePlayList(CREDITS, SngCredits);
			addToTypePlayList(DIE, null);
			addToTypePlayList(FINAL_BOSS, SngMedusa);
			addToTypePlayList(GAME_OVER, SngDeath);
			addToTypePlayList(HURRY, SngReaper);
			addToTypePlayList(STAR, null);
			addToTypePlayList(TITLE_SCREEN, SngIntro);
			addToTypePlayList(WIN, SngStageComplete);
			addToTypePlayList(WIN_CASTLE, SngStageComplete);
			
		}
	}
}