package com.smbc.data
{
	public class MusicQuality
	{
		public static const LOW:int = 0;
		public static const MID:int = 1;
		public static const HIGH:int = 2;
		public static const MAX_VALUE:int = HIGH;
		
		public static function convNumToName(num:int):String
		{
			switch(num)
			{
				case LOW:
					return "low";
				case MID:
					return "mid";
				case HIGH:
					return "high";
			}
			return null;
		}
	}
}