package com.smbc.enums
{
	import com.explodingRabbit.utils.Enum;
	
	public class SophiaWeapon extends Enum
	{
		{ initEnum(SophiaWeapon); }
		
		public static const TripleMissile:SophiaWeapon = new SophiaWeapon("Triple Missile");
		public static const HomingMissile:SophiaWeapon = new SophiaWeapon("Homing Missile");
		
		public function SophiaWeapon(niceName:String=null)
		{
			super(niceName);
		}
	}
}