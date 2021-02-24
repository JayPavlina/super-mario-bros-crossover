package com.smbc.enums
{
	import com.explodingRabbit.utils.Enum;
	
	public class CoinSoundType extends Enum
	{
		{ initEnum(CoinSoundType); } // static ctor
		
		public static const Normal:CoinSoundType = new CoinSoundType();
		public static const Quiet:CoinSoundType = new CoinSoundType();
		public static const Off:CoinSoundType = new CoinSoundType();
		
		public function CoinSoundType(niceName:String = null)
		{
			super(niceName);
		}
	}
}