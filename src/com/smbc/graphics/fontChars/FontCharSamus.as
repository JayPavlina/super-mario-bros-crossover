package com.smbc.graphics.fontChars
{
	import com.smbc.text.TextFieldContainer;
	
	import flash.geom.Point;
	
	public class FontCharSamus extends FontChar
	{
		public static const FONT_NUM:int = 4;
		private static const TYPE_NORMAL:int = 0;
		public static const MAX_CHAR_WIDTH:int = 18;
		public static const MIN_CHAR_WIDTH:int = 14;
		public static const HEART_CHAR:String = "_";
		private static const CHAR_VEC:Vector.<String> = Vector.<String>([
			"0","1","2","3","4","5","6","7","8","9"
		]);
		public static const CHAR_OBJ:Object = new Object();
		{
			(function ():void
			{
				var n:int = CHAR_VEC.length;
				for (var i:int = 0; i < n; i++) 
				{
					CHAR_OBJ[ CHAR_VEC[i] ] = i;
				}
			}() );
		}
		public function FontCharSamus(character:String, lastChar:FontChar, parContainer:TextFieldContainer, parContInd:int)
		{
			super(character, lastChar, parContainer, parContInd);
		}
	}
}