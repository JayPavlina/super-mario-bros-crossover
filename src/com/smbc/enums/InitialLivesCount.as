package com.smbc.enums
{
	import com.explodingRabbit.utils.Enum;
	
	public class InitialLivesCount extends Enum
	{
		{ initEnum(InitialLivesCount); } // static ctor
		
		public static const One:InitialLivesCount = new InitialLivesCount("1");
		public static const Three:InitialLivesCount = new InitialLivesCount("3");
		public static const Five:InitialLivesCount = new InitialLivesCount("5");
		public static const Seven:InitialLivesCount = new InitialLivesCount("7");
		public static const Ten:InitialLivesCount = new InitialLivesCount("10");
		
		public function InitialLivesCount(niceName:String = null)
		{
			super(niceName);
		}
		
		public function get lifeCount():int
		{
			return int(NiceName);
		}
	}
}