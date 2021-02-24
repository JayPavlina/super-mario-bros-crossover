package com.explodingRabbit.utils
{
	import flash.utils.Dictionary;

	public class ArrayUtils
	{
		private static function writeNestedArrayWithOptions(arr:Array,value:*, readInsteadOfWrite:Boolean, indexes:Array):Array
		{
			var n:int = indexes.length - 1;
			var storedArrs:Array = [];
			storedArrs[0] = arr;
			for (var i:int = 0; i < n; i++) 
			{
				var curVal:int = indexes[i];
				var curArr:Array = storedArrs[i][curVal];
				if (!curArr)
				{
					curArr = [];
					storedArrs[i][curVal] = curArr;
				}
				storedArrs[i + 1] = curArr;
			}
			if (!readInsteadOfWrite )
				storedArrs[ n ][ indexes[n] ] = value; // writing ends here
			else
			{
				var finalArr:Array = storedArrs[ n ][ indexes[n] ];
				if (finalArr)
					return finalArr;
				else
				{
					finalArr = [];
					storedArrs[ n ][ indexes[n] ] = finalArr;
					return finalArr;
				}
			}
			return null;
		}
		public static function readNestedArr(arr:Array, ... indexes):*
		{
			var n:int = indexes.length - 1;
			var storedArrs:Array = [];
			storedArrs[0] = arr;
			for (var i:int = 0; i < n; i++) 
			{
				var curVal:int = indexes[i];
				var curArr:Array = storedArrs[i][curVal];
				if (curArr)
					storedArrs[i + 1] = curArr;
				else
					return null;
			}
			return storedArrs[ n ][ indexes[n] ];
		}
		public static function writeNestedArray(arr:Array,value:*, ... indexes):void
		{
			writeNestedArrayWithOptions(arr, value, false, indexes);
		}
		/**
		 * Returns a new array if current array doesn't exist 
		 * @param arr - Array to create
		 * @param indexes - Nested indexes
		 * @return 
		 * 
		 */		
		public static function readWriteNestedArr(arr:Array, ... indexes):*
		{
			return writeNestedArrayWithOptions(arr, null, true, indexes);
		}
		public static function convArrayToDct(arr:Array,weakKeys:Boolean = false):Dictionary
		{
			var dct:Dictionary = new Dictionary(weakKeys);
			for each (var value:Object in arr)
			{
				dct[value] = value;
			}
			return dct;
		}
		/**
		 * Returns the max value of an array of ints
		 * @param arr - Array to check
		 * @return - max value of array
		 * 
		 */	
		public static function maxValue(arr:Array):int
		{
			var max:int = arr[0];
			for each (var num:int in arr)
			{
				if (num > max)
					max = num;
			}
			return max;
		}
		
		/**
		 * Returns the minimum value of an array of ints
		 * @param arr - Array to check
		 * @return - min value of array
		 * 
		 */	
		public static function minValue(arr:Array):int
		{
			var min:int = arr[0];
			for each (var num:int in arr)
			{
				if (num < min)
					min = num;
			}
			return min;
		}
	}
}