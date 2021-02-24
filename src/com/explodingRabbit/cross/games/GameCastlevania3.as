package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameCastlevania3 extends Game
	{
		private static var instance:Game; 
		
		public function GameCastlevania3(gameNum:int, skinSetNum:int = -1)
		{
			super("Castlevania III: Dracula's Curse", "Konami", Consoles.nintendo, gameNum, "Castlevania III", skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/nsf/Castlevania3.nsf", mimeType="application/octet-stream")]
		public const Nsf:Class;
		
		private const VOLUME:int = 65;
		
		public const SngBeginning:Song = addSong( Nsf, 1, null, VOLUME );
		public const SngClockwork:Song = addSong( Nsf, 2, null, VOLUME );
		public const SngMadForest:Song = addSong( Nsf, 3, null, VOLUME );
		public const SngAnxiety:Song = addSong( Nsf, 4, null, VOLUME );
		public const SngRising:Song = addSong( Nsf, 5, null, VOLUME );
		public const SngStream:Song = addSong( Nsf, 6, null, VOLUME );
		public const SngDeadBeat:Song = addSong( Nsf, 7, null, VOLUME );
		public const SngNightmare:Song = addSong( Nsf, 8, null, VOLUME );
		public const SngAquarius:Song = addSong( Nsf, 9, null, VOLUME );
		public const SngDemonSeed:Song = addSong( Nsf, 10, null, VOLUME );
		public const SngVampireKiller:Song = addSong( Nsf, 11, null, VOLUME );
		public const SngRiddle:Song = addSong( Nsf, 12, null, VOLUME );
		public const SngPressure:Song = addSong( Nsf, 13, null, VOLUME );
		public const SngDraculasRoom:Song = addSong( Nsf, 14, null, VOLUME );
		public const SngBossBattle:Song = addSong( Nsf, 15, null, VOLUME );
		public const SngStageClear:Song = addSong( Nsf, 16, null, VOLUME );
		public const SngDraculaBattle1:Song = addSong( Nsf, 17, null, VOLUME );
		public const SngDraculaBattle2:Song = addSong( Nsf, 18, null, VOLUME );
		public const SngAllClear:Song = addSong( Nsf, 19, null, VOLUME );
		public const SngPathSelection:Song = addSong( Nsf, 20, null, VOLUME );
		public const SngEncounter:Song = addSong( Nsf, 21, null, VOLUME );
		public const SngPrelude:Song = addSong( Nsf, 22, null, VOLUME );
		public const SngPrayer:Song = addSong( Nsf, 23, null, VOLUME );
		public const SngPasswordEntry:Song = addSong( Nsf, 24, null, VOLUME );
		public const SngEnding:Song = addSong( Nsf, 25, null, VOLUME );
		public const SngCredits:Song = addSong( Nsf, 26, null, VOLUME );
		public const SngDie:Song = addSong( Nsf, 27, null, VOLUME );
		public const SngGameOver:Song = addSong( Nsf, 28, null, VOLUME );
		
		
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngDraculasRoom);
			addToTypePlayList(LT_CHEEP_CHEEP, SngClockwork);
			addToTypePlayList(LT_COIN_HEAVEN, SngDeadBeat);
			addToTypePlayList(LT_INTRO, SngPathSelection);
			addToTypePlayList(LT_NORMAL, SngBeginning);
			addToTypePlayList(LT_PIPE_BONUS, SngRising);
			addToTypePlayList(LT_PLATFORM, SngMadForest);
			addToTypePlayList(LT_UNDER_GROUND, SngDemonSeed);
			addToTypePlayList(LT_WATER, SngNightmare);
			addToTypePlayList(MT_DARK_EPIC, SngAquarius);
			
			
			addToTypePlayList(BOSS, SngBossBattle);
			addToTypePlayList(CHAR_SEL, SngPasswordEntry);
			addToTypePlayList(CHOOSE_CHARACTER, SngPrelude);
			addToTypePlayList(CREDITS, SngCredits);
			addToTypePlayList(DIE, SngDie);
			addToTypePlayList(FINAL_BOSS, SngDraculaBattle2);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, SngPressure);
			addToTypePlayList(STAR, SngVampireKiller);
			addToTypePlayList(TITLE_SCREEN, SngPrelude);
			addToTypePlayList(WIN, SngStageClear);
			addToTypePlayList(WIN_CASTLE, SngAllClear);
			
		}
	}
}