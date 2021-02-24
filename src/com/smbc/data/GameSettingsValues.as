package com.smbc.data
{
	import com.explodingRabbit.utils.CustomDictionary;
	
	import flash.utils.describeType;

	public class GameSettingsValues
	{
		private static const IND_VALUE:int = 0;
		private static const IND_NAME:int = 1;
		
		private static var paletteTargetCtr:int = -1;
		public static const PALETTE_TARGET_PREFIX:String = "paletteTarget";
		private static const _paletteTargetAll:Array = [ paletteTargetCtr+=1, MenuBoxValues.PALETTE_TARGET_ALL ];
		private static const _paletteTarget8Bit:Array = [ paletteTargetCtr+=1, MenuBoxValues.PALETTE_TARGET_8BIT ];
		private static const _paletteTarget16Bit:Array = [ paletteTargetCtr+=1, MenuBoxValues.PALETTE_TARGET_16BIT ];
//		private static const _paletteTargetSnes:Array = [ paletteTargetCtr+=1, MenuBoxValues.PALETTE_TARGET_SNES ];
//		private static const _paletteTargetAll:Array = [ paletteTargetCtr+=1, MenuBoxValues.PALETTE_TARGET_ALL ];
		public static const PALETTE_TARGET_MAX_VALUE:int = _paletteTarget16Bit[IND_VALUE];
		public static const paletteTargetVec:Vector.<String> = new Vector.<String>(PALETTE_TARGET_MAX_VALUE + 1,true);
		public static const paletteTargetObj:Object = {};
		
		// calculated later, these are offsets
		public static var mapSkinMaxValue:int = 0;
		public static var mapSkinLimitedMaxValue:int = -1;
		public static var enemySkinMaxValue:int = 1;
		public static var enemySkinLimitedMaxValue:int = -1;
		public static var interfaceSkinMaxValue:int = 1;
		public static var interfaceSkinLimitedMaxValue:int = -1;
		
		public static function initiate():Boolean
		{
			var list:XMLList = describeType(GameSettingsValues)..accessor;
			var n:int = list.length();
			if (!n)
				throw new Error("cannot initiate");
			for (var i:int; i < n; i++)
			{
				var name:String = list[i].@name;
				var value:Object = GameSettingsValues["_"+name];
//				trace("name: "+name+" value: "+value);
				if (name.indexOf(PALETTE_TARGET_PREFIX) != -1 && value)
				{
					var arr:Array = value as Array;
					var curName:String = arr[IND_NAME];
					var curValue:String = arr[IND_VALUE];
//					trace("curName: "+curName+" curValue: "+curValue);
					paletteTargetVec[curValue] = curName;
					paletteTargetObj[curName] = curValue;
				}
			}
//			trace("paletteTargetVec: "+paletteTargetVec);
			return true;
		}
		public static function nameToNum(prefix:String,name:String):int // set up prefix later
		{
			return paletteTargetObj[name];
		}

		public static function numToName(prefix:String,num:int):String
		{
			return paletteTargetVec[num];
		}
		public static function calcSkinMaxValue(... inactiveSkinNums):Array
		{
			var biggestPossible:int = LevelDataTranscoder.SKINS_VEC.length;
			var activeSkinNumsDct:CustomDictionary = new CustomDictionary();
			for (var i:int = 0; i <= biggestPossible; i++) 
			{
				activeSkinNumsDct.addItem(i);
			}
			var maxActiveSkinNum:int;
			if (inactiveSkinNums)
			{
				for each (var skinNum:int in inactiveSkinNums)
				{
					activeSkinNumsDct.removeItem(skinNum);
				}
			}
			for each (skinNum in activeSkinNumsDct)
			{
				maxActiveSkinNum = Math.max( maxActiveSkinNum, skinNum );
			}
			var value:int = Math.min( biggestPossible, maxActiveSkinNum );
			mapSkinMaxValue += value;
			mapSkinLimitedMaxValue += value;
			enemySkinMaxValue += value;
			enemySkinLimitedMaxValue += value;
			interfaceSkinMaxValue += value;
			interfaceSkinLimitedMaxValue += value;
			return inactiveSkinNums;
		}
		
//		public static function get paletteTargetGb():int { return _paletteTarget8Bit[IND_VALUE]; }
//		public static function get paletteTargetNes():int { return _paletteTargetAll[IND_VALUE]; }
		public static function get paletteTarget8Bit():int { return _paletteTarget8Bit[IND_VALUE]; }
		public static function get paletteTarget16Bit():int { return _paletteTarget16Bit[IND_VALUE]; }
		public static function get paletteTargetAll():int { return _paletteTargetAll[IND_VALUE]; }
	}
}