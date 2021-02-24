package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameZeldaLinksAwakening extends Game
	{
		private static var instance:Game; 
		
		public function GameZeldaLinksAwakening(gameNum:int, skinSetNum:int = -1)
		{
			super("The Legend of Zelda: Link's Awakening", "Nintendo", Consoles.gameBoy, gameNum, "LOZ: Link's Awakening", skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/gbs/ZeldaLinksAwakening.gbs", mimeType="application/octet-stream")]
		public const Gbs:Class;
		
		private const VOLUME:int = 70; 
		
		public const SngTitle:Song = addSong( Gbs, 1, null, VOLUME );
		public const SngCraneGame:Song = addSong( Gbs, 2, null, VOLUME );
		public const SngGameOver:Song = addSong( Gbs, 3, null, VOLUME );
		public const SngMabeVillage:Song = addSong( Gbs, 4, null, VOLUME );
		public const SngOverworld:Song = addSong( Gbs, 5, null, VOLUME );
		public const SngTalTalHeights:Song = addSong( Gbs, 6, null, VOLUME );
		public const SngStore:Song = addSong( Gbs, 7, null, VOLUME );
		public const SngStrangeWoods:Song = addSong( Gbs, 8, null, VOLUME );
		public const SngMysteriousWoods:Song = addSong( Gbs, 9, null, VOLUME );
		public const SngHouse:Song = addSong( Gbs, 10, null, VOLUME );
		public const SngHouse2:Song = addSong( Gbs, 11, null, VOLUME );
		public const SngFairy:Song = addSong( Gbs, 12, null, VOLUME );
		public const SngTitle2:Song = addSong( Gbs, 13, null, VOLUME );
		public const SngSaveBowWow:Song = addSong( Gbs, 14, null, VOLUME );
		public const SngGlitchSword:Song = addSong( Gbs, 15, null, VOLUME );
		public const SngGlitchItem:Song = addSong( Gbs, 16, null, VOLUME );
		public const SngFileSelect:Song = addSong( Gbs, 17, null, VOLUME );
		public const SngSpookyCave:Song = addSong( Gbs, 18, null, VOLUME );
		public const SngDungeonCave:Song = addSong( Gbs, 19, null, VOLUME );
		public const SngTailCave:Song = addSong( Gbs, 20, null, VOLUME );
		public const SngBottleGrotto:Song = addSong( Gbs, 21, null, VOLUME );
		public const SngKeyCavern:Song = addSong( Gbs, 22, null, VOLUME );
		public const SngAnglerTunnel:Song = addSong( Gbs, 23, null, VOLUME );
		public const SngInstrumentRoom:Song = addSong( Gbs, 24, null, VOLUME );
		public const SngBoss:Song = addSong( Gbs, 25, null, VOLUME );
		public const SngIntro:Song = addSong( Gbs, 26, null, VOLUME );
		public const SngGetInstrument:Song = addSong( Gbs, 27, null, VOLUME );
		public const SngEchoHouse:Song = addSong( Gbs, 28, null, VOLUME );
		public const SngBeach:Song = addSong( Gbs, 29, null, VOLUME );
		public const SngTransition:Song = addSong( Gbs, 30, null, VOLUME );
		public const SngEerieRuins:Song = addSong( Gbs, 31, null, VOLUME );
		public const SngBallad1:Song = addSong( Gbs, 32, null, VOLUME );
		public const SngCave2:Song = addSong( Gbs, 33, null, VOLUME );
		public const SngOwl:Song = addSong( Gbs, 34, null, VOLUME );
		public const SngFinalBoss:Song = addSong( Gbs, 35, null, VOLUME );
		public const SngUpperDream:Song = addSong( Gbs, 36, null, VOLUME );
		public const SngBeatBoss:Song = addSong( Gbs, 37, null, VOLUME );
		public const SngCave3:Song = addSong( Gbs, 38, null, VOLUME );
		public const SngAcornPower:Song = addSong( Gbs, 39, null, VOLUME );
		public const SngBallad2:Song = addSong( Gbs, 40, null, VOLUME );
		public const SngBallad3:Song = addSong( Gbs, 41, null, VOLUME );
		public const SngWindfish:Song = addSong( Gbs, 42, null, VOLUME );
		public const SngBallad4:Song = addSong( Gbs, 43, null, VOLUME );
		public const SngBallad5:Song = addSong( Gbs, 44, null, VOLUME );
		public const SngBallad6:Song = addSong( Gbs, 45, null, VOLUME );
		public const SngBallad7:Song = addSong( Gbs, 46, null, VOLUME );
		public const SngMaronSong:Song = addSong( Gbs, 47, null, VOLUME );
		public const SngMamboMambo:Song = addSong( Gbs, 48, null, VOLUME );
		public const SngGetSword:Song = addSong( Gbs, 49, null, VOLUME );
		public const SngHouse3:Song = addSong( Gbs, 50, null, VOLUME );
		public const SngPhoneHouse:Song = addSong( Gbs, 51, null, VOLUME );
		public const SngRunning:Song = addSong( Gbs, 52, null, VOLUME );
		public const SngWart:Song = addSong( Gbs, 53, null, VOLUME );
		public const SngMokeyBridge:Song = addSong( Gbs, 54, null, VOLUME );
		public const SngRichardVilla:Song = addSong( Gbs, 55, null, VOLUME );
		public const SngBallad8:Song = addSong( Gbs, 56, null, VOLUME );
		public const SngTempleFight:Song = addSong( Gbs, 57, null, VOLUME );
		public const SngTrendyGame:Song = addSong( Gbs, 58, null, VOLUME );
		public const SngItem:Song = addSong( Gbs, 59, null, VOLUME );
		public const SngZeldaTune:Song = addSong( Gbs, 60, null, VOLUME );
		public const SngCredits:Song = addSong( Gbs, 61, null, VOLUME );
		public const SngSaveBowWow2:Song = addSong( Gbs, 62, null, VOLUME );
		public const SngBallad9:Song = addSong( Gbs, 63, null, VOLUME );
		public const SngVilla2:Song = addSong( Gbs, 64, null, VOLUME );
		public const SngBallad10:Song = addSong( Gbs, 65, null, VOLUME );
		public const SngBallad11:Song = addSong( Gbs, 66, null, VOLUME );
		public const SngBallad12:Song = addSong( Gbs, 67, null, VOLUME );
		public const SngBallad13:Song = addSong( Gbs, 68, null, VOLUME );
		public const SngBallad14:Song = addSong( Gbs, 69, null, VOLUME );
		public const SngBallad15:Song = addSong( Gbs, 70, null, VOLUME );
		public const SngBallad16:Song = addSong( Gbs, 71, null, VOLUME );
		public const SngGhostHouse:Song = addSong( Gbs, 72, null, VOLUME );
		public const SngAdrenaline:Song = addSong( Gbs, 73, null, VOLUME );
		public const SngBallad17:Song = addSong( Gbs, 74, null, VOLUME );
		public const SngCatfishMaw:Song = addSong( Gbs, 75, null, VOLUME );
		public const SngStrange:Song = addSong( Gbs, 76, null, VOLUME );
		public const SngJingle1:Song = addSong( Gbs, 77, null, VOLUME );
		public const SngBeachTalk:Song = addSong( Gbs, 78, null, VOLUME );
		public const SngJingle2:Song = addSong( Gbs, 79, null, VOLUME );
		public const SngMiniBoss:Song = addSong( Gbs, 80, null, VOLUME );
		public const SngFaceShrine:Song = addSong( Gbs, 81, null, VOLUME );
		public const SngTailCave2:Song = addSong( Gbs, 82, null, VOLUME );
		public const SngDreamShrine:Song = addSong( Gbs, 83, null, VOLUME );
		public const SngStrangeBoss:Song = addSong( Gbs, 84, null, VOLUME );
		public const SngSpectralStairs:Song = addSong( Gbs, 85, null, VOLUME );
		public const SngStairCreate:Song = addSong( Gbs, 86, null, VOLUME );
		public const SngVillage:Song = addSong( Gbs, 87, null, VOLUME );
		public const SngEagleTower:Song = addSong( Gbs, 88, null, VOLUME );
		public const SngWindFishBroken:Song = addSong( Gbs, 89, null, VOLUME );
		public const SngUnknownDungeon:Song = addSong( Gbs, 90, null, VOLUME );
		public const SngTurtleRock:Song = addSong( Gbs, 91, null, VOLUME );
		public const SngNightmare1:Song = addSong( Gbs, 92, null, VOLUME );
		public const SngNightmare2:Song = addSong( Gbs, 93, null, VOLUME );
		public const SngNightmare3:Song = addSong( Gbs, 94, null, VOLUME );
		public const SngBeatNightmare:Song = addSong( Gbs, 95, null, VOLUME );
		public const SngZeldaTune2:Song = addSong( Gbs, 96, null, VOLUME );
		public const SngColorDungeon:Song = addSong( Gbs, 97, null, VOLUME );
		public const SngItemTune:Song = addSong( Gbs, 98, null, VOLUME );
		public const SngSolveTune:Song = addSong( Gbs, 99, null, VOLUME );
		public const SngDie:Song = addSong( Gbs, 169, null, VOLUME );
		public const SngOcarinaBallad:Song = addSong( Gbs, 170, null, VOLUME );
		
		override protected function setUpLevelThemes():void
		{
			
		}
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL); // song types that will switch to DARK_EPIC song if the theme is dark
			
			addToTypePlayList(LT_CASTLE, SngBottleGrotto); //82
			addToTypePlayList(LT_CHEEP_CHEEP, SngStrangeWoods); //
			addToTypePlayList(LT_COIN_HEAVEN, SngZeldaTune2); //96
			addToTypePlayList(LT_INTRO, SngSolveTune); //99
			addToTypePlayList(LT_NORMAL, SngOverworld); //5
			addToTypePlayList(LT_PIPE_BONUS, SngHouse2); //11
			addToTypePlayList(LT_PLATFORM, SngMysteriousWoods); //9
			addToTypePlayList(LT_UNDER_GROUND, SngCave3); //38
			addToTypePlayList(LT_WATER, SngBeach); //29
			addToTypePlayList(MT_DARK_EPIC, SngTalTalHeights); //6
			
			addToTypePlayList(BOSS, SngBoss); //25
			addToTypePlayList(CHAR_SEL, SngFileSelect); //17
			addToTypePlayList(CHOOSE_CHARACTER, SngOcarinaBallad); //170
			addToTypePlayList(CREDITS, SngCredits); //61
			addToTypePlayList(DIE, SngDie); //169
			addToTypePlayList(FINAL_BOSS, SngFinalBoss); //35
			addToTypePlayList(GAME_OVER, SngGameOver); //3
			addToTypePlayList(HURRY, SngSaveBowWow2); //62
			addToTypePlayList(STAR, SngAdrenaline); //73
			addToTypePlayList(TITLE_SCREEN, SngTitle); //1
			addToTypePlayList(WIN, SngBeatBoss); //27
			addToTypePlayList(WIN_CASTLE, SngGetInstrument); //27
		}
	}
}