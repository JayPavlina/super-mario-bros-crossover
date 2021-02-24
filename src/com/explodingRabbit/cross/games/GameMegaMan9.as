package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameMegaMan9 extends Game
	{
		private static var instance:Game; 
		
		public function GameMegaMan9(gameNum:int, skinSetNum:int = -1)
		{
			super("Mega Man 9",  "Capcom", Consoles.nintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/nsf/MegaMan9.nsf", mimeType="application/octet-stream")]
		public const Nsf:Class;
		[Embed(source="../../../../../assets/audio/seq/nsf/MegaMan9Inaccurate.nsfe", mimeType="application/octet-stream")]
		public const Nsfe:Class;
		
		private const VOLUME:int = 55;
		
		public const SngCapcomLogo:Song = addSong( Nsf, 1, null, VOLUME );
		public const SngOpening1:Song = addSong( Nsf, 2, null, VOLUME );
		public const SngOpening2:Song = addSong( Nsf, 3, null, VOLUME );
		public const SngOpening3:Song = addSong( Nsf, 4, null, VOLUME );
		public const SngTitle:Song = addSong( Nsf, 5, null, VOLUME );
		public const SngMenu:Song = addSong( Nsf, 6, null, VOLUME );
		public const SngLevelSelect:Song = addSong( Nsf, 7, null, VOLUME );
		public const SngLevelIntro:Song = addSong( Nsf, 8, null, VOLUME );
		public const SngConcreteMan:Song = addSong( Nsf, 9, null, VOLUME );
		public const SngTornadoMan:Song = addSong( Nsf, 10, null, VOLUME );
		public const SngSplashWoman:Song = addSong( Nsfe, 10, null, VOLUME );
		public const SngPlugMan:Song = addSong( Nsf, 12, null, VOLUME );
		public const SngJewelMan:Song = addSong( Nsf, 11, null, VOLUME );
		public const SngHornetMan:Song = addSong( Nsfe, 13, null, VOLUME );
		public const SngMagmaMan:Song = addSong( Nsfe, 14, null, VOLUME );
		public const SngGalaxyMan:Song = addSong( Nsfe, 16, null, VOLUME );
		public const SngBossBattle:Song = addSong( Nsf, 13, null, VOLUME );
		public const SngVictoryLevelClear:Song = addSong( Nsf, 14, null, VOLUME );
		public const SngGetWeapon:Song = addSong( Nsf, 15, null, VOLUME );
		public const SngShop:Song = addSong( Nsfe, 20, null, VOLUME );
		public const SngGetRushJet:Song = addSong( Nsf, 16, null, VOLUME );
		public const SngSuspense:Song = addSong( Nsfe, 22, null, VOLUME );
		public const SngWilyCastle:Song = addSong( Nsf, 17, null, VOLUME );
		public const SngWilyStage1:Song = addSong( Nsf, 18, null, VOLUME );
		public const SngWilyStage2:Song = addSong( Nsf, 19, null, VOLUME );
		public const SngWilyStage3:Song = addSong( Nsf, 20, null, VOLUME );
		public const SngWilyStage4:Song = addSong( Nsf, 21, null, VOLUME );
		public const SngBossFinal:Song = addSong( Nsf, 22, null, VOLUME );
		public const SngEnding:Song = addSong( Nsfe, 32, null, VOLUME );
		public const SngCredits:Song = addSong( Nsfe, 33, null, VOLUME );
		public const SngEndlessStage:Song = addSong( Nsf, 23, null, VOLUME );
		public const SngSpecialStage:Song = addSong( Nsf, 24, null, VOLUME );
		public const SngGameOver:Song = addSong( Nsf, 25, null, VOLUME );
		public const SngProtoManWhistle:Song = addSong( Nsf, 26, null, VOLUME );
		public const SngMedley:Song = addSong( Nsf, 27, null, VOLUME );
		public const SngUnknown:Song = addSong( Nsf, 28, null, VOLUME );
		
		
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngWilyStage4);
			addToTypePlayList(LT_CHEEP_CHEEP, SngWilyStage1);
			addToTypePlayList(LT_COIN_HEAVEN, SngEndlessStage);
			addToTypePlayList(LT_INTRO, SngGetRushJet);
			addToTypePlayList(LT_NORMAL, SngConcreteMan);
			addToTypePlayList(LT_PIPE_BONUS, SngJewelMan);
			addToTypePlayList(LT_PLATFORM, SngPlugMan);
			addToTypePlayList(LT_UNDER_GROUND, SngJewelMan);
			addToTypePlayList(LT_WATER, SngSplashWoman);
			addToTypePlayList(MT_DARK_EPIC, SngWilyStage2);
			
			
			addToTypePlayList(BOSS, SngBossBattle);
			addToTypePlayList(CHAR_SEL, SngLevelSelect);
			addToTypePlayList(CHOOSE_CHARACTER, SngLevelIntro);
			addToTypePlayList(CREDITS, SngCredits);
			addToTypePlayList(DIE, null);
			addToTypePlayList(FINAL_BOSS, SngBossFinal);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, SngSpecialStage);
			addToTypePlayList(STAR, SngGalaxyMan);
			addToTypePlayList(TITLE_SCREEN, SngConcreteMan);
			addToTypePlayList(WIN, SngVictoryLevelClear);
			addToTypePlayList(WIN_CASTLE, SngOpening1);
			
		}
	}
}