package com.smbc.enums
{
	import com.explodingRabbit.utils.Enum;
	
	public class ScrollingIndicatorDirection extends Enum
	{
		{ initEnum(ScrollingIndicatorDirection); }
		
		public static const Down:ScrollingIndicatorDirection = new ScrollingIndicatorDirection();
		public static const Up:ScrollingIndicatorDirection = new ScrollingIndicatorDirection();
	}
}