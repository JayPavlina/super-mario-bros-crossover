package com.smbc.enums
{
	import com.explodingRabbit.utils.Enum;
	
	public class RyuSimonThrowType extends Enum
	{
		{ initEnum(RyuSimonThrowType); }
		
		public static const Default:RyuSimonThrowType = new RyuSimonThrowType();
		public static const Extra:RyuSimonThrowType = new RyuSimonThrowType();
		
		public function RyuSimonThrowType(niceName:String=null)
		{
			super(niceName);
		}
	}
}