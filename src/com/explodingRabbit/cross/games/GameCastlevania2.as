package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameCastlevania2 extends Game
	{
		private static var instance:Game; 
		
		public function GameCastlevania2(gameNum:int, skinSetNum:int = -1)
		{
			super("Castlevania II: Simon's Quest", "Konami", Consoles.nintendo, gameNum, "Castlevania II", skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/nsf/Castlevania2.nsf", mimeType="application/octet-stream")]
		public const Nsf:Class;
		private const VOLUME:int = 80;
		
		public const SngTown:Song = addSong( Nsf, 1, null, VOLUME );
		public const SngBloodyTears:Song = addSong( Nsf, 2, null, VOLUME );
		public const SngNight:Song = addSong( Nsf, 3, null, VOLUME );
		public const SngMansion:Song = addSong( Nsf, 4, null, VOLUME );
		public const SngCastle:Song = addSong( Nsf, 5, null, VOLUME );
		public const SngFinalBoss:Song = addSong( Nsf, 6, null, VOLUME );
		public const SngGameOver:Song = addSong( Nsf, 7, null, VOLUME );
		public const SngPassword:Song = addSong( Nsf, 8, null, VOLUME );
		public const SngEnding:Song = addSong( Nsf, 9, null, VOLUME );
		public const SngDie:Song = addSong( Nsf, 10, null, VOLUME );
		
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL, LT_CHEEP_CHEEP, LT_PLATFORM);
			
			addToTypePlayList(LT_CASTLE, SngCastle);
			addToTypePlayList(LT_CHEEP_CHEEP, SngBloodyTears);
			addToTypePlayList(LT_COIN_HEAVEN, SngMansion);
			addToTypePlayList(LT_INTRO, SngPassword);
			addToTypePlayList(LT_NORMAL, SngBloodyTears);
			addToTypePlayList(LT_PIPE_BONUS, SngMansion);
			addToTypePlayList(LT_PLATFORM, SngBloodyTears);
			addToTypePlayList(LT_UNDER_GROUND, SngMansion);
			addToTypePlayList(LT_WATER, SngTown);
			addToTypePlayList(MT_DARK_EPIC, SngNight);
			
			addToTypePlayList(BOSS, SngFinalBoss);
			addToTypePlayList(CHAR_SEL, SngPassword);
			addToTypePlayList(CHOOSE_CHARACTER, Games.castlevania.SngIntro);
			addToTypePlayList(CREDITS, SngEnding);
			addToTypePlayList(DIE, SngDie);
			addToTypePlayList(FINAL_BOSS, SngFinalBoss);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, SngFinalBoss);
			addToTypePlayList(STAR, null);
			addToTypePlayList(TITLE_SCREEN, SngBloodyTears);
			addToTypePlayList(WIN, Games.castlevania.SngVictory);
			addToTypePlayList(WIN_CASTLE, SngEnding);
			
		}
	}
}