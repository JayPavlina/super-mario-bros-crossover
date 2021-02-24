package com.smbc.graphics
{
	import com.explodingRabbit.utils.ArrayUtils;
	import com.explodingRabbit.utils.ColorUtils;
	import com.explodingRabbit.utils.CustomDictionary;
	import com.smbc.data.EnemyInfo;
	import com.smbc.data.HealthValue;
	import com.smbc.data.Themes;
	import com.smbc.graphics.BmdInfo;
	import com.smbc.managers.GraphicsManager;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.net.getClassByAlias;
	import flash.utils.Dictionary;

	public class Palette
	{
		[Embed(source="../assets/images/other/gb_palettes.png")]
		private static var GbPalettesClass:Class;
		public static const TYPE_MAP:int = 0;
		public static const TYPE_ENEMY:int = 1;
		public static const TYPE_INTERFACE:int = 2;
		public static const TYPE_CHARACTER:int = 3;
		/**
		 *Array that stores all palettes 
		 */	
		public static var GBpalette:Palette;
		public static const MAIN_PAL_ARR:Array = [];
		private static const CHAR_PAL_ARR:Array = [];
		public static const COLOR_NEW_REGULAR_PALETTE:uint = 0xFFFFFF00; // yellow		
		public static const COLOR_NEW_FLASH_PALETTE:uint = 0xFF00FF00; // green		
		public static const COLOR_NEW_ROW:uint = 0xFFFF0000; // red
		public static const COLOR_STANDARD_PALETTE:uint = 0xFFFF00FF; // magenta
		public static const COLOR_ANIM_FRAME_DELAY:uint = 0xFF00FFFF; // turquoise
		public static const COLOR_FRAME:uint = 0xFF6f3198; // purple		
		public static const STANDARD_COLOR_DCT:CustomDictionary = new CustomDictionary(); // contains standard colors used
		{
			STANDARD_COLOR_DCT.addItem(COLOR_NEW_REGULAR_PALETTE);
			STANDARD_COLOR_DCT.addItem(COLOR_NEW_FLASH_PALETTE);
			STANDARD_COLOR_DCT.addItem(COLOR_NEW_ROW);
			STANDARD_COLOR_DCT.addItem(COLOR_STANDARD_PALETTE);
			STANDARD_COLOR_DCT.addItem(COLOR_ANIM_FRAME_DELAY);
//			STANDARD_COLOR_DCT.addItem(COLOR_FRAME);			
		}
		private static const ITEM_NUM_MAP_REG_START:int = 40;
		public static const COLOR_END:uint = 0;
		private static const MIN_THEME:int = 1;
		private static const MIN_SET:int = 1;
		private static const TYPE_WIDTH:int = 21;
		private static const TYPE_COL_WIDTH:int = 1;
		private static const THEME_BORDER:int = 1;
		private static const SPACE_BTW_TYPES:int = 1;
		private static const SET_HEIGHT:int = 99;
		private static const SPACE_BTW_SETS:int = 1;
		private static const NUM_TYPES_PER_THEME_MAIN:int = 3;
		private static const NUM_TYPES_PER_THEME_CHAR:int = 1;
		public static const NUM_GB_PALETTE_GROUPS:int = 3;
		public static const NUM_GB_COLORS_PER_GROUP:int = 4;
		
		private static const LUM_MULT:Number = 63.75; // 63.75
		private static const GB_LUM_PAL_1:int = LUM_MULT*3;
		private static const GB_LUM_PAL_2:int = LUM_MULT*2;
		private static const GB_LUM_PAL_3:int = LUM_MULT*1;
		
		private static var GB_COL_0:uint;
		private static var GB_COL_1:uint;
		private static var GB_COL_2:uint;
		private static var GB_COL_3:uint;
		private var data:Array = [];
		private var charNum:int = -1; // same as theme for characters
		private var itemNum:int;
		private var bmd:BitmapData;
		private var skin:int;
		private var theme:int; // same as charNum for characters
		private var set:int;
		private var type:int;
		private var typeColNum:int;
		private var _numRows:int;
		private var _numCols:int;
		private var numColorsPerStandardRow:int;
		public var newColorsEnd:int; // when replace colors begin in first row
		private var numTypesPerTheme:int;
		
		public function Palette(palArr:Array)
		{
			this.data = palArr;
			setUpDimensions();
			getNewColorsEnd();
		}
		
		private function setUpDimensions():void
		{
			_numRows = data.length;
			for (var row:int = 0; row < _numRows; row++) 
			{
				_numCols = Math.max( _numCols, (data[row] as Array).length );
			}
		}
		
		public function get numRows():int
		{
			return _numRows;
		}

		public function get numCols():int
		{
			return _numCols;
		}

		public function toString():String
		{
			return data.toString();
		}
		private function getNewColorsEnd():int
		{
			if ( getRowFirstColor(0) != COLOR_STANDARD_PALETTE )
				return 0;
			var arr:Array = data[0];
			var n:int = arr.length;
			for (var i:int = 1; i < n; i++) 
			{
				if (arr[i] == COLOR_STANDARD_PALETTE)
				{
					newColorsEnd = i;
					break;
				}
			}
			return newColorsEnd;
		}
		
		/*public function getNumRowsByColorType(color:uint):int
		{
			
		}*/
		public function extractPaletteByColorType(extractColor:uint):Palette
		{
			if (extractColor == COLOR_NEW_ROW)
				throw new Error("cannot use new row as color type");
			var rowStart:int = -1;
			var rowEnd:int = -1;
			for (var i:int = 0; i < _numRows; i++) 
			{
				var rowColor:uint = getRowFirstColor(i);
				if (rowStart == -1)
				{
					if (rowColor == extractColor)
						rowStart = i;
				}
				else
				{
					if (rowColor != COLOR_NEW_ROW && rowColor != extractColor)
					{
						rowEnd = i - 1;
						break;
					}
				}
			}
			if (rowStart == -1)
				return null;
			if (rowEnd == -1)
				rowEnd = _numRows - 1;
			var arr:Array = [];
			for (var j:int = rowStart; j <= rowEnd; j++) 
			{
				arr.push(j);
			}
			return extractRowsAsPalette(arr);
		}
		
		private function drawToPalSheet():void
		{
			for (var row:int = 0; row < _numRows; row++) 
			{
				var y:int;
				var xStart:int;
				if ( rowIsGlobal(row) )
					y = itemNum;
				else
					y = itemNum + ( SET_HEIGHT + SPACE_BTW_SETS)*set;
				xStart = getXPos(row,y);
				for (var col:int = 0; col < _numCols; col++) 
				{
					bmd.setPixel32( xStart+col, y, readColor(row,col) );
				}
			}
		}
		
		private function getXPos(palRow:int,yPos:int):int
		{
			if (palRow != 0)
				palRow = 1;
			palRow--;
			var xPos:int;
//			do {
			palRow++;
			var colOfs:int = palRow*( numTypesPerTheme*TYPE_WIDTH + numTypesPerTheme*TYPE_COL_WIDTH + THEME_BORDER*2 ) + 1;
			if (palRow == 0)
				colOfs = 1; // because left border is only 1 pixel wide on first theme
			var typeOfs:int = typeColNum*TYPE_WIDTH + (typeColNum*TYPE_COL_WIDTH + 1);
			xPos = colOfs + typeOfs;
//			} while (bmd.getPixel32(xPos,yPos) != COLOR_END)
			return xPos;
		}
		private function getYPos(firstRow:Boolean = false):int
		{
			if ( firstRow )
				return itemNum;
			else
				return itemNum + ( SET_HEIGHT + SPACE_BTW_SETS)*set;
		}
		public function convToGrayScale(skipFirstCol:Boolean = true):Palette
		{
			var tempPal:Palette = clone();
			var lumFct:Function = ColorUtils.luminance;
			for (var row:int = 0; row < _numRows; row++) 
			{
				var rowArr:Array = tempPal.data[row];
				var n:int = rowArr.length;
				inner: for (var col:int = 0; col < n; col++) 
				{
					if (skipFirstCol && col == 0)
						continue;
					var color:uint = rowArr[col];
					var luminance:int = lumFct(color);
					if (luminance < GB_LUM_PAL_3)
						color = GB_COL_3; 
					else if (luminance < GB_LUM_PAL_2)
						color = GB_COL_2;
					else if (luminance < GB_LUM_PAL_1)
						color = GB_COL_1;
					else
						color = GB_COL_0;
					rowArr[col] = color;
				}
			}
			return tempPal;
		}
		public function convToGameBoy(palNum:int, group:int, skipFirstCol:Boolean = true):Palette
		{
			var tempPal:Palette = convToGrayScale(skipFirstCol);
			for (var row:int = 0; row < _numRows; row++) 
			{
				var rowArr:Array = tempPal.data[row];
				var n:int = rowArr.length;
				inner: for (var col:int = 0; col < n; col++) 
				{
					if (skipFirstCol && col == 0)
						continue inner;
					var color:uint = rowArr[col];
					var ofs:int = 0;
					if (color == GB_COL_1)
						ofs = 1;
					else if (color == GB_COL_2)
						ofs = 2;
					else if (color == GB_COL_3)
						ofs = 3;
					color = GBpalette.readColor(palNum - 1,NUM_GB_COLORS_PER_GROUP*group + ofs);
					rowArr[col] = color;
				}
			}
			return tempPal;
		}
		private function readNewPalette():void
		{
			var startY:int = getYPos(true);
			var startX:int = getXPos(0,startY);
			var inColor:uint = bmd.getPixel32( startX, startY );
//			if (inColor != COLOR_STANDARD_PALETTE)
//				throw new Error("must have standard palette");
			data[0] = [];
			var i:int = 0;
			// read standard row
			while (inColor != COLOR_END)
			{
				data[0][i] = inColor;
				if (inColor == COLOR_STANDARD_PALETTE && i != 0)
					newColorsEnd = i;
				i++;
				inColor = bmd.getPixel32(startX + i,startY);
			}
			numColorsPerStandardRow = i;
			_numCols = numColorsPerStandardRow;
			var standardRowsEnd:int;
			// read all palettes in current row
			// move on to next row
			
		}
		public function readOldPalette(srcBmd:BitmapData,pnt:Point):Array
		{
			// only currently designed for standard, new palette, and continue rows
			var inColor:uint = srcBmd.getPixel32(pnt.x,pnt.y);
			if (inColor != COLOR_STANDARD_PALETTE)
				throw new Error("must have standard palette");
			data[0] = [];
			var standardRowsEnd:int;
			var i:int = 0;
			// read left column, create arrays
			while (inColor != COLOR_END)
			{
				inColor = srcBmd.getPixel32(pnt.x,pnt.y + i);
				if (inColor != COLOR_END && inColor != COLOR_NEW_ROW && inColor != COLOR_NEW_REGULAR_PALETTE && inColor != COLOR_NEW_FLASH_PALETTE)
				{
					standardRowsEnd = i;
				}
				data[i] = [inColor];
				i++;
			}
			_numRows = i - 1;
			inColor = srcBmd.getPixel32(pnt.x,pnt.y);
			i = 0;
			// read standard row
			while (inColor != COLOR_END)
			{
				data[0][i] = inColor;
				if (inColor == COLOR_STANDARD_PALETTE && i != 0)
					newColorsEnd = i;
				i++;
				inColor = srcBmd.getPixel32(pnt.x + i,pnt.y);
			}
			numColorsPerStandardRow = i;
			_numCols = numColorsPerStandardRow;
			var n:int = _numRows;
			if (standardRowsEnd)
				n = standardRowsEnd;
			// read the other rows, skipping first row
			for (i = 1; i < n; i++) // i == 1 because first row is already read
			{
				for (var j:int = 0; j < numColorsPerStandardRow; j++) 
				{
					data[i][j] = srcBmd.getPixel32(pnt.x + j,pnt.y + i);
				}
			}
			if (standardRowsEnd)
			{
				for (i = standardRowsEnd; i < _numRows; i++) 
				{
					j = 1;
					inColor = srcBmd.getPixel32(pnt.x + j,pnt.y + i);
					while (inColor != COLOR_END)
					{
						data[i][j] = inColor;
						j++;
						inColor = srcBmd.getPixel32(pnt.x + j,pnt.y + i);
					}
				}
			}
			
			
			data.push(newColorsEnd);
			return data;
		}
		public function getRowFirstColor(rowNum:int):uint
		{
			return uint( ArrayUtils.readNestedArr(data,rowNum,0) );
		}
		private function rowIsGlobal(rowNum:int):Boolean
		{
			if (type == TYPE_CHARACTER)
				return false;
			var rowType:uint = getRowFirstColor(rowNum);
			if (rowType == COLOR_NEW_FLASH_PALETTE || rowType == COLOR_STANDARD_PALETTE || rowType == COLOR_ANIM_FRAME_DELAY)
				return true;
			if (rowType == COLOR_NEW_ROW)
			{
				var i:int = rowNum - 1;
				rowType = getRowFirstColor(i);
				while ( rowType != COLOR_NEW_REGULAR_PALETTE && rowType != COLOR_NEW_FLASH_PALETTE && rowType != COLOR_STANDARD_PALETTE)
				{
					i--;
					rowType = getRowFirstColor(i);
				}
				if (rowType == COLOR_NEW_FLASH_PALETTE)
					return true;
			}
			return false;
		}
		public function extractRowsAsPalette(... rows):Palette
		{
			if (rows[0] is Array)
				rows = rows[0];
			var n:int = rows.length;
			var container:Array = [];
			for (var i:int = 0; i < n; i++) 
			{
				var rowNum:int = rows[i];
				var row:Array = data[rowNum];
				if (row)
					container.push(row.concat());
			}
			return new Palette( container );
		}
		public function clone():Palette
		{
			var n:int = numRows;
			var arr:Array = [];
			for (var i:int = 0; i < n; i++) 
			{
				arr[i] = i;
			}
			return extractRowsAsPalette(arr);
		}
		public function addToPalArr():void
		{
			savePalette(this,type,skin,theme,set);
		}
		public function readColor(row:int,col:int):uint
		{
//			return uint(data[row][col]);
			return uint( ArrayUtils.readNestedArr(data,row,col) );
		}
		public static function savePalette(palette:Palette,type:int,skin:int,theme:int,set:int = MIN_SET):void
		{
			if (type == TYPE_CHARACTER)
				ArrayUtils.writeNestedArray(CHAR_PAL_ARR,palette,theme,skin);
			else
				ArrayUtils.writeNestedArray(MAIN_PAL_ARR,palette,type,skin,theme,set);
		}
		public static function getPalette(type:int,skin:int,theme:int,set:int = MIN_SET):Palette
		{
			if (type == TYPE_CHARACTER)
				return ArrayUtils.readNestedArr(CHAR_PAL_ARR,theme,skin);
			else
				return ArrayUtils.readNestedArr(MAIN_PAL_ARR,type,skin,int,theme,set);
		} 
		
		public static function createGameBoyPalette():Palette
		{
			if (GBpalette)
				throw new Error("Gameboy palette already created");
			var bmd:BitmapData = Bitmap( new GbPalettesClass() ).bitmapData;
			GbPalettesClass = null;
			var data:Array = [];
			var numRows:int = bmd.height;
			var numCols:int = bmd.width;
			for (var row:int = 0; row < numRows; row++) 
			{
				var rowArr:Array = [];
				data[row] = rowArr;
				for (var col:int = 0; col < numCols; col++) 
				{
					rowArr[col] = bmd.getPixel32(col,row);
				}
			}
			GBpalette = new Palette( data );
			GB_COL_0 = GBpalette.readColor(0,0);
			GB_COL_1 = GBpalette.readColor(0,1);
			GB_COL_2 = GBpalette.readColor(0,2);
			GB_COL_3 = GBpalette.readColor(0,3);
			return GBpalette;
		}
	}
}