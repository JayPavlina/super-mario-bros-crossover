package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameDragonWarriorGb extends Game
	{
		private static var instance:Game; 
		
		public function GameDragonWarriorGb(gameNum:int, skinSetNum:int = -1)
		{
			super("Dragon Quest I & II (GBC)", "Square-Enix", Consoles.gameBoy, gameNum, "DQ I & II (GBC)", skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		[Embed(source="../../../../../assets/audio/seq/gbs/DragonQuest1-2Gb.gbs", mimeType="application/octet-stream")]
		public const Gbs:Class;
		
		private const VOLUME:int = 35; 
		
		public const SngCursed:Song = addSong( Gbs, 2, null, VOLUME );
		public const SngThouHastDied:Song = addSong( Gbs, 3, null, VOLUME );
		public const SngOverture:Song = addSong( Gbs, 6, null, VOLUME );
		public const SngImprovement:Song = addSong( Gbs, 10, null, VOLUME );
		public const SngPeacefulVillage:Song = addSong( Gbs, 12, null, VOLUME );
		public const SngLotosDescendant:Song = addSong( Gbs, 13, null, VOLUME );
		public const SngKingdomOfAlefgard:Song = addSong( Gbs, 15, null, VOLUME );
		public const SngTantegelCastle:Song = addSong( Gbs, 17, null, VOLUME );
		public const SngAMonsterDrawsNear:Song = addSong( Gbs, 19, null, VOLUME );
		public const SngHerosFanfare:Song = addSong( Gbs, 25, null, VOLUME );
		public const SngTheDragonlord:Song = addSong( Gbs, 26, null, VOLUME );
		public const SngFairyFlute:Song = addSong( Gbs, 36, null, VOLUME );
		public const SngLaurasLove:Song = addSong( Gbs, 39, null, VOLUME );
		public const SngRainbowBridge:Song = addSong( Gbs, 43, null, VOLUME );
		public const SngDarkDungeonFloor1:Song = addSong( Gbs, 46, null, VOLUME );
		public const SngDarkDungeonFloor2:Song = addSong( Gbs, 48, null, VOLUME );
		public const SngThroneOfDarkness:Song = addSong( Gbs, 49, null, VOLUME );
		
		override protected function setUpLevelThemes():void
		{
			
		}
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngThroneOfDarkness);
			addToTypePlayList(LT_CHEEP_CHEEP, SngKingdomOfAlefgard);
			addToTypePlayList(LT_COIN_HEAVEN, SngPeacefulVillage);
			addToTypePlayList(LT_INTRO, SngRainbowBridge);
			addToTypePlayList(LT_NORMAL, SngKingdomOfAlefgard);
			addToTypePlayList(LT_PIPE_BONUS, SngDarkDungeonFloor2);
			addToTypePlayList(LT_PLATFORM, SngKingdomOfAlefgard);
			addToTypePlayList(LT_UNDER_GROUND, SngDarkDungeonFloor2);
			addToTypePlayList(LT_WATER, SngTantegelCastle);
			addToTypePlayList(MT_DARK_EPIC, SngTantegelCastle);
			
			addToTypePlayList(BOSS, SngAMonsterDrawsNear);
			addToTypePlayList(CHAR_SEL, SngLotosDescendant);
			addToTypePlayList(CHOOSE_CHARACTER, SngFairyFlute);
			addToTypePlayList(CREDITS, SngHerosFanfare);
			addToTypePlayList(DIE, null);
			addToTypePlayList(FINAL_BOSS, SngTheDragonlord);
			addToTypePlayList(GAME_OVER, SngThouHastDied);
			addToTypePlayList(HURRY, SngDarkDungeonFloor1);
			addToTypePlayList(STAR, Games.superMarioBros.SngInvincible);
			addToTypePlayList(TITLE_SCREEN, SngOverture);
			addToTypePlayList(WIN, SngImprovement);
			addToTypePlayList(WIN_CASTLE, SngLaurasLove);
			
		}
	}
}