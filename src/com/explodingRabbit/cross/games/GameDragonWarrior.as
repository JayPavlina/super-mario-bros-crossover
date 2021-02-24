package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameDragonWarrior extends Game
	{
		private static var instance:Game; 
		
		public function GameDragonWarrior(gameNum:int, skinSetNum:int = -1)
		{
			super("Dragon Warrior", "Square-Enix", Consoles.nintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		[Embed(source="../../../../../assets/audio/seq/nsf/DragonWarrior.nsfe", mimeType="application/octet-stream")]
		public const Nsfe:Class;
		
		private const VOLUME:int = 65; 
		
		public const SngTitleTheme:Song = addSong( Nsfe, 1, null, VOLUME );
		public const SngTown:Song = addSong( Nsfe, 2, null, VOLUME );
		public const SngCastleThroneRoom:Song = addSong( Nsfe, 3, null, VOLUME );
		public const SngCastleCourtyard:Song = addSong( Nsfe, 4, null, VOLUME );
		public const SngOverworld:Song = addSong( Nsfe, 5, null, VOLUME );
		public const SngUnderworld1:Song = addSong( Nsfe, 6, null, VOLUME );
		public const SngUnderworld2:Song = addSong( Nsfe, 7, null, VOLUME );
		public const SngUnderworld3:Song = addSong( Nsfe, 8, null, VOLUME );
		public const SngUnderworld4:Song = addSong( Nsfe, 9, null, VOLUME );
		public const SngBattleTheme:Song = addSong( Nsfe, 14, null, VOLUME );
		public const SngFinalBattleTheme:Song = addSong( Nsfe, 16, null, VOLUME );
		public const SngDeathTheme:Song = addSong( Nsfe, 18, null, VOLUME );
		public const SngCursed:Song = addSong( Nsfe, 19, null, VOLUME );
		public const SngMagicFlute:Song = addSong( Nsfe, 21, null, VOLUME );
		public const SngRainbowAppears:Song = addSong( Nsfe, 22, null, VOLUME );
		public const SngLoveTheme:Song = addSong( Nsfe, 23, null, VOLUME );
		public const SngEndingTheme:Song = addSong( Nsfe, 24, null, VOLUME );
		public const SngLevelUp:Song = addSong( Nsfe, 25, null, VOLUME );
		
		override protected function setUpLevelThemes():void
		{
			
		}
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngUnderworld4);
			addToTypePlayList(LT_CHEEP_CHEEP, SngOverworld);
			addToTypePlayList(LT_COIN_HEAVEN, SngTown);
			addToTypePlayList(LT_INTRO, SngRainbowAppears);
			addToTypePlayList(LT_NORMAL, SngOverworld);
			addToTypePlayList(LT_PIPE_BONUS, SngUnderworld2);
			addToTypePlayList(LT_PLATFORM, SngOverworld);
			addToTypePlayList(LT_UNDER_GROUND, SngUnderworld3);
			addToTypePlayList(LT_WATER, SngCastleThroneRoom);
			addToTypePlayList(MT_DARK_EPIC, SngCastleCourtyard);
			
			addToTypePlayList(BOSS, SngBattleTheme);
			addToTypePlayList(CHAR_SEL, SngTown);
			addToTypePlayList(CHOOSE_CHARACTER, SngMagicFlute);
			addToTypePlayList(CREDITS, SngEndingTheme);
			addToTypePlayList(DIE, null);
			addToTypePlayList(FINAL_BOSS, SngFinalBattleTheme);
			addToTypePlayList(GAME_OVER, SngDeathTheme);
			addToTypePlayList(HURRY, SngUnderworld1);
			addToTypePlayList(STAR, Games.superMarioBros.SngInvincible);
			addToTypePlayList(TITLE_SCREEN, SngTitleTheme);
			addToTypePlayList(WIN, SngLevelUp);
			addToTypePlayList(WIN_CASTLE, SngLoveTheme);
			
		}
	}
}