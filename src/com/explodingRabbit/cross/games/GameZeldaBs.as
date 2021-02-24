package com.explodingRabbit.cross.games
{
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameZeldaBs extends Game
	{
		private static var instance:Game; 
		
		public function GameZeldaBs(gameNum:int, skinSetNum:int = -1)
		{
			super("BS The Legend of Zelda", "Nintendo", Consoles.superNintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		private const VOLUME:int = 90;
		
		[Embed(source="../../../../../assets/audio/seq/spc/BSZelda/01 Main Theme.spc", mimeType="application/octet-stream")]
		private const MainThemeData:Class;		public const SngMainTheme:Song = addSong( MainThemeData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/BSZelda/02 Overworld.spc", mimeType="application/octet-stream")]
		private const OverworldData:Class;		public const SngOverworld:Song = addSong( OverworldData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/BSZelda/03 Dungeon.spc", mimeType="application/octet-stream")]
		private const DungeonData:Class;		public const SngDungeon:Song = addSong( DungeonData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/BSZelda/04 Ganon's Lair.spc", mimeType="application/octet-stream")]
		private const GanonsLairData:Class;		public const SngGanonsLair:Song = addSong( GanonsLairData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/BSZelda/06 Zelda Rescued.spc", mimeType="application/octet-stream")]
		private const ZeldaRescuedData:Class;		public const SngZeldaRescued:Song = addSong( ZeldaRescuedData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/BSZelda/07 Ending.spc", mimeType="application/octet-stream")]
		private const EndingData:Class;		public const SngEnding:Song = addSong( EndingData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/BSZelda/99 Discovery.spc", mimeType="application/octet-stream")]
		private const DiscoveryData:Class;		public const SngDiscovery:Song = addSong( DiscoveryData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/BSZelda/99 Triforce of Power.spc", mimeType="application/octet-stream")]
		private const TriforceOfPowerData:Class;		public const SngTriforceOfPower:Song = addSong( TriforceOfPowerData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/BSZelda/99 Triforce of Wisdom.spc", mimeType="application/octet-stream")]
		private const TriforceOfWisdomData:Class;		public const SngTriforceOfWisdom:Song = addSong( TriforceOfWisdomData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/BSZelda/99 Whistle.spc", mimeType="application/octet-stream")]
		private const WhistleData:Class;		public const SngWhistle:Song = addSong( WhistleData, -1, null, VOLUME );

		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngGanonsLair);
			addToTypePlayList(LT_CHEEP_CHEEP, SngOverworld);
			addToTypePlayList(LT_COIN_HEAVEN, SngZeldaRescued);
			addToTypePlayList(LT_INTRO, SngDiscovery);
			addToTypePlayList(LT_NORMAL, SngOverworld);
			addToTypePlayList(LT_PIPE_BONUS, SngDungeon);
			addToTypePlayList(LT_PLATFORM, SngOverworld);
			addToTypePlayList(LT_UNDER_GROUND, SngDungeon);
			addToTypePlayList(LT_WATER, SngMainTheme);
			addToTypePlayList(MT_DARK_EPIC, SngOverworld);
			
			addToTypePlayList(BOSS, Games.zeldaLinkToThePast.SngAngerOfTheGuardians);
			addToTypePlayList(CHAR_SEL, SngZeldaRescued);
			addToTypePlayList(CHOOSE_CHARACTER, SngWhistle);
			addToTypePlayList(CREDITS, SngEnding);
			addToTypePlayList(DIE, null);
			addToTypePlayList(FINAL_BOSS, Games.zeldaLinkToThePast.SngThePrinceOfDarknessData);
			addToTypePlayList(GAME_OVER, SngZeldaRescued);
			addToTypePlayList(HURRY, Games.zeldaLinkToThePast.SngSoldiersOfKakarikoVillage);
			addToTypePlayList(STAR, Games.superMarioBrosSnes.SngInvincible);
			addToTypePlayList(TITLE_SCREEN, SngMainTheme);
			addToTypePlayList(WIN, SngTriforceOfPower);
			addToTypePlayList(WIN_CASTLE, SngTriforceOfWisdom);
		}
	}
}