package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameContra3 extends Game
	{
		private static var instance:Game; 
		
		public function GameContra3(gameNum:int, skinSetNum:int = -1)
		{
			super("Contra 3: The Alien Wars", "Konami", Consoles.superNintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		private const VOLUME:int = 70;
		
		[Embed(source="../../../../../assets/audio/seq/spc/Contra3/Casualty of War.spc", mimeType="application/octet-stream")]
		private const CasualtyOfWarData:Class;	public const SngCasualtyOfWar:Song = addSong( CasualtyOfWarData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/Contra3/Ground Zero.spc", mimeType="application/octet-stream")]
		private const GroundZeroData:Class;	public const SngGroundZero:Song = addSong( GroundZeroData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/Contra3/Mission Accomplished.spc", mimeType="application/octet-stream")]
		private const MissionAccomplishedData:Class;	public const SngMissionAccomplished:Song = addSong( MissionAccomplishedData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/Contra3/Invasion.spc", mimeType="application/octet-stream")]
		private const InvasionData:Class;	public const SngInvasion:Song = addSong( InvasionData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/Contra3/No Man's Land.spc", mimeType="application/octet-stream")]
		private const NoMansLandData:Class;	public const SngNoMansLand:Song = addSong( NoMansLandData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/Contra3/Tearing Up the Turnpike.spc", mimeType="application/octet-stream")]
		private const TearingUpTheTurnpikeData:Class;	public const SngTearingUpTheTurnpike:Song = addSong( TearingUpTheTurnpikeData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/Contra3/Road Warriors.spc", mimeType="application/octet-stream")]
		private const RoadWarriorsData:Class;	public const SngRoadWarriors:Song = addSong( RoadWarriorsData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/Contra3/Nesting in the Sands.spc", mimeType="application/octet-stream")]
		private const NestingInTheSandsData:Class;	public const SngNestingInTheSands:Song = addSong( NestingInTheSandsData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/Contra3/Neo Kobe Steel Factory.spc", mimeType="application/octet-stream")]
		private const NeoKobeSteelFactoryData:Class;	public const SngNeoKobeSteelFactory:Song = addSong( NeoKobeSteelFactoryData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/Contra3/Point of Entry.spc", mimeType="application/octet-stream")]
		private const PointOfEntryData:Class;	public const SngPointOfEntry:Song = addSong( PointOfEntryData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/Contra3/Cease Fire.spc", mimeType="application/octet-stream")]
		private const CeaseFireData:Class;	public const SngCeaseFire:Song = addSong( CeaseFireData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/Contra3/The Final Gauntlet (Part 1).spc", mimeType="application/octet-stream")]
		private const TheFinalGauntletPart1Data:Class;	public const SngTheFinalGauntletPart1:Song = addSong( TheFinalGauntletPart1Data, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/Contra3/The Final Gauntlet (Part 2).spc", mimeType="application/octet-stream")]
		private const TheFinalGauntletPart2Data:Class;	public const SngTheFinalGauntletPart2:Song = addSong( TheFinalGauntletPart2Data, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/Contra3/The Final Gauntlet (Part 3).spc", mimeType="application/octet-stream")]
		private const TheFinalGauntletPart3Data:Class;	public const SngTheFinalGauntletPart3:Song = addSong( TheFinalGauntletPart3Data, -1, null, VOLUME );
		
		
		
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngInvasion);
			addToTypePlayList(LT_CHEEP_CHEEP, SngRoadWarriors);
			addToTypePlayList(LT_COIN_HEAVEN, SngNestingInTheSands);
			addToTypePlayList(LT_INTRO, SngPointOfEntry);
			addToTypePlayList(LT_NORMAL, SngGroundZero);
			addToTypePlayList(LT_PIPE_BONUS, SngTearingUpTheTurnpike);
			addToTypePlayList(LT_PLATFORM, SngNeoKobeSteelFactory);
			addToTypePlayList(LT_UNDER_GROUND, SngTearingUpTheTurnpike);
			addToTypePlayList(LT_WATER, SngNestingInTheSands);
			addToTypePlayList(MT_DARK_EPIC, SngNoMansLand);
			
			
			addToTypePlayList(BOSS, SngTheFinalGauntletPart2);
			addToTypePlayList(CHAR_SEL, SngPointOfEntry);
			addToTypePlayList(CHOOSE_CHARACTER, SngCeaseFire);
			addToTypePlayList(CREDITS, SngCeaseFire);
			addToTypePlayList(DIE, null);
			addToTypePlayList(FINAL_BOSS, SngTheFinalGauntletPart3);
			addToTypePlayList(GAME_OVER, SngCasualtyOfWar);
			addToTypePlayList(HURRY, SngTheFinalGauntletPart1);
			addToTypePlayList(STAR, SngRoadWarriors);
			addToTypePlayList(TITLE_SCREEN, SngGroundZero);
			addToTypePlayList(WIN, SngMissionAccomplished);
			addToTypePlayList(WIN_CASTLE, SngMissionAccomplished);
			
		}
	}
}