package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameFinalFantasyAdventure extends Game
	{
		private static var instance:Game;
		public function GameFinalFantasyAdventure( gameNum:int, skinSetNum:int = -1 )
		{
			super("Final Fantasy Adventure", "Square-Enix", Consoles.gameBoy, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/gbs/FinalFantasyAdventure.gbs", mimeType="application/octet-stream")]
		public const Gbs:Class;
		
		private const VOLUME:int = 50;
		public const SngRisingSun:Song = addSong( Gbs, 1, null, VOLUME );
		public const SngReqiuem:Song = addSong( Gbs, 3, null, VOLUME );
		public const SngVillage:Song = addSong( Gbs, 8, null, VOLUME );
		public const SngDungeon1:Song = addSong( Gbs, 11, null, VOLUME );
		public const SngDungeon2:Song = addSong( Gbs, 12, null, VOLUME );
		public const SngDanger:Song = addSong( Gbs, 13, null, VOLUME );
		public const SngRoyalPalaceTheme:Song = addSong( Gbs, 14, null, VOLUME );
		public const SngDungeon3:Song = addSong( Gbs, 15, null, VOLUME );
		public const SngLetThoughtsRideOnKnowledge:Song = addSong( Gbs, 16, null, VOLUME );
		public const SngBattle1:Song = addSong( Gbs, 17, null, VOLUME );
		public const SngFinalBattle:Song = addSong( Gbs, 18, null, VOLUME );
		public const SngBattle2:Song = addSong( Gbs, 21, null, VOLUME );
		public const SngEndlessBattlefield:Song = addSong( Gbs, 22, null, VOLUME );
		public const SngLegendForever:Song = addSong( Gbs, 23, null, VOLUME );
		public const SngManaPalace:Song = addSong( Gbs, 24, null, VOLUME );
		public const SngInSearchOfTheHolySword:Song = addSong( Gbs, 26, null, VOLUME );
		public const SngFanfare:Song = addSong( Gbs, 28, null, VOLUME );
		public const SngDie:Song = addSong( Gbs, 29, null, VOLUME );

		override protected function setUpLevelThemes():void
		{
			
		}
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngDungeon1);
			addToTypePlayList(LT_CHEEP_CHEEP, SngBattle1);
			addToTypePlayList(LT_COIN_HEAVEN, SngManaPalace);
			addToTypePlayList(LT_INTRO, SngLetThoughtsRideOnKnowledge);
			addToTypePlayList(LT_NORMAL, SngEndlessBattlefield);
			addToTypePlayList(LT_PIPE_BONUS, SngDungeon3);
			addToTypePlayList(LT_PLATFORM, SngBattle1);
			addToTypePlayList(LT_UNDER_GROUND, SngDungeon2);
			addToTypePlayList(LT_WATER, SngRoyalPalaceTheme);
			addToTypePlayList(MT_DARK_EPIC, SngBattle1);
			
			addToTypePlayList(BOSS, SngBattle2);
			addToTypePlayList(CHAR_SEL, SngVillage);
			addToTypePlayList(CHOOSE_CHARACTER, SngFanfare);
			addToTypePlayList(CREDITS, SngLegendForever);
			addToTypePlayList(DIE, SngDie);
			addToTypePlayList(FINAL_BOSS, SngFinalBattle);
			addToTypePlayList(GAME_OVER, SngReqiuem);
			addToTypePlayList(HURRY, SngDanger);	
			addToTypePlayList(STAR, SngInSearchOfTheHolySword);
			addToTypePlayList(TITLE_SCREEN, SngRisingSun);
			addToTypePlayList(WIN, SngFanfare);
			addToTypePlayList(WIN_CASTLE, SngFanfare);
			
		}
	}
}