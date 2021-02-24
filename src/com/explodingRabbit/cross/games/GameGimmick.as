package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameGimmick extends Game
	{
		private static var instance:Game; 
		
		public function GameGimmick(gameNum:int, skinSetNum:int = -1)
		{
			super("Gimmick!", "Sunsoft", Consoles.nintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		[Embed(source="../../../../../assets/audio/seq/nsf/Gimmick.nsfe", mimeType="application/octet-stream")]
		public const Nsfe:Class;
		
		private const VOLUME:int = 65; 
		
		public const SngGoodMorning:Song = addSong( Nsfe, 1, null, VOLUME );
		public const SngHappyBirthday:Song = addSong( Nsfe, 2, null, VOLUME );
		public const SngGoodWeather:Song = addSong( Nsfe, 3, null, VOLUME );
		public const SngSlowIllusion:Song = addSong( Nsfe, 4, null, VOLUME );
		public const SngParadigm:Song = addSong( Nsfe, 5, null, VOLUME );
		public const SngLionHeart:Song = addSong( Nsfe, 6, null, VOLUME );
		public const SngCadbury:Song = addSong( Nsfe, 7, null, VOLUME );
		public const SngStrangeMemory:Song = addSong( Nsfe, 8, null, VOLUME );
		public const SngAporia:Song = addSong( Nsfe, 9, null, VOLUME );
		public const SngIndentBeliever:Song = addSong( Nsfe, 10, null, VOLUME );
		public const SngLongTomorrow:Song = addSong( Nsfe, 11, null, VOLUME );
		public const SngJustFriends:Song = addSong( Nsfe, 12, null, VOLUME );
		public const SngSophiaTake2:Song = addSong( Nsfe, 13, null, VOLUME );
		public const SngParadox:Song = addSong( Nsfe, 14, null, VOLUME );
		public const SngInnocent:Song = addSong( Nsfe, 15, null, VOLUME );
		public const SngNoLimits:Song = addSong( Nsfe, 16, null, VOLUME );
		public const SngSiesta:Song = addSong( Nsfe, 17, null, VOLUME );
		public const SngGoodNightTake2:Song = addSong( Nsfe, 18, null, VOLUME );
		public const SngCadburyNoIntro:Song = addSong( Nsfe, 19, null, VOLUME );
		public const SngUntitled:Song = addSong( Nsfe, 20, null, VOLUME );
		public const SngSfxDie:Song = addSong( Nsfe, 29, null, VOLUME );
		
		override protected function setUpLevelThemes():void
		{
			
		}
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngLionHeart);
			addToTypePlayList(LT_CHEEP_CHEEP, SngSlowIllusion);
			addToTypePlayList(LT_COIN_HEAVEN, SngJustFriends);
			addToTypePlayList(LT_INTRO, SngNoLimits);
			addToTypePlayList(LT_NORMAL, SngHappyBirthday);
			addToTypePlayList(LT_PIPE_BONUS, SngGoodNightTake2);
			addToTypePlayList(LT_PLATFORM, SngLongTomorrow);
			addToTypePlayList(LT_UNDER_GROUND, SngParadigm);
			addToTypePlayList(LT_WATER, SngGoodWeather);
			addToTypePlayList(MT_DARK_EPIC, SngIndentBeliever);
			
			addToTypePlayList(BOSS, SngAporia);
			addToTypePlayList(CHAR_SEL, SngNoLimits);
			addToTypePlayList(CHOOSE_CHARACTER, SngUntitled);
			addToTypePlayList(CREDITS, SngSophiaTake2);
			addToTypePlayList(DIE, SngSfxDie);
			addToTypePlayList(FINAL_BOSS, SngAporia);
			addToTypePlayList(GAME_OVER, SngInnocent);
			addToTypePlayList(HURRY, SngStrangeMemory);
			addToTypePlayList(STAR, Games.superMarioBros3.SngInvincible);
			addToTypePlayList(TITLE_SCREEN, SngGoodMorning);
			addToTypePlayList(WIN, SngCadburyNoIntro);
			addToTypePlayList(WIN_CASTLE, SngSiesta);
			
		}
	}
}