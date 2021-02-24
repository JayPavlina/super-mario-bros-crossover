package com.explodingRabbit.cross.games
{
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameNinjaGaiden extends Game
	{
		private static var instance:Game; 
		
		public function GameNinjaGaiden(gameNum:int, skinSetNum:int = -1)
		{
			super("Ninja Gaiden", "Tecmo", Consoles.nintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/nsf/NinjaGaiden.nsf", mimeType="application/octet-stream")]
		public const Nsf:Class;
		
		private const VOLUME:int = 70;
		
		public const SngOpeningDuel:Song = addSong( Nsf, 1, null, VOLUME );
		public const SngOpeningVowOfRevenge:Song = addSong( Nsf, 2, null, VOLUME );
		public const SngLevelIntro:Song = addSong( Nsf, 3, null, VOLUME );
		public const SngPushingOnward:Song = addSong( Nsf, 4, null, VOLUME );
		public const SngBossBattle:Song = addSong( Nsf, 5, null, VOLUME );
		public const SngVeilOfUncertaintyCutscene:Song = addSong( Nsf, 6, null, VOLUME );
		public const SngApprehensiveMomentsCustscene:Song = addSong( Nsf, 7, null, VOLUME );
		public const SngEvadingTheEnemy:Song = addSong( Nsf, 8, null, VOLUME );
		public const SngRuggedTerrain:Song = addSong( Nsf, 9, null, VOLUME );
		public const SngSwiftNinjaCutscene:Song = addSong( Nsf, 10, null, VOLUME );
		public const SngSeekingTruthCutscene:Song = addSong( Nsf, 11, null, VOLUME );
		public const SngNowhereToRun:Song = addSong( Nsf, 12, null, VOLUME );
		public const SngDevelishInfluence:Song = addSong( Nsf, 13, null, VOLUME );
		public const SngInformationAndCoercionCustcene:Song = addSong( Nsf, 14, null, VOLUME );
		public const SngUnbreakableDetermination:Song = addSong( Nsf, 15, null, VOLUME );
		public const SngJaquioFortressCutscene:Song = addSong( Nsf, 16, null, VOLUME );
		public const SngSpawnOfEvilCutscene:Song = addSong( Nsf, 17, null, VOLUME );
		public const SngEvilPlansCutscene:Song = addSong( Nsf, 18, null, VOLUME );
		public const SngDepthOfWickedness:Song = addSong( Nsf, 19, null, VOLUME );
		public const SngBloodyMalthCutscene:Song = addSong( Nsf, 20, null, VOLUME );
		public const SngAftermathCutscene:Song = addSong( Nsf, 21, null, VOLUME );
		public const SngEndingAHerosEnd:Song = addSong( Nsf, 22, null, VOLUME );
		public const SngEndingItsOver:Song = addSong( Nsf, 23, null, VOLUME );
		public const SngEndingForYourLove:Song = addSong( Nsf, 24, null, VOLUME );
		public const SngGameOver:Song = addSong( Nsf, 26, null, VOLUME );
		public const SngSadExtraCutscene:Song = addSong( Nsf, 27, null, VOLUME );
		public const SngSurpriseBig:Song = addSong( Nsf, 28, null, VOLUME );
		public const SngSurpriseFast:Song = addSong( Nsf, 30, null, VOLUME );
		public const SngWhatThe:Song = addSong( Nsf, 31, null, VOLUME );
		
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngDepthOfWickedness);
			addToTypePlayList(LT_CHEEP_CHEEP, SngNowhereToRun);
			addToTypePlayList(LT_COIN_HEAVEN, SngSeekingTruthCutscene);
			addToTypePlayList(LT_INTRO, SngVeilOfUncertaintyCutscene);
			addToTypePlayList(LT_NORMAL, SngUnbreakableDetermination);
			addToTypePlayList(LT_PIPE_BONUS, SngInformationAndCoercionCustcene);
			addToTypePlayList(LT_PLATFORM, SngPushingOnward);
			addToTypePlayList(LT_UNDER_GROUND, SngRuggedTerrain);
			addToTypePlayList(LT_WATER, SngDevelishInfluence);
			addToTypePlayList(MT_DARK_EPIC, SngEvadingTheEnemy);
			
			addToTypePlayList(BOSS, SngBossBattle);
			addToTypePlayList(CHAR_SEL, SngApprehensiveMomentsCustscene);
			addToTypePlayList(CHOOSE_CHARACTER, SngLevelIntro);
			addToTypePlayList(CREDITS, SngUnbreakableDetermination);
			addToTypePlayList(DIE, SngGameOver);
			addToTypePlayList(FINAL_BOSS, SngBossBattle);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, SngSwiftNinjaCutscene);
			addToTypePlayList(STAR, null);
			addToTypePlayList(TITLE_SCREEN, SngUnbreakableDetermination);
			addToTypePlayList(WIN, SngSurpriseBig);
			addToTypePlayList(WIN_CASTLE, SngEndingAHerosEnd);
		}
	}
}