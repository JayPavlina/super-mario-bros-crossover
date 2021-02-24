package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameCastlevaniaAdventure extends Game
	{
		private static var instance:Game; 
		
		public function GameCastlevaniaAdventure(gameNum:int, skinSetNum:int = -1)
		{
			super("Castlevania: The Adventure", "Konami", Consoles.gameBoy, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/gbs/CastlevaniaAdventure.gbs", mimeType="application/octet-stream")]
		public const Gbs:Class;
		private const VOLUME:int = 50;
		
		public const SngLevel1:Song = addSong( Gbs, 1, null, VOLUME );
		public const SngDie:Song = addSong( Gbs, 2, null, VOLUME );
		public const SngGameOver:Song = addSong( Gbs, 3, null, VOLUME );
		public const SngBoss:Song = addSong( Gbs, 4, null, VOLUME );
		public const SngLevel3:Song = addSong( Gbs, 5, null, VOLUME );
		public const SngLevel2:Song = addSong( Gbs, 6, null, VOLUME );
		public const SngLevel4:Song = addSong( Gbs, 7, null, VOLUME );
		public const SngEnding:Song = addSong( Gbs, 8, null, VOLUME );
		public const SngLegendOfDracula:Song = addSong( Gbs, 9, null, VOLUME );
		public const SngVictory:Song = addSong( Gbs, 10, null, VOLUME );
		public const SngFinalBossForm1:Song = addSong( Gbs, 11, null, VOLUME );
		public const SngFinalBossForm2:Song = addSong( Gbs, 12, null, VOLUME );
		public const SngIntroduction:Song = addSong( Gbs, 13, null, VOLUME );
		public const SngFanfare:Song = addSong( Gbs, 37, null, VOLUME );
		
		
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngLevel2);
			addToTypePlayList(LT_CHEEP_CHEEP, SngLevel1);
			addToTypePlayList(LT_COIN_HEAVEN, SngLevel3);
			addToTypePlayList(LT_INTRO, SngLegendOfDracula);
			addToTypePlayList(LT_NORMAL, SngLevel1);
			addToTypePlayList(LT_PIPE_BONUS, SngLevel4);
			addToTypePlayList(LT_PLATFORM, SngLevel1);
			addToTypePlayList(LT_UNDER_GROUND, SngLevel4);
			addToTypePlayList(LT_WATER, SngLevel3);
			addToTypePlayList(MT_DARK_EPIC, SngLevel1);
			
			addToTypePlayList(BOSS, SngBoss);
			addToTypePlayList(CHAR_SEL, SngLegendOfDracula);
			addToTypePlayList(CHOOSE_CHARACTER, SngIntroduction);
			addToTypePlayList(CREDITS, SngEnding);
			addToTypePlayList(DIE, SngDie);
			addToTypePlayList(FINAL_BOSS, SngFinalBossForm1);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, SngFinalBossForm2);
			addToTypePlayList(STAR, null);
			addToTypePlayList(TITLE_SCREEN, SngLevel1);
			addToTypePlayList(WIN, SngVictory);
			addToTypePlayList(WIN_CASTLE, SngVictory);
			
		}
	}
}