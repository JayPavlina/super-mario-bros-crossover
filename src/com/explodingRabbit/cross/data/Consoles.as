package com.explodingRabbit.cross.data
{

	public class Consoles
	{
		private static const IND_NAME:int = 0;
		
		private static const _atari:Array = [ "atari", ConsoleType.BIT_8 ];
		public static function get atari():String { return _atari[IND_NAME]; } 
		
		private static const _gameBoy:Array = [ "gameBoy", ConsoleType.GB ];
		public static function get gameBoy():String { return _gameBoy[IND_NAME]; } 
		
		private static const _gameGear:Array = [ "gameGear", ConsoleType.BIT_8 ];
		public static function get gameGear():String { return _gameGear[IND_NAME]; }
		
		private static const _nintendo:Array = [ "nintendo", ConsoleType.BIT_8 ];
		public static function get nintendo():String { return _nintendo[IND_NAME]; }

		private static const _nintendoDS:Array = [ "NintendoDS", ConsoleType.BIT_16 ];
		public static function get nintendoDS():String { return _nintendoDS[IND_NAME]; }

		private static const _nintendoWii:Array = [ "NintendoWii", ConsoleType.BIT_16 ];
		public static function get nintendoWii():String { return _nintendoWii[IND_NAME]; }

		private static const _msx:Array = [ "msx", ConsoleType.BIT_8 ];
		public static function get msx():String { return _msx[IND_NAME]; }
		
		private static const _segaGenesis:Array = [ "segaGenesis", ConsoleType.BIT_16 ];
		public static function get segaGenesis():String { return _segaGenesis[IND_NAME]; }
		
		private static const _segaMasterSystem:Array = [ "segaMasterSystem", ConsoleType.BIT_8 ];
		public static function get segaMasterSystem():String { return _segaMasterSystem[IND_NAME]; }
		
		private static const _superNintendo:Array = [ "superNintendo", ConsoleType.BIT_16 ];
		public static function get superNintendo():String { return _superNintendo[IND_NAME]; }
		
	}
}