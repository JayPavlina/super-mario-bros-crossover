package com.explodingRabbit.cross.games
{
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameFinalFantasy5 extends Game
	{
		private static var instance:Game; 
		
		public function GameFinalFantasy5(gameNum:int, skinSetNum:int = -1)
		{
			super("Final Fantasy V", "Square-Enix", Consoles.superNintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		override public function initiate():void
		{
			super.initiate();	
			creditsGame = Games.finalFantasy5;
		}
		
		private const VOLUME:int = 100;

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy5/101 Ahead on our Way.spc", mimeType="application/octet-stream")]
		private const AheadOnOurWayData:Class;		public const SngAheadOnOurWay:Song = addSong( AheadOnOurWayData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy5/103 Four Valiant Hearts.spc", mimeType="application/octet-stream")]
		private const FourValiantHeartsData:Class;		public const SngFourValiantHearts:Song = addSong( FourValiantHeartsData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy5/104 Hurry! Hurry!.spc", mimeType="application/octet-stream")]
		private const HurryData:Class;		public const SngHurry:Song = addSong( HurryData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy5/106 Fate in Haze.spc", mimeType="application/octet-stream")]
		private const FateInHazeData:Class;		public const SngFateInHaze:Song = addSong( FateInHazeData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy5/108 Victory's Fanfare.spc", mimeType="application/octet-stream")]
		private const VictoryFanfareData:Class;		public const SngVictoryFanfare:Song = addSong( VictoryFanfareData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy5/109 Requiem.spc", mimeType="application/octet-stream")]
		private const RequiemData:Class;		public const SngRequiem:Song = addSong( RequiemData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy5/112 Good Night!.spc", mimeType="application/octet-stream")]
		private const GoodNightData:Class;		public const SngGoodNight:Song = addSong( GoodNightData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy5/117 Walking the Snowy Mountains.spc", mimeType="application/octet-stream")]
		private const WalkingTheSnowyMountainsData:Class;		public const SngWalkingTheSnowyMountains:Song = addSong( WalkingTheSnowyMountainsData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy5/119 The Fierce Battle.spc", mimeType="application/octet-stream")]
		private const FierceBattleData:Class;		public const SngFierceBattle:Song = addSong( FierceBattleData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy5/120 The Dragon Spreads its Wings.spc", mimeType="application/octet-stream")]
		private const TheDragonSpreadsItsWingsData:Class;		public const SngTheDragonSpreadsItsWings:Song = addSong( TheDragonSpreadsItsWingsData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy5/122 The Fire-Powered Ship.spc", mimeType="application/octet-stream")]
		private const FirePoweredShipData:Class;		public const SngFirePoweredShip:Song = addSong( FirePoweredShipData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy5/133 The Airship.spc", mimeType="application/octet-stream")]
		private const AirshipData:Class;		public const SngAirship:Song = addSong( AirshipData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy5/201 Exdeath's Castle.spc", mimeType="application/octet-stream")]
		private const ExdeathsCastleData:Class;		public const SngExdeathsCastle:Song = addSong( ExdeathsCastleData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy5/203 Battle with Gilgamesh.spc", mimeType="application/octet-stream")]
		private const BattleWithGilgameshData:Class;		public const SngBattleWithGilgamesh:Song = addSong( BattleWithGilgameshData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy5/207 Beyond the Deep Blue Sea.spc", mimeType="application/octet-stream")]
		private const BeyondTheDeepBlueSeaData:Class;		public const SngBeyondTheDeepBlueSea:Song = addSong( BeyondTheDeepBlueSeaData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy5/213 Intention of the Earth.spc", mimeType="application/octet-stream")]
		private const IntentionOfTheEarthData:Class;		public const SngIntentionOfTheEarth:Song = addSong( IntentionOfTheEarthData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy5/215 Searching the Light.spc", mimeType="application/octet-stream")]
		private const SearchingTheLightData:Class;		public const SngSearchingTheLight:Song = addSong( SearchingTheLightData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy5/218 The Silent Beyond.spc", mimeType="application/octet-stream")]
		private const SilentBeyondData:Class;		public const SngSilentBeyond:Song = addSong( SilentBeyondData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy5/221 A New Origin.spc", mimeType="application/octet-stream")]
		private const NewOriginData:Class;		public const SngNewOrigin:Song = addSong( NewOriginData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy5/222 The Prelude.spc", mimeType="application/octet-stream")]
		private const PreludeData:Class;		public const SngPrelude:Song = addSong( PreludeData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy5/223 Fanfare 1.spc", mimeType="application/octet-stream")]
		private const Fanfare1Data:Class;		public const SngFanfare1:Song = addSong( Fanfare1Data, -1, null, VOLUME );

		override protected function setUpLevelThemes():void
		{
			
		}
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngExdeathsCastle);
			addToTypePlayList(LT_CHEEP_CHEEP, SngFirePoweredShip);
			addToTypePlayList(LT_COIN_HEAVEN, SngAirship);
			addToTypePlayList(LT_INTRO, SngIntentionOfTheEarth);
			addToTypePlayList(LT_NORMAL, SngFourValiantHearts);
			addToTypePlayList(LT_PIPE_BONUS, SngSilentBeyond);
			addToTypePlayList(LT_PLATFORM, SngWalkingTheSnowyMountains);
			addToTypePlayList(LT_UNDER_GROUND, SngFateInHaze);
			addToTypePlayList(LT_WATER, SngBeyondTheDeepBlueSea);
			addToTypePlayList(MT_DARK_EPIC, SngSearchingTheLight);
			
			addToTypePlayList(BOSS, SngFierceBattle);
			addToTypePlayList(CHAR_SEL, SngPrelude);
			addToTypePlayList(CHOOSE_CHARACTER, SngFanfare1);
			addToTypePlayList(CREDITS, SngNewOrigin);
			addToTypePlayList(DIE, SngGoodNight);
			addToTypePlayList(FINAL_BOSS, SngBattleWithGilgamesh);
			addToTypePlayList(GAME_OVER, SngRequiem);
			addToTypePlayList(HURRY, SngHurry);
			addToTypePlayList(STAR, SngAirship);
			addToTypePlayList(TITLE_SCREEN, SngAheadOnOurWay);
			addToTypePlayList(WIN, SngVictoryFanfare);
			addToTypePlayList(WIN_CASTLE, SngVictoryFanfare);
		}
	}
}