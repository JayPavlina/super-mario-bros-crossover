package com.smbc.sound
{
	import com.explodingRabbit.cross.games.Games;
	import com.explodingRabbit.cross.sound.Song;

	public class Songs
	{
		public static const SuperMarioBros3_GrassLand:Song = addSmb3( 1, "Grass Land" );
		public static const SuperMarioBros3_DesertLand:Song = addSmb3( 2, "Desert Land" );
		public static const SuperMarioBros3_WaterWorld:Song = addSmb3( 3, "Water World" );
		public static const SuperMarioBros3_GiantsWorld:Song = addSmb3( 4, "Giant's World" );
		public static const SuperMarioBros3_CloudWorld:Song = addSmb3( 5, "Cloud World" );
		public static const SuperMarioBros3_IceWorld:Song = addSmb3( 6, "Ice World" );
		public static const SuperMarioBros3_PipeWorld:Song = addSmb3( 7, "Pipe World" );
		public static const SuperMarioBros3_DarkWorld:Song = addSmb3( 8, "Dark World" );
		public static const SuperMarioBros3_OverWorld:Song = addSmb3( 9, "Overworld" );
		public static const SuperMarioBros3_Athletic:Song = addSmb3( 10, "Athletic" );
		public static const SuperMarioBros3_Swimming:Song = addSmb3( 11, "Swimming" );
		public static const SuperMarioBros3_UnderGround:Song = addSmb3( 12, "Under Ground" );
		public static const SuperMarioBros3_UpAbove:Song = addSmb3( 13, "Up Above" );
		public static const SuperMarioBros3_Invincible:Song = addSmb3( 14, "Invincible" );
		public static const SuperMarioBros3_WarpWhistle:Song = addSmb3( 15, "Warp Whistle" );
		public static const SuperMarioBros3_MusicBox:Song = addSmb3( 16, "Music Box" );
		public static const SuperMarioBros3_CardGame:Song = addSmb3( 17, "Card Game" );
		public static const SuperMarioBros3_ChestGame:Song = addSmb3( 18, "Chest Game" );
		public static const SuperMarioBros3_HammerBros:Song = addSmb3( 19, "Hammer Bros." );
		public static const SuperMarioBros3_SaveTheKing:Song = addSmb3( 20, "Save the King" );
		public static const SuperMarioBros3_Airship:Song = addSmb3( 21, "Airship" );
		public static const SuperMarioBros3_BossFight:Song = addSmb3( 22, "Boss Fight" );
		public static const SuperMarioBros3_Castle:Song = addSmb3( 23, "Castle" );
		public static const SuperMarioBros3_BowserBattle:Song = addSmb3( 24, "Bowser Battle" );
		public static const SuperMarioBros3_SaveThePrincess:Song = addSmb3( 25, "Save the Princess" );
		public static const SuperMarioBros3_OverWorldHurry:Song = addSmb3( 27, "Overworld Hurry" );
		public static const SuperMarioBros3_AthleticHurry:Song = addSmb3( 28, "Athletic Hurry" );
		public static const SuperMarioBros3_SwimmingHurry:Song = addSmb3( 29, "Swimming Hurry" );
		public static const SuperMarioBros3_UnderGroundHurry:Song = addSmb3( 30, "Under Ground Hurry" );
		public static const SuperMarioBros3_InvincibleHurry:Song = addSmb3( 31, "Invincible Hurry" );
		public static const SuperMarioBros3_ChestGameHurry:Song = addSmb3( 32, "Chest Game Hurry" );
		public static const SuperMarioBros3_HammerBrosHurry:Song = addSmb3( 33, "Hammer Bros. Hurry" );
		public static const SuperMarioBros3_AirshipHurry:Song = addSmb3( 34, "Airship Hurry" );
		public static const SuperMarioBros3_BossHurry:Song = addSmb3( 35, "Boss Fight Hurry" );
		public static const SuperMarioBros3_CastleHurry:Song = addSmb3( 36, "Castle Hurry" );
		public static const SuperMarioBros3_BowserBattleHurry:Song = addSmb3( 37, "Bowser Battle Hurry" );
		public static const SuperMarioBros3_BeatLevel:Song = addSmb3( 38, "Beat Level" );
		public static const SuperMarioBros3_BeatAirship:Song = addSmb3( 40, "Beat Airship" );
		public static const SuperMarioBros3_BeatBoomBoom:Song = addSmb3( 41, "Beat Boom Boom" );
		public static const SuperMarioBros3_GameOver:Song = addSmb3( 42, "Game Over" );
		public static const SuperMarioBros3_Die:Song = addSmb3( 43, "Die" );
		
		private static function addSmb3(track:int, name:String, volume:int = 80, start:int = 0, loop:int = 0):Song{ 
			return new Song( MusicInfo.SuperMarioBros3Nsfe, name, Games.superMarioBros3, track, volume, start, loop ); }
	}
}