package com.explodingRabbit.cross.games
{
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameNinjaGaiden2 extends Game
	{
		private static var instance:Game; 
		
		public function GameNinjaGaiden2(gameNum:int, skinSetNum:int = -1)
		{
			super("Ninja Gaiden II: The Dark Sword of Chaos", "Tecmo", Consoles.nintendo, gameNum, "Ninja Gaiden II", skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/nsf/NinjaGaiden2.nsf", mimeType="application/octet-stream")]
		public const Nsf:Class;
		
		private const VOLUME:int = 70;
		
		public const SngAct32:Song = addSong( Nsf, 1, null, VOLUME );
		public const SngAct21:Song = addSong( Nsf, 2, null, VOLUME );
		public const SngAct22:Song = addSong( Nsf, 3, null, VOLUME );
		public const SngAct31:Song = addSong( Nsf, 4, null, VOLUME );
		public const SngAct4:Song = addSong( Nsf, 5, null, VOLUME );
		public const SngAct5:Song = addSong( Nsf, 6, null, VOLUME );
		public const SngBossBattle1:Song = addSong( Nsf, 7, null, VOLUME );
		public const SngBossBattle2:Song = addSong( Nsf, 8, null, VOLUME );
		public const SngCutscene1:Song = addSong( Nsf, 12, null, VOLUME );
		public const SngAct1:Song = addSong( Nsf, 22, null, VOLUME );
		public const SngEndingPart1:Song = addSong( Nsf, 26, null, VOLUME );
		public const SngEndingPart2:Song = addSong( Nsf, 27, null, VOLUME );
		public const SngActIntro:Song = addSong( Nsf, 30, null, VOLUME );
		public const SngGameOver:Song = addSong( Nsf, 31, null, VOLUME );
		public const SngLifeLost:Song = addSong( Nsf, 32, null, VOLUME );
		
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngAct5);
			addToTypePlayList(LT_CHEEP_CHEEP, SngAct1);
			addToTypePlayList(LT_COIN_HEAVEN, SngAct22);
			addToTypePlayList(LT_INTRO, SngCutscene1);
			addToTypePlayList(LT_NORMAL, SngAct32);
			addToTypePlayList(LT_PIPE_BONUS, SngAct31);
			addToTypePlayList(LT_PLATFORM, SngAct1);
			addToTypePlayList(LT_UNDER_GROUND, SngAct31);
			addToTypePlayList(LT_WATER, SngAct4);
			addToTypePlayList(MT_DARK_EPIC, SngAct22);
			
			addToTypePlayList(BOSS, SngBossBattle1);
			addToTypePlayList(CHAR_SEL, SngCutscene1);
			addToTypePlayList(CHOOSE_CHARACTER, SngActIntro);
			addToTypePlayList(CREDITS, SngEndingPart1);
			addToTypePlayList(DIE, SngLifeLost);
			addToTypePlayList(FINAL_BOSS, SngBossBattle2);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, SngAct22);
			addToTypePlayList(STAR, null);
			addToTypePlayList(TITLE_SCREEN, SngAct32);
			addToTypePlayList(WIN, SngActIntro);
			addToTypePlayList(WIN_CASTLE, SngEndingPart1);
		}
	}
}