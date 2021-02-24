package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameZeldaOracleOfAges extends Game
	{
		private static var instance:Game; 
		
		public function GameZeldaOracleOfAges(gameNum:int, skinSetNum:int = -1)
		{
			super("The Legend of Zelda: Oracle of Ages", "Nintendo", Consoles.gameBoy, gameNum, "LoZ: Oracle of Ages", skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/gbs/ZeldaOracleOfAges.gbs", mimeType="application/octet-stream")]
		public const Gbs:Class;
		
		private const VOLUME:int = 70; 
		
		public const SngTitle:Song = addSong( Gbs, 1, null, VOLUME );
		public const SngOverworld:Song = addSong( Gbs, 3, null, VOLUME );
		public const SngOverworldPast:Song = addSong( Gbs, 4, null, VOLUME );
		public const SngIsland:Song = addSong( Gbs, 5, null, VOLUME );
		public const SngWinLevel:Song = addSong( Gbs, 6, null, VOLUME );
		public const SngNaryu:Song = addSong( Gbs, 8, null, VOLUME );
		public const SngGameOver:Song = addSong( Gbs, 9, null, VOLUME );
		public const SngFileSelect:Song = addSong( Gbs, 17, null, VOLUME );
		public const SngSneak:Song = addSong( Gbs, 18, null, VOLUME );
		public const SngFinalDungeon:Song = addSong( Gbs, 27, null, VOLUME );
		public const SngDungeon:Song = addSong( Gbs, 28, null, VOLUME );
		public const SngMarch:Song = addSong( Gbs, 32, null, VOLUME );
		public const SngCredits:Song = addSong( Gbs, 41, null, VOLUME );
		public const SngHurry:Song = addSong( Gbs, 44, null, VOLUME );
		public const SngBoss:Song = addSong( Gbs, 45, null, VOLUME );
		public const SngFinalBoss:Song = addSong( Gbs, 46, null, VOLUME );
		public const SngWinCastle:Song = addSong( Gbs, 60, null, VOLUME );
		public const SngSolveTune:Song = addSong( Gbs, 78, null, VOLUME );
		public const SngDie:Song = addSong( Gbs, 87, null, VOLUME );
		public const SngHarp:Song = addSong( Gbs, 162, null, VOLUME );
		
		override protected function setUpLevelThemes():void
		{
			
		}
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL); // song types that will switch to DARK_EPIC song if the theme is dark
			
			addToTypePlayList(LT_CASTLE, SngFinalDungeon); //82
			addToTypePlayList(LT_CHEEP_CHEEP, SngOverworld); //
			addToTypePlayList(LT_COIN_HEAVEN, SngNaryu); //96
			addToTypePlayList(LT_INTRO, SngSolveTune); //99
			addToTypePlayList(LT_NORMAL, SngOverworldPast); //5
			addToTypePlayList(LT_PIPE_BONUS, SngSneak); //11
			addToTypePlayList(LT_PLATFORM, SngOverworld); //9
			addToTypePlayList(LT_UNDER_GROUND, SngDungeon); //38
			addToTypePlayList(LT_WATER, SngIsland); //29
			addToTypePlayList(MT_DARK_EPIC, SngMarch); //6
			
			addToTypePlayList(BOSS, SngBoss); //25
			addToTypePlayList(CHAR_SEL, SngFileSelect); //17
			addToTypePlayList(CHOOSE_CHARACTER, SngHarp); //170
			addToTypePlayList(CREDITS, SngCredits); //61
			addToTypePlayList(DIE, SngDie); //169
			addToTypePlayList(FINAL_BOSS, SngFinalBoss); //35
			addToTypePlayList(GAME_OVER, SngGameOver); //3
			addToTypePlayList(HURRY, SngHurry); //62
			addToTypePlayList(STAR, Games.zeldaLinksAwakening.SngAdrenaline); //73
			addToTypePlayList(TITLE_SCREEN, SngTitle); //1
			addToTypePlayList(WIN, SngWinLevel); //27
			addToTypePlayList(WIN_CASTLE, SngWinCastle); //27
		}
	}
}