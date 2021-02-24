package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameRiverCityRansom extends Game
	{
		private static var instance:Game; 
		
		public function GameRiverCityRansom(gameNum:int, skinSetNum:int = -1)
		{
			super("River City Ransom", "Technos Japan", Consoles.nintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/nsf/RiverCityRansom.nsfe", mimeType="application/octet-stream")]
		public const Nsfe:Class;
		private const VOLUME:int = 80;
		
		public const SngTitleScreen:Song = addSong( Nsfe, 1, null, VOLUME );
		public const SngOverworld:Song = addSong( Nsfe, 2, null, VOLUME );
		public const SngIntro:Song = addSong( Nsfe, 3, null, VOLUME );
		public const SngWater:Song = addSong( Nsfe, 4, null, VOLUME );
		public const SngCastle:Song = addSong( Nsfe, 5, null, VOLUME );
		public const SngUnderground:Song = addSong( Nsfe, 6, null, VOLUME );
		public const SngHurry:Song = addSong( Nsfe, 7, null, VOLUME );
		public const SngBoss:Song = addSong( Nsfe, 8, null, VOLUME );
		public const SngFinalBoss:Song = addSong( Nsfe, 9, null, VOLUME );
		public const SngAthletic:Song = addSong( Nsfe, 10, null, VOLUME );
		public const SngWinCastle:Song = addSong( Nsfe, 11, null, VOLUME );
		public const SngDarkEpic:Song = addSong( Nsfe, 12, null, VOLUME );
		public const SngDie:Song = addSong( Nsfe, 13, null, VOLUME );
		public const SngChooseCharacter:Song = addSong( Nsfe, 14, null, VOLUME );
		public const SngWin:Song = addSong( Nsfe, 15, null, VOLUME );
		public const SngGameOver:Song = addSong( Nsfe, 16, null, VOLUME );
		public const SngStar:Song = addSong( Nsfe, 17, null, VOLUME );
		public const SngCredits:Song = addSong( Nsfe, 18, null, VOLUME );
		
		override protected function setUpLevelThemes():void
		{
			
		}
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
				
			addToTypePlayList(LT_CASTLE, SngCastle);
			addToTypePlayList(LT_CHEEP_CHEEP, SngAthletic);
			addToTypePlayList(LT_COIN_HEAVEN, SngIntro);
			addToTypePlayList(LT_INTRO, SngIntro);
			addToTypePlayList(LT_NORMAL, SngOverworld);
			addToTypePlayList(LT_PIPE_BONUS, SngUnderground);
			addToTypePlayList(LT_PLATFORM, SngAthletic);
			addToTypePlayList(LT_UNDER_GROUND, SngUnderground);
			addToTypePlayList(LT_WATER, SngWater);
			addToTypePlayList(MT_DARK_EPIC, SngDarkEpic);
			
			addToTypePlayList(BOSS, SngBoss);
			addToTypePlayList(CHAR_SEL, SngTitleScreen);
			addToTypePlayList(CHOOSE_CHARACTER, SngChooseCharacter);
			addToTypePlayList(CREDITS, SngCredits);
			addToTypePlayList(DIE, SngDie);
			addToTypePlayList(FINAL_BOSS, SngFinalBoss);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, SngHurry);
			addToTypePlayList(STAR, SngStar);
			addToTypePlayList(TITLE_SCREEN, SngTitleScreen);
			addToTypePlayList(WIN, SngWin);
			addToTypePlayList(WIN_CASTLE, SngWinCastle);
			
		}
	}
}