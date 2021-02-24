package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameMetroid extends Game
	{
		private static var instance:Game; 
		
		public function GameMetroid(gameNum:int, skinSetNum:int = -1)
		{
			super("Metroid", "Nintendo", Consoles.nintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/nsf/Metroid.nsf", mimeType="application/octet-stream")]
		public const Nsf:Class;
		
		private const VOLUME:int = 65;
		
		public const SngTitle:Song = addSong( Nsf, 1, null, VOLUME );
		public const SngEnding:Song = addSong( Nsf, 2, null, VOLUME );
		public const SngGetPowerUp:Song = addSong( Nsf, 3, null, VOLUME );
		public const SngSamusAppear:Song = addSong( Nsf, 4, null, VOLUME );
		public const SngBrinstar:Song = addSong( Nsf, 5, null, VOLUME );
		public const SngMotherBrain:Song = addSong( Nsf, 6, null, VOLUME );
		public const SngEscape:Song = addSong( Nsf, 7, null, VOLUME );
		public const SngNorfair:Song = addSong( Nsf, 8, null, VOLUME );
		public const SngKraidsLair:Song = addSong( Nsf, 9, null, VOLUME );
		public const SngChozos:Song = addSong( Nsf, 10, null, VOLUME );
		public const SngTourian:Song = addSong( Nsf, 11, null, VOLUME );
		public const SngRidleysLair:Song = addSong( Nsf, 12, null, VOLUME );
		
		
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL, LT_PLATFORM, LT_CHEEP_CHEEP);
			
			addToTypePlayList(LT_CASTLE, SngTourian);
			addToTypePlayList(LT_CHEEP_CHEEP, SngBrinstar);
			addToTypePlayList(LT_COIN_HEAVEN, SngChozos);
			addToTypePlayList(LT_INTRO, SngChozos);
			addToTypePlayList(LT_NORMAL, SngBrinstar);
			addToTypePlayList(LT_PIPE_BONUS, SngKraidsLair);
			addToTypePlayList(LT_PLATFORM, SngBrinstar);
			addToTypePlayList(LT_UNDER_GROUND, SngRidleysLair);
			addToTypePlayList(LT_WATER, SngNorfair);
			addToTypePlayList(MT_DARK_EPIC, SngBrinstar);
			
			
			addToTypePlayList(BOSS, null);
			addToTypePlayList(CHAR_SEL, SngTitle);
			addToTypePlayList(CHOOSE_CHARACTER, SngSamusAppear);
			addToTypePlayList(CREDITS, SngEnding);
			addToTypePlayList(DIE, null);
			addToTypePlayList(FINAL_BOSS, SngMotherBrain);
			addToTypePlayList(GAME_OVER, null);
			addToTypePlayList(HURRY, SngEscape);
			addToTypePlayList(STAR, null);
			addToTypePlayList(TITLE_SCREEN, SngTitle);
			addToTypePlayList(WIN, SngGetPowerUp);
			addToTypePlayList(WIN_CASTLE, SngChozos);
			
		}
	}
}