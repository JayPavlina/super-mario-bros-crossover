package com.smbc.enums
{
	import com.explodingRabbit.utils.Enum;
	
	public class SamusWeapon extends Enum
	{
		{ initEnum(SamusWeapon); }
		
		public static const IceBeam:SamusWeapon = new SamusWeapon("Ice Beam");
		public static const WaveBeam:SamusWeapon = new SamusWeapon("Wave Beam");
		
		public function SamusWeapon(niceName:String=null)
		{
			super(niceName);
		}
	}
}