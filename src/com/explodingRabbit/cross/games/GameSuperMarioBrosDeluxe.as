package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameSuperMarioBrosDeluxe extends Game
	{
		private static var instance:Game;
		public function GameSuperMarioBrosDeluxe( gameNum:int, skinSetNum:int = -1 )
		{
			super("Super Mario Bros. Deluxe", "Nintendo", Consoles.gameBoy, gameNum, "SMB Deluxe", skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/gbs/SuperMarioBrosDeluxe.gbs", mimeType="application/octet-stream")]
		public const Gbs:Class;
		
		private const VOLUME:int = 60;
		public const SngOverworld:Song = addSong( Gbs, 1, null, VOLUME );
		public const SngUnderground:Song = addSong( Gbs, 2, null, VOLUME );
		public const SngLevelClear:Song = addSong( Gbs, 3, null, VOLUME );
		public const SngInvincible:Song = addSong( Gbs, 4, null, VOLUME );
		public const SngWater:Song = addSong( Gbs, 5, null, VOLUME );
		public const SngDie:Song = addSong( Gbs, 6, null, VOLUME );
		public const SngCastle:Song = addSong( Gbs, 7, null, VOLUME );
		public const SngGameOver:Song = addSong( Gbs, 8, null, VOLUME );
		public const SngCredits:Song = addSong( Gbs, 9, null, VOLUME );
		public const SngCastleClear:Song = addSong( Gbs, 10, null, VOLUME );

		public const Sng11:Song = addSong( Gbs, 11, null, VOLUME );
		public const Sng12:Song = addSong( Gbs, 12, null, VOLUME );
		public const SngCoinHeaven:Song = addSong( Gbs, 13, null, VOLUME );
		public const Sng14:Song = addSong( Gbs, 14, null, VOLUME );
		public const Sng15:Song = addSong( Gbs, 15, null, VOLUME );
		public const SngPipeIntro:Song = addSong( Gbs, 16, null, VOLUME );
		public const Sng17:Song = addSong( Gbs, 17, null, VOLUME );
		public const Sng18:Song = addSong( Gbs, 18, null, VOLUME );
		public const SngCharSelect:Song = addSong( Gbs, 19, null, VOLUME );
		public const Sng20:Song = addSong( Gbs, 20, null, VOLUME );

		public const SngTitle:Song = addSong( Gbs, 21, null, VOLUME );
		public const Sng22:Song = addSong( Gbs, 22, null, VOLUME );
		public const Sng23:Song = addSong( Gbs, 23, null, VOLUME );
		public const Sng24:Song = addSong( Gbs, 24, null, VOLUME );
		public const Sng25:Song = addSong( Gbs, 25, null, VOLUME );
		public const Sng26:Song = addSong( Gbs, 26, null, VOLUME );
		public const Sng27:Song = addSong( Gbs, 27, null, VOLUME );
		public const Sng28:Song = addSong( Gbs, 28, null, VOLUME );
		public const Sng29:Song = addSong( Gbs, 29, null, VOLUME );
		public const SngOverworldHurry:Song = addSong( Gbs, 30, null, VOLUME );

		public const Sng31:Song = addSong( Gbs, 31, null, VOLUME );
		public const Sng32:Song = addSong( Gbs, 32, null, VOLUME );
		public const Sng33:Song = addSong( Gbs, 33, null, VOLUME );
		public const Sng34:Song = addSong( Gbs, 34, null, VOLUME );
		public const Sng35:Song = addSong( Gbs, 35, null, VOLUME );
		public const Sng36:Song = addSong( Gbs, 36, null, VOLUME );
		public const Sng37:Song = addSong( Gbs, 37, null, VOLUME );
		public const Sng38:Song = addSong( Gbs, 38, null, VOLUME );
		public const Sng39:Song = addSong( Gbs, 39, null, VOLUME );
		
		override protected function setUpLevelThemes():void
		{
			
		}
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngCastle);
			addToTypePlayList(LT_CHEEP_CHEEP, SngOverworld);
			addToTypePlayList(LT_COIN_HEAVEN, SngCoinHeaven);
			addToTypePlayList(LT_INTRO, SngPipeIntro);
			addToTypePlayList(LT_NORMAL, SngOverworld);
			addToTypePlayList(LT_PIPE_BONUS, SngUnderground);
			addToTypePlayList(LT_PLATFORM, SngOverworld);
			addToTypePlayList(LT_UNDER_GROUND, SngUnderground);
			addToTypePlayList(LT_WATER, SngWater);
			addToTypePlayList(MT_DARK_EPIC, SngOverworld);
			
			addToTypePlayList(BOSS, SngCastle);
			addToTypePlayList(CHAR_SEL, SngCharSelect);
			addToTypePlayList(CHOOSE_CHARACTER, SngPipeIntro);
			addToTypePlayList(CREDITS, SngCredits);
			addToTypePlayList(DIE, SngDie);
			addToTypePlayList(FINAL_BOSS, SngCastle);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, Games.superMarioBros.SngOverworldHurry);	
			addToTypePlayList(STAR, SngInvincible);
			addToTypePlayList(TITLE_SCREEN, SngTitle);
			addToTypePlayList(WIN, SngLevelClear);
			addToTypePlayList(WIN_CASTLE, SngCastleClear);
			
			addHurryVersionOfSong( SngCastle, Games.superMarioBros.SngCastleHurry );
			addHurryVersionOfSong( SngInvincible, Games.superMarioBros.SngInvincibleHurry );
			addHurryVersionOfSong( SngOverworld, Games.superMarioBros.SngOverworldHurry );
			addHurryVersionOfSong( SngUnderground, Games.superMarioBros.SngUnderGroundHurry );
			addHurryVersionOfSong( SngWater, Games.superMarioBros.SngWaterHurry );
		}
	}
}