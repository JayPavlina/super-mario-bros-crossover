package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameSuperMetroid extends Game
	{
		private static var instance:Game; 
		
		public function GameSuperMetroid(gameNum:int, skinSetNum:int = -1)
		{
			super("Super Metroid", "Nintendo", Consoles.superNintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		private const VOLUME:int = 88;
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMetroid/Item Room.spc", mimeType="application/octet-stream")]
		private const ItemRoomData:Class;	public const SngItemRoom:Song = addSong( ItemRoomData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMetroid/Item Acquisition Fanfare.spc", mimeType="application/octet-stream")]
		private const ItemFanfareData:Class;		public const SngItemFanfare:Song = addSong( ItemFanfareData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMetroid/Maridia Rocky Underwater Area No Fade.spc", mimeType="application/octet-stream")]
		private const MaridiaRockyUnderwaterData:Class;	public const SngMaridiaRockyUnderwater:Song = addSong( MaridiaRockyUnderwaterData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMetroid/Samus Aran's Appearance Fanfare.spc", mimeType="application/octet-stream")]
		private const SamusAppearanceFanfareData:Class;	public const SngSamusAppearanceFanfare:Song = addSong( SamusAppearanceFanfareData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMetroid/Samus Aran's Final Cry.spc", mimeType="application/octet-stream")]
		private const SamusDieData:Class;	public const SngSamusDie:Song = addSong( SamusDieData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMetroid/Brinstar Overgrown with Vegetation Area No Fade.spc", mimeType="application/octet-stream")]
		private const BrinstarVegetationData:Class;	public const SngBrinstarVegetation:Song = addSong( BrinstarVegetationData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMetroid/Crateria ~ The Space Pirates Appear.spc", mimeType="application/octet-stream")]
		private const CriteriaSpacePiratesData:Class;	public const SngCriteriaSpacePirates:Song = addSong( CriteriaSpacePiratesData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMetroid/Norfair Ancient Ruins Area.spc", mimeType="application/octet-stream")]
		private const NorfairAncientRuinsData:Class;		public const SngNorfairAncientRuins:Song = addSong( NorfairAncientRuinsData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMetroid/Continue.spc", mimeType="application/octet-stream")]
		private const ContinueData:Class;	public const SngContinue:Song = addSong( ContinueData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMetroid/Escape.spc", mimeType="application/octet-stream")]
		private const EscapeData:Class;		public const SngEscape:Song = addSong( EscapeData, -1, null, VOLUME );
		
//		[Embed(source="../../../../../assets/audio/seq/spc/SuperMetroid/Tension.spc", mimeType="application/octet-stream")]
//		private const TensionData:Class;		public const SngTension:Song = addSong( TensionData, -1, null, VOLUME );
		
//		[Embed(source="../../../../../assets/audio/seq/spc/SuperMetroid/Theme of Samus Aran ~ Galactic Warrior.spc", mimeType="application/octet-stream")]
//		private const SamusThemeData:Class;	public const SngSamusTheme:Song = addSong( SamusThemeData, -1, null, VOLUME );
		
//		[Embed(source="../../../../../assets/audio/seq/spc/SuperMetroid/Theme of Super Metroid.spc", mimeType="application/octet-stream")]
//		private const SuperMetroidThemeData:Class;	public const SngSuperMetroidTheme:Song = addSong( SuperMetroidThemeData, -1, null, VOLUME );
		
//		[Embed(source="../../../../../assets/audio/seq/spc/SuperMetroid/Tourian.spc", mimeType="application/octet-stream")]
//		private const TourianData:Class;		public const SngTourian:Song = addSong( TourianData, -1, null, VOLUME );
		
//		[Embed(source="../../../../../assets/audio/seq/spc/SuperMetroid/Big Boss Confrontation 1.spc", mimeType="application/octet-stream")]
//		private const BigBossConfrontation1Data:Class;		public const SngBigBossConfrontation1:Song = addSong( BigBossConfrontation1Data, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMetroid/Big Boss Confrontation 2.spc", mimeType="application/octet-stream")]
		private const BigBossConfrontation2Data:Class;		public const SngBigBossConfrontation2:Song = addSong( BigBossConfrontation2Data, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMetroid/Mother Brain.spc", mimeType="application/octet-stream")]
		private const MotherBrainData:Class;		public const SngMotherBrain:Song = addSong( MotherBrainData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMetroid/Ending.spc", mimeType="application/octet-stream")]
		private const EndingData:Class;		public const SngEnding:Song = addSong( EndingData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMetroid/Opening ~ Destruction of the Space Colony.spc", mimeType="application/octet-stream")]
		private const OpeningData:Class;		public const SngOpening:Song = addSong( OpeningData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMetroid/Brinstar Red Soil Swampy Area No Fade.spc", mimeType="application/octet-stream")]
		private const BrinstarRedSwampyAreaData:Class;		public const SngBrinstarRedSwampyArea:Song = addSong( BrinstarRedSwampyAreaData, -1, null, VOLUME );
		
//		[Embed(source="../../../../../assets/audio/seq/spc/SuperMetroid/Norfair Hot Lava Area.spc", mimeType="application/octet-stream")]
//		private const NorfairHotLavaAreaData:Class;		public const SngNorfairHotLavaArea:Song = addSong( NorfairHotLavaAreaData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMetroid/Planet Zebes ~ Arrival on Crateria.spc", mimeType="application/octet-stream")]
		private const PlanetZebesArrivalOnCrateriaData:Class;		public const SngPlanetZebesArrivalOnCrateria:Song = addSong( PlanetZebesArrivalOnCrateriaData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMetroid/Crateria Underground.spc", mimeType="application/octet-stream")]
		private const CrateriaUndergroundData:Class;		public const SngCrateriaUnderground:Song = addSong( CrateriaUndergroundData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperMetroid/Wrecked Ship.spc", mimeType="application/octet-stream")]
		private const WreckedShipData:Class;		public const SngWreckedShip:Song = addSong( WreckedShipData, -1, null, VOLUME + 10 );
		
		
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);

			addToTypePlayList(LT_CASTLE, SngWreckedShip);
			addToTypePlayList(LT_CHEEP_CHEEP, SngNorfairAncientRuins);
			addToTypePlayList(LT_COIN_HEAVEN, SngPlanetZebesArrivalOnCrateria);
			addToTypePlayList(LT_INTRO, SngCrateriaUnderground);
			addToTypePlayList(LT_NORMAL, SngBrinstarVegetation);
			addToTypePlayList(LT_PIPE_BONUS, SngItemRoom);
			addToTypePlayList(LT_PLATFORM, SngBrinstarRedSwampyArea);
			addToTypePlayList(LT_UNDER_GROUND, SngCriteriaSpacePirates);
			addToTypePlayList(LT_WATER, SngMaridiaRockyUnderwater);
			addToTypePlayList(MT_DARK_EPIC, SngNorfairAncientRuins);
			
			
			addToTypePlayList(BOSS, SngBigBossConfrontation2);
			addToTypePlayList(CHAR_SEL, SngItemRoom);
			addToTypePlayList(CHOOSE_CHARACTER, SngSamusAppearanceFanfare);
			addToTypePlayList(CREDITS, SngEnding);
			addToTypePlayList(DIE, SngSamusDie);
			addToTypePlayList(FINAL_BOSS, SngMotherBrain);
			addToTypePlayList(GAME_OVER, SngContinue);
			addToTypePlayList(HURRY, SngEscape);
			addToTypePlayList(STAR, null);
			addToTypePlayList(TITLE_SCREEN, SngOpening);
			addToTypePlayList(WIN, SngItemFanfare);
			addToTypePlayList(WIN_CASTLE, SngItemFanfare);
			
		}
	}
}