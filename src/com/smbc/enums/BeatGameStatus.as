package com.smbc.enums
{
	import com.explodingRabbit.utils.Enum;
	import com.smbc.data.MapDifficulty;
	
	public class BeatGameStatus extends Enum
	{
		{ initEnum(BeatGameStatus); } // static ctor
		
		public static const None:BeatGameStatus = new BeatGameStatus();
		public static const Easy:BeatGameStatus = new BeatGameStatus();
		public static const Normal:BeatGameStatus = new BeatGameStatus();
		public static const Hard:BeatGameStatus = new BeatGameStatus();
		
		public static function GetStatus(mapDifficulty:int):BeatGameStatus
		{
			switch(mapDifficulty)
			{
				case MapDifficulty.EASY:
					return Easy;
				case MapDifficulty.NORMAL:
					return Normal;
				case MapDifficulty.HARD:
					return Hard;
				default:
					return None;
			}
		}
		
		public static function GetMapDifficulty(status:BeatGameStatus):int
		{
			switch(status)
			{
				case Easy:
					return MapDifficulty.EASY;
				case Normal:
					return MapDifficulty.NORMAL;
				case Hard:
					return MapDifficulty.HARD;
				default:
					return -1;
			}
		}
		
		public function BeatGameStatus(niceName:String = null)
		{
			super(niceName);
		}
	}
}