package com.explodingRabbit.utils
{
	public class StringUtils
	{
		public static const IND_DATA_TYPE:int = 0;
		public static const IND_DATA_SKIN:int = 1;
		public static const IND_DATA_THEME:int = 2;
		public static const IND_DATA_SET:int = 3;
		public static const IND_DATA_LAYER:int = 4;
		
		private static const STR_TRIM_LENGTH:int = 22;
		private static const STR_SKIN_LENGTH:int = 3;
		private static const STR_THEME_LENGTH:int = 2;
		private static const STR_SET_LENGTH:int = 2;
		private static const STR_LAYER_LENGTH:int = 2;
		private static const STR_SEP_LENGTH:int = 1;
		private static const STR_SEP:String = "_";
		
		public static function readClassData(cl:Class):Array
		{
			var str:String = Class(cl).toString();
			str = str.substr(STR_TRIM_LENGTH,str.length - STR_TRIM_LENGTH - 1);
			var index:int;
			var arr:Array = ["",-1,-1,-1,-1];
			var typeLength:int = str.indexOf(STR_SEP);
			arr[IND_DATA_TYPE] = str.substr(index,typeLength);
			index = typeLength + STR_SEP_LENGTH;
			arr[IND_DATA_SKIN] = int( str.substr(index,STR_SKIN_LENGTH) );
			index += STR_SKIN_LENGTH + STR_SEP_LENGTH;
			arr[IND_DATA_THEME] = int( str.substr(index,STR_THEME_LENGTH) );
			index += STR_THEME_LENGTH + STR_SEP_LENGTH;
			if (index >= str.length)
				return arr;
			arr[IND_DATA_SET] = int( str.substr(index,STR_SET_LENGTH) );
			index += STR_SET_LENGTH + STR_SEP_LENGTH;
			if (index >= str.length)
				return arr;
			arr[IND_DATA_LAYER] = int( str.substr(index,STR_LAYER_LENGTH) );
			return arr;
		}
		public static function getClassNameFromClass(classObj:Class):String
		{
			var str:String = Class(classObj).toString();
			var num:int = 17;
			return str.substr(num,str.length - num - 1);
		}
		public static function getClassNameFromQualifiedName(className:String):String
		{
			
			return className.substr(className.indexOf("::") + 2);
		}
	}
}