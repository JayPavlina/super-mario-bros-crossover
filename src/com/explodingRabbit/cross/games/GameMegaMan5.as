package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameMegaMan5 extends Game
	{
		private static var instance:Game; 
		
		public function GameMegaMan5(gameNum:int, skinSetNum:int = -1)
		{
			super("Mega Man 5",  "Capcom", Consoles.nintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/nsf/MegaMan5.nsf", mimeType="application/octet-stream")]
		public const Nsf:Class;
		
		private const VOLUME:int = 65;
		
		public const SngGravityMan:Song = addSong( Nsf, 1, null, VOLUME );
		public const SngStoneMan:Song = addSong( Nsf, 2, null, VOLUME );
		public const SngWaveMan:Song = addSong( Nsf, 3, null, VOLUME );
		public const SngStarMan:Song = addSong( Nsf, 4, null, VOLUME );
		public const SngCrystalMan:Song = addSong( Nsf, 5, null, VOLUME );
		public const SngGyroMan:Song = addSong( Nsf, 6, null, VOLUME );
		public const SngChargeMan:Song = addSong( Nsf, 7, null, VOLUME );
		public const SngNapalmMan:Song = addSong( Nsf, 8, null, VOLUME );
		public const SngProtoManFortressStage:Song = addSong( Nsf, 9, null, VOLUME );
		public const SngDrWilyCastleStage:Song = addSong( Nsf, 10, null, VOLUME );
		public const SngStageBoss:Song = addSong( Nsf, 11, null, VOLUME );
		public const SngIntro:Song = addSong( Nsf, 12, null, VOLUME );
		public const SngCredits:Song = addSong( Nsf, 13, null, VOLUME );
		public const SngMakeYourSelection:Song = addSong( Nsf, 14, null, VOLUME );
		public const SngPrepareForBattle:Song = addSong( Nsf, 15, null, VOLUME );
		public const SngProtoManFortress:Song = addSong( Nsf, 16, null, VOLUME );
		public const SngDrWilyCastle:Song = addSong( Nsf, 17, null, VOLUME );
		public const SngVictory:Song = addSong( Nsf, 18, null, VOLUME );
		public const SngDefeated:Song = addSong( Nsf, 19, null, VOLUME );
		public const SngPassword:Song = addSong( Nsf, 20, null, VOLUME );
		public const SngNewToys:Song = addSong( Nsf, 21, null, VOLUME );
		public const SngDrWilyIsDown:Song = addSong( Nsf, 22, null, VOLUME );
		public const SngBattleWithDrWily:Song = addSong( Nsf, 23, null, VOLUME );
		
		
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngDrWilyCastleStage);
			addToTypePlayList(LT_CHEEP_CHEEP, SngWaveMan);
			addToTypePlayList(LT_COIN_HEAVEN, SngStarMan);
			addToTypePlayList(LT_INTRO, SngPassword);
			addToTypePlayList(LT_NORMAL, SngNapalmMan);
			addToTypePlayList(LT_PIPE_BONUS, SngStoneMan);
			addToTypePlayList(LT_PLATFORM, SngGyroMan);
			addToTypePlayList(LT_UNDER_GROUND, SngCrystalMan);
			addToTypePlayList(LT_WATER, SngGravityMan);
			addToTypePlayList(MT_DARK_EPIC, SngProtoManFortressStage);
			
			
			addToTypePlayList(BOSS, SngStageBoss);
			addToTypePlayList(CHAR_SEL, SngMakeYourSelection);
			addToTypePlayList(CHOOSE_CHARACTER, SngPrepareForBattle);
			addToTypePlayList(CREDITS, SngCredits);
			addToTypePlayList(DIE, null);
			addToTypePlayList(FINAL_BOSS, SngBattleWithDrWily);
			addToTypePlayList(GAME_OVER, SngDefeated);
			addToTypePlayList(HURRY, SngNewToys);
			addToTypePlayList(STAR, SngChargeMan);
			addToTypePlayList(TITLE_SCREEN, SngPassword);
			addToTypePlayList(WIN, SngVictory);
			addToTypePlayList(WIN_CASTLE, SngDrWilyIsDown);
			
		}
	}
}