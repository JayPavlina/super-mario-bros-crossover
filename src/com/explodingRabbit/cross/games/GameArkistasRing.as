package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameArkistasRing extends Game
	{
		private static var instance:Game;
		public function GameArkistasRing(gameNum:int, skinSetNum:int = -1)
		{
			super("Arkista's Ring", "American Sammy", Consoles.nintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/nsf/ArkistasRing.nsf", mimeType="application/octet-stream")]
		public const NSF:Class;
		
		private const VOLUME:int = 60;
		public const SngTitle:Song = addSong( NSF, 1, null, VOLUME );
		public const SngBonus:Song = addSong( NSF, 2, null, VOLUME );
		public const SngOverworld:Song = addSong( NSF, 3, null, VOLUME );
		public const SngDungeon:Song = addSong( NSF, 4, null, VOLUME );
		public const SngCastle:Song = addSong( NSF, 5, null, 45 );
		public const SngVictory:Song = addSong( NSF, 6, null, 50 );
		public const SngGameOver:Song = addSong( NSF, 7, null, VOLUME );
		
		override protected function setUpLevelThemes():void
		{

		}
		override protected function createPlayList():void
		{
			addToTypePlayList(LT_CASTLE, SngCastle);
			addToTypePlayList(LT_CHEEP_CHEEP, SngOverworld);
			addToTypePlayList(LT_COIN_HEAVEN, SngBonus);
			addToTypePlayList(LT_INTRO, SngBonus);
			addToTypePlayList(LT_NORMAL, SngOverworld);
			addToTypePlayList(LT_PIPE_BONUS, SngBonus);
			addToTypePlayList(LT_PLATFORM, SngOverworld);
			addToTypePlayList(LT_UNDER_GROUND, SngDungeon);
			addToTypePlayList(LT_WATER, SngDungeon);
			addToTypePlayList(MT_DARK_EPIC, SngCastle);
			
			addToTypePlayList(BOSS, SngCastle);
			addToTypePlayList(CHAR_SEL, SngBonus);
			addToTypePlayList(CHOOSE_CHARACTER, SngTitle);
			addToTypePlayList(CREDITS, SngTitle);
			addToTypePlayList(DIE, null);
			addToTypePlayList(FINAL_BOSS, SngCastle);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, SngCastle);
			addToTypePlayList(STAR, Games.superMarioBros.SngInvincible);
			addToTypePlayList(TITLE_SCREEN, SngTitle);
			addToTypePlayList(WIN, SngVictory);
			addToTypePlayList(WIN_CASTLE, SngVictory);
			
		}
	}
}