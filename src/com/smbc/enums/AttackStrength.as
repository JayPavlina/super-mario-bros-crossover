package com.smbc.enums
{
	import com.explodingRabbit.utils.Enum;
	
	public class AttackStrength extends Enum
	{
		{ initEnum(AttackStrength); } // static ctor
		
		public static const VeryWeak:AttackStrength = new AttackStrength(.66, "Very Weak");
		public static const Weak:AttackStrength = new AttackStrength(.75);
		public static const Normal:AttackStrength = new AttackStrength(1);
		public static const Strong:AttackStrength = new AttackStrength(1.75);
		public static const VeryStrong:AttackStrength = new AttackStrength(3, "Very Strong");
		
		private var _strength:Number;
		
		public function AttackStrength(strength:Number, niceName:String = null)
		{
			super(niceName);
			this._strength = strength;
		}
		
		public function get strength():Number
		{
			return _strength;
		}
	}
}