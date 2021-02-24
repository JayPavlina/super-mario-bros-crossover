package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameFinalFantasy3 extends Game
	{
		private static var instance:Game; 
		
		public function GameFinalFantasy3(gameNum:int, skinSetNum:int = -1)
		{
			super("Final Fantasy III", "Square-Enix", Consoles.nintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		[Embed(source="../../../../../assets/audio/seq/nsf/FinalFantasy3.nsf", mimeType="application/octet-stream")]
		public const Nsf:Class;
		
		private const VOLUME:int = 50; 
		
		public const SngSleep:Song = addSong( Nsf, 1, null, VOLUME );
		public const SngPrelude:Song = addSong( Nsf, 2, null, VOLUME );
		public const SngVictory:Song = addSong( Nsf, 8, null, VOLUME );
		public const SngGoAboveTheClouds:Song = addSong( Nsf, 11, null, VOLUME );
		public const SngJinnTheFire:Song = addSong( Nsf, 13, null, VOLUME );
		public const SngHurry:Song = addSong( Nsf, 15, null, VOLUME );
		public const SngVictoryCastle:Song = addSong( Nsf, 17, null, VOLUME );
		public const SngGameOver:Song = addSong( Nsf, 20, null, VOLUME );
		public const SngDeepUnderTheWater:Song = addSong( Nsf, 22, null, VOLUME );
		public const SngItemFanfare:Song = addSong( Nsf, 24, null, VOLUME );
		public const SngDungeon:Song = addSong( Nsf, 30, null, VOLUME );
		public const SngEternalWind:Song = addSong( Nsf, 31, null, VOLUME );
		public const SngMyHomeTown:Song = addSong( Nsf, 32, null, VOLUME );
		public const SngBattle:Song = addSong( Nsf, 33, null, VOLUME );
		public const SngTheWayToTheTop:Song = addSong( Nsf, 34, null, VOLUME );
		public const SngSailingEnterprise:Song = addSong( Nsf, 35, null, VOLUME );
		public const SngTheInvincible:Song = addSong( Nsf, 36, null, VOLUME );
		public const SngLetMeKnowTheTruth:Song = addSong( Nsf, 39, null, VOLUME );
		public const SngForbiddenLand:Song = addSong( Nsf, 40, null, VOLUME );
		public const SngTheDarkCrystals:Song = addSong( Nsf, 42, null, VOLUME );
		public const SngBossBattle:Song = addSong( Nsf, 43, null, VOLUME );
		public const SngEndingTheme:Song = addSong( Nsf, 44, null, VOLUME );
		
		override protected function setUpLevelThemes():void
		{
			
		}
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngTheDarkCrystals);
			addToTypePlayList(LT_CHEEP_CHEEP, SngSailingEnterprise);
			addToTypePlayList(LT_COIN_HEAVEN, SngGoAboveTheClouds);
			addToTypePlayList(LT_INTRO, SngLetMeKnowTheTruth);
			addToTypePlayList(LT_NORMAL, SngEternalWind);
			addToTypePlayList(LT_PIPE_BONUS, SngJinnTheFire);
			addToTypePlayList(LT_PLATFORM, SngTheWayToTheTop);
			addToTypePlayList(LT_UNDER_GROUND, SngDungeon);
			addToTypePlayList(LT_WATER, SngDeepUnderTheWater);
			addToTypePlayList(MT_DARK_EPIC, SngForbiddenLand);
			
			addToTypePlayList(BOSS, SngBattle);
			addToTypePlayList(CHAR_SEL, SngMyHomeTown);
			addToTypePlayList(CHOOSE_CHARACTER, SngItemFanfare);
			addToTypePlayList(CREDITS, SngEndingTheme);
			addToTypePlayList(DIE, SngSleep);
			addToTypePlayList(FINAL_BOSS, SngBossBattle);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, SngHurry);
			addToTypePlayList(STAR, SngTheInvincible);
			addToTypePlayList(TITLE_SCREEN, SngPrelude);
			addToTypePlayList(WIN, SngVictory);
			addToTypePlayList(WIN_CASTLE, SngVictoryCastle);
			
		}
	}
}