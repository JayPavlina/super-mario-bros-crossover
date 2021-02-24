package com.smbc.graphics.fontChars
{
	import com.smbc.data.GameSettings;
	import com.smbc.graphics.BmdInfo;
	import com.smbc.graphics.SkinNames;
	import com.smbc.main.SkinObj;
	import com.smbc.text.TextFieldContainer;
	
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	
	public class FontChar extends SkinObj
	{
		
//		private static var ctrTemp:int;
//		private var originalVersion:Bitmap;
		private static const BORDER_SIZE:int = 2;
		private static const SPACE_BTW_LINES:int = 24;
		private static const CHAR_OBJ_STR:String = "CHAR_OBJ";
		private static const MAX_CHAR_WIDTH_STR:String = "MAX_CHAR_WIDTH";
		private static const MIN_CHAR_WIDTH_STR:String = "MIN_CHAR_WIDTH";
		private static const LC_CHAR_VEC:Vector.<String> = Vector.<String>([
			"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"
		]);
		private static const UC_CHAR_VEC:Vector.<String> = Vector.<String>([
			"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"
		]);
		protected var parCont:TextFieldContainer;
		protected var parContInd:int;
		public var character:String;
		public static var escapeChar:Boolean;
		public function FontChar(character:String, lastChar:FontChar, parContainer:TextFieldContainer, parContInd:int)
		{
			super();
			this.parCont = parContainer;
			this.character = character;
			this.parContInd = parContInd;
//			x += Number(classObj[CHAR_SIZE_STR]) * index;
			/*if (lastChar)
			{
				var widthNum:Number = lastChar.width*2;
				var maxWidth:Number = classObj[MAX_CHAR_WIDTH_STR];
				var minWidth:Number = classObj[MIN_CHAR_WIDTH_STR]; 
				if (widthNum > maxWidth)
					widthNum = maxWidth;
				else if (widthNum < minWidth)
					widthNum = minWidth;
				trace("widthNum: "+widthNum);
				if (widthNum == 0)
					widthNum = 10;
				x = lastChar.x + widthNum + 2;
			}*/
			var charObj:Object = classObj[CHAR_OBJ_STR]; 
			gotoAndStop(charObj[character] + 1);
		}
		/*public function storeOriginal():void
		{
			relinkBmdToMasterSingleFrame();
			var bmd:BitmapData = getBmpsFromFrame()[0].bitmapData.clone();
			originalVersion = new Bitmap(bmd);
		}*/
		public function calcPos(mainColor:uint, secondColor:uint):void
		{
			if (escapeChar)
			{
				activateEscapeChar();
				return;
			}
			if (character == " ")
				parCont.curWordArr = [];
			else if (character == "\\")
			{
				parCont.curWordArr = [];
				visible = false;
				escapeChar = true;
			}
			else
				parCont.curWordArr.push(this);
			if (parContInd)
			{
				var lastFontChar:FontChar = parCont.fontCharVec[parContInd - 1];
				var lastRect:Rectangle = getSingleColorRect(lastFontChar.getChildAt(0) as Bitmap,mainColor);
				var interfaceSkin:int = GameSettings.getInterfaceSkinLimited();
				if (interfaceSkin == BmdInfo.SKIN_NUM_SMB3_SNES || interfaceSkin == BmdInfo.SKIN_NUM_BLASTER_MASTER)
				{
//					allows use of two colors instead of just one for rect
					var rect2:Rectangle = getSingleColorRect(lastFontChar.getChildAt(0) as Bitmap,secondColor);
					lastRect = lastRect.union(rect2);
				}
//				if (lastFontChar.originalVersion)
//					var lastRect:Rectangle = getSingleColorRect(lastFontChar.originalVersion,mainColor);
				var lastWidth:Number = lastRect.width*2;
				var xOfs:Number = lastRect.x*2;
				if (lastWidth == 0)
					lastWidth = 10;
				if (lastFontChar.character == '"' || lastFontChar.character == "*" || lastFontChar.character == "-")
					lastWidth += 2;
				x = lastFontChar.x + lastWidth + xOfs;
				y = parCont.currentLine;
				if (lastFontChar.y != y)
					x = 0;
			}
			if (parCont.multiline && x > parCont.textBlockWidth)
			{
				if (character == " ") // makes so there is no space at end
					x = lastFontChar.x;
				else
					newLine();
			}
		}
		
		private function activateEscapeChar():void
		{
			switch(character)
			{
				case "n":
				{
					newLine();
					break;
				}
			}
			visible = false;
			escapeChar = false;
		}
		private function newLine():void
		{
			var curWordArr:Array = parCont.curWordArr;
			parCont.currentLine += SPACE_BTW_LINES;
			if (!curWordArr.length)
				return;
			var n:int = curWordArr.length;
			var firstCharPos:int = FontChar(curWordArr[i]).x;
//			trace("parCont.currentLine: "+parCont.currentLine);
			for (var i:int = 0; i < n; i++) 
			{
				var char:FontChar = curWordArr[i];
				char.x -= firstCharPos;
				char.y = parCont.currentLine;
			}
		}
		protected function getSingleColorRect(bmp:Bitmap,color:uint):Rectangle
		{
//			var obj:Bitmap = fontChar.getChildAt(0) as Bitmap;
			return bmp.bitmapData.getColorBoundsRect(0xFFFFFFFF, color, true);
		}
		protected static function matchLCToUC(obj:Object):void
		{
			var n:int = LC_CHAR_VEC.length;
			for (var i:int = 0; i < n; i++) 
			{
				var lcChar:String = LC_CHAR_VEC[i];
				var ucChar:String = UC_CHAR_VEC[i];
				obj[lcChar] = obj[ucChar];
			}
		}
	}
}