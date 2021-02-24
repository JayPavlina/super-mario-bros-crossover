package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameMegaMan2 extends Game
	{
		private static var instance:Game; 
		
		public function GameMegaMan2(gameNum:int, skinSetNum:int = -1)
		{
			super("Mega Man 2", "Capcom", Consoles.nintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/nsf/MegaMan2.nsf", mimeType="application/octet-stream")]
		public const Nsf:Class;
		
		private const VOLUME:int = 55;
		
		public const SngFlashMan:Song = addSong( Nsf, 1, null, VOLUME );
		public const SngWoodMan:Song = addSong( Nsf, 2, null, VOLUME );
		public const SngCrashMan:Song = addSong( Nsf, 3, null, VOLUME );
		public const SngHeatMan:Song = addSong( Nsf, 4, null, VOLUME );
		public const SngAirMan:Song = addSong( Nsf, 5, null, VOLUME );
		public const SngMetalMan:Song = addSong( Nsf, 6, null, VOLUME );
		public const SngQuickMan:Song = addSong( Nsf, 7, null, VOLUME );
		public const SngBubbleMan:Song = addSong( Nsf, 8, null, VOLUME );
		public const SngWilyCastle:Song = addSong( Nsf, 9, null, VOLUME );
		public const SngWilyCastle2:Song = addSong( Nsf, 10, null, VOLUME );
		public const SngEnemyChosen:Song = addSong( Nsf, 11, null, VOLUME );
		public const SngBossBattle:Song = addSong( Nsf, 12, null, VOLUME );
		public const SngStageSelect:Song = addSong( Nsf, 13, null, VOLUME );
		public const SngTitleScreen:Song = addSong( Nsf, 14, null, VOLUME );
		public const SngIntroduction:Song = addSong( Nsf, 15, null, VOLUME );
		public const SngVictorySmall:Song = addSong( Nsf, 16, null, VOLUME );
		public const SngPassword:Song = addSong( Nsf, 17, null, VOLUME );
		public const SngWilyMap:Song = addSong( Nsf, 18, null, VOLUME );
//		public const Sng:Song = addSong( Nsf, 19, null, VOLUME );
		public const SngEpilogue:Song = addSong( Nsf, 20, null, VOLUME );
		public const SngCredits:Song = addSong( Nsf, 21, null, VOLUME );
		public const SngVictory:Song = addSong( Nsf, 22, null, VOLUME );
		public const SngWilyDefeated:Song = addSong( Nsf, 23, null, VOLUME );
		public const SngNewWeapon:Song = addSong( Nsf, 24, null, VOLUME );
		
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngWilyCastle2);
			addToTypePlayList(LT_CHEEP_CHEEP, SngHeatMan);
			addToTypePlayList(LT_COIN_HEAVEN, SngCrashMan);
			addToTypePlayList(LT_INTRO, SngNewWeapon);
			addToTypePlayList(LT_NORMAL, SngWoodMan);
			addToTypePlayList(LT_PIPE_BONUS, SngMetalMan);
			addToTypePlayList(LT_PLATFORM, SngAirMan);
			addToTypePlayList(LT_UNDER_GROUND, SngFlashMan);
			addToTypePlayList(LT_WATER, SngBubbleMan);
			addToTypePlayList(MT_DARK_EPIC, SngWilyCastle);

			addToTypePlayList(BOSS, SngBossBattle);
			addToTypePlayList(CHAR_SEL, SngStageSelect);
			addToTypePlayList(CHOOSE_CHARACTER, SngEnemyChosen);
			addToTypePlayList(CREDITS, SngCredits);
			addToTypePlayList(DIE, null);
			addToTypePlayList(FINAL_BOSS, SngBossBattle);
			addToTypePlayList(GAME_OVER, SngPassword);
			addToTypePlayList(HURRY, SngNewWeapon);
			addToTypePlayList(STAR, SngTitleScreen);
			addToTypePlayList(TITLE_SCREEN, SngTitleScreen);
			addToTypePlayList(WIN, SngVictory);
			addToTypePlayList(WIN_CASTLE, SngWilyDefeated);
		}
	}
}