package com.smbc.graphics
{
	import com.explodingRabbit.utils.ArrayUtils;
	import com.explodingRabbit.utils.CustomDictionary;
	import com.smbc.data.GameSettings;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	import flash.utils.Dictionary;

	public class PaletteSheet
	{
		public static const TYPE_MAIN:String = "main";
		public static const TYPE_CHARACTER:String = "character";
		private static const TYPE_WIDTH:int = 21;
		private static const TYPE_COL_WIDTH:int = 1;
		private static const THEME_BORDER:int = 1;
		private static const SPACE_BTW_TYPES:int = 1;
		private static const SET_HEIGHT:int = 99;
		private static const NUM_ITEMS_PER_SET:int = 99;
		private static const SPACE_BTW_SETS:int = 1;
		public static const ITEM_NUM_MAP_REG_START:int = 40;
		private static const COLOR_END:uint = Palette.COLOR_END;
		private static const NUM_COL_PER_TYPE_DCT:Dictionary = new Dictionary();
		{
			NUM_COL_PER_TYPE_DCT[TYPE_MAIN] = 3;
			NUM_COL_PER_TYPE_DCT[TYPE_CHARACTER] = 1;
		}
		
		public static const THEME_TYPE_MAP:int = 0;
		public static const THEME_TYPE_ENEMY:int = 1;
		public static const THEME_TYPE_INTERFACE:int = 2;
		public static const THEME_TYPE_CHARACTER:int = 3;
		private var data:Array = [];
		private var infoNum:int; // charNum or skinNum
		private var bmd:BitmapData;
		private var sheetType:String;
		private var numThemeTypes:int;
		private var numRows:int;
		private var numCols:int;
		private static var standardColDct:CustomDictionary;
		
		public function PaletteSheet(bmp:Bitmap,sheetType:String,infoNum:int)
		{
			if (!standardColDct)
				standardColDct = Palette.STANDARD_COLOR_DCT;
			bmd = bmp.bitmapData;
			this.sheetType = sheetType;
			this.infoNum = infoNum;
			numThemeTypes = NUM_COL_PER_TYPE_DCT[sheetType];
			setUpDimensions();
			setUpData();
			
		}
		private function setUpDimensions():void
		{
			var themeWidth:int = numThemeTypes*TYPE_WIDTH + (numThemeTypes*TYPE_COL_WIDTH) + THEME_BORDER*2;
			numCols = Math.round( bmd.width/themeWidth );
			var setHeight:int = SET_HEIGHT + SPACE_BTW_SETS;
			numRows = Math.round( bmd.height/setHeight );
		}
		private function setUpData():void
		{
			for (var row:int = 0; row < numRows; row++) 
			{
				for (var col:int = 0; col < numCols; col++) 
				{
					for (var themeType:int = 0; themeType < numThemeTypes; themeType++) 
					{
						var x:int = getXPos(col,themeType);
						for (var itemNum:int = 1; itemNum <= NUM_ITEMS_PER_SET; itemNum++) 
						{
							var y:int = itemNum + ( SET_HEIGHT + SPACE_BTW_SETS)*row;
							var inColor:uint = bmd.getPixel32(x,y);
							var i:int = 0;
							if (inColor != COLOR_END)
							{
								var match:Boolean = false;
								colorTester: for each (var colorNum:uint in standardColDct)
								{
									if (inColor == colorNum)
									{
										match = true;
										break colorTester;
									}
								}
//								if (!match)
//									throw new Error("wrong palette color... sheet type: "+sheetType+" infoNum: "+infoNum.toString()+" x: "+x+" y: "+y);
								var arr:Array = ArrayUtils.readWriteNestedArr(data,itemNum,themeType,row,col);
								while (i < TYPE_WIDTH)
								{
									arr[i] = inColor;
									i++;
									inColor = bmd.getPixel32(x+i,y);
								}
								i--;
								inColor = arr[i];
								while (inColor == COLOR_END && i >= 0)
								{
									arr.pop();
									i--;
									inColor = arr[i];
								}
							}
						}
					}
				}
			}
			
		}
		private function convThemeTypeToUsable(num:int):int
		{
			if (num == THEME_TYPE_CHARACTER)
				return 0;
			return num;
		}
		private function getArrFromBox(itemNum:int,row:int,col:int,themeType:int = 0):Array
		{
//			return data[row][col][themeType][itemNum];
			return ArrayUtils.readNestedArr(data,itemNum,convThemeTypeToUsable(themeType),row,col);
		}
		private function getArrFromRow(itemNum:int,row:int,themeType:int = 0,firstColIsStandard:Boolean = false):Array
		{
			var container:Array = [];
			var col:int;
			var arr:Array;
			if (firstColIsStandard)
			{
				if (themeType == THEME_TYPE_CHARACTER)
					arr = getArrFromBox(itemNum,row,0,themeType);
				else
					arr = getArrFromBox(itemNum,0,0,themeType);
				if (!arr)
					return container;
				container[0] = arr;
				col = 1;
			}
			for (col; col < numCols; col++) 
			{
				arr = getArrFromBox(itemNum,row,col,themeType);
				if (!arr)
					break;
				container[col] = arr;
			}
			return container;
		}
		private function getStandardArr(itemNum:int,row:int = 0,col:int = 0,themeType:int = 0):Array
		{
			if (sheetType == TYPE_CHARACTER)
				return getArrFromBox(itemNum,row,0,0);
			else
				return getArrFromBox(itemNum,0,0,themeType);
		}
		public function getMapThemePalette(itemNum:int,set:int,theme:int):Palette
		{
			if (itemNum >= ITEM_NUM_MAP_REG_START)
				throw new Error("this is not a map theme item");
			else if (set == 0)
				throw new Error("set greater than 0 must be used for map theme items");
			var container:Array = [];
			var arr:Array = getArrFromBox(itemNum,0,theme,THEME_TYPE_MAP);
			if (arr)
				container.push(arr);
			arr = getArrFromBox(itemNum,set,theme,THEME_TYPE_MAP);
			if (arr)
				container.push(arr);
			return new Palette( container );
		}
		public function getPaletteFromBox(itemNum:int,row:int,col:int,themeType:int = 0):Palette
		{
			return new Palette( getArrFromBox(itemNum,row,col,themeType) );
		}
		public function getPaletteFromRow(itemNum:int,row:int,themeType:int = 0,firstColIsStandard:Boolean = false):Palette
		{
			return new Palette( getArrFromRow(itemNum,row,themeType,firstColIsStandard) );
		}
		public function getInOutPalette(itemNum:int,row:int,col:int,themeType:int):Palette
		{
			if (sheetType == TYPE_MAIN && themeType == THEME_TYPE_MAP && itemNum < ITEM_NUM_MAP_REG_START)
				return getMapThemePalette(itemNum,row,col);
			var container:Array = [];
			var arr:Array = getStandardArr(itemNum,row,col,themeType);
			if (arr)
				container.push(arr);
			arr = getArrFromBox(itemNum,row,col,themeType)
			if (arr)
				container.push(arr);
			return new Palette( container );
		}
		
		private function getXPos(col:int,themeType:int):int
		{
			var colOfs:int = col*( numThemeTypes*TYPE_WIDTH + numThemeTypes*TYPE_COL_WIDTH + THEME_BORDER*2 ) + 1;
			if (col == 0)
				colOfs = 1; // because left border is only 1 pixel wide on first theme
			var typeOfs:int = themeType*TYPE_WIDTH + (themeType*TYPE_COL_WIDTH + 1);
			return colOfs + typeOfs;
		}
		
	}
}