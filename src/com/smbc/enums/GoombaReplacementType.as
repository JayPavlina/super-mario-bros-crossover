package com.smbc.enums
{
	import com.explodingRabbit.utils.Enum;
	
	public class GoombaReplacementType extends Enum
	{
		{ initEnum(GoombaReplacementType); } // static ctor
		
		public static const Goomba:GoombaReplacementType = new GoombaReplacementType("Off");
		public static const BuzzyBeetle:GoombaReplacementType = new GoombaReplacementType("Buzzy Beetle");
		public static const Spiney:GoombaReplacementType = new GoombaReplacementType();
		public static const SpikeTop:GoombaReplacementType = new GoombaReplacementType("Spike Top");
		
		public function GoombaReplacementType(niceName:String = null)
		{
			super(niceName);
		}
	}
}