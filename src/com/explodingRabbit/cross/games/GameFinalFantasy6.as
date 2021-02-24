package com.explodingRabbit.cross.games
{
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameFinalFantasy6 extends Game
	{
		private static var instance:Game; 
		
		public function GameFinalFantasy6(gameNum:int, skinSetNum:int = -1)
		{
			super("Final Fantasy VI", "Square-Enix", Consoles.superNintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		override public function initiate():void
		{
			super.initiate();	
			creditsGame = Games.finalFantasy6;
		}
		
		private const VOLUME:int = 100;

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy6/battle_theme.spc", mimeType="application/octet-stream")]
		private const DarkEpicData:Class;		public const SngBattleTheme:Song = addSong( DarkEpicData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy6/the_prelude.spc", mimeType="application/octet-stream")]
		private const CharSelectData:Class;		public const SngPrelude:Song = addSong( CharSelectData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy6/fanfare_2.spc", mimeType="application/octet-stream")]
		private const ChooseCharacterData:Class;		public const SngFanfare2:Song = addSong( ChooseCharacterData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy6/ending_theme_1.spc", mimeType="application/octet-stream")]
		private const CreditsData:Class;		public const SndEndingTheme1:Song = addSong( CreditsData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy6/boss.spc", mimeType="application/octet-stream")]
		private const BossData:Class;		public const SngBoss:Song = addSong( BossData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy6/rest_in_peace.spc", mimeType="application/octet-stream")]
		private const GameOverData:Class;		public const SngRestInPeace:Song = addSong( GameOverData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy6/the_unforgiven.spc", mimeType="application/octet-stream")]
		private const HurryData:Class;		public const SngUnforgiven:Song = addSong( HurryData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy6/203 Techno de Chocobo.spc", mimeType="application/octet-stream")]
		private const StarData:Class;		public const SngTechnoDeChocobo:Song = addSong( StarData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy6/opening_theme_2.spc", mimeType="application/octet-stream")]
		private const TitleData:Class;		public const SngOpeningTheme2:Song = addSong( TitleData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy6/fanfare.spc", mimeType="application/octet-stream")]
		private const WinData:Class;		public const SngFanfare:Song = addSong( WinData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy6/313 Last Dungeon.spc", mimeType="application/octet-stream")]
		private const CastleData:Class;		public const SngLastDungeon:Song = addSong( CastleData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy6/save_them.spc", mimeType="application/octet-stream")]
		private const CheepCheepData:Class;		public const SngSaveThem:Song = addSong( CheepCheepData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy6/215 Blackjack.spc", mimeType="application/octet-stream")]
		private const CoinHeavenData:Class;		public const SngBlackjack:Song = addSong( CoinHeavenData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy6/____.spc", mimeType="application/octet-stream")]
		private const IntroData:Class;		public const SngIntro:Song = addSong( IntroData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy6/terra.spc", mimeType="application/octet-stream")]
		private const TerraData:Class;		public const SngTerra:Song = addSong( TerraData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy6/110 Returners.spc", mimeType="application/octet-stream")]
		private const PipeBonusData:Class;		public const SngReturners:Song = addSong( PipeBonusData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy6/the_phantom_forest.spc", mimeType="application/octet-stream")]
		private const UnderGroundData:Class;		public const SngPhantomForest:Song = addSong( UnderGroundData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy6/the_serpent_trench.spc", mimeType="application/octet-stream")]
		private const WaterData:Class;		public const SngSerpentTrench:Song = addSong( WaterData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy6/mt_koltz.spc", mimeType="application/octet-stream")]
		private const PlatformData:Class;		public const SngMtKoltz:Song = addSong( PlatformData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy6/dancing_mad_5.spc", mimeType="application/octet-stream")]
		private const FinalBossData:Class;		public const SngDancingMad5:Song = addSong( FinalBossData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy6/202 Coin Song.spc", mimeType="application/octet-stream")]
		private const DieData:Class;		public const SngCoinSong:Song = addSong( DieData, -1, null, VOLUME, 0, 0, 1500, 200 );

		override protected function setUpLevelThemes():void
		{
			
		}
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngLastDungeon);
			addToTypePlayList(LT_CHEEP_CHEEP, SngSaveThem);
			addToTypePlayList(LT_COIN_HEAVEN, SngBlackjack);
			addToTypePlayList(LT_INTRO, SngIntro);
			addToTypePlayList(LT_NORMAL, SngTerra);
			addToTypePlayList(LT_PIPE_BONUS, SngReturners);
			addToTypePlayList(LT_PLATFORM, SngMtKoltz);
			addToTypePlayList(LT_UNDER_GROUND, SngPhantomForest);
			addToTypePlayList(LT_WATER, SngSerpentTrench);
			addToTypePlayList(MT_DARK_EPIC, SngBattleTheme);
			
			addToTypePlayList(BOSS, SngBoss);
			addToTypePlayList(CHAR_SEL, SngPrelude);
			addToTypePlayList(CHOOSE_CHARACTER, SngFanfare2);
			addToTypePlayList(CREDITS, SndEndingTheme1);
			addToTypePlayList(DIE, SngCoinSong);
			addToTypePlayList(FINAL_BOSS, SngDancingMad5);
			addToTypePlayList(GAME_OVER, SngRestInPeace);
			addToTypePlayList(HURRY, SngUnforgiven);
			addToTypePlayList(STAR, SngTechnoDeChocobo);
			addToTypePlayList(TITLE_SCREEN, SngOpeningTheme2);
			addToTypePlayList(WIN, SngFanfare);
			addToTypePlayList(WIN_CASTLE, SngFanfare);
		}
	}
}