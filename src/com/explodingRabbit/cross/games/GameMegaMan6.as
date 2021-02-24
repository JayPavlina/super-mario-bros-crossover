package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameMegaMan6 extends Game
	{
		private static var instance:Game; 
		
		public function GameMegaMan6(gameNum:int, skinSetNum:int = -1)
		{
			super("Mega Man 6", "Capcom", Consoles.nintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/nsf/MegaMan6.nsf", mimeType="application/octet-stream")]
		public const Nsf:Class;
		
		private const VOLUME:int = 55;
		
		public const SngWindMan:Song = addSong( Nsf, 1, null, VOLUME );
		public const SngBlizzardMan:Song = addSong( Nsf, 2, null, VOLUME );
		public const SngYamatoMan:Song = addSong( Nsf, 3, null, VOLUME );
		public const SngCentaurMan:Song = addSong( Nsf, 4, null, VOLUME );
		public const SngPlantMan:Song = addSong( Nsf, 5, null, VOLUME );
		public const SngFlameMan:Song = addSong( Nsf, 6, null, VOLUME );
		public const SngTomahawkMan:Song = addSong( Nsf, 7, null, VOLUME );
		public const SngKnightMan:Song = addSong( Nsf, 8, null, VOLUME );
		public const SngMrXCastle:Song = addSong( Nsf, 10, null, VOLUME );
		public const SngCredits:Song = addSong( Nsf, 11, null, VOLUME );
		public const SngDrWilyCastle:Song = addSong( Nsf, 12, null, VOLUME );
		public const SngBossBattle:Song = addSong( Nsf, 13, null, VOLUME );
		public const SngStageSelect:Song = addSong( Nsf, 16, null, VOLUME );
		public const SngStageChosen:Song = addSong( Nsf, 17, null, VOLUME );
		public const SngBossVictory:Song = addSong( Nsf, 20, null, VOLUME );
		public const SngGameOver:Song = addSong( Nsf, 21, null, VOLUME );
		public const SngPassword:Song = addSong( Nsf, 22, null, VOLUME );
		public const SngWilyVictory:Song = addSong( Nsf, 24, null, VOLUME );
		public const SngWilyBattle:Song = addSong( Nsf, 25, null, VOLUME );
		public const SngTitleScreen:Song = addSong( Nsf, 26, null, VOLUME );
		
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngMrXCastle);
			addToTypePlayList(LT_CHEEP_CHEEP, SngPlantMan);
			addToTypePlayList(LT_COIN_HEAVEN, SngBlizzardMan);
			addToTypePlayList(LT_INTRO, SngPassword);
			addToTypePlayList(LT_NORMAL, SngTomahawkMan);
			addToTypePlayList(LT_PIPE_BONUS, SngFlameMan);
			addToTypePlayList(LT_PLATFORM, SngWindMan);
			addToTypePlayList(LT_UNDER_GROUND, SngYamatoMan);
			addToTypePlayList(LT_WATER, SngCentaurMan);
			addToTypePlayList(MT_DARK_EPIC, SngKnightMan);


			addToTypePlayList(BOSS, SngBossBattle);
			addToTypePlayList(CHAR_SEL, SngStageSelect);
			addToTypePlayList(CHOOSE_CHARACTER, SngStageChosen);
			addToTypePlayList(CREDITS, SngCredits);
			addToTypePlayList(DIE, null);
			addToTypePlayList(FINAL_BOSS, SngWilyBattle);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, SngTitleScreen);
			addToTypePlayList(STAR, SngDrWilyCastle);
			addToTypePlayList(TITLE_SCREEN, SngTitleScreen);
			addToTypePlayList(WIN, SngBossVictory);
			addToTypePlayList(WIN_CASTLE, SngWilyVictory);
			
		}
	}
}