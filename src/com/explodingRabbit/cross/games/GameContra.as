package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameContra extends Game
	{
		private static var instance:Game; 
		
		public function GameContra(gameNum:int, skinSetNum:int = -1)
		{
			super("Contra", "Konami", Consoles.nintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/nsf/ContraSfx.nsf", mimeType="application/octet-stream")]
		public const Nsf:Class;
		[Embed(source="../../../../../assets/audio/seq/nsf/ContraJ.nsfe", mimeType="application/octet-stream")]
		public const Nsfe:Class;
		
		private const VOLUME:int = 70;
		
		private const TG_OVERWORLD:ThemeGroup = addThemeGroup( 1, 1 ); 
		
		public const SngTitle:Song = addSong( Nsfe, 1, null, VOLUME );
		public const SngIntroduction:Song = addSong( Nsfe, 2, null, VOLUME );
		public const SngJungle:Song = addSong( Nsfe, 3, null, VOLUME );
		public const SngBeatLevel:Song = addSong( Nsfe, 4, null, VOLUME );
		public const SngBase:Song = addSong( Nsfe, 5, null, VOLUME );
		public const SngBoss:Song = addSong( Nsfe, 6, null, VOLUME );
		public const SngWaterfall:Song = addSong( Nsfe, 7, null, VOLUME );
		public const SngSnowField:Song = addSong( Nsfe, 8, null, VOLUME );
		public const SngEnergyZone:Song = addSong( Nsfe, 9, null, VOLUME );
		public const SngAliensLair:Song = addSong( Nsfe, 10, null, VOLUME );
		public const SngBeatFinalBoss:Song = addSong( Nsfe, 11, null, VOLUME );
		public const SngCredits:Song = addSong( Nsfe, 12, null, VOLUME );
		public const SngGameOver:Song = addSong( Nsfe, 13, null, VOLUME );
		
		override protected function setUpLevelThemes():void
		{
			
		}
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL, LT_PLATFORM, LT_CHEEP_CHEEP);
			
			addToTypePlayList(LT_CASTLE, SngAliensLair);
			addToTypePlayList(LT_CHEEP_CHEEP, SngJungle);
			addToTypePlayList(LT_COIN_HEAVEN, SngEnergyZone);
			addToTypePlayList(LT_INTRO, SngIntroduction);
			addToTypePlayList(LT_NORMAL, SngJungle);
			addToTypePlayList(LT_PIPE_BONUS, SngBase);
			addToTypePlayList(LT_PLATFORM, SngJungle);
			addToTypePlayList(LT_UNDER_GROUND, SngBase);
			addToTypePlayList(LT_WATER, SngWaterfall);
			addToTypePlayList(MT_DARK_EPIC, SngSnowField);
			
			
			addToTypePlayList(BOSS, SngBoss);
			addToTypePlayList(CHAR_SEL, SngIntroduction);
			addToTypePlayList(CHOOSE_CHARACTER, SngTitle);
			addToTypePlayList(CREDITS, SngCredits);
			addToTypePlayList(DIE, null);
			addToTypePlayList(FINAL_BOSS, SngBoss);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, SngBoss);
			addToTypePlayList(STAR, null);
			addToTypePlayList(TITLE_SCREEN, SngJungle);
			addToTypePlayList(WIN, SngBeatLevel);
			addToTypePlayList(WIN_CASTLE, SngBeatFinalBoss);
			
		}
	}
}