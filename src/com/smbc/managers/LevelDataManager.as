package com.smbc.managers
{
	import com.explodingRabbit.utils.CustomDictionary;
	import com.explodingRabbit.utils.Enum;
	import com.smbc.data.GameSettings;
	import com.smbc.data.MapPack;
	import com.smbc.errors.SingletonError;
	import com.smbc.level.LevelData;
	
	import flash.utils.Dictionary;

	public class LevelDataManager
	{
		
		private static var levelDatas:CustomDictionary = new CustomDictionary();
		private static const INSTANCE:LevelDataManager = new LevelDataManager(); // don't put this first
		private static var instantiated:Boolean;
		
		public static function get currentLevelData():LevelData
		{
			return getLevelData(GameSettings.mapPack);
		}
		
		public function LevelDataManager()
		{
			if (instantiated)
				throw new SingletonError();
			instantiated = true;
			
			for each( var mapPack:MapPack in Enum.GetConstants(MapPack) )
			{
				levelDatas.addItem( mapPack, new LevelData(mapPack) );
			}
		}
		
		public static function getLevelData(mapPack:MapPack):LevelData
		{
			return levelDatas[mapPack];
		}
	}
}