package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameMegaMan4Gb extends Game
	{
		private static var instance:Game; 
		
		public function GameMegaMan4Gb(gameNum:int, skinSetNum:int = -1)
		{
			super("Mega Man IV (Game Boy)",  "Capcom", Consoles.gameBoy, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/gbs/MegaMan4.gbs", mimeType="application/octet-stream")]
		public const Gbs:Class;
		private const VOLUME:int = 60;
		
		public const SngBrightMan:Song = addSong( Gbs, 1, null, VOLUME );
		public const SngToadMan:Song = addSong( Gbs, 2, null, VOLUME );
		public const SngRingMan:Song = addSong( Gbs, 3, null, VOLUME );
		public const SngPharoahMan:Song = addSong( Gbs, 4, null, VOLUME );
		public const SngStoneMan:Song = addSong( Gbs, 5, null, VOLUME );
		public const SngCrystalMan:Song = addSong( Gbs, 6, null, VOLUME );
		public const SngChargeMan:Song = addSong( Gbs, 7, null, VOLUME );
		public const SngNapalmMan:Song = addSong( Gbs, 8, null, VOLUME );
		public const SngBossBattle2:Song = addSong( Gbs, 9, null, VOLUME );
		public const SngProtoWhistle:Song = addSong( Gbs, 10, null, VOLUME );
		public const SngStageSelect1:Song = addSong( Gbs, 11, null, VOLUME );
		public const SngStageSelect2:Song = addSong( Gbs, 12, null, VOLUME );
		public const SngPassword:Song = addSong( Gbs, 13, null, VOLUME );
		public const SngStageStart:Song = addSong( Gbs, 14, null, VOLUME );
		public const SngGameOver:Song = addSong( Gbs, 15, null, VOLUME );
		public const SngVictory:Song = addSong( Gbs, 16, null, VOLUME );
		public const SngFinalVictory:Song = addSong( Gbs, 17, null, VOLUME );
		public const SngGotWeapon:Song = addSong( Gbs, 18, null, VOLUME );
		public const SngGotBeat:Song = addSong( Gbs, 19, null, VOLUME );
		public const SngEnterBase:Song = addSong( Gbs, 20, null, VOLUME );
		public const SngWilyBaseEscape:Song = addSong( Gbs, 21, null, VOLUME );
		public const SngBossBattle1:Song = addSong( Gbs, 22, null, VOLUME );
		public const SngTitle:Song = addSong( Gbs, 23, null, VOLUME );
		public const SngEndingTheme:Song = addSong( Gbs, 24, null, VOLUME );
		public const SngAltWilyAssault:Song = addSong( Gbs, 25, null, VOLUME );
		public const SngWilyMachine:Song = addSong( Gbs, 26, null, VOLUME );
		public const SngAltWilyBattle:Song = addSong( Gbs, 27, null, VOLUME );
		public const SngWilyBattle:Song = addSong( Gbs, 28, null, VOLUME );
		public const SngWilyAssault:Song = addSong( Gbs, 29, null, VOLUME );
		public const SngAltGotBeat:Song = addSong( Gbs, 30, null, VOLUME );
		public const SngAltLab:Song = addSong( Gbs, 31, null, VOLUME );
		public const SngInstructions:Song = addSong( Gbs, 32, null, VOLUME );
		public const SngFinalStage:Song = addSong( Gbs, 33, null, VOLUME );
		public const SngRockTheme:Song = addSong( Gbs, 34, null, VOLUME );
		public const SngShop:Song = addSong( Gbs, 35, null, VOLUME );
		public const SngDie:Song = addSong( Gbs, 52, null, VOLUME );
		
		
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngFinalStage);
			addToTypePlayList(LT_CHEEP_CHEEP, SngBrightMan);
			addToTypePlayList(LT_COIN_HEAVEN, SngGotBeat);
			addToTypePlayList(LT_INTRO, SngStageSelect1);
			addToTypePlayList(LT_NORMAL, SngNapalmMan);
			addToTypePlayList(LT_PIPE_BONUS, SngStoneMan);
			addToTypePlayList(LT_PLATFORM, SngRingMan);
			addToTypePlayList(LT_UNDER_GROUND, SngCrystalMan);
			addToTypePlayList(LT_WATER, SngChargeMan);
			addToTypePlayList(MT_DARK_EPIC, SngPharoahMan);
			
			addToTypePlayList(BOSS, SngBossBattle2);
			addToTypePlayList(CHAR_SEL, SngStageSelect1);
			addToTypePlayList(CHOOSE_CHARACTER, SngProtoWhistle);
			addToTypePlayList(CREDITS, SngEndingTheme);
			addToTypePlayList(DIE, SngDie);
			addToTypePlayList(FINAL_BOSS, SngWilyBattle);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, SngToadMan);
			addToTypePlayList(STAR, SngAltLab);
			addToTypePlayList(TITLE_SCREEN, SngRockTheme);
			addToTypePlayList(WIN, SngVictory);
			addToTypePlayList(WIN_CASTLE, SngFinalVictory);
			
		}
	}
}