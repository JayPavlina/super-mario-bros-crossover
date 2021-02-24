package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameCastlevaniaDraculaX extends Game
	{
		private static var instance:Game; 
		
		public function GameCastlevaniaDraculaX(gameNum:int, skinSetNum:int = -1)
		{
			super("Castlevania: Dracula X", "Konami", Consoles.superNintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		private const VOLUME:int = 80;

		[Embed(source="../../../../../assets/audio/seq/spc/CastlevaniaDraculaX/01 Overture.spc", mimeType="application/octet-stream")]
		private const OvertureData:Class;	public const SngOverture:Song = addSong( OvertureData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/CastlevaniaDraculaX/02 Map.spc", mimeType="application/octet-stream")]
		private const MapData:Class;	public const SngMap:Song = addSong( MapData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/CastlevaniaDraculaX/03 Bloodlines.spc", mimeType="application/octet-stream")]
		private const BloodlinesData:Class;	public const SngBloodlines:Song = addSong( BloodlinesData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/CastlevaniaDraculaX/04 Vampire Hunter.spc", mimeType="application/octet-stream")]
		private const VampireHunterData:Class;	public const SngVampireHunter:Song = addSong( VampireHunterData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/CastlevaniaDraculaX/05 Bloody Tears.spc", mimeType="application/octet-stream")]
		private const BloodyTearsData:Class;	public const SngBloodyTears:Song = addSong( BloodyTearsData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/CastlevaniaDraculaX/06 Cemetery.spc", mimeType="application/octet-stream")]
		private const CemeteryData:Class;	public const SngCemetery:Song = addSong( CemeteryData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/CastlevaniaDraculaX/07 Slash.spc", mimeType="application/octet-stream")]
		private const SlashData:Class;	public const SngSlash:Song = addSong( SlashData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/CastlevaniaDraculaX/08 Picture of the Ghost Ship.spc", mimeType="application/octet-stream")]
		private const PictureOfTheGhostShipData:Class;	public const SngPictureOfTheGhostShip:Song = addSong( PictureOfTheGhostShipData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/CastlevaniaDraculaX/09 Beginning.spc", mimeType="application/octet-stream")]
		private const BeginningData:Class;	public const SngBeginning:Song = addSong( BeginningData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/CastlevaniaDraculaX/10 Den.spc", mimeType="application/octet-stream")]
		private const DenData:Class;		public const SngDen:Song = addSong( DenData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/CastlevaniaDraculaX/12 Boss.spc", mimeType="application/octet-stream")]
		private const BossData:Class;		public const SngBoss:Song = addSong( BossData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/CastlevaniaDraculaX/13 Illusionary Dance.spc", mimeType="application/octet-stream")]
		private const IllusionaryDanceData:Class;		public const SngIllusionaryDance:Song = addSong( IllusionaryDanceData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/CastlevaniaDraculaX/14 Rescued.spc", mimeType="application/octet-stream")]
		private const RescuedData:Class;		public const SngRescued:Song = addSong( RescuedData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/CastlevaniaDraculaX/15 Stage Clear.spc", mimeType="application/octet-stream")]
		private const StageClearData:Class;		public const SngStageClear:Song = addSong( StageClearData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/CastlevaniaDraculaX/16 Game Over.spc", mimeType="application/octet-stream")]
		private const GameOverData:Class;		public const SngGameOver:Song = addSong( GameOverData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/CastlevaniaDraculaX/18 Credit.spc", mimeType="application/octet-stream")]
		private const CreditData:Class;		public const SngCredit:Song = addSong( CreditData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/CastlevaniaDraculaX/99 Death of Richter.spc", mimeType="application/octet-stream")]
		private const DeathOfRichterData:Class;		public const SngDeathOfRichter:Song = addSong( DeathOfRichterData, -1, null, VOLUME );
		
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);

			addToTypePlayList(LT_CASTLE, SngCemetery);
			addToTypePlayList(LT_CHEEP_CHEEP, SngBloodyTears);
			addToTypePlayList(LT_COIN_HEAVEN, SngDen);
			addToTypePlayList(LT_INTRO, SngRescued);
			addToTypePlayList(LT_NORMAL, SngBloodlines);
			addToTypePlayList(LT_PIPE_BONUS, SngSlash);
			addToTypePlayList(LT_PLATFORM, SngBloodyTears);
			addToTypePlayList(LT_UNDER_GROUND, SngSlash);
			addToTypePlayList(LT_WATER, SngPictureOfTheGhostShip);
			addToTypePlayList(MT_DARK_EPIC, SngVampireHunter);
			
			addToTypePlayList(BOSS, SngBoss);
			addToTypePlayList(CHAR_SEL, SngOverture);
			addToTypePlayList(CHOOSE_CHARACTER, SngMap);
			addToTypePlayList(CREDITS, SngCredit);
			addToTypePlayList(DIE, SngDeathOfRichter);
			addToTypePlayList(FINAL_BOSS, SngIllusionaryDance);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, Games.superCastlevania4.SngRoomOfCloseAssociates);
			addToTypePlayList(STAR, Games.superCastlevania4.SngBeginning);
			addToTypePlayList(TITLE_SCREEN, SngOverture);
			addToTypePlayList(WIN, SngStageClear);
			addToTypePlayList(WIN_CASTLE, SngStageClear);
		}
	}
}