package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameMegaMan4 extends Game
	{
		private static var instance:Game; 
		
		public function GameMegaMan4(gameNum:int, skinSetNum:int = -1)
		{
			super("Mega Man 4",  "Capcom", Consoles.nintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/nsf/MegaMan4.nsf", mimeType="application/octet-stream")]
		public const Nsf:Class;
		
		private const VOLUME:int = 65;
		
		public const SngBrightMan:Song = addSong( Nsf, 1, null, VOLUME );
		public const SngToadMan:Song = addSong( Nsf, 2, null, VOLUME );
		public const SngRingMan:Song = addSong( Nsf, 3, null, VOLUME );
		public const SngDrillMan:Song = addSong( Nsf, 4, null, VOLUME );
		public const SngPharaohMan:Song = addSong( Nsf, 5, null, VOLUME );
		public const SngDiveMan:Song = addSong( Nsf, 6, null, VOLUME );
		public const SngSkullMan:Song = addSong( Nsf, 7, null, VOLUME );
		public const SngDustMan:Song = addSong( Nsf, 8, null, VOLUME );
		public const SngDrCossack1:Song = addSong( Nsf, 9, null, VOLUME );
		public const SngDrCossack2:Song = addSong( Nsf, 10, null, VOLUME );
		public const SngIntro1:Song = addSong( Nsf, 11, null, VOLUME );
		public const SngEnding1:Song = addSong( Nsf, 12, null, VOLUME );
		public const SngVictory:Song = addSong( Nsf, 13, null, VOLUME );
		public const SngPassword:Song = addSong( Nsf, 14, null, VOLUME );
		public const SngGameOver:Song = addSong( Nsf, 15, null, VOLUME );
		public const SngBossChosen:Song = addSong( Nsf, 16, null, VOLUME );
		public const SngStageSelect:Song = addSong( Nsf, 17, null, VOLUME );
		public const SngBossBattle:Song = addSong( Nsf, 18, null, VOLUME );
		public const SngTitleScreen:Song = addSong( Nsf, 19, null, VOLUME );
		public const SngEnding2:Song = addSong( Nsf, 20, null, VOLUME );
		public const SngWeaponGet:Song = addSong( Nsf, 21, null, VOLUME );
		public const SngDrWily1:Song = addSong( Nsf, 22, null, VOLUME );
		public const SngDrWily2:Song = addSong( Nsf, 23, null, VOLUME );
		public const SngItemGet:Song = addSong( Nsf, 59, null, VOLUME );
		public const SngWilyBattle:Song = addSong( Nsf, 70, null, VOLUME );
		public const SngWilyDefeated:Song = addSong( Nsf, 71, null, VOLUME );
		
		
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngDustMan);
			addToTypePlayList(LT_CHEEP_CHEEP, SngToadMan);
			addToTypePlayList(LT_COIN_HEAVEN, SngRingMan);
			addToTypePlayList(LT_INTRO, SngWeaponGet);
			addToTypePlayList(LT_NORMAL, SngPharaohMan);
			addToTypePlayList(LT_PIPE_BONUS, SngBrightMan);
			addToTypePlayList(LT_PLATFORM, SngSkullMan);
			addToTypePlayList(LT_UNDER_GROUND, SngDrillMan);
			addToTypePlayList(LT_WATER, SngDiveMan);
			addToTypePlayList(MT_DARK_EPIC, SngDrWily2);
			
			
			addToTypePlayList(BOSS, SngBossBattle);
			addToTypePlayList(CHAR_SEL, SngStageSelect);
			addToTypePlayList(CHOOSE_CHARACTER, SngBossChosen);
			addToTypePlayList(CREDITS, SngEnding2);
			addToTypePlayList(DIE, null);
			addToTypePlayList(FINAL_BOSS, SngWilyBattle);
			addToTypePlayList(GAME_OVER, SngPassword);
			addToTypePlayList(HURRY, SngDrWily1);
			addToTypePlayList(STAR, null);
			addToTypePlayList(TITLE_SCREEN, SngTitleScreen);
			addToTypePlayList(WIN, SngVictory);
			addToTypePlayList(WIN_CASTLE, SngWilyDefeated);
			
		}
	}
}