package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameNinjaGaidenSnes extends Game
	{
		private static var instance:Game; 
		
		public function GameNinjaGaidenSnes(gameNum:int, skinSetNum:int = -1)
		{
			super("Ninja Gaiden 1 (SNES)", "Tecmo", Consoles.superNintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		override public function initiate():void
		{
			super.initiate();	
			creditsGame = Games.ninjaGaidenTrilogy;
		}
		private const VOLUME:int = 80;
		
//		[Embed(source="../../../../../assets/audio/seq/spc/NinjaGaidenSnes/A Moment of Relief.spc", mimeType="application/octet-stream")]
//		private const MomentOfReliefData:Class;		public const SngMomentOfRelief:Song = addSong( MomentOfReliefData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/NinjaGaidenSnes/Construction Site.spc", mimeType="application/octet-stream")]
		private const ConstructionSiteData:Class;		public const SngConstructionSite:Song = addSong( ConstructionSiteData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/NinjaGaidenSnes/Death.spc", mimeType="application/octet-stream")]
		private const DeathData:Class;		public const SngDeath:Song = addSong( DeathData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/NinjaGaidenSnes/Underground.spc", mimeType="application/octet-stream")]
		private const UndergroundData:Class;		public const SngUnderground:Song = addSong( UndergroundData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/NinjaGaidenSnes/Snowfield.spc", mimeType="application/octet-stream")]
		private const SnowfieldData:Class;		public const SngSnowfield:Song = addSong( SnowfieldData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/NinjaGaidenSnes/Walter Smith's Theme.spc", mimeType="application/octet-stream")]
		private const WalterSmithThemeData:Class;		public const SngWalterSmithTheme:Song = addSong( WalterSmithThemeData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/NinjaGaidenSnes/Irene Lew's Theme.spc", mimeType="application/octet-stream")]
		private const IreneLewsThemeData:Class;		public const SngIreneLewsTheme:Song = addSong( IreneLewsThemeData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/NinjaGaidenSnes/Prison.spc", mimeType="application/octet-stream")]
		private const PrisonData:Class;		public const SngPrison:Song = addSong( PrisonData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/NinjaGaidenSnes/Mine.spc", mimeType="application/octet-stream")]
		private const MineData:Class;		public const SngMine:Song = addSong( MineData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/NinjaGaidenSnes/Boss Fight.spc", mimeType="application/octet-stream")]
		private const BossFightData:Class;	public const SngBossFight:Song = addSong( BossFightData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/NinjaGaidenSnes/Act... .spc", mimeType="application/octet-stream")]
		private const ActData:Class;		public const SngAct:Song = addSong( ActData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/NinjaGaidenSnes/Running.spc", mimeType="application/octet-stream")]
		private const RunningData:Class;		public const SngRunning:Song = addSong( RunningData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/NinjaGaidenSnes/Sunrise.spc", mimeType="application/octet-stream")]
		private const SunriseData:Class;		public const SngSunrise:Song = addSong( SunriseData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/NinjaGaidenSnes/After Him!.spc", mimeType="application/octet-stream")]
		private const AfterHimData:Class;	public const SngAfterHim:Song = addSong( AfterHimData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/NinjaGaidenSnes/Foster's Theme.spc", mimeType="application/octet-stream")]
		private const FostersThemeData:Class;	public const SngFostersTheme:Song = addSong( FostersThemeData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/NinjaGaidenSnes/The City.spc", mimeType="application/octet-stream")]
		private const TheCityData:Class;	public const SngTheCity:Song = addSong( TheCityData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/NinjaGaidenSnes/Outpost.spc", mimeType="application/octet-stream")]
		private const OutpostData:Class;	public const SngOutpost:Song = addSong( OutpostData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/NinjaGaidenSnes/The Light Statue.spc", mimeType="application/octet-stream")]
		private const TheLightStatueData:Class;	public const SngTheLightStatue:Song = addSong( TheLightStatueData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/NinjaGaidenSnes/Sorrow.spc", mimeType="application/octet-stream")]
		private const SorrowData:Class;	public const SngSorrow:Song = addSong( SorrowData, -1, null, VOLUME );
		
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngUnderground);
			addToTypePlayList(LT_CHEEP_CHEEP, SngSnowfield);
			addToTypePlayList(LT_COIN_HEAVEN, SngWalterSmithTheme);
			addToTypePlayList(LT_INTRO, SngIreneLewsTheme);
			addToTypePlayList(LT_NORMAL, SngMine);
			addToTypePlayList(LT_PIPE_BONUS, SngFostersTheme);
			addToTypePlayList(LT_PLATFORM, SngTheCity);
			addToTypePlayList(LT_UNDER_GROUND, SngOutpost);
			addToTypePlayList(LT_WATER, SngTheLightStatue);
			addToTypePlayList(MT_DARK_EPIC, SngConstructionSite);
			
			
			addToTypePlayList(BOSS, SngBossFight);
			addToTypePlayList(CHAR_SEL, SngPrison);
			addToTypePlayList(CHOOSE_CHARACTER, SngAct);
			addToTypePlayList(CREDITS, SngSunrise);
			addToTypePlayList(DIE, SngDeath);
			addToTypePlayList(FINAL_BOSS, SngBossFight);
			addToTypePlayList(GAME_OVER, SngDeath);
			addToTypePlayList(HURRY, SngRunning);
			addToTypePlayList(STAR, null);
			addToTypePlayList(TITLE_SCREEN, SngMine);
			addToTypePlayList(WIN, SngAfterHim);
			addToTypePlayList(WIN_CASTLE, SngSorrow);
			
		}
	}
}