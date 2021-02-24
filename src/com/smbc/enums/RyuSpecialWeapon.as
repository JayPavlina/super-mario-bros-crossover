package com.smbc.enums
{
	import com.explodingRabbit.utils.Enum;
	
	public class RyuSpecialWeapon extends Enum
	{
		{ initEnum(RyuSpecialWeapon); }
		
		public static const Shuriken:RyuSpecialWeapon = new RyuSpecialWeapon();
		public static const WindmillShuriken:RyuSpecialWeapon = new RyuSpecialWeapon("Windmill Shuriken");
		public static const JumpSlash:RyuSpecialWeapon = new RyuSpecialWeapon("Jump Slash");
		public static const ArtOfFireWheel:RyuSpecialWeapon = new RyuSpecialWeapon("Art of Fire Wheel");
		public static const FireDragonBall:RyuSpecialWeapon = new RyuSpecialWeapon("Fire Dragon Ball");
		
		
		public function RyuSpecialWeapon(niceName:String=null)
		{
			super(niceName);
		}
	}
}