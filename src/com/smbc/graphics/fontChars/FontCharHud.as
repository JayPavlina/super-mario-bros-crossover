package com.smbc.graphics.fontChars
{
	import com.smbc.data.InterfaceInfo;
	import com.smbc.text.TextFieldContainer;
	
	import flash.geom.Point;

	public class FontCharHud extends FontChar
	{
		public static const FONT_NUM:int = 1;
		public static const TYPE_NORMAL:int = 0;
		public static const TYPE_OUTLINE:int = 1;
		public static const MAX_CHAR_WIDTH:int = 18;
		public static const MIN_CHAR_WIDTH:int = 14;
		private static const CHAR_VEC:Vector.<String> = Vector.<String>([
			"0","1","2","3","4","5","6","7","8","9","A","B",
			"C","D","E","F","G","H","I","J","K","L","M","N",
			"O","P","Q","R","S","T","U","V","W","X","Y","Z",
			" ","*","-",".",":","!","?","'"
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
			matchLCToUC(CHAR_OBJ);
		}
		public function FontCharHud(character:String, lastChar:FontChar, parContainer:TextFieldContainer, parContInd:int)
		{
			super(character, lastChar, parContainer, parContInd);
		}
	}
}