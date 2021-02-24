package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameNinjaGaidenShadow extends Game
	{
		private static var instance:Game; 
		
		public function GameNinjaGaidenShadow(gameNum:int, skinSetNum:int = -1)
		{
			super("Ninja Gaiden Shadow", "Tecmo", Consoles.gameBoy, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/gbs/NinjaGaidenShadow.gbs", mimeType="application/octet-stream")]
		public const Gbs:Class;
		private const VOLUME:int = 45;
		
		public const SngPrologue:Song = addSong( Gbs, 1, null, VOLUME );
		public const SngLevelStart:Song = addSong( Gbs, 2, null, VOLUME );
		public const SngLevel1:Song = addSong( Gbs, 3, null, VOLUME );
		public const SngLevel2:Song = addSong( Gbs, 4, null, VOLUME );
		public const SngLevel3:Song = addSong( Gbs, 5, null, VOLUME );
		public const SngLevel4:Song = addSong( Gbs, 6, null, VOLUME );
		public const SngLevel5:Song = addSong( Gbs, 7, null, VOLUME );
		public const SngBossBattle:Song = addSong( Gbs, 8, null, VOLUME );
		public const SngFinalBoss:Song = addSong( Gbs, 9, null, VOLUME );
		public const SngGameOver:Song = addSong( Gbs, 10, null, VOLUME );
		public const SngDie:Song = addSong( Gbs, 11, null, VOLUME );
		public const SngEnding:Song = addSong( Gbs, 12, null, VOLUME );
		public const SngCredits:Song = addSong( Gbs, 13, null, VOLUME );
		
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngLevel4);
			addToTypePlayList(LT_CHEEP_CHEEP, SngLevel2);
			addToTypePlayList(LT_COIN_HEAVEN, SngCredits);
			addToTypePlayList(LT_INTRO, SngPrologue);
			addToTypePlayList(LT_NORMAL, SngLevel3);
			addToTypePlayList(LT_PIPE_BONUS, SngLevel1);
			addToTypePlayList(LT_PLATFORM, SngLevel2);
			addToTypePlayList(LT_UNDER_GROUND, SngLevel1);
			addToTypePlayList(LT_WATER, SngLevel1);
			addToTypePlayList(MT_DARK_EPIC, SngLevel5);
			
			addToTypePlayList(BOSS, SngBossBattle);
			addToTypePlayList(CHAR_SEL, SngPrologue);
			addToTypePlayList(CHOOSE_CHARACTER, SngLevelStart);
			addToTypePlayList(CREDITS, SngCredits);
			addToTypePlayList(DIE, SngDie);
			addToTypePlayList(FINAL_BOSS, SngFinalBoss);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, SngFinalBoss);
			addToTypePlayList(STAR, null);
			addToTypePlayList(TITLE_SCREEN, SngLevel3);
			addToTypePlayList(WIN, SngLevelStart);
			addToTypePlayList(WIN_CASTLE, SngEnding);
			
		}
	}
}