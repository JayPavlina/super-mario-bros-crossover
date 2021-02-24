package com.smbc.data
{
	import com.smbc.main.GlobVars;
	
	public class FireworkLocations
	{
		// all locations are added to level.castleFlag.x or level.castleFlagEndPosition
		public static const TS:int = GlobVars.TILE_SIZE;
		public static const X_1:int = -TS;
		public static const Y_1:int = -TS*4;
		public static const X_2:int = -TS*3;
		public static const Y_2:int = -TS;
		public static const X_3:int = TS*3;
		public static const Y_3:int = -TS*3;
		public static const X_4:int = TS*3;
		public static const Y_4:int = 0;
		public static const X_5:int = 0;
		public static const Y_5:int = -TS*3;
		public static const X_6:int = -TS*3;
		public static const Y_6:int = -TS;
		public static const FW_6_ARR:Array = [
		[X_1,Y_1],[X_2,Y_2],[X_3,Y_3],[X_4,Y_4],[X_5,Y_5],[X_6,Y_6]
		];
		public static const FW_3_ARR:Array = [
		[X_1,Y_1],[X_2,Y_2],[X_3,Y_3]
		];
		public static const FW_1_ARR:Array = [
		[X_1,Y_1]
		];
		
	}
}