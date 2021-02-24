package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameZelda extends Game
	{
		private static var instance:Game; 
		
		public function GameZelda(gameNum:int, skinSetNum:int = -1)
		{
			super("The Legend of Zelda", "Nintendo", Consoles.nintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/nsf/Zelda1.nsf", mimeType="application/octet-stream")]
		public const Nsf:Class;
		
		private const VOLUME:int = 60;
		
		public const SngTitle:Song = addSong( Nsf, 1, null, VOLUME );
		public const SngCredits:Song = addSong( Nsf, 2, null, VOLUME );
		public const SngOverworld:Song = addSong( Nsf, 3, null, VOLUME );
		public const SngDungeon:Song = addSong( Nsf, 4, null, VOLUME );
		public const SngGetItem:Song = addSong( Nsf, 5, null, VOLUME );
		public const SngVictoryTriforce:Song = addSong( Nsf, 6, null, VOLUME );
		public const SngGanonIntro:Song = addSong( Nsf, 7, null, VOLUME );
		public const SngGanonsFortress:Song = addSong( Nsf, 8, null, VOLUME );
		public const SngNameEntry:Song = addSong( Nsf, 9, null, VOLUME );
		public const SngFlute:Song = addSong( Nsf, 11, null, VOLUME );
		public const SngVictorySmall:Song = addSong( Nsf, 12, null, VOLUME );
		public const SngSecret:Song = addSong( Nsf, 23, null, VOLUME );
		
		
		
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngGanonsFortress);
			addToTypePlayList(LT_CHEEP_CHEEP, SngOverworld);
			addToTypePlayList(LT_COIN_HEAVEN, SngCredits);
			addToTypePlayList(LT_INTRO, SngSecret);
			addToTypePlayList(LT_NORMAL, SngOverworld);
			addToTypePlayList(LT_PIPE_BONUS, SngDungeon);
			addToTypePlayList(LT_PLATFORM, SngOverworld);
			addToTypePlayList(LT_UNDER_GROUND, SngDungeon);
			addToTypePlayList(LT_WATER, SngTitle);
			addToTypePlayList(MT_DARK_EPIC, SngOverworld);
			
			
			addToTypePlayList(BOSS, null);
			addToTypePlayList(CHAR_SEL, SngNameEntry);
			addToTypePlayList(CHOOSE_CHARACTER, SngFlute);
			addToTypePlayList(CREDITS, SngCredits);
			addToTypePlayList(DIE, null);
			addToTypePlayList(FINAL_BOSS, null);
			addToTypePlayList(GAME_OVER, SngNameEntry);
			addToTypePlayList(HURRY, null);
			addToTypePlayList(STAR, null);
			addToTypePlayList(TITLE_SCREEN, SngTitle);
			addToTypePlayList(WIN, SngVictorySmall);
			addToTypePlayList(WIN_CASTLE, SngVictoryTriforce);
			
		}
	}
}