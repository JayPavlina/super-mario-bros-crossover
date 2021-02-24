package com.explodingRabbit.cross.data
{
	import com.smbc.messageBoxes.MenuBoxItems;

	public class ConsoleType
	{
		public static const BIT_8:int = 0;
		public static const BIT_16:int = 1;
		public static const GB:int = 2;
		public static const CHARACTER:int = 3; // yeah I know this is bad
		public static const MAP:int = 4; 
		public static const RANDOM:int = 5;
		public static const MAX_VALUE:int = RANDOM;
		public static const MAX_CONSOLE_VALUE:int = GB;
		
		public static function convNumToName(num:int):String
		{
			switch (num)
			{
				case BIT_8:
					return MenuBoxItems.NES;
				case BIT_16:
					return MenuBoxItems.SUPER_NES;
				case GB:
					return MenuBoxItems.GAMEBOY;
				case MAP:
					return "Map";
				case CHARACTER:
					return "Character";
				case RANDOM:
					return "Random";
			}
			return null;
		}
	}
}