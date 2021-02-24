package com.explodingRabbit.cross.games
{
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameFinalFantasy4 extends Game
	{
		private static var instance:Game; 
		
		public function GameFinalFantasy4(gameNum:int, skinSetNum:int = -1)
		{
			super("Final Fantasy IV", "Square-Enix", Consoles.superNintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		override public function initiate():void
		{
			super.initiate();	
			creditsGame = Games.finalFantasy4;
		}
		
		private const VOLUME:int = 100;

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy4/01 The Prelude.spc", mimeType="application/octet-stream")]
		private const PreludeData:Class;		public const SngPrelude:Song = addSong( PreludeData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy4/07a Main Theme.spc", mimeType="application/octet-stream")]
		private const MainThemeData:Class;		public const SngMainTheme:Song = addSong( MainThemeData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy4/08 Fight 1.spc", mimeType="application/octet-stream")]
		private const Fight1Data:Class;		public const SngFight1:Song = addSong( Fight1Data, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy4/09 Fanfare.spc", mimeType="application/octet-stream")]
		private const FanfareData:Class;		public const SngFanfare:Song = addSong( FanfareData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy4/12 Into the Darkness.spc", mimeType="application/octet-stream")]
		private const IntoTheDarknessData:Class;		public const SngIntoTheDarkness:Song = addSong( IntoTheDarknessData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy4/13 Fight 2.spc", mimeType="application/octet-stream")]
		private const Fight2Data:Class;		public const SngFight2:Song = addSong( Fight2Data, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy4/17a Cry in Sorrow (part 1).spc", mimeType="application/octet-stream")]
		private const CryInSorrowData:Class;		public const SngCryInSorrow:Song = addSong( CryInSorrowData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy4/19 Mt. Ordeals.spc", mimeType="application/octet-stream")]
		private const MtOrdealsData:Class;		public const SngMtOrdeals:Song = addSong( MtOrdealsData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy4/21 Run!!!.spc", mimeType="application/octet-stream")]
		private const RunData:Class;		public const SngRun:Song = addSong( RunData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy4/25 Mystic Mysidia.spc", mimeType="application/octet-stream")]
		private const MysticMysidiaData:Class;		public const SngMysticMysidia:Song = addSong( MysticMysidiaData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy4/26 Long Way to Go.spc", mimeType="application/octet-stream")]
		private const LongWayToGoData:Class;		public const SngLongWayToGo:Song = addSong( LongWayToGoData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy4/29 The Airship.spc", mimeType="application/octet-stream")]
		private const AirshipData:Class;		public const SngAirship:Song = addSong( AirshipData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy4/32 The Tower of Babel.spc", mimeType="application/octet-stream")]
		private const TowerOfBabelData:Class;		public const SngTowerOfBabel:Song = addSong( TowerOfBabelData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy4/33 Somewhere in the World.spc", mimeType="application/octet-stream")]
		private const SomewhereInTheWorldData:Class;		public const SngSomewhereInTheWorld:Song = addSong( SomewhereInTheWorldData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy4/38 Illusionary World.spc", mimeType="application/octet-stream")]
		private const IllusionaryWorldData:Class;		public const SngIllusionaryWorld:Song = addSong( IllusionaryWorldData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy4/39 The Big Whale.spc", mimeType="application/octet-stream")]
		private const BigWhaleData:Class;		public const SngBigWhale:Song = addSong( BigWhaleData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy4/42 Within the Giant.spc", mimeType="application/octet-stream")]
		private const WithinTheGiantData:Class;		public const SngWithinTheGiant:Song = addSong( WithinTheGiantData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy4/43 The Final Battle.spc", mimeType="application/octet-stream")]
		private const FinalBattleData:Class;		public const SngFinalBattle:Song = addSong( FinalBattleData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy4/44c Epilogue (part 3).spc", mimeType="application/octet-stream")]
		private const Epilogue3Data:Class;		public const SngEpilogue3:Song = addSong( Epilogue3Data, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy4/99 Join the Party!.spc", mimeType="application/octet-stream")]
		private const JoinThePartyData:Class;		public const SngJoinTheParty:Song = addSong( JoinThePartyData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasy4/99 Surprise.spc", mimeType="application/octet-stream")]
		private const SurpriseData:Class;		public const SngSurprise:Song = addSong( SurpriseData, -1, null, VOLUME );

		override protected function setUpLevelThemes():void
		{
			
		}
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngWithinTheGiant);
			addToTypePlayList(LT_CHEEP_CHEEP, SngTowerOfBabel);
			addToTypePlayList(LT_COIN_HEAVEN, SngAirship);
			addToTypePlayList(LT_INTRO, SngSomewhereInTheWorld);
			addToTypePlayList(LT_NORMAL, SngMainTheme);
			addToTypePlayList(LT_PIPE_BONUS, SngMysticMysidia);
			addToTypePlayList(LT_PLATFORM, SngMtOrdeals);
			addToTypePlayList(LT_UNDER_GROUND, SngIntoTheDarkness);
			addToTypePlayList(LT_WATER, SngIllusionaryWorld);
			addToTypePlayList(MT_DARK_EPIC, SngFight1);
			
			addToTypePlayList(BOSS, SngFight2);
			addToTypePlayList(CHAR_SEL, SngLongWayToGo);
			addToTypePlayList(CHOOSE_CHARACTER, SngJoinTheParty);
			addToTypePlayList(CREDITS, SngEpilogue3);
			addToTypePlayList(DIE, SngSurprise);
			addToTypePlayList(FINAL_BOSS, SngFinalBattle);
			addToTypePlayList(GAME_OVER, SngCryInSorrow);
			addToTypePlayList(HURRY, SngRun);
			addToTypePlayList(STAR, SngBigWhale);
			addToTypePlayList(TITLE_SCREEN, SngPrelude);
			addToTypePlayList(WIN, SngFanfare);
			addToTypePlayList(WIN_CASTLE, SngFanfare);
			
		}
	}
}