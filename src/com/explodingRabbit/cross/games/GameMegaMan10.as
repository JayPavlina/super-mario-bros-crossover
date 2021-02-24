package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameMegaMan10 extends Game
	{
		private static var instance:Game; 
		
		public function GameMegaMan10(gameNum:int, skinSetNum:int = -1)
		{
			super("Mega Man 10", "Capcom", Consoles.nintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/nsf/MegaMan10.nsf", mimeType="application/octet-stream")]
		public const Nsf:Class;
		
		private const VOLUME:int = 45;
		
		public const SngCapcomLogo:Song = addSong( Nsf, 1, null, VOLUME );
		public const SngOpeningUsualDay:Song = addSong( Nsf, 3, null, VOLUME );
		public const SngOpeningFutureWorld:Song = addSong( Nsf, 4, null, VOLUME );
		public const SngOpeningSuspicion:Song = addSong( Nsf, 5, null, VOLUME );
		public const SngOpeningGoTogether:Song = addSong( Nsf, 6, null, VOLUME );
		public const SngTitle:Song = addSong( Nsf, 7, null, VOLUME );
		public const SngMainMenu:Song = addSong( Nsf, 8, null, VOLUME );
		public const SngLevelSelect:Song = addSong( Nsf, 9, null, VOLUME );
		public const SngLevelIntro:Song = addSong( Nsf, 10, null, VOLUME );
		public const SngPumpMan:Song = addSong( Nsf, 11, null, VOLUME );
		public const SngNitroMan:Song = addSong( Nsf, 12, null, VOLUME );
		public const SngStrikeMan:Song = addSong( Nsf, 13, null, VOLUME );
		public const SngSheepMan:Song = addSong( Nsf, 14, null, VOLUME );
		public const SngChillMan:Song = addSong( Nsf, 15, null, VOLUME );
		public const SngSolarMan:Song = addSong( Nsf, 16, null, VOLUME );
		public const SngCommandoMan:Song = addSong( Nsf, 17, null, VOLUME );
		public const SngBladeMan:Song = addSong( Nsf, 18, null, VOLUME );
		public const SngBossBattle:Song = addSong( Nsf, 19, null, VOLUME );
		public const SngVictorySingleLevel:Song = addSong( Nsf, 20, null, VOLUME );
		public const SngGetWeapon:Song = addSong( Nsf, 21, null, VOLUME );
		public const SngShopMegaMan:Song = addSong( Nsf, 22, null, VOLUME );
		public const SngShopProtoMan:Song = addSong( Nsf, 23, null, VOLUME );
		public const SngShopBass:Song = addSong( Nsf, 24, null, VOLUME );
		public const SngRoboenza:Song = addSong( Nsf, 25, null, VOLUME );
		public const SngWilyCrisis:Song = addSong( Nsf, 26, null, VOLUME );
		public const SngRollsGift:Song = addSong( Nsf, 27, null, VOLUME );
		public const SngWilyCastleMap:Song = addSong( Nsf, 28, null, VOLUME );
		public const SngWilyStage1Entrance:Song = addSong( Nsf, 29, null, VOLUME );
		public const SngBossBattleWilyStage:Song = addSong( Nsf, 30, null, VOLUME );
		public const SngWilyStage1:Song = addSong( Nsf, 31, null, VOLUME );
		public const SngWilyStage2:Song = addSong( Nsf, 32, null, VOLUME );
		public const SngWilyStage3:Song = addSong( Nsf, 33, null, VOLUME );
		public const SngWilyStage4:Song = addSong( Nsf, 34, null, VOLUME );
		public const SngBossBattleWilyMachine:Song = addSong( Nsf, 35, null, VOLUME );
		public const SngWilyStationMap:Song = addSong( Nsf, 36, null, VOLUME );
		public const SngWilyStage5:Song = addSong( Nsf, 37, null, VOLUME );
		public const SngBossBattleFinal:Song = addSong( Nsf, 38, null, VOLUME );
		public const SngVictoryAllLevels:Song = addSong( Nsf, 39, null, VOLUME );
		public const SngWilysGift:Song = addSong( Nsf, 40, null, VOLUME );
		public const SngCredits:Song = addSong( Nsf, 41, null, VOLUME );
		public const SngChallenge:Song = addSong( Nsf, 42, null, VOLUME );
		public const SngSpecialStage1:Song = addSong( Nsf, 43, null, VOLUME );
		public const SngSpecialStage2:Song = addSong( Nsf, 44, null, VOLUME );
		public const SngSpecialStage3:Song = addSong( Nsf, 45, null, VOLUME );
		public const SngEndlessMode:Song = addSong( Nsf, 46, null, VOLUME );
		public const SngGameOver:Song = addSong( Nsf, 47, null, VOLUME );
		
		
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngWilyStage4);
			addToTypePlayList(LT_CHEEP_CHEEP, SngSpecialStage2);
			addToTypePlayList(LT_COIN_HEAVEN, SngShopBass);
			addToTypePlayList(LT_INTRO, SngMainMenu);
			addToTypePlayList(LT_NORMAL, SngStrikeMan);
			addToTypePlayList(LT_PIPE_BONUS, SngSolarMan);
			addToTypePlayList(LT_PLATFORM, SngNitroMan);
			addToTypePlayList(LT_UNDER_GROUND, SngPumpMan);
			addToTypePlayList(LT_WATER, SngSheepMan);
			addToTypePlayList(MT_DARK_EPIC, SngWilyStage1);
			
			
			addToTypePlayList(BOSS, SngBossBattle);
			addToTypePlayList(CHAR_SEL, SngLevelSelect);
			addToTypePlayList(CHOOSE_CHARACTER, SngLevelIntro);
			addToTypePlayList(CREDITS, SngCredits);
			addToTypePlayList(DIE, null);
			addToTypePlayList(FINAL_BOSS, SngBossBattleFinal);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, SngWilyStage2);
			addToTypePlayList(STAR, SngEndlessMode);
			addToTypePlayList(TITLE_SCREEN, SngNitroMan);
			addToTypePlayList(WIN, SngVictorySingleLevel);
			addToTypePlayList(WIN_CASTLE, SngVictoryAllLevels);
			
		}
	}
}