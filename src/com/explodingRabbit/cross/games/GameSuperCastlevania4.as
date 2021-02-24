package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameSuperCastlevania4 extends Game
	{
		private static var instance:Game; 
		
		public function GameSuperCastlevania4(gameNum:int, skinSetNum:int = -1)
		{
			super("Super Castlevania IV", "Konami", Consoles.superNintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		private const VOLUME:int = 80;
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperCastlevania4/Beginning.spc", mimeType="application/octet-stream")]
		private const BeginningData:Class;	public const SngBeginning:Song = addSong( BeginningData, -1, null, VOLUME );
		
//		[Embed(source="../../../../../assets/audio/seq/spc/SuperCastlevania4/Bloody Tears.spc", mimeType="application/octet-stream")]
//		private const BloodyTearsData:Class;	public const SngBloodyTears:Song = addSong( BloodyTearsData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperCastlevania4/Death of Simon.spc", mimeType="application/octet-stream")]
		private const DeathOfSimonData:Class;	public const SngDeathOfSimon:Song = addSong( DeathOfSimonData, -1, null, VOLUME );
		
//		[Embed(source="../../../../../assets/audio/seq/spc/SuperCastlevania4/Dracula's Theme.spc", mimeType="application/octet-stream")]
//		private const DraculasThemeData:Class;	public const SngDraculasTheme:Song = addSong( DraculasThemeData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperCastlevania4/Game Over.spc", mimeType="application/octet-stream")]
		private const GameOverData:Class;	public const SngGameOver:Song = addSong( GameOverData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperCastlevania4/In the Castle.spc", mimeType="application/octet-stream")]
		private const InTheCastleData:Class;	public const SngInTheCastle:Song = addSong( InTheCastleData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperCastlevania4/Secret Room.spc", mimeType="application/octet-stream")]
		private const SecretRoomData:Class;	public const SngSecretRoom:Song = addSong( SecretRoomData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperCastlevania4/Stage Clear.spc", mimeType="application/octet-stream")]
		private const StageClearData:Class;	public const SngStageClear:Song = addSong( StageClearData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperCastlevania4/The Cave.spc", mimeType="application/octet-stream")]
		private const TheCaveData:Class;		public const SngTheCave:Song = addSong( TheCaveData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperCastlevania4/Theme of Simon.spc", mimeType="application/octet-stream")]
		private const ThemeOfSimonData:Class;	public const SngThemeOfSimon:Song = addSong( ThemeOfSimonData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperCastlevania4/Vampire Killer.spc", mimeType="application/octet-stream")]
		private const VampireKillerData:Class;	public const SngVampireKiller:Song = addSong( VampireKillerData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperCastlevania4/Dracula Battle.spc", mimeType="application/octet-stream")]
		private const DraculaBattleData:Class;	public const SngDraculaBattle:Song = addSong( DraculaBattleData, -1, null, VOLUME );
				
		[Embed(source="../../../../../assets/audio/seq/spc/SuperCastlevania4/Boss 1.spc", mimeType="application/octet-stream")]
		private const Boss1Data:Class;	public const SngBoss1:Song = addSong( Boss1Data, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperCastlevania4/Ending.spc", mimeType="application/octet-stream")]
		private const EndingData:Class;	public const SngEnding:Song = addSong( EndingData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperCastlevania4/Password.spc", mimeType="application/octet-stream")]
		private const PasswordData:Class;	public const SngPassword:Song = addSong( PasswordData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperCastlevania4/The Waterfalls.spc", mimeType="application/octet-stream")]
		private const TheWaterfallsData:Class;	public const SngTheWaterfalls:Song = addSong( TheWaterfallsData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperCastlevania4/Pillared Corridor.spc", mimeType="application/octet-stream")]
		private const PillardCorridorData:Class;	public const SngPillardCorridor:Song = addSong( PillardCorridorData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperCastlevania4/Room of Close Associates.spc", mimeType="application/octet-stream")]
		private const RoomOfCloseAssociatesData:Class;	public const SngRoomOfCloseAssociates:Song = addSong( RoomOfCloseAssociatesData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperCastlevania4/Map A.spc", mimeType="application/octet-stream")]
		private const MapAData:Class;	public const SngMapA:Song = addSong( MapAData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperCastlevania4/Map C.spc", mimeType="application/octet-stream")]
		private const MapCData:Class;	public const SngMapC:Song = addSong( MapCData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperCastlevania4/Chandeliers.spc", mimeType="application/octet-stream")]
		private const ChandeliersData:Class;	public const SngChandeliers:Song = addSong( ChandeliersData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperCastlevania4/Dracula's Death.spc", mimeType="application/octet-stream")]
		private const DraculasDeathData:Class;	public const SngDraculasDeath:Song = addSong( DraculasDeathData, -1, null, VOLUME );
		
//		[Embed(source="../../../../../assets/audio/seq/spc/SuperCastlevania4/Cellar.spc", mimeType="application/octet-stream")]
//		private const CellarData:Class;	public const SngCellar:Song = addSong( CellarData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/SuperCastlevania4/Spinning Tower.spc", mimeType="application/octet-stream")]
		private const SpinningTowerData:Class;	public const SngSpinningTower:Song = addSong( SpinningTowerData, -1, null, VOLUME );
		
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngInTheCastle);
			addToTypePlayList(LT_CHEEP_CHEEP, SngChandeliers);
			addToTypePlayList(LT_COIN_HEAVEN, SngPillardCorridor);
			addToTypePlayList(LT_INTRO, SngMapA);
			addToTypePlayList(LT_NORMAL, SngVampireKiller);
			addToTypePlayList(LT_PIPE_BONUS, SngSecretRoom);
			addToTypePlayList(LT_PLATFORM, SngSpinningTower);
			addToTypePlayList(LT_UNDER_GROUND, SngTheCave);
			addToTypePlayList(LT_WATER, SngTheWaterfalls);
			addToTypePlayList(MT_DARK_EPIC, SngThemeOfSimon);
			
			addToTypePlayList(BOSS, SngBoss1);
			addToTypePlayList(CHAR_SEL, SngPassword);
			addToTypePlayList(CHOOSE_CHARACTER, SngMapC);
			addToTypePlayList(CREDITS, SngEnding);
			addToTypePlayList(DIE, SngDeathOfSimon);
			addToTypePlayList(FINAL_BOSS, SngDraculaBattle);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, SngRoomOfCloseAssociates);
			addToTypePlayList(STAR, SngBeginning);
			addToTypePlayList(TITLE_SCREEN, SngThemeOfSimon);
			addToTypePlayList(WIN, SngStageClear);
			addToTypePlayList(WIN_CASTLE, SngDraculasDeath);
			
		}
	}
}