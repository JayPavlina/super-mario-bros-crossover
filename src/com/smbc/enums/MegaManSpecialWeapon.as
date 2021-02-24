package com.smbc.enums
{
	import com.explodingRabbit.utils.Enum;
	
	public class MegaManSpecialWeapon extends Enum
	{
		{ initEnum(MegaManSpecialWeapon); }
		
		public static const SuperArm:MegaManSpecialWeapon = new MegaManSpecialWeapon("Super Arm");
		public static const MetalBlade:MegaManSpecialWeapon = new MegaManSpecialWeapon("Metal Blade");
		public static const HardKnuckle:MegaManSpecialWeapon = new MegaManSpecialWeapon("Hard Knuckle");
		public static const PharaohShot:MegaManSpecialWeapon = new MegaManSpecialWeapon("Pharaoh Shot");
		public static const ChargeKick:MegaManSpecialWeapon = new MegaManSpecialWeapon("Charge Kick");
		public static const FlameBlast:MegaManSpecialWeapon = new MegaManSpecialWeapon("Flame Blast");
		public static const MagmaBazooka:MegaManSpecialWeapon = new MegaManSpecialWeapon("Magma Bazooka");
		public static const WaterShield:MegaManSpecialWeapon = new MegaManSpecialWeapon("Water Shield");
		public static const ScrewCrusher:MegaManSpecialWeapon = new MegaManSpecialWeapon("Screw Crusher");
		
		public function MegaManSpecialWeapon(niceName:String=null)
		{
			super(niceName);
		}
	}
}