package com.smbc.graphics.fontChars
{
	import com.smbc.text.TextFieldContainer;
	
	import flash.geom.Point;

	public class FontCharMenu extends FontChar
	{
		public static const FONT_NUM:int = 0;
		public static const PALETTE_PNT:Point = new Point(118,61);
		public static const TYPE_NORMAL:int = 0;
		public static const TYPE_SELECTED:int = 1;
		public static const TYPE_DISABLED:int = 2;
		public static const TYPE_CREDITS:int = 3;
//		public static const TYPE_CHAR_NAME:int = 4;
//		public static const TYPE_SKIN_NAME:int = 5;
//		public static const TYPE_GAME_NAME:int = 6;
		public static const MAX_CHAR_WIDTH:int = 12;
		public static const MIN_CHAR_WIDTH:int = 10;
		
		private static const CHAR_VEC:Vector.<String> = Vector.<String>([
			" ","!","\"","#","$","%","&","'","(",")","*","+",",","-",
			".","/","0","1","2","3","4","5","6","7","8","9",":",";",
			"<","=",">","?","@","A","B","C","D","E","F","G","H","I",
			"J","K","L","M","N","O","P","Q","R","S","T","U","V","W",
			"X","Y","Z","[","\\","]","^","_","`","a","b","c","d","e",
			"f","g","h","i","j","k","l","m","n","o","p","q","r","s",
			"t","u","v","w","x","y","z","{","|","}"
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
			}());
		}
		public function FontCharMenu(character:String, lastChar:FontChar, parContainer:TextFieldContainer, parContInd:int)
		{
			super(character, lastChar, parContainer, parContInd);
		}
	}
}