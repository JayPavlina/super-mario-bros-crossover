package com.explodingRabbit.utils
{
	public class SortingFunctions
	{
		public static function sortStrings(s1:String,s2:String):int
		{
			if (s1 < s2) return -1;
			else if (s1 > s2) return 1;
			else return 0;
		}
		public static function sortNums(n1:Number,n2:Number):int
		{
			if (n1 < n2)
				return -1;
			else if (n1 > n2)
				return 1;
			else
				return 0;
		}
	}
}