package com.explodingRabbit.cross.games
{
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameBlasterMasterSnes extends Game
	{
		private static var instance:Game; 
		
		public function GameBlasterMasterSnes(gameNum:int, skinSetNum:int = -1)
		{
			super("Blaster Master (SNES)", "Sunsoft", Consoles.superNintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		override public function initiate():void
		{
			super.initiate();
			creditsGame = Games.blasterMaster;
		}
		
		private const VOLUME:int = 70;
		
		[Embed(source="../../../../../assets/audio/seq/spc/BlasterMasterSnes/Overworld.spc", mimeType="application/octet-stream")]
		private const OverworldData:Class;	public const SngOverworld:Song = addSong( OverworldData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/BlasterMasterSnes/Area 2.spc", mimeType="application/octet-stream")]
		private const Area2Data:Class;	public const SngArea2:Song = addSong( Area2Data, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/BlasterMasterSnes/Area 3.spc", mimeType="application/octet-stream")]
		private const Area3Data:Class;	public const SngArea3:Song = addSong( Area3Data, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/BlasterMasterSnes/Game Over.spc", mimeType="application/octet-stream")]
		private const GameOverData:Class;	public const SngGameOver:Song = addSong( GameOverData, -1, null, VOLUME, 0, 0, 3200 );
		
		[Embed(source="../../../../../assets/audio/seq/spc/BlasterMasterSnes/Opening.spc", mimeType="application/octet-stream")]
		private const OpeningData:Class;	public const SngOpening:Song = addSong( OpeningData, -1, null, VOLUME, 0, 0 );
		
		[Embed(source="../../../../../assets/audio/seq/spc/BlasterMasterSnes/Victory.spc", mimeType="application/octet-stream")]
		private const VictoryData:Class;	public const SngVictory:Song = addSong( VictoryData, -1, null, VOLUME, 0, 0, 4000 );
		
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, Games.blasterMaster.SngArea4Frog);
			addToTypePlayList(LT_CHEEP_CHEEP, SngArea3);
			addToTypePlayList(LT_COIN_HEAVEN, Games.blasterMaster.SngArea5Water);
			addToTypePlayList(LT_INTRO, Games.blasterMaster.SngArea8Final);
			addToTypePlayList(LT_NORMAL, SngOverworld);
			addToTypePlayList(LT_PIPE_BONUS, SngArea2);
			addToTypePlayList(LT_PLATFORM, SngArea3);
			addToTypePlayList(LT_UNDER_GROUND, SngArea2);
			addToTypePlayList(LT_WATER, Games.blasterMaster.SngArea5Water);
			addToTypePlayList(MT_DARK_EPIC, Games.blasterMaster.SngArea6);
			
			addToTypePlayList(BOSS, Games.blasterMaster.SngBossEasy);
			addToTypePlayList(CHAR_SEL, SngOpening);
			addToTypePlayList(CHOOSE_CHARACTER, SngOverworld);
			addToTypePlayList(CREDITS, Games.blasterMaster.SngEnding);
			addToTypePlayList(DIE, null);
			addToTypePlayList(FINAL_BOSS, Games.blasterMaster.SngBossHard);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, Games.blasterMaster.SngArea7);
			addToTypePlayList(STAR, Games.blasterMaster.SngBossHard);
			addToTypePlayList(TITLE_SCREEN, SngOpening);
			addToTypePlayList(WIN, SngVictory);
			addToTypePlayList(WIN_CASTLE, SngVictory);
		}
	}
}