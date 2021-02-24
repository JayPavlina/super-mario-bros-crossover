package com.explodingRabbit.cross.games
{
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameMegaMan2Gb extends Game
	{
		private static var instance:Game; 
		
		public function GameMegaMan2Gb(gameNum:int, skinSetNum:int = -1)
		{
			super("Mega Man II (GB)", "Capcom", Consoles.gameBoy, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/gbs/MegaMan2.gbs", mimeType="application/octet-stream")]
		public const Gbs:Class;
		private const VOLUME:int = 35;
		
		public const SngTitleScreen:Song = addSong( Gbs, 1, null, VOLUME );
		public const SngStageSelect:Song = addSong( Gbs, 2, null, VOLUME );
		public const SngBossSelect:Song = addSong( Gbs, 3, null, VOLUME );
		public const SngPassword:Song = addSong( Gbs, 4, null, VOLUME );
		public const SngBossBattle:Song = addSong( Gbs, 5, null, VOLUME );
		public const SngStageClear:Song = addSong( Gbs, 6, null, VOLUME );
		public const SngWeaponGet:Song = addSong( Gbs, 7, null, VOLUME );
		public const SngCrashMan:Song = addSong( Gbs, 8, null, VOLUME );
		public const SngAirMan:Song = addSong( Gbs, 9, null, VOLUME );
		public const SngMetalMan:Song = addSong( Gbs, 10, null, VOLUME );
		public const SngHardMan:Song = addSong( Gbs, 11, null, VOLUME );
		public const SngWoodMan:Song = addSong( Gbs, 12, null, VOLUME );
		public const SngTopMan:Song = addSong( Gbs, 13, null, VOLUME );
		public const SngMagnetMan:Song = addSong( Gbs, 14, null, VOLUME );
		public const SngNeedleMan:Song = addSong( Gbs, 15, null, VOLUME );
		public const SngEndingTheme:Song = addSong( Gbs, 17, null, VOLUME );
		
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngTitleScreen);
			addToTypePlayList(LT_CHEEP_CHEEP, SngAirMan);
			addToTypePlayList(LT_COIN_HEAVEN, SngCrashMan);
			addToTypePlayList(LT_INTRO, SngWeaponGet);
			addToTypePlayList(LT_NORMAL, SngHardMan);
			addToTypePlayList(LT_PIPE_BONUS, SngMagnetMan);
			addToTypePlayList(LT_PLATFORM, SngAirMan);
			addToTypePlayList(LT_UNDER_GROUND, SngWoodMan);
			addToTypePlayList(LT_WATER, SngMetalMan);
			addToTypePlayList(MT_DARK_EPIC, SngNeedleMan);
			
			addToTypePlayList(BOSS, SngBossBattle);
			addToTypePlayList(CHAR_SEL, SngStageSelect);
			addToTypePlayList(CHOOSE_CHARACTER, SngBossSelect);
			addToTypePlayList(CREDITS, SngEndingTheme);
			addToTypePlayList(DIE, null);
			addToTypePlayList(FINAL_BOSS, SngBossBattle);
			addToTypePlayList(GAME_OVER, SngPassword);
			addToTypePlayList(HURRY, SngBossBattle);
			addToTypePlayList(STAR, SngTopMan);
			addToTypePlayList(TITLE_SCREEN, SngTitleScreen);
			addToTypePlayList(WIN, SngStageClear);
			addToTypePlayList(WIN_CASTLE, SngStageClear);
		}
	}
}