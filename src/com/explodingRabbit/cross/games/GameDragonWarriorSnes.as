package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameDragonWarriorSnes extends Game
	{
		private static var instance:Game; 
		
		public function GameDragonWarriorSnes(gameNum:int, skinSetNum:int = -1)
		{
			super("Dragon Quest I & II", "Square-Enix", Consoles.superNintendo, gameNum, "DQ I & II (SNES)", skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		private const VOLUME:int = 90;

		[Embed(source="../../../../../assets/audio/seq/spc/DragonQuest1-2/101 Overture (Full).spc", mimeType="application/octet-stream")]
		private const OvertureFullData:Class;	public const SngOvertureFull:Song = addSong( OvertureFullData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/DragonQuest1-2/201 Erdrick's Descendant.spc", mimeType="application/octet-stream")]
		private const ErdricksDescendantData:Class;	public const SngErdricksDescendant:Song = addSong( ErdricksDescendantData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/DragonQuest1-2/202 Tantegel Castle.spc", mimeType="application/octet-stream")]
		private const TantegelCastleData:Class;	public const SngTantegelCastle:Song = addSong( TantegelCastleData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/DragonQuest1-2/203 Peaceful Village.spc", mimeType="application/octet-stream")]
		private const PeacefulVillageData:Class;	public const SngPeacefulVillage:Song = addSong( PeacefulVillageData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/DragonQuest1-2/204 Kingdom of Alefgard.spc", mimeType="application/octet-stream")]
		private const KingdomOfAlefgardData:Class;	public const SngKingdomOfAlefgard:Song = addSong( KingdomOfAlefgardData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/DragonQuest1-2/205 A Monster Draws Near.spc", mimeType="application/octet-stream")]
		private const AMonsterDrawsNearData:Class;	public const SngAMonsterDrawsNear:Song = addSong( AMonsterDrawsNearData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/DragonQuest1-2/206 Thou Hast Died....spc", mimeType="application/octet-stream")]
		private const ThouHastDiedData:Class;	public const SngThouHastDied:Song = addSong( ThouHastDiedData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/DragonQuest1-2/208 Dark Dungeon ~ Floor 1.spc", mimeType="application/octet-stream")]
		private const DarkDungeonFloor1Data:Class;	public const SngDarkDungeonFloor1:Song = addSong( DarkDungeonFloor1Data, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/DragonQuest1-2/209 Dark Dungeon ~ Floor 2.spc", mimeType="application/octet-stream")]
		private const DarkDungeonFloor2Data:Class;	public const SngDarkDungeonFloor2:Song = addSong( DarkDungeonFloor2Data, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/DragonQuest1-2/212 Princess Gwaelin's Love.spc", mimeType="application/octet-stream")]
		private const PrincessGwaelinsLoveData:Class;		public const SngPrincessGwaelinsLove:Song = addSong( PrincessGwaelinsLoveData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/DragonQuest1-2/213 Rainbow Bridge.spc", mimeType="application/octet-stream")]
		private const RainbowBridgeData:Class;		public const SngRainbowBridge:Song = addSong( RainbowBridgeData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/DragonQuest1-2/214 Throne of Darkness.spc", mimeType="application/octet-stream")]
		private const ThroneOfDarknessData:Class;		public const SngThroneOfDarkness:Song = addSong( ThroneOfDarknessData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/DragonQuest1-2/215 The Dragonlord.spc", mimeType="application/octet-stream")]
		private const TheDragonlordData:Class;		public const SngTheDragonlord:Song = addSong( TheDragonlordData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/DragonQuest1-2/216 Hero's Fanfare.spc", mimeType="application/octet-stream")]
		private const HerosFanfareData:Class;		public const SngHerosFanfare:Song = addSong( HerosFanfareData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/DragonQuest1-2/218 Improvement.spc", mimeType="application/octet-stream")]
		private const ImprovementData:Class;		public const SngImprovement:Song = addSong( ImprovementData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/DragonQuest1-2/222 Fairy Flute.spc", mimeType="application/octet-stream")]
		private const FairyFluteData:Class;		public const SngFairyFlute:Song = addSong( FairyFluteData, -1, null, VOLUME );

		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);

			addToTypePlayList(LT_CASTLE, SngThroneOfDarkness);
			addToTypePlayList(LT_CHEEP_CHEEP, SngKingdomOfAlefgard);
			addToTypePlayList(LT_COIN_HEAVEN, SngPeacefulVillage);
			addToTypePlayList(LT_INTRO, SngRainbowBridge);
			addToTypePlayList(LT_NORMAL, SngKingdomOfAlefgard);
			addToTypePlayList(LT_PIPE_BONUS, SngDarkDungeonFloor2);
			addToTypePlayList(LT_PLATFORM, SngKingdomOfAlefgard);
			addToTypePlayList(LT_UNDER_GROUND, SngDarkDungeonFloor2);
			addToTypePlayList(LT_WATER, SngTantegelCastle);
			addToTypePlayList(MT_DARK_EPIC, SngTantegelCastle);
			
			addToTypePlayList(BOSS, SngAMonsterDrawsNear);
			addToTypePlayList(CHAR_SEL, SngErdricksDescendant);
			addToTypePlayList(CHOOSE_CHARACTER, SngFairyFlute);
			addToTypePlayList(CREDITS, SngHerosFanfare);
			addToTypePlayList(DIE, null);
			addToTypePlayList(FINAL_BOSS, SngTheDragonlord);
			addToTypePlayList(GAME_OVER, SngThouHastDied);
			addToTypePlayList(HURRY, SngDarkDungeonFloor1);
			addToTypePlayList(STAR, Games.superMarioBrosSnes.SngInvincible);
			addToTypePlayList(TITLE_SCREEN, SngOvertureFull);
			addToTypePlayList(WIN, SngImprovement);
			addToTypePlayList(WIN_CASTLE, SngPrincessGwaelinsLove);
		}
	}
}