package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameCastlevaniaLegends extends Game
	{
		private static var instance:Game; 
		
		public function GameCastlevaniaLegends(gameNum:int, skinSetNum:int = -1)
		{
			super("Castlevania Legends", "Konami", Consoles.gameBoy, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/gbs/CastlevaniaLegends.gbs", mimeType="application/octet-stream")]
		public const Gbs:Class;
		private const VOLUME:int = 50;
		
		public const SngEpilogue:Song = addSong( Gbs, 1, null, VOLUME );
		public const SngTrapRoom:Song = addSong( Gbs, 2, null, VOLUME );
		public const SngUnusedOkada:Song = addSong( Gbs, 3, null, VOLUME );
		public const SngBloodyTearsStage1:Song = addSong( Gbs, 4, null, VOLUME );
		public const SngBossBattle:Song = addSong( Gbs, 5, null, VOLUME );
		public const SngUnderGroundWaterStage5:Song = addSong( Gbs, 6, null, VOLUME );
		public const SngAlacardBattle:Song = addSong( Gbs, 7, null, VOLUME );
		public const SngInsideTheCastle2:Song = addSong( Gbs, 8, null, VOLUME );
		public const SngClockTowerStage3:Song = addSong( Gbs, 9, null, VOLUME );
		public const SngHighestCastleFloorStage4:Song = addSong( Gbs, 10, null, VOLUME );
		public const SngDungeonOfSilenceSecretStage:Song = addSong( Gbs, 11, null, VOLUME );
		public const SngTitle:Song = addSong( Gbs, 12, null, VOLUME );
		public const SngPrologue:Song = addSong( Gbs, 13, null, VOLUME );
//		public const SngHopeAndDesire:Song = addSong( Gbs, 14, null, VOLUME );
		public const SngDraculaBattle:Song = addSong( Gbs, 15, null, VOLUME );
		public const SngVampireKillerFinalBattle:Song = addSong( Gbs, 16, null, VOLUME );
		public const SngEnding:Song = addSong( Gbs, 17, null, VOLUME );
		public const SngGateKeeperMiniBoss:Song = addSong( Gbs, 18, null, VOLUME );
		public const SngGameSelect:Song = addSong( Gbs, 19, null, VOLUME );
		public const SngTheCastleLordsRoom:Song = addSong( Gbs, 20, null, VOLUME );
		public const SngDraculaCastleCathedral:Song = addSong( Gbs, 21, null, VOLUME );
		public const SngGameOverUnused:Song = addSong( Gbs, 22, null, VOLUME );
		public const SngDie:Song = addSong( Gbs, 45, null, VOLUME );
		public const SngQuickJingle:Song = addSong( Gbs, 73, null, VOLUME );
		
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngTheCastleLordsRoom);
			addToTypePlayList(LT_CHEEP_CHEEP, SngDungeonOfSilenceSecretStage);
			addToTypePlayList(LT_COIN_HEAVEN, SngDraculaCastleCathedral);
			addToTypePlayList(LT_INTRO, SngPrologue);
			addToTypePlayList(LT_NORMAL, SngBloodyTearsStage1);
			addToTypePlayList(LT_PIPE_BONUS, SngInsideTheCastle2);
			addToTypePlayList(LT_PLATFORM, SngClockTowerStage3);
			addToTypePlayList(LT_UNDER_GROUND, SngInsideTheCastle2);
			addToTypePlayList(LT_WATER, SngUnderGroundWaterStage5);
			addToTypePlayList(MT_DARK_EPIC, SngHighestCastleFloorStage4);
			
			addToTypePlayList(BOSS, SngBossBattle);
			addToTypePlayList(CHAR_SEL, SngGameSelect);
			addToTypePlayList(CHOOSE_CHARACTER, SngTitle);
			addToTypePlayList(CREDITS, SngEnding);
			addToTypePlayList(DIE, SngDie);
			addToTypePlayList(FINAL_BOSS, SngDraculaBattle);
			addToTypePlayList(GAME_OVER, SngGameOverUnused);
			addToTypePlayList(HURRY, SngGateKeeperMiniBoss);
			addToTypePlayList(STAR, SngVampireKillerFinalBattle);
			addToTypePlayList(TITLE_SCREEN, SngBloodyTearsStage1);
			addToTypePlayList(WIN, Games.castlevaniaAdventure.SngVictory);
			addToTypePlayList(WIN_CASTLE, SngEpilogue);
			
		}
	}
}