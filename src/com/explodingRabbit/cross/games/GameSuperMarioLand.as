package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.MapPack;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameSuperMarioLand extends Game
	{
		private static var instance:Game;

		public function GameSuperMarioLand(gameNum:int, skinSetNum:int = -1)
		{
			super("Super Mario Land", "Nintendo", Consoles.gameBoy, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		[Embed(source="../../../../../assets/audio/seq/gbs/SuperMarioLand.gbs", mimeType="application/octet-stream")]
		public const Gbs:Class;
		
		private const VOLUME:int = 60;
		public const SngWin:Song = addSong( Gbs, 1, null, VOLUME );
		public const SngDie:Song = addSong( Gbs, 2, null, VOLUME );
		public const SngEastonKingdom:Song = addSong( Gbs, 3, null, VOLUME );
		public const SngPipeBonus:Song = addSong( Gbs, 4, null, VOLUME );
		public const SngSkyPop:Song = addSong( Gbs, 5, null, VOLUME );
		public const SngChaiKingdom:Song = addSong( Gbs, 6, null, VOLUME );
		public const SngBirabutoKingdom:Song = addSong( Gbs, 7, null, VOLUME );
		public const SngMudaKingdom:Song = addSong( Gbs, 8, null, VOLUME );
		public const SngHurry:Song = addSong( Gbs, 9, null, VOLUME );
		public const SngBoss:Song = addSong( Gbs, 11, null, VOLUME );
		public const SngStar:Song = addSong( Gbs, 12, null, VOLUME );
		public const SngChooseCharacter:Song = addSong( Gbs, 13, null, VOLUME + 20 );
		public const SngWinCastle:Song = addSong( Gbs, 15, null, VOLUME );
		public const SngGameOver:Song = addSong( Gbs, 16, null, VOLUME );
		public const SngCredits:Song = addSong( Gbs, 17, null, VOLUME );
		public const SngIntro:Song = addSong( Gbs, 18, null, VOLUME );
		public const SngFinalBoss:Song = addSong( Gbs, 19, null, VOLUME );
		
		override protected function setUpLevelThemes():void
		{

		}
		override protected function createPlayList():void
		{
			addToTypePlayList(LT_CASTLE, SngEastonKingdom);
			addToTypePlayList(LT_CHEEP_CHEEP, SngMudaKingdom);
			addToTypePlayList(LT_COIN_HEAVEN, SngSkyPop);
			addToTypePlayList(LT_INTRO, SngIntro);
			addToTypePlayList(LT_NORMAL, SngBirabutoKingdom);
			addToTypePlayList(LT_PIPE_BONUS, SngPipeBonus);
			addToTypePlayList(LT_PLATFORM, SngMudaKingdom);
			addToTypePlayList(LT_UNDER_GROUND, SngEastonKingdom);
			addToTypePlayList(LT_WATER, SngSkyPop);
			addToTypePlayList(MT_DARK_EPIC, SngChaiKingdom);
			
			addToTypePlayList(BOSS, SngBoss);
			addToTypePlayList(CHAR_SEL, SngPipeBonus);
			addToTypePlayList(CHOOSE_CHARACTER, SngChooseCharacter);
			addToTypePlayList(CREDITS, SngCredits);
			addToTypePlayList(DIE, SngDie);
			addToTypePlayList(FINAL_BOSS, SngFinalBoss);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, SngHurry);	
			addToTypePlayList(STAR, SngStar);
			addToTypePlayList(TITLE_SCREEN, SngChaiKingdom);
			addToTypePlayList(WIN, SngWin);
			addToTypePlayList(WIN_CASTLE, SngWinCastle);
		}
	}
}