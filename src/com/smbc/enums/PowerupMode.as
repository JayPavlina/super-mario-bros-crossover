package com.smbc.enums
{
	import com.explodingRabbit.utils.Enum;
	
	public class PowerupMode extends Enum
	{
		{ initEnum(PowerupMode); }
		
		public static const Classic:PowerupMode = new PowerupMode("Classic");
		public static const Modern:PowerupMode = new PowerupMode("Modern");
		
		public function PowerupMode(niceName:String = null)
		{
			super(niceName);
		}
	}
}