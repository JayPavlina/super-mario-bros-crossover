package com.smbc.graphics
{
	import com.smbc.data.LevelDataTranscoder;
	import com.smbc.managers.GraphicsManager;

	public final class SkinNames
	{
		public static const USE_MAP_SKIN:String = "map skin";
		public static const RANDOM:String = "random";
		
		public static function getName(num:int):String
		{
			var rNum:int = GraphicsManager.RANDOM_SKIN_NUM;
			if (num < rNum)
				return LevelDataTranscoder.SKINS_VEC[num];
			else if (num == rNum)
				return RANDOM;
			else
				return USE_MAP_SKIN;
		}
		public static function getNum(name:String):int
		{
			if (name === RANDOM)
				return GraphicsManager.RANDOM_SKIN_NUM;
			else if (name === USE_MAP_SKIN)
				return GraphicsManager.USE_MAP_SKIN_NUM;
			else
				return LevelDataTranscoder.SKINS_OBJ[name];
		}
	}
}