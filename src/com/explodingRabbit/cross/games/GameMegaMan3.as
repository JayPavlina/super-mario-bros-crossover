package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameMegaMan3 extends Game
	{
		private static var instance:Game; 
		
		public function GameMegaMan3(gameNum:int, skinSetNum:int = -1)
		{
			super("Mega Man 3",  "Capcom", Consoles.nintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/nsf/MegaMan3.nsf", mimeType="application/octet-stream")]
		public const Nsf:Class;
		
		private const VOLUME:int = 65;
		
		public const SngIntroNoIntro:Song = addSong( Nsf, 1, null, VOLUME );
		public const SngIntro:Song = addSong( Nsf, 2, null, VOLUME );
		public const SngNeedleMan:Song = addSong( Nsf, 3, null, VOLUME );
		public const SngMagnetMan:Song = addSong( Nsf, 4, null, VOLUME );
		public const SngGeminiMan:Song = addSong( Nsf, 5, null, VOLUME );
		public const SngHardMan:Song = addSong( Nsf, 6, null, VOLUME );
		public const SngTopMan:Song = addSong( Nsf, 7, null, VOLUME );
		public const SngSnakeMan:Song = addSong( Nsf, 8, null, VOLUME );
		public const SngSparkMan:Song = addSong( Nsf, 9, null, VOLUME );
		public const SngShadowMan:Song = addSong( Nsf, 10, null, VOLUME );
		public const SngWilyCastle1:Song = addSong( Nsf, 11, null, VOLUME );
		public const SngWilyCastle2:Song = addSong( Nsf, 12, null, VOLUME );
		public const SngWilyCastle3:Song = addSong( Nsf, 13, null, VOLUME );
		public const SngBossBattle:Song = addSong( Nsf, 14, null, VOLUME );
		public const SngWilyBattle:Song = addSong( Nsf, 15, null, VOLUME );
		public const SngPassword:Song = addSong( Nsf, 16, null, VOLUME );
		public const SngCredits:Song = addSong( Nsf, 17, null, VOLUME );
		public const SngStageSelect:Song = addSong( Nsf, 18, null, VOLUME );
		public const SngProtoManWhistle:Song = addSong( Nsf, 19, null, VOLUME );
		public const SngProtoManSong:Song = addSong( Nsf, 20, null, VOLUME );
		public const SngLevelStart:Song = addSong( Nsf, 53, null, VOLUME );
		public const SngWeaponAcquired:Song = addSong( Nsf, 55, null, VOLUME );
		public const SngWilyMap:Song = addSong( Nsf, 56, null, VOLUME );
		public const SngWilyDefeated:Song = addSong( Nsf, 57, null, VOLUME );
		public const SngLevelComplete:Song = addSong( Nsf, 58, null, VOLUME );
		
		
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngWilyCastle3);
			addToTypePlayList(LT_CHEEP_CHEEP, SngTopMan);
			addToTypePlayList(LT_COIN_HEAVEN, SngHardMan);
			addToTypePlayList(LT_INTRO, SngWeaponAcquired);
			addToTypePlayList(LT_NORMAL, SngSparkMan);
			addToTypePlayList(LT_PIPE_BONUS, SngNeedleMan);
			addToTypePlayList(LT_PLATFORM, SngSnakeMan);
			addToTypePlayList(LT_UNDER_GROUND, SngShadowMan);
			addToTypePlayList(LT_WATER, SngGeminiMan);
			addToTypePlayList(MT_DARK_EPIC, SngMagnetMan);
			
			addToTypePlayList(BOSS, SngBossBattle);
			addToTypePlayList(CHAR_SEL, SngStageSelect);
			addToTypePlayList(CHOOSE_CHARACTER, SngLevelStart);
			addToTypePlayList(CREDITS, SngCredits);
			addToTypePlayList(DIE, null);
			addToTypePlayList(FINAL_BOSS, SngWilyBattle);
			addToTypePlayList(GAME_OVER, SngPassword);
			addToTypePlayList(HURRY, SngWilyCastle1);
			addToTypePlayList(STAR, SngWilyCastle2);
			addToTypePlayList(TITLE_SCREEN, SngIntro);
			addToTypePlayList(WIN, SngLevelComplete);
			addToTypePlayList(WIN_CASTLE, SngWilyDefeated);
		}
	}
}