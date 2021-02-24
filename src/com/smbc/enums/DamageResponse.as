package com.smbc.enums
{
	import com.explodingRabbit.utils.Enum;
	
	public class DamageResponse extends Enum
	{
		{ initEnum(DamageResponse); } // static ctor
		
		public static const LoseSomeUpgrades:DamageResponse = new DamageResponse("Lose Some Upgrades");
		public static const LoseAllUpgrades:DamageResponse = new DamageResponse("Lose All Upgrades");
		public static const KeepUpgrades:DamageResponse = new DamageResponse("Keep Most Upgrades");
		public static const InstantDeath:DamageResponse = new DamageResponse("Instant Death");
		
		public function DamageResponse(niceName:String = null)
		{
			super(niceName);
		}
	}
}