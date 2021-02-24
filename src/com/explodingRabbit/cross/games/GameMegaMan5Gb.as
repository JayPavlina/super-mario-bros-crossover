package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameMegaMan5Gb extends Game
	{
		private static var instance:Game; 
		
		public function GameMegaMan5Gb(gameNum:int, skinSetNum:int = -1)
		{
			super("Mega Man V (Game Boy)",  "Capcom", Consoles.gameBoy, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/gbs/MegaMan5.gbs", mimeType="application/octet-stream")]
		public const Gbs:Class;
		private const VOLUME:int = 55;
		
		public const SngStageSelect:Song = addSong( Gbs, 1, null, VOLUME );
		public const SngWilyStarIntro:Song = addSong( Gbs, 2, null, VOLUME );
		public const SngUranus:Song = addSong( Gbs, 3, null, VOLUME );
		public const SngSpaceRush:Song = addSong( Gbs, 4, null, VOLUME );
		public const SngNeptune:Song = addSong( Gbs, 5, null, VOLUME );
		public const SngAltBoss:Song = addSong( Gbs, 6, null, VOLUME );
		public const SngBoss:Song = addSong( Gbs, 7, null, VOLUME );
		public const SngSaturn:Song = addSong( Gbs, 8, null, VOLUME );
		public const SngMecury:Song = addSong( Gbs, 9, null, VOLUME );
		public const SngStarEscape:Song = addSong( Gbs, 10, null, VOLUME );
		public const SngMars:Song = addSong( Gbs, 11, null, VOLUME );
		public const SngJupiter:Song = addSong( Gbs, 12, null, VOLUME );
		public const SngUnknownStage:Song = addSong( Gbs, 13, null, VOLUME );
		public const SngPluto:Song = addSong( Gbs, 14, null, VOLUME );
		public const SngFinalStage:Song = addSong( Gbs, 15, null, VOLUME );
		public const SngPrologue1:Song = addSong( Gbs, 16, null, VOLUME );
		public const SngStageStart:Song = addSong( Gbs, 17, null, VOLUME );
		public const SngGameOver:Song = addSong( Gbs, 18, null, VOLUME );
		public const SngVictory:Song = addSong( Gbs, 19, null, VOLUME );
		public const SngAltFinalV:Song = addSong( Gbs, 20, null, VOLUME );
		public const SngGotWeapon:Song = addSong( Gbs, 21, null, VOLUME );
		public const SngEndingTheme:Song = addSong( Gbs, 22, null, VOLUME );
		public const SngAltVictory:Song = addSong( Gbs, 23, null, VOLUME );
		public const SngAltTitle:Song = addSong( Gbs, 24, null, VOLUME );
		public const SngTitle:Song = addSong( Gbs, 25, null, VOLUME );
		public const SngPrologue2:Song = addSong( Gbs, 26, null, VOLUME );
		public const SngDrLightShop:Song = addSong( Gbs, 27, null, VOLUME );
		public const SngInstructions:Song = addSong( Gbs, 28, null, VOLUME );
		public const SngPrologue3:Song = addSong( Gbs, 29, null, VOLUME );
		public const SngPassword:Song = addSong( Gbs, 30, null, VOLUME );
		public const SngSunStar:Song = addSong( Gbs, 31, null, VOLUME );
		public const SngFinalVictory:Song = addSong( Gbs, 32, null, VOLUME );
		public const SngVenus:Song = addSong( Gbs, 33, null, VOLUME );
		public const SngDie:Song = addSong( Gbs, 50, null, VOLUME );
		public const SngProtoWhistle:Song = addSong( Gbs, 75, null, VOLUME );
		
		
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngFinalStage);
			addToTypePlayList(LT_CHEEP_CHEEP, SngVenus);
			addToTypePlayList(LT_COIN_HEAVEN, SngGotWeapon);
			addToTypePlayList(LT_INTRO, SngPassword);
			addToTypePlayList(LT_NORMAL, SngSpaceRush);
			addToTypePlayList(LT_PIPE_BONUS, SngUranus);
			addToTypePlayList(LT_PLATFORM, SngJupiter);
			addToTypePlayList(LT_UNDER_GROUND, SngMars);
			addToTypePlayList(LT_WATER, SngPluto);
			addToTypePlayList(MT_DARK_EPIC, SngSaturn);
			
			addToTypePlayList(BOSS, SngBoss);
			addToTypePlayList(CHAR_SEL, SngStageSelect);
			addToTypePlayList(CHOOSE_CHARACTER, SngStageStart);
			addToTypePlayList(CREDITS, SngEndingTheme);
			addToTypePlayList(DIE, SngDie);
			addToTypePlayList(FINAL_BOSS, SngSunStar);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, SngStarEscape);
			addToTypePlayList(STAR, SngAltBoss);
			addToTypePlayList(TITLE_SCREEN, SngTitle);
			addToTypePlayList(WIN, SngVictory);
			addToTypePlayList(WIN_CASTLE, SngFinalVictory);
			
		}
	}
}