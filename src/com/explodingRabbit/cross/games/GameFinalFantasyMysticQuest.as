package com.explodingRabbit.cross.games
{
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameFinalFantasyMysticQuest extends Game
	{
		private static var instance:Game; 
		
		public function GameFinalFantasyMysticQuest(gameNum:int, skinSetNum:int = -1)
		{
			super("Final Fantasy Mystic Quest", "Square-Enix", Consoles.superNintendo, gameNum, "FF: Mystic Quest", skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		private const VOLUME:int = 100;

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasyMysticQuest/03 Mystic Quest.spc", mimeType="application/octet-stream")]
		private const MysticQuestData:Class;	public const SngMysticQuest:Song = addSong( MysticQuestData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasyMysticQuest/04 Hill of Fate.spc", mimeType="application/octet-stream")]
		private const HillOfFateData:Class;		public const SngHillOfFate:Song = addSong( HillOfFateData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasyMysticQuest/05 World.spc", mimeType="application/octet-stream")]
		private const WorldData:Class;		public const SngWorld:Song = addSong( WorldData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasyMysticQuest/06 Beautiful Forest.spc", mimeType="application/octet-stream")]
		private const BeautifulForestData:Class;		public const SngBeautifulForest:Song = addSong( BeautifulForestData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasyMysticQuest/07 Battle 1.spc", mimeType="application/octet-stream")]
		private const Battle1Data:Class;		public const SngBattle1:Song = addSong( Battle1Data, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasyMysticQuest/08 Victory Fanfare.spc", mimeType="application/octet-stream")]
		private const VictoryFanfareData:Class;		public const SngVictoryFanfare:Song = addSong( VictoryFanfareData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasyMysticQuest/09 City of Forest.spc", mimeType="application/octet-stream")]
		private const CityOfForestData:Class;		public const SngCityOfForest:Song = addSong( CityOfForestData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasyMysticQuest/11 Battle 2.spc", mimeType="application/octet-stream")]
		private const Battle2Data:Class;		public const SngBattle2:Song = addSong( Battle2Data, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasyMysticQuest/12 Middle Tower.spc", mimeType="application/octet-stream")]
		private const MiddleTowerData:Class;		public const SngMiddleTower:Song = addSong( MiddleTowerData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasyMysticQuest/13 Shrine of Light.spc", mimeType="application/octet-stream")]
		private const ShrineOfLightData:Class;		public const SngShrineOfLight:Song = addSong( ShrineOfLightData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasyMysticQuest/14 Rock Theme.spc", mimeType="application/octet-stream")]
		private const RockThemeData:Class;		public const SngRockTheme:Song = addSong( RockThemeData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasyMysticQuest/15 Fanfare of Friendship.spc", mimeType="application/octet-stream")]
		private const FanfareOfFriendshipData:Class;		public const SngFanfareOfFriendship:Song = addSong( FanfareOfFriendshipData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasyMysticQuest/16 Dungeon of Ice.spc", mimeType="application/octet-stream")]
		private const DungeonOfIceData:Class;		public const SngDungeonOfIce:Song = addSong( DungeonOfIceData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasyMysticQuest/18 City of Fire ~ Faeria.spc", mimeType="application/octet-stream")]
		private const CityOfFireData:Class;		public const SngCityOfFire:Song = addSong( CityOfFireData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasyMysticQuest/20 Lava Dome.spc", mimeType="application/octet-stream")]
		private const LavaDomeData:Class;		public const SngLavaDome:Song = addSong( LavaDomeData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasyMysticQuest/22 Mountain Range of Whirlwinds.spc", mimeType="application/octet-stream")]
		private const MountainRangeData:Class;		public const SngMountainRange:Song = addSong( MountainRangeData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasyMysticQuest/24 Last Castle.spc", mimeType="application/octet-stream")]
		private const LastCastleData:Class;		public const SngLastCastle:Song = addSong( LastCastleData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/FinalFantasyMysticQuest/27 Ending.spc", mimeType="application/octet-stream")]
		private const EndingData:Class;		public const SngEnding:Song = addSong( EndingData, -1, null, VOLUME );

		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);

			addToTypePlayList(LT_CASTLE, SngMiddleTower);
			addToTypePlayList(LT_CHEEP_CHEEP, SngBattle1);
			addToTypePlayList(LT_COIN_HEAVEN, SngCityOfFire);
			addToTypePlayList(LT_INTRO, SngWorld);
			addToTypePlayList(LT_NORMAL, SngMysticQuest);
			addToTypePlayList(LT_PIPE_BONUS, SngCityOfForest);
			addToTypePlayList(LT_PLATFORM, SngMountainRange);
			addToTypePlayList(LT_UNDER_GROUND, SngDungeonOfIce);
			addToTypePlayList(LT_WATER, SngShrineOfLight);
			addToTypePlayList(MT_DARK_EPIC, SngLavaDome);
			
			addToTypePlayList(BOSS, SngBattle2);
			addToTypePlayList(CHAR_SEL, SngWorld);
			addToTypePlayList(CHOOSE_CHARACTER, SngFanfareOfFriendship);
			addToTypePlayList(CREDITS, SngEnding);
			addToTypePlayList(DIE, null);
			addToTypePlayList(FINAL_BOSS, SngLastCastle);
			addToTypePlayList(GAME_OVER, SngBeautifulForest);
			addToTypePlayList(HURRY, SngHillOfFate);
			addToTypePlayList(STAR, SngRockTheme);
			addToTypePlayList(TITLE_SCREEN, SngMysticQuest);
			addToTypePlayList(WIN, SngVictoryFanfare);
			addToTypePlayList(WIN_CASTLE, SngVictoryFanfare);
		}
	}
}