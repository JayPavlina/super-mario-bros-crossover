package com.smbc.enums
{
	import com.explodingRabbit.utils.Enum;
	
	public class LinkWeapon extends Enum
	{
		{ initEnum(LinkWeapon); }
		
		public static const Bomb:LinkWeapon = new LinkWeapon("Bomb");
		public static const BowAndArrow:LinkWeapon = new LinkWeapon("Bow and Arrow");
		
		public function LinkWeapon(niceName:String=null)
		{
			super(niceName);
		}
	}
}