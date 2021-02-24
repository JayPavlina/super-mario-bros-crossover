package com.smbc.text
{
	import com.explodingRabbit.utils.CustomDictionary;
	import com.smbc.data.GameBoyPalettes;
	import com.smbc.data.GameSettings;
	import com.smbc.data.InterfaceInfo;
	import com.smbc.data.PaletteTypes;
	import com.smbc.graphics.Palette;
	import com.smbc.graphics.PaletteSheet;
	import com.smbc.graphics.fontChars.*;
	import com.smbc.graphics.BmdInfo;
	import com.smbc.graphics.BmdSkinCont;
	import com.smbc.managers.GraphicsManager;
	import com.smbc.managers.TextManager;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.sampler.getMasterString;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Dictionary;
	
	import nl.stroep.utils.ImageSaver;
	
	public class TextFieldContainer extends Sprite
	{
		// types are linked to colors in bitmap sheet
		private static const TFC_DCT:Dictionary = new Dictionary(true);
		private static const GM:GraphicsManager = GraphicsManager.INSTANCE;
		private static const NUM_FONTS:int = 7;
		private static const FONT_CHAR_CLASS_VEC:Vector.<Class> = new Vector.<Class>(NUM_FONTS,true);
		{	// sets up selectable fontChars
			FONT_CHAR_CLASS_VEC[FontCharHud.FONT_NUM] = FontCharHud;
			FONT_CHAR_CLASS_VEC[FontCharMenu.FONT_NUM] = FontCharMenu;
			FONT_CHAR_CLASS_VEC[FontCharScore.FONT_NUM] = FontCharScore;
			FONT_CHAR_CLASS_VEC[FontCharSimon.FONT_NUM] = FontCharSimon;
			FONT_CHAR_CLASS_VEC[FontCharSamus.FONT_NUM] = FontCharSamus;
			FONT_CHAR_CLASS_VEC[FontCharRyu.FONT_NUM] = FontCharRyu;
			FONT_CHAR_CLASS_VEC[FontCharLink.FONT_NUM] = FontCharLink;
		}
		private static const FONT_CHAR_PAL_PNT_STR:String = "PALETTE_PNT";
		private var font:int;
		private var type:int;
		public var fontCharVec:Vector.<FontChar> = new Vector.<FontChar>();
		public var curWordArr:Array = [];
		public var textBlockWidth:Number;
		private var align:String = TextFormatAlign.LEFT;
		//private var _autoSize:String;
		//private var _defaultTextFormat:TextFormat;
		//private var _embedFonts:Boolean;
		//private var _selectable:Boolean;
		private var _text:String = "";
//		private var charDct:Dictionary = new Dictionary();
		//private var _textColor:uint;
		private var charContainer:Sprite = new Sprite();
		public var currentLine:int;
		public var lineArr:Array = [];
		public var multiline:Boolean;
		
		public function TextFieldContainer(font:int,type:int = 0)
		{
			super();
			this.type = type;
			this.font = font;
			TFC_DCT[this] = true;
		}
		public static function updateTfcs():void
		{
			for (var obj:Object in TFC_DCT)
			{
				(obj as TextFieldContainer).recolorCharacters();
			}
		}
		/*public static function storeOriginalFontChars():void
		{
			for each (var tfc:TextFieldContainer in TFC_DCT)
			{
				var container:Sprite = tfc.charContainer;
				var n:int = container.numChildren;
				for (var i:int = 0; i < n; i++) 
				{
					var fontChar:FontChar = container.getChildAt(i) as FontChar;
					fontChar.storeOriginal();
				}
			}
		}*/
		private function removeAllTextFields():void
		{
			/*var n:int = numChildren;
			for (var i:int; i < n; i++)
			{
				removeChild(getChildAt(0));
			}
			TF_VEC.length = 0;*/
		}
		public function changeType(type:int):void
		{
			this.type = type;
			recolorCharacters();
		}
		public function get text():String
		{
			return _text;
		}
		
		public function set text(value:String):void
		{
			if (value == null)
				value = "";
			_text = value;
			var fontChar:FontChar;
//			trace("start charContainer.numChildren: "+charContainer.numChildren);
			/*for each (var fontChar:FontChar in fontCharVec)
			{
				if (fontChar.parent)
				{
					fontChar.parent.removeChild(fontChar);
				}
				fontChar.cleanUp();
			}*/
			if (contains(charContainer))
				removeChild(charContainer);
			charContainer = null;
			charContainer = new Sprite();
//			trace("end charContainer.numChildren: "+charContainer.numChildren);
			addChild(charContainer);
			curWordArr = [];
			lineArr = [];
			fontCharVec.length = 0;
			var n:int = value.length;
			var fontClass:Class = FONT_CHAR_CLASS_VEC[font];
			var lastFontChar:FontChar;
			for (var i:int = 0; i < n; i++) 
			{
				fontChar = new fontClass( value.charAt(i), lastFontChar, this, i );
				lastFontChar = fontChar;
				charContainer.addChild(fontChar);
				fontCharVec[i] = fontChar;
			}
			recolorCharacters();
		}
		private function recolorCharacters():void
		{
			if (!charContainer.numChildren)
				return;
			var fontChar:FontChar = charContainer.getChildAt(0) as FontChar;
			fontChar.masterObj.redraw(-1,GM.CLEAN_BMC_VEC_INTERFACE[GameSettings.getInterfaceSkinLimited()].bmd);
			var itemNum:int = int( InterfaceInfo[fontChar.shortClassName] );
			var paletteSheet:PaletteSheet = BmdInfo.getMainPaletteSheet( GameSettings.getInterfaceSkinLimited() );
			var palette:Palette;
			var paletteOut:Palette;
			if (itemNum)
			{
				palette = paletteSheet.getPaletteFromRow(itemNum,1,PaletteSheet.THEME_TYPE_INTERFACE,true);
				paletteOut = palette.clone();
			}
			if ( palette && GM.shouldBeRecoloredToGb(GM.drawingBoardInterfaceSkinCont) && GameSettings.getInterfacePaletteLimited() )
				paletteOut = paletteOut.convToGameBoy( GameSettings.getInterfacePaletteLimited(), GraphicsManager.GB_PAL_BG );	
			var n:int = charContainer.numChildren;
			currentLine = 0;
			lineArr = [];
			var ctr:int;
//			fontChar.masterObj.resetColor(true);
			for (var i:int = 0; i < n; i++) 
			{
				fontChar = charContainer.getChildAt(i) as FontChar;
				fontChar.relinkBmdToMasterSingleFrame(fontChar.currentFrame);
				var bmp:Bitmap = fontChar.getChildAt(0) as Bitmap;
				var bmd:BitmapData = bmp.bitmapData.clone();
				bmp.bitmapData = bmd;
//				GM.recolorSingleBitmap(bmd,palette,palette,0,type + 1);
//				GM.recolorSingleBitmap(bmd,palette,paletteOut,type + 1,type + 1);
				GM.recolorSingleBitmap(bmd,palette,paletteOut,0,type + 1);
				fontChar.calcPos( paletteOut.readColor(type + 1,1), paletteOut.readColor(type + 1,2) );
			}
			for (i = 0; i < n; i++) 
			{
				fontChar = charContainer.getChildAt(i) as FontChar;
				var yNum:Number = fontChar.y;
				var vec:Vector.<FontChar> = lineArr[yNum];
				if (!vec)
				{
					vec = new Vector.<FontChar>();
					lineArr[yNum] = vec;
				}
				vec.push(fontChar);
			}
//			for (i = 0; i < n; i++)
//			{
//				fontChar = charContainer.getChildAt(i) as FontChar;
//				if (palette)
//				{
//					
//					
//					if (fontChar.character == "b" || fontChar.character == "B")
//					{
//						ImageSaver.INSTANCE.save(bmd, "fuck"+1+".png",0);
//						ctr++;
//					}
////					trace("fontChar.character: "+fontChar.character);
////					if (fontChar.character == "b" || fontChar.character == "B")
////					{
////						ImageSaver.INSTANCE.save(bmd, "fuck"+2+".png",0);
////						ctr++;
////					}*/
////					if (palette2)
////						fontChar.calcPos( palette2.readColor(0,1) );
////						else
//					
//				}
//				else
//				{
//					trace("no palette");
//					fontChar.calcPos(0xFFFcFcFc);
//				}
//			}
		}
		public function center():void
		{
			var n:int = lineArr.length;
			var widthNum:Number = charContainer.width;
			for (var i:int = 0; i < n; i++) 
			{
				var vec:Vector.<FontChar> = lineArr[i];
				if (!vec)
					continue;
				var n2:int = vec.length;
				var xMin:Number = getMinX(vec);
				var xMax:Number = getMaxX(vec);
				var dx:Number = xMax - xMin;
				var shiftNum:Number = (widthNum - dx)/2;
				for (var j:int = 0; j < n2; j++) 
				{
					vec[j].x += shiftNum;
				}
			}
		}
		private function getMinX(vec:Vector.<FontChar>):Number
		{
			var min:Number = Number.MAX_VALUE;
			for each (var fontChar:FontChar in vec)
			{
				var xNum:Number = fontChar.x;
				if (xNum < min)
					min = xNum;
			}
			return min;
		}
		private function getMaxX(vec:Vector.<FontChar>):Number
		{
			var max:Number = Number.MIN_VALUE;
			for each (var fontChar:FontChar in vec)
			{
				var xNum:Number = fontChar.x;
				if (xNum > max)
					max = xNum;
			}
			return max;
		}
		/*override public function get width():Number
		{
			return _width;
		}
		override public function set width(value:Number):void
		{
			_width = value;
			for each (var tf:TextField in TF_VEC)
			{
				tf.width = value;
				trace("tf.width: "+tf.width+" value: "+value);
			}
		}*/
		/*public function setTextFormat(format:TextFormat,beginIndex:int=-1,endIndex:int=-1):void
		{
			for each (var tf:TextField in TF_VEC)
			{
				tf.setTextFormat(format,beginIndex,endIndex);
			}
		}

		public function get autoSize():String
		{
			return _autoSize;
		}

		public function set autoSize(value:String):void
		{
			_autoSize = value;
			for each (var tf:TextField in TF_VEC)
			{
				tf.autoSize = value;
			}
		}

		public function get defaultTextFormat():TextFormat
		{
			return _defaultTextFormat;
		}

		public function set defaultTextFormat(value:TextFormat):void
		{
			_defaultTextFormat = value;
			for each (var tf:TextField in TF_VEC)
			{
				tf.defaultTextFormat = value;
			}
		}

		public function get embedFonts():Boolean
		{
			return _embedFonts;
		}

		public function set embedFonts(value:Boolean):void
		{
			_embedFonts = value;
			for each (var tf:TextField in TF_VEC)
			{
				tf.embedFonts = value;
			}
		}

		public function get selectable():Boolean
		{
			return _selectable;
		}

		public function set selectable(value:Boolean):void
		{
			_selectable = value;
			for each (var tf:TextField in TF_VEC)
			{
				tf.selectable = value;
			}
		}*/

		/*public function get textColor():uint
		{
			return _textColor;
		}

		public function set textColor(value:uint):void
		{
			_textColor = value;
			for each (var tf:TextField in TF_VEC)
			{
				tf.textColor = value;
			}
		}*/
	}
}