package com.smbc.enums
{
	import com.explodingRabbit.utils.Enum;
	
	public class MegaManShootType extends Enum
	{
		{ initEnum(MegaManShootType); }
		
		public static const Primary:MegaManShootType = new MegaManShootType();
		public static const Secondary:MegaManShootType = new MegaManShootType();
		
		public function MegaManShootType(niceName:String=null)
		{
			super(niceName);
		}
	}
}