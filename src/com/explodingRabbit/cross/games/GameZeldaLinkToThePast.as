package com.explodingRabbit.cross.games
{
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameZeldaLinkToThePast extends Game
	{
		private static var instance:Game; 
		
		public function GameZeldaLinkToThePast(gameNum:int, skinSetNum:int = -1)
		{
			super("The Legend of Zelda: A Link To The Past", "Nintendo", Consoles.superNintendo, gameNum, "LOZ: A Link to the Past", skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		private const VOLUME:int = 75;
		
		[Embed(source="../../../../../assets/audio/seq/spc/ZeldaLinkToThePast/Hyrule Field Main Theme.spc", mimeType="application/octet-stream")]
		private const HyruleFieldData:Class;		public const SngHyruleField:Song = addSong( HyruleFieldData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/ZeldaLinkToThePast/Dark Golden Land.spc", mimeType="application/octet-stream")]
		private const DarkGoldenLandData:Class;	public const SngDarkGoldenLand:Song = addSong( DarkGoldenLandData, -1, null, VOLUME );
		
//		[Embed(source="../../../../../assets/audio/seq/spc/ZeldaLinkToThePast/Treasure!.spc", mimeType="application/octet-stream")]
//		private const TreasureData:Class;		public const SngTreasure:Song = addSong( TreasureData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/ZeldaLinkToThePast/Guessing-Game House.spc", mimeType="application/octet-stream")]
		private const GuessingGameHouseData:Class;	public const SngGuessingGameHouse:Song = addSong( GuessingGameHouseData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/ZeldaLinkToThePast/Lost Ancient Ruins.spc", mimeType="application/octet-stream")]
		private const LostAncientRuinsData:Class;	public const SngLostAncientRuins:Song = addSong( LostAncientRuinsData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/ZeldaLinkToThePast/Beginning of the Journey.spc", mimeType="application/octet-stream")]
		private const BeginningOfTheJourneyData:Class;	public const SngBeginningOfTheJourney:Song = addSong( BeginningOfTheJourneyData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/ZeldaLinkToThePast/Great Victory!.spc", mimeType="application/octet-stream")]
		private const GreatVictoryData:Class;	public const SngGreatVictory:Song = addSong( GreatVictoryData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/ZeldaLinkToThePast/Princess Zelda's Rescue.spc", mimeType="application/octet-stream")]
		private const PrincessZeldasRescueData:Class;	public const SngPrincessZeldasRescue:Song = addSong( PrincessZeldasRescueData, -1, null, VOLUME );

//		[Embed(source="../../../../../assets/audio/seq/spc/ZeldaLinkToThePast/Priest of the Dark Order.spc", mimeType="application/octet-stream")]
//		private const PriestOfTheDarkOrderData:Class;	public const SngPriestOfTheDarkOrder:Song = addSong( PriestOfTheDarkOrderData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/ZeldaLinkToThePast/Dank Dungeons.spc", mimeType="application/octet-stream")]
		private const DankDungeonsData:Class;	public const SngDankDungeons:Song = addSong( DankDungeonsData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/ZeldaLinkToThePast/The Silly Pink Rabbit!.spc", mimeType="application/octet-stream")]
		private const TheSillyPinkRabbitData:Class;	public const SngTheSillyPinkRabbit:Song = addSong( TheSillyPinkRabbitData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/ZeldaLinkToThePast/Soldiers of Kakariko Village.spc", mimeType="application/octet-stream")]
		private const SoldiersOfKakarikoVillageData:Class;	public const SngSoldiersOfKakarikoVillage:Song = addSong( SoldiersOfKakarikoVillageData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/ZeldaLinkToThePast/Seal of Seven Maidens.spc", mimeType="application/octet-stream")]
		private const SealOfSevenMaidensData:Class;	public const SngSealOfSevenMaidens:Song = addSong( SealOfSevenMaidensData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/ZeldaLinkToThePast/The Prince of Darkness.spc", mimeType="application/octet-stream")]
		private const ThePrinceOfDarknessData:Class;	public const SngThePrinceOfDarknessData:Song = addSong( ThePrinceOfDarknessData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/ZeldaLinkToThePast/Epilogue ~ Beautiful Hyrule.spc", mimeType="application/octet-stream")]
		private const EpilogueData:Class;	public const SngEpilogue:Song = addSong( EpilogueData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/ZeldaLinkToThePast/Dungeon of Shadows.spc", mimeType="application/octet-stream")]
		private const DungeonOfShadowsData:Class;	public const SngDungeonOfShadows:Song = addSong( DungeonOfShadowsData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/ZeldaLinkToThePast/Forest of Mystery.spc", mimeType="application/octet-stream")]
		private const ForestOfMysteryData:Class;	public const SngForestOfMystery:Song = addSong( ForestOfMysteryData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/ZeldaLinkToThePast/Anger of the Guardians.spc", mimeType="application/octet-stream")]
		private const AngerOfTheGuardiansData:Class;	public const SngAngerOfTheGuardians:Song = addSong( AngerOfTheGuardiansData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/ZeldaLinkToThePast/Ocarina Song (Short).spc", mimeType="application/octet-stream")]
		private const OcarinaSongShortData:Class;	public const SngOcarinaSongShort:Song = addSong( OcarinaSongShortData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/ZeldaLinkToThePast/Black Mist.spc", mimeType="application/octet-stream")]
		private const BlackMistData:Class;	public const SngBlackMist:Song = addSong( BlackMistData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/ZeldaLinkToThePast/Kakariko Village.spc", mimeType="application/octet-stream")]
		private const KakarikoVillageData:Class;	public const SngKakarikoVillage:Song = addSong( KakarikoVillageData, -1, null, VOLUME );
		
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngDungeonOfShadows);
			addToTypePlayList(LT_CHEEP_CHEEP, SngBlackMist);
			addToTypePlayList(LT_COIN_HEAVEN, SngGuessingGameHouse);
			addToTypePlayList(LT_INTRO, SngKakarikoVillage);
			addToTypePlayList(LT_NORMAL, SngHyruleField);
			addToTypePlayList(LT_PIPE_BONUS, SngDankDungeons);
			addToTypePlayList(LT_PLATFORM, SngForestOfMystery);
			addToTypePlayList(LT_UNDER_GROUND, SngLostAncientRuins);
			addToTypePlayList(LT_WATER, SngSealOfSevenMaidens);
			addToTypePlayList(MT_DARK_EPIC, SngDarkGoldenLand);
			
			addToTypePlayList(BOSS, SngAngerOfTheGuardians);
			addToTypePlayList(CHAR_SEL, SngBeginningOfTheJourney);
			addToTypePlayList(CHOOSE_CHARACTER, SngOcarinaSongShort);
			addToTypePlayList(CREDITS, SngEpilogue);
			addToTypePlayList(DIE, null);
			addToTypePlayList(FINAL_BOSS, SngThePrinceOfDarknessData);
			addToTypePlayList(GAME_OVER, SngBeginningOfTheJourney);
			addToTypePlayList(HURRY, SngSoldiersOfKakarikoVillage);
			addToTypePlayList(STAR, SngTheSillyPinkRabbit);
			addToTypePlayList(TITLE_SCREEN, SngHyruleField);
			addToTypePlayList(WIN, SngGreatVictory);
			addToTypePlayList(WIN_CASTLE, SngPrincessZeldasRescue);
		}
	}
}