package com.explodingRabbit.cross.games
{
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.MapPack;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameDemonReturns extends Game
	{
		private static var instance:Game; 
		
		public function GameDemonReturns(gameNum:int, skinSetNum:int)
		{
			super("Demon Returns", "Namco Bandai Games", Consoles.nintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		override public function initiate():void
		{
			super.initiate();
			creditsGame = Games.gameCenterCx2;
			
		}

		private const TG_OVERWORLD_1:ThemeGroup = addThemeGroup( 1, 1 );
		private const TG_OVERWORLD_2:ThemeGroup = addThemeGroup( 1, 2 );
		private const TG_OVERWORLD_3:ThemeGroup = addThemeGroup( 1, 3 );
		private const TG_OVERWORLD_4:ThemeGroup = addThemeGroup( 1, 4, MT_DARK_EPIC );
		private const TG_UNDERGROUND_1:ThemeGroup = addThemeGroup( 2, 1 );
		private const TG_UNDERGROUND_2:ThemeGroup = addThemeGroup( 2, 2 );
		private const TG_UNDERGROUND_3:ThemeGroup = addThemeGroup( 2, 3 );
		private const TG_UNDERGROUND_4:ThemeGroup = addThemeGroup( 2, 4 );
		private const TG_BONUS:ThemeGroup = addThemeGroup( 2, 5 );
		private const TG_PLATFORM_1:ThemeGroup = addThemeGroup( 3, 1, MT_DARK_EPIC );
		private const TG_PLATFORM_2:ThemeGroup = addThemeGroup( 3, 2, MT_DARK_EPIC );
		private const TG_PLATFORM_3:ThemeGroup = addThemeGroup( 3, 3, MT_DARK_EPIC );
		private const TG_PLATFORM_4:ThemeGroup = addThemeGroup( 3, 4, MT_DARK_EPIC );
		private const TG_CASTLE_1:ThemeGroup = addThemeGroup( 4, 1 );
		private const TG_CASTLE_2:ThemeGroup = addThemeGroup( 4, 2 );
		private const TG_CASTLE_3:ThemeGroup = addThemeGroup( 4, 3 );
		private const TG_CASTLE_4:ThemeGroup = addThemeGroup( 4, 4 );
		private const TG_CASTLE_4_WATER:ThemeGroup = addThemeGroup( 4, 5 );
		private const TG_COIN_HEAVEN_NORMAL:ThemeGroup = addThemeGroup( 5, 1 );
		private const TG_COIN_HEAVEN_SPECIAL:ThemeGroup = addThemeGroup( 5, 2 );
		private const TG_WATER_1:ThemeGroup = addThemeGroup( 6, 1 );
		private const TG_WATER_2:ThemeGroup = addThemeGroup( 6, 2 );
		private const TG_WATER_3:ThemeGroup = addThemeGroup( 6, 3 );
		private const TG_WATER_4:ThemeGroup = addThemeGroup( 6, 4 );
		/*I figure worlds 1-2 are set 1, 3-4 set 2, 5-6 set 3, 7-8 set 4... this is for all themes except 5
		what should coin heaven be?
			Theme 5 set 1
		Set 2 is for the coin heaven that has the warp pipes if its possible to make that different
		The underground bonus areas would be theme 2 set 5
		water is theme 6
		
		All overworld is theme 1, underground is 2, platforms are 3, castle is 4
		Then coin heaven is 5 and water is 6
		*/
		override protected function setUpLevelThemes():void
		{
			addToThemeInfoGeneral( TG_BONUS, LT_PIPE_BONUS);
			addToThemeInfoGeneral( TG_COIN_HEAVEN_NORMAL, LT_COIN_HEAVEN );
			
			addToThemeInfoGeneral( TG_OVERWORLD_1, LT_NORMAL, LT_INTRO );
			addToThemeInfoGeneral( TG_PLATFORM_1, LT_PLATFORM, LT_CHEEP_CHEEP );
			addToThemeInfoGeneral( TG_UNDERGROUND_1, LT_UNDER_GROUND );
			addToThemeInfoGeneral( TG_CASTLE_1, LT_CASTLE );
			addToThemeInfoGeneral( TG_WATER_1, LT_WATER );

			addToThemeInfoWorld( 3, TG_OVERWORLD_2, LT_NORMAL, LT_INTRO );
			addToThemeInfoWorld( 3, TG_PLATFORM_2, LT_PLATFORM, LT_CHEEP_CHEEP );
			addToThemeInfoWorld( 3, TG_UNDERGROUND_2, LT_UNDER_GROUND );
			addToThemeInfoWorld( 3, TG_CASTLE_2, LT_CASTLE );
			addToThemeInfoWorld( 3, TG_WATER_2, LT_WATER );

			addToThemeInfoWorld( 4, TG_OVERWORLD_2, LT_NORMAL, LT_INTRO );
			addToThemeInfoWorld( 4, TG_PLATFORM_2, LT_PLATFORM, LT_CHEEP_CHEEP );
			addToThemeInfoWorld( 4, TG_UNDERGROUND_2, LT_UNDER_GROUND );
			addToThemeInfoWorld( 4, TG_CASTLE_2, LT_CASTLE );
			addToThemeInfoWorld( 4, TG_WATER_2, LT_WATER );

			addToThemeInfoWorld( 5, TG_OVERWORLD_3, LT_NORMAL, LT_INTRO );
			addToThemeInfoWorld( 5, TG_PLATFORM_3, LT_PLATFORM, LT_CHEEP_CHEEP );
			addToThemeInfoWorld( 5, TG_UNDERGROUND_3, LT_UNDER_GROUND );
			addToThemeInfoWorld( 5, TG_CASTLE_3, LT_CASTLE );
			addToThemeInfoWorld( 5, TG_WATER_3, LT_WATER );

			addToThemeInfoWorld( 6, TG_OVERWORLD_3, LT_NORMAL, LT_INTRO );
			addToThemeInfoWorld( 6, TG_PLATFORM_3, LT_PLATFORM, LT_CHEEP_CHEEP );
			addToThemeInfoWorld( 6, TG_UNDERGROUND_3, LT_UNDER_GROUND );
			addToThemeInfoWorld( 6, TG_CASTLE_3, LT_CASTLE );
			addToThemeInfoWorld( 6, TG_WATER_3, LT_WATER );

			addToThemeInfoWorld( 7, TG_OVERWORLD_4, LT_NORMAL, LT_INTRO );
			addToThemeInfoWorld( 7, TG_PLATFORM_4, LT_PLATFORM, LT_CHEEP_CHEEP );
			addToThemeInfoWorld( 7, TG_UNDERGROUND_4, LT_UNDER_GROUND );
			addToThemeInfoWorld( 7, TG_CASTLE_4, LT_CASTLE );
			addToThemeInfoWorld( 7, TG_WATER_4, LT_WATER );

			addToThemeInfoWorld( 8, TG_OVERWORLD_4, LT_NORMAL, LT_INTRO );
			addToThemeInfoWorld( 8, TG_PLATFORM_4, LT_PLATFORM, LT_CHEEP_CHEEP );
			addToThemeInfoWorld( 8, TG_UNDERGROUND_4, LT_UNDER_GROUND );
			addToThemeInfoWorld( 8, TG_CASTLE_4, LT_CASTLE );
			addToThemeInfoWorld( 8, TG_CASTLE_4_WATER, LT_WATER );
			
			themeMapPack = MapPack.Special;
			
			addToThemeInfoGeneral( TG_UNDERGROUND_3, "6-2d" );
			addToThemeInfoGeneral( TG_WATER_4, "8-2b" );
			
			themeMapPack = MapPack.LostLevels;
			
			addToThemeInfoWorld( 11, TG_OVERWORLD_2, LT_NORMAL, LT_INTRO );
			addToThemeInfoWorld( 11, TG_PLATFORM_2, LT_PLATFORM, LT_CHEEP_CHEEP );
			addToThemeInfoWorld( 11, TG_UNDERGROUND_2, LT_UNDER_GROUND );
			addToThemeInfoWorld( 11, TG_CASTLE_2, LT_CASTLE );
			addToThemeInfoWorld( 11, TG_WATER_2, LT_WATER );
			
			addToThemeInfoWorld( 12, TG_OVERWORLD_3, LT_NORMAL, LT_INTRO );
			addToThemeInfoWorld( 12, TG_PLATFORM_3, LT_PLATFORM, LT_CHEEP_CHEEP );
			addToThemeInfoWorld( 12, TG_UNDERGROUND_3, LT_UNDER_GROUND );
			addToThemeInfoWorld( 12, TG_CASTLE_3, LT_CASTLE );
			addToThemeInfoWorld( 12, TG_WATER_3, LT_WATER );
			
			addToThemeInfoWorld( 13, TG_OVERWORLD_4, LT_NORMAL, LT_INTRO );
			addToThemeInfoWorld( 13, TG_PLATFORM_4, LT_PLATFORM, LT_CHEEP_CHEEP );
			addToThemeInfoWorld( 13, TG_UNDERGROUND_4, LT_UNDER_GROUND );
			addToThemeInfoWorld( 13, TG_CASTLE_4, LT_CASTLE );
			addToThemeInfoWorld( 13, TG_WATER_4, LT_WATER );
			
			addToThemeInfoGeneral( TG_WATER_4, "8-1b" );
			addToThemeInfoGeneral( TG_COIN_HEAVEN_NORMAL, "8-2b", "8-3a", "10-3a" );
			addToThemeInfoGeneral( TG_OVERWORLD_3, "9-3a" );
		}
		override protected function createPlayList():void
		{
			setGameToUseAsPlayList(Games.gimmick);
			addToThemePlayList( TG_CASTLE_4_WATER, Games.gimmick.SngLionHeart, [ LT_WATER ] );
		}
	}
}