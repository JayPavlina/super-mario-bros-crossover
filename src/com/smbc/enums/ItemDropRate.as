package com.smbc.enums
{
	import com.explodingRabbit.utils.Enum;
	
	public class ItemDropRate extends Enum
	{
		{ initEnum(ItemDropRate); } // static ctor
		
		public static const VeryLow:ItemDropRate = new ItemDropRate(-.05, "Very Low");
		public static const Low:ItemDropRate = new ItemDropRate(-.025, "Low");
		public static const Normal:ItemDropRate = new ItemDropRate(0, "Normal");
		public static const High:ItemDropRate = new ItemDropRate(.075, "High");
		public static const VeryHigh:ItemDropRate = new ItemDropRate(.15, "Very High");
		
		private var _dropRateOffset:Number;
		
		public function ItemDropRate(dropRateOffset:Number, niceName:String = null)
		{
			super(niceName);
			this._dropRateOffset = dropRateOffset;
		}
		
		public function get dropRateOffset():Number
		{
			return _dropRateOffset;
		}
	}
}