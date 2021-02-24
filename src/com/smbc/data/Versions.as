package com.smbc.data
{
	public class Versions
	{
		
//		add const, add in array, add in toString function
		public static const V_2_0:Number = 2.0;
		public static const V_2_0_2:Number = 2.02;
		public static const V_2_0_3:Number = 2.03;
		public static const V_2_0_31:Number = 2.031;
		public static const V_2_1:Number = 2.1;
		public static const V_2_1_1:Number = 2.11;
		public static const V_2_1_11:Number = 2.111;
		public static const V_3_0:Number = 3.0;
		public static const V_3_01:Number = 3.01;
		public static const V_3_02:Number = 3.02;
		public static const V_3_1:Number = 3.1;
		public static const V_3_101:Number = 3.101;
		public static const V_3_12:Number = 3.12;
		public static const V_3_121:Number = 3.121;
		
		private static const arr:Array = [ V_2_0, V_2_0_2, V_2_0_3, V_2_0_31, V_2_1, V_2_1_1, V_2_1_11, V_3_0, V_3_01, V_3_02, V_3_1, V_3_101, V_3_12, V_3_121 ];
		
		public static function toInt(num:Number):int
		{
			return arr.indexOf(num);
		}
		public static function toNum(numInt:int):Number
		{
			return arr[numInt];
		}
		public static function toString(num:Number):String
		{
			switch(num)
			{
				case V_2_0:
					return "2.0";
				case V_2_0_2:
					return "2.02";
				case V_2_0_3:
					return "2.03";
				case V_2_0_31:
					return "2.031";
				case V_2_1:
					return "2.1";
				case V_2_1_1:
					return "2.1.1";
				case V_2_1_11:
					return "2.1.11";
				case V_3_0:
					return "3.0";
				case V_3_01:
					return "3.01";
				case V_3_02:
					return "3.02";
				case V_3_1:
					return "3.1";
				case V_3_101:
					return "3.1.01";
				case V_3_12:
					return "3.1.2";
				case V_3_121:
					return "3.1.21";
			}
			throw new Error("string not written for this version");
			return null;
		}
	}
}