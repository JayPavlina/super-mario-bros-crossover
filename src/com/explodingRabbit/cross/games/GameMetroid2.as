package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameMetroid2 extends Game
	{
		private static var instance:Game; 
		
		public function GameMetroid2(gameNum:int, skinSetNum:int = -1)
		{
			super("Metroid II: Return of Samus", "Nintendo", Consoles.gameBoy, gameNum, "Metroid II", skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/gbs/Metroid2.gbs", mimeType="application/octet-stream")]
		public const Gbs:Class;
		private const VOLUME:int = 60;
		
		public const SngTitle:Song = addSong( Gbs, 1, null, VOLUME );
		public const SngSamusAppears:Song = addSong( Gbs, 2, null, VOLUME );
		public const SngSR388:Song = addSong( Gbs, 3, null, VOLUME );
		public const SngRuins:Song = addSong( Gbs, 4, null, VOLUME );
		public const SngCaverns1:Song = addSong( Gbs, 5, null, VOLUME );
		public const SngCaverns2:Song = addSong( Gbs, 6, null, VOLUME );
		public const SngCaverns3:Song = addSong( Gbs, 7, null, VOLUME );
		public const SngCaverns4:Song = addSong( Gbs, 8, null, VOLUME );
		public const SngItemAcquisition:Song = addSong( Gbs, 9, null, VOLUME );
		public const SngMissileExpansion:Song = addSong( Gbs, 10, null, VOLUME );
		public const SngMetroidConfrontation:Song = addSong( Gbs, 11, null, VOLUME );
		public const SngDefeatMetroid:Song = addSong( Gbs, 12, null, VOLUME );
		public const SngFinalCavern:Song = addSong( Gbs, 13, null, VOLUME );
		public const SngFinalCavern2:Song = addSong( Gbs, 14, null, VOLUME );
		public const SngMetroidsAppear:Song = addSong( Gbs, 15, null, VOLUME );
		public const SngBeforeFinalConfrontation:Song = addSong( Gbs, 16, null, VOLUME );
		public const SngFinalBattle:Song = addSong( Gbs, 17, null, VOLUME );
		public const SngTheMetroidHatchling:Song = addSong( Gbs, 18, null, VOLUME );
		public const SngEnding:Song = addSong( Gbs, 19, null, VOLUME );
		
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngRuins);
			addToTypePlayList(LT_CHEEP_CHEEP, SngSR388);
			addToTypePlayList(LT_COIN_HEAVEN, SngTheMetroidHatchling);
			addToTypePlayList(LT_INTRO, SngCaverns1);
			addToTypePlayList(LT_NORMAL, SngSR388);
			addToTypePlayList(LT_PIPE_BONUS, SngFinalCavern);
			addToTypePlayList(LT_PLATFORM, SngSR388);
			addToTypePlayList(LT_UNDER_GROUND, SngFinalCavern);
			addToTypePlayList(LT_WATER, SngFinalCavern2);
			addToTypePlayList(MT_DARK_EPIC, SngSR388);
			
			addToTypePlayList(BOSS, SngMetroidConfrontation);
			addToTypePlayList(CHAR_SEL, SngTitle);
			addToTypePlayList(CHOOSE_CHARACTER, SngSamusAppears);
			addToTypePlayList(CREDITS, SngEnding);
			addToTypePlayList(DIE, null);
			addToTypePlayList(FINAL_BOSS, SngFinalBattle);
			addToTypePlayList(GAME_OVER, null);
			addToTypePlayList(HURRY, SngBeforeFinalConfrontation);
			addToTypePlayList(STAR, SngEnding);
			addToTypePlayList(TITLE_SCREEN, SngTitle);
			addToTypePlayList(WIN, SngItemAcquisition);
			addToTypePlayList(WIN_CASTLE, SngItemAcquisition);
		}
	}
}