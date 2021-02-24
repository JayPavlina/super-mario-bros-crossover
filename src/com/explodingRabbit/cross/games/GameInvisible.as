package com.explodingRabbit.cross.games
{
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.MapPack;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameInvisible extends Game
	{
		private static var instance:Game;
		public static const NUM_WORLDS:int = 8;
		public function GameInvisible(gameNum:int, skinSetNum:int)
		{
			super("Super Mario Bros.", "Nintendo", Consoles.nintendo, gameNum, "SMB (Invisible)", skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		private const TG_DAY:ThemeGroup = addThemeGroup( 1, 1 );
		private const TG_NIGHT:ThemeGroup = addThemeGroup( 1, 2, MT_DARK_EPIC );
		private const TG_BLACK:ThemeGroup = addThemeGroup( 1, 3 );
		private const TG_WATER:ThemeGroup = addThemeGroup( 1, 4 );
		private const TG_WATER_NIGHT:ThemeGroup = addThemeGroup( 1, 5 );
		
		override protected function setUpLevelThemes():void
		{
			addToThemeInfoGeneral( TG_DAY, LT_NORMAL, LT_INTRO, LT_PLATFORM, LT_CHEEP_CHEEP, LT_COIN_HEAVEN );
			addToThemeInfoGeneral( TG_BLACK, LT_UNDER_GROUND, LT_PIPE_BONUS, LT_CASTLE );
			addToThemeInfoGeneral( TG_WATER, LT_WATER );
			
			addToThemeInfoWorld( 3, TG_NIGHT, LT_NORMAL, LT_PLATFORM, LT_COIN_HEAVEN );
			addToThemeInfoWorld( 6, TG_NIGHT, LT_NORMAL, LT_PLATFORM, LT_COIN_HEAVEN );
			
			themeMapPack = MapPack.Special;
				
			addToThemeInfoGeneral( TG_WATER_NIGHT, "3-1b", "6-2c", "6-2e" );
				
			themeMapPack = MapPack.LostLevels;
			
			addToThemeInfoWorld( 2, TG_NIGHT, LT_NORMAL, LT_CHEEP_CHEEP );
			addToThemeInfoWorld( 3, TG_DAY, LT_NORMAL, LT_PLATFORM );
			addToThemeInfoWorld( 6, TG_DAY, LT_NORMAL, LT_CHEEP_CHEEP );
			addToThemeInfoWorld( 7, TG_NIGHT, LT_NORMAL, LT_PLATFORM );
			addToThemeInfoWorld( 9, TG_NIGHT, LT_COIN_HEAVEN );
			addToThemeInfoWorld( 12, TG_NIGHT, LT_NORMAL, LT_PLATFORM, LT_CHEEP_CHEEP );

			addToThemeInfoGeneral( TG_WATER_NIGHT, "9-4a" );
		}
		override protected function createPlayList():void
		{
			setGameToUseAsPlayList(Games.superMarioBros);
		}
	}
}