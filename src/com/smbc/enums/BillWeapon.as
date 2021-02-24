package com.smbc.enums
{
	import com.explodingRabbit.utils.Enum;
	
	public class BillWeapon extends Enum
	{
		{ initEnum(BillWeapon); }
		
		public static const Flare:BillWeapon = new BillWeapon();
		public static const Laser:BillWeapon = new BillWeapon();
		public static const MachineGun:BillWeapon = new BillWeapon("Machine Gun");
		public static const Spread:BillWeapon = new BillWeapon();
		
		public function BillWeapon(niceName:String=null)
		{
			super(niceName);
		}
	}
}