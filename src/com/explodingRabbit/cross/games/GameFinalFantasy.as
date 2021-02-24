package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameFinalFantasy extends Game
	{
		private static var instance:Game; 
		
		public function GameFinalFantasy(gameNum:int, skinSetNum:int = -1)
		{
			super("Final Fantasy", "Square-Enix", Consoles.nintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		[Embed(source="../../../../../assets/audio/seq/nsf/FinalFantasy.nsf", mimeType="application/octet-stream")]
		public const Nsf:Class;
		
		private const VOLUME:int = 50; 
		
		public const SngTitle:Song = addSong( Nsf, 1, null, VOLUME );
		public const SngPrelude:Song = addSong( Nsf, 2, null, VOLUME );
		public const SngEnding:Song = addSong( Nsf, 3, null, VOLUME );
		public const SngOverworld:Song = addSong( Nsf, 4, null, VOLUME );
		public const SngShip:Song = addSong( Nsf, 5, null, VOLUME );
		public const SngAirship:Song = addSong( Nsf, 6, null, VOLUME );
		public const SngTown:Song = addSong( Nsf, 7, null, VOLUME );
		public const SngCastle:Song = addSong( Nsf, 8, null, VOLUME );
		public const SngCave1:Song = addSong( Nsf, 9, null, VOLUME );
		public const SngCave2:Song = addSong( Nsf, 10, null, VOLUME );
		public const SngCave3:Song = addSong( Nsf, 11, null, VOLUME );
		public const SngCave4:Song = addSong( Nsf, 12, null, VOLUME );
		public const SngSkyCastle:Song = addSong( Nsf, 13, null, VOLUME );
		public const SngFinalCastle:Song = addSong( Nsf, 14, null, VOLUME );
		public const SngShop:Song = addSong( Nsf, 15, null, VOLUME );
		public const SngBattle:Song = addSong( Nsf, 16, null, VOLUME );
		public const SngInn:Song = addSong( Nsf, 17, null, VOLUME );
		public const SngGameOver:Song = addSong( Nsf, 18, null, VOLUME );
		public const SngVictory:Song = addSong( Nsf, 19, null, VOLUME );
		public const SngItemFanfare:Song = addSong( Nsf, 20, null, VOLUME );
		
		override protected function setUpLevelThemes():void
		{
			
		}
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngFinalCastle);
			addToTypePlayList(LT_CHEEP_CHEEP, SngShip);
			addToTypePlayList(LT_COIN_HEAVEN, SngPrelude);
			addToTypePlayList(LT_INTRO, SngInn);
			addToTypePlayList(LT_NORMAL, SngOverworld);
			addToTypePlayList(LT_PIPE_BONUS, SngCave2);
			addToTypePlayList(LT_PLATFORM, SngShip);
			addToTypePlayList(LT_UNDER_GROUND, SngCave1);
			addToTypePlayList(LT_WATER, SngSkyCastle);
			addToTypePlayList(MT_DARK_EPIC, SngCave4);
			
			addToTypePlayList(BOSS, SngBattle);
			addToTypePlayList(CHAR_SEL, SngTown);
			addToTypePlayList(CHOOSE_CHARACTER, SngItemFanfare);
			addToTypePlayList(CREDITS, SngEnding);
			addToTypePlayList(DIE, null);
			addToTypePlayList(FINAL_BOSS, SngBattle);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, SngCave3);
			addToTypePlayList(STAR, SngAirship);
			addToTypePlayList(TITLE_SCREEN, SngTitle);
			addToTypePlayList(WIN, SngVictory);
			addToTypePlayList(WIN_CASTLE, SngVictory);
			
		}
	}
}