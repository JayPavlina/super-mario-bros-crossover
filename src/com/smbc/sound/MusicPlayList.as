package com.smbc.sound
{
	import com.explodingRabbit.cross.games.Games;
	import com.explodingRabbit.cross.games.GameSuperMarioBros3;
	import com.explodingRabbit.cross.sound.Song;
	import com.explodingRabbit.utils.CustomDictionary;
	import com.smbc.data.LevelTypes;

	public class MusicPlayList
	{
		public static const BGM_STR:String = "_BGM"; // begins with separator
		
		public static const LT_CASTLE:String = LevelTypes.CASTLE;
		public static const LT_CHEEP_CHEEP:String = LevelTypes.CHEEP_CHEEP;
		public static const LT_COIN_HEAVEN:String = LevelTypes.COIN_HEAVEN;
		public static const LT_INTRO:String = LevelTypes.INTRO;
		public static const LT_NORMAL:String = LevelTypes.NORMAL;
		public static const LT_PIPE_BONUS:String = LevelTypes.PIPE_BONUS;
		public static const LT_PLATFORM:String = LevelTypes.PLATFORM;
		public static const LT_UNDER_GROUND:String = LevelTypes.UNDER_GROUND;
		public static const LT_WATER:String = LevelTypes.WATER;
			
		public static const TYPE_BOSS:String = "BOSS";
		public static const TYPE_CHAR_SEL:String = "CHAR_SEL";
		public static const TYPE_CHOOSE_CHARACTER:String = "INTRO_LEVEL";
		public static const TYPE_CREDITS:String = "CREDITS";
		public static const TYPE_DIE:String = "DIE";
		public static const TYPE_FINAL_BOSS:String = "FINAL_BOSS";
		public static const TYPE_GAME_OVER:String = "GAME_OVER";
		public static const TYPE_LAKITU:String = "LAKITU";
		public static const TYPE_HURRY:String = "HURRY";
		public static const TYPE_STAR:String = "STAR";
		public static const TYPE_WIN:String = "WIN";
		public static const TYPE_WIN_CASTLE:String = "WIN_CASTLE";
		
		private static const SONG_DCT:CustomDictionary = new CustomDictionary();
		
		private static function superMarioBros3(type:String,... songs):void { 
			addSong(Games.superMarioBros3.fullName, type, songs);}
		{(function ():void{
			var smb3:Function = superMarioBros3;			
			smb3(LT_CASTLE, GameSuperMarioBros3.SngCastle);
			smb3(LT_CHEEP_CHEEP, GameSuperMarioBros3.SngAthletic);
			smb3(LT_COIN_HEAVEN, GameSuperMarioBros3.SngUpAbove);
			smb3(LT_INTRO, GameSuperMarioBros3.SngChestGame);
			smb3(LT_NORMAL, GameSuperMarioBros3.SngOverWorld);
			smb3(LT_PIPE_BONUS, GameSuperMarioBros3.SngUnderGround);
			smb3(LT_PLATFORM, GameSuperMarioBros3.SngAthletic);
			smb3(LT_UNDER_GROUND, GameSuperMarioBros3.SngUnderGround);
			smb3(LT_WATER, GameSuperMarioBros3.SngSwimming);
			
			smb3(TYPE_BOSS, GameSuperMarioBros3.SngBossFight);
			smb3(TYPE_CHAR_SEL, GameSuperMarioBros3.SngGrassLand);
			smb3(TYPE_CHOOSE_CHARACTER, GameSuperMarioBros3.SngWarpWhistle);
			smb3(TYPE_CREDITS, GameSuperMarioBros3.SngSaveThePrincess);
			smb3(TYPE_DIE, GameSuperMarioBros3.SngDie);
			smb3(TYPE_FINAL_BOSS, GameSuperMarioBros3.SngBowserBattle);
			smb3(TYPE_GAME_OVER, GameSuperMarioBros3.SngGameOver);
			smb3(TYPE_HURRY, GameSuperMarioBros3.SngAthleticHurry);
			smb3(TYPE_LAKITU, GameSuperMarioBros3.SngHammerBros);			
			smb3(TYPE_STAR, GameSuperMarioBros3.SngInvincible);
			smb3(TYPE_WIN, GameSuperMarioBros3.SngBeatLevel);
			smb3(TYPE_WIN_CASTLE, GameSuperMarioBros3.SngBeatAirship);
			
			smb3( GameSuperMarioBros3.SngAirship + TYPE_HURRY, GameSuperMarioBros3.SngAirshipHurry);
			smb3( GameSuperMarioBros3.SngAthletic + TYPE_HURRY, GameSuperMarioBros3.SngAthleticHurry);
			smb3( GameSuperMarioBros3.SngBossFight + TYPE_HURRY, GameSuperMarioBros3.SngBossHurry);
			smb3( GameSuperMarioBros3.SngBowserBattle + TYPE_HURRY, GameSuperMarioBros3.SngBowserBattleHurry);
			smb3( GameSuperMarioBros3.SngCastle + TYPE_HURRY, GameSuperMarioBros3.SngCastleHurry);
			smb3( GameSuperMarioBros3.SngHammerBros + TYPE_HURRY, GameSuperMarioBros3.SngHammerBrosHurry);
			smb3( GameSuperMarioBros3.SngInvincible + TYPE_HURRY, GameSuperMarioBros3.SngInvincibleHurry);
			smb3( GameSuperMarioBros3.SngOverWorld + TYPE_HURRY, GameSuperMarioBros3.SngOverWorldHurry);
			smb3( GameSuperMarioBros3.SngSwimming + TYPE_HURRY, GameSuperMarioBros3.SngSwimmingHurry);
			smb3( GameSuperMarioBros3.SngUnderGround + TYPE_HURRY, GameSuperMarioBros3.SngUnderGroundHurry);
			
		}() );}
		/*
		private static function superMarioWorld(type:String,... songs):void { 
			addSong(Games.superMarioWorld.name, type, songs);}
		{(function ():void{
			var smw:Function = superMarioWorld;			
			smw(LT_CASTLE, GameSuperMarioWorld.SngCastle);
			smw(LT_CHEEP_CHEEP, GameSuperMarioWorld.SngAthletic);
			smw(LT_COIN_HEAVEN, GameSuperMarioWorld.SngBonus);
			smw(LT_INTRO, GameSuperMarioWorld.SngIntroLevel);
			smw(LT_NORMAL, GameSuperMarioWorld.SngOverworld);
			smw(LT_PIPE_BONUS, GameSuperMarioWorld.SngBonus);
			smw(LT_PLATFORM, GameSuperMarioWorld.SngAthletic);
			smw(LT_UNDER_GROUND, GameSuperMarioWorld.SngUnderGround);
			smw(LT_WATER, GameSuperMarioWorld.SngSwimming);
			
			smw(TYPE_BOSS, GameSuperMarioWorld.SngBoss);
			smw(TYPE_CHAR_SEL, GameSuperMarioWorld.SngGameSelect);
			smw(TYPE_CHOOSE_CHARACTER, GameSuperMarioBros3.SngWarpWhistle);
			smw(TYPE_CREDITS, GameSuperMarioWorld.SngSaveThePrincess);
			smw(TYPE_DIE, GameSuperMarioWorld.SngEnding);
			smw(TYPE_FINAL_BOSS, GameSuperMarioWorld.SngKingBowser);
			smw(TYPE_GAME_OVER, GameSuperMarioWorld.SngGameOver);
			smw(TYPE_HURRY, GameSuperMarioWorld.SngAthleticHurry);
//			smw(TYPE_LAKITU, GameSuperMarioWorld.SngHammerBros);			
			smw(TYPE_STAR, GameSuperMarioWorld.SngInvincible);
			smw(TYPE_WIN, GameSuperMarioWorld.SngCourseClear);
			smw(TYPE_WIN_CASTLE, GameSuperMarioWorld.SngWinCastle);
			
			smw( GameSuperMarioWorld.SngCastle + TYPE_HURRY, GameSuperMarioWorld.SngCastleFast);
			smw( GameSuperMarioWorld.SngAthletic + TYPE_HURRY, GameSuperMarioWorld.SngAthleticFast);
			smw( GameSuperMarioWorld.SngBoss + TYPE_HURRY, GameSuperMarioWorld.SngBossFast);
			smw( GameSuperMarioWorld.SngKingBowser + TYPE_HURRY, GameSuperMarioWorld.SngKingBowserFast);
			smw( GameSuperMarioWorld.SngCastle + TYPE_HURRY, GameSuperMarioWorld.SngCastleFast);
//			smw( GameSuperMarioWorld.SngHammerBros + TYPE_HURRY, GameSuperMarioWorld.SngHammerBrosHurry);
			smw( GameSuperMarioWorld.SngInvincible + TYPE_HURRY, GameSuperMarioWorld.SngInvincibleFast);
			smw( GameSuperMarioWorld.SngOverworld + TYPE_HURRY, GameSuperMarioWorld.SngOverworldFast);
			smw( GameSuperMarioWorld.SngSwimming + TYPE_HURRY, GameSuperMarioWorld.SngSwimmingFast);
			smw( GameSuperMarioWorld.SngUnderGround + TYPE_HURRY, GameSuperMarioWorld.SngUnderGroundFast);
			
		}() );}
		*/
		private static function addSong(game:String,type:String,songs:Array):void
		{
			SONG_DCT.addItem(game + type, songs);
		}
		public static function getSong(str:String):Song
		{
			return SONG_DCT[str][0];
		}
	}
}