package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameSuperC extends Game
	{
		private static var instance:Game; 
		
		public function GameSuperC(gameNum:int, skinSetNum:int = -1)
		{
			super("Super C", "Konami", Consoles.nintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/nsf/SuperC.nsf", mimeType="application/octet-stream")]
		public const Nsf:Class;
		
		private const VOLUME:int = 70; 
		
		public const SngLightningAndGrenades:Song = addSong( Nsf, 41, null, VOLUME );
		public const SngMechanicFactory:Song = addSong( Nsf, 42, null, VOLUME );
		public const SngJungle:Song = addSong( Nsf, 43, null, VOLUME );
		public const SngMilitaryFortress:Song = addSong( Nsf, 44, null, VOLUME );
		public const SngPerilousCliff:Song = addSong( Nsf, 45, null, VOLUME );
		public const SngUnderTheFeet:Song = addSong( Nsf, 46, null, VOLUME );
//		public const SngXenophobicOrigins:Song = addSong( Nsf, 47, null, VOLUME );
		public const SngTheFallingWall:Song = addSong( Nsf, 48, null, VOLUME );
		public const SngBossHard:Song = addSong( Nsf, 49, null, VOLUME );
		public const SngBossSimple:Song = addSong( Nsf, 50, null, VOLUME );
		public const SngBossSpider:Song = addSong( Nsf, 51, null, VOLUME );
		public const SngStageClear:Song = addSong( Nsf, 52, null, VOLUME );
		public const SngStageClearAll:Song = addSong( Nsf, 53, null, VOLUME );
		public const SngGameOver:Song = addSong( Nsf, 54, null, VOLUME );
		public const SngEnding:Song = addSong( Nsf, 55, null, VOLUME );
		
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL, LT_PLATFORM, LT_CHEEP_CHEEP);
			
			addToTypePlayList(LT_CASTLE, SngTheFallingWall);
			addToTypePlayList(LT_CHEEP_CHEEP, SngPerilousCliff);
			addToTypePlayList(LT_COIN_HEAVEN, SngMilitaryFortress);
			addToTypePlayList(LT_INTRO, SngBossHard);
			addToTypePlayList(LT_NORMAL, SngLightningAndGrenades);
			addToTypePlayList(LT_PIPE_BONUS, SngMechanicFactory);
			addToTypePlayList(LT_PLATFORM, SngPerilousCliff);
			addToTypePlayList(LT_UNDER_GROUND, SngMechanicFactory);
			addToTypePlayList(LT_WATER, SngJungle);
			addToTypePlayList(MT_DARK_EPIC, SngUnderTheFeet);
			
			addToTypePlayList(BOSS, SngBossSimple);
			addToTypePlayList(CHAR_SEL, SngMechanicFactory);
			addToTypePlayList(CHOOSE_CHARACTER, Games.contra.SngIntroduction);
			addToTypePlayList(CREDITS, SngEnding);
			addToTypePlayList(DIE, null);
			addToTypePlayList(FINAL_BOSS, SngBossHard);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, SngBossSpider);
			addToTypePlayList(STAR, null);
			addToTypePlayList(TITLE_SCREEN, SngMilitaryFortress);
			addToTypePlayList(WIN, SngStageClear);
			addToTypePlayList(WIN_CASTLE, SngStageClearAll);
		}
	}
}