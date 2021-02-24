package com.explodingRabbit.cross.games
{
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameMegaManGb extends Game
	{
		private static var instance:Game; 
		
		public function GameMegaManGb(gameNum:int, skinSetNum:int = -1)
		{
			super("Mega Man: Dr. Wily's Revenge", "Capcom", Consoles.gameBoy, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/gbs/MegaMan.gbs", mimeType="application/octet-stream")]
		public const Gbs:Class;
		private const VOLUME:int = 45;
		
		public const SngCutMan:Song = addSong( Gbs, 1, null, VOLUME );
		public const SngIceMan:Song = addSong( Gbs, 2, null, VOLUME );
		public const SngElecMan:Song = addSong( Gbs, 3, null, VOLUME );
		public const SngFireMan:Song = addSong( Gbs, 4, null, VOLUME );
		public const SngBossBattle:Song = addSong( Gbs, 5, null, VOLUME );
		public const SngVictory:Song = addSong( Gbs, 6, null, VOLUME );
		public const SngWilyCastle:Song = addSong( Gbs, 7, null, VOLUME );
		public const SngWilyStar:Song = addSong( Gbs, 9, null, VOLUME );
		public const SngWilyIntro:Song = addSong( Gbs, 10, null, VOLUME );
		public const SngBossSelect:Song = addSong( Gbs, 12, null, VOLUME );
		public const SngStageSelect:Song = addSong( Gbs, 13, null, VOLUME );
		public const SngEnding:Song = addSong( Gbs, 14, null, VOLUME );
		public const SngWeaponGet:Song = addSong( Gbs, 15, null, VOLUME );
		public const SngTitleScreen:Song = addSong( Gbs, 16, null, VOLUME );
		public const SngGameOver:Song = addSong( Gbs, 17, null, VOLUME );
		
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngWilyCastle);
			addToTypePlayList(LT_CHEEP_CHEEP, SngCutMan);
			addToTypePlayList(LT_COIN_HEAVEN, SngCutMan);
			addToTypePlayList(LT_INTRO, SngWeaponGet);
			addToTypePlayList(LT_NORMAL, SngElecMan);
			addToTypePlayList(LT_PIPE_BONUS, SngFireMan);
			addToTypePlayList(LT_PLATFORM, SngCutMan);
			addToTypePlayList(LT_UNDER_GROUND, SngFireMan);
			addToTypePlayList(LT_WATER, SngIceMan);
			addToTypePlayList(MT_DARK_EPIC, SngWilyStar);
			
			addToTypePlayList(BOSS, SngBossBattle);
			addToTypePlayList(CHAR_SEL, SngStageSelect);
			addToTypePlayList(CHOOSE_CHARACTER, SngBossSelect);
			addToTypePlayList(CREDITS, SngEnding);
			addToTypePlayList(DIE, null);
			addToTypePlayList(FINAL_BOSS, SngBossBattle);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, SngBossBattle);
			addToTypePlayList(STAR, SngTitleScreen);
			addToTypePlayList(TITLE_SCREEN, SngTitleScreen);
			addToTypePlayList(WIN, SngVictory);
			addToTypePlayList(WIN_CASTLE, SngVictory);
			
		}
	}
}