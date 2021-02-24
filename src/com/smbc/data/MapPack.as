package com.smbc.data
{
	import com.explodingRabbit.utils.Enum;
	import com.smbc.messageBoxes.MenuBoxItems;

	public class MapPack extends Enum
	{
		{ initEnum(MapPack); } // static ctor
		
		public static const Smb:MapPack = new MapPack();
		public static const Special:MapPack = new MapPack();
		public static const LostLevels:MapPack = new MapPack("Lost Levels");
		
		public function MapPack(niceName:String = null)
		{
			super(niceName);
		}
		
//		public static const SMB_NAME:String = "Smb";
//		public static const SPECIAL_NAME:String = "Special";
		
//		private static const _SMB:Array = [ 0, MenuBoxItems.MAP_PACK_SMB ];
//		private static const _SPECIAL:Array = [ 1, MenuBoxItems.MAP_PACK_SMB_SPECIAL ];
//		private static const IND_VALUE:int = 0;
//		private static const IND_NAME:int = 1;
//		private static const VEC:Vector.<Array> = Vector.<Array>([_SMB, _SPECIAL]);
//		public static const MAX_VALUE:int = _SPECIAL[IND_VALUE];
		
//		public static function GetMapPackNames():Vector.<String>
//		{
//			return new <String>[SMB_NAME, SPECIAL_NAME];
//		}
		
//		public static function getMapPackName(mapPack:int):String
//		{
//			switch(mapPack)
//			{
//				case SMB:
//					return SMB_NAME;
//				case SPECIAL:
//					return SPECIAL_NAME;
//			}
//			return null;
//		}
//		public static function swapNumAndName(value:*):*
//		{
//			if (value is int)
//				return VEC[value][IND_NAME];
//			else if (value is String)
//			{
//				for each (var arr:Array in VEC)
//				{
//					if (value == arr[IND_NAME])
//						return arr[IND_VALUE];
//				}
//			}
//			throw new Error("improper conversion input");
//			return null;
//		}
//		
//		public static function get SMB():int
//		{
//			return _SMB[IND_VALUE];
//		}
//		
//		public static function get SPECIAL():int
//		{
//			return _SPECIAL[IND_VALUE];
//		}
	}
}