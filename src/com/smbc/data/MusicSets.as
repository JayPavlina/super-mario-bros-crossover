package com.smbc.data
{
	import com.smbc.characters.Bill;
	import com.smbc.characters.Link;
	import com.smbc.characters.Luigi;
	import com.smbc.characters.Mario;
	import com.smbc.characters.MegaMan;
	import com.smbc.characters.Ryu;
	import com.smbc.characters.Samus;
	import com.smbc.characters.Simon;
	import com.smbc.characters.Sophia;
	import com.smbc.main.GlobalFunctions;
	
	import flash.utils.describeType;

	public final class MusicSets
	{
		public static const SWAP_ORDER_VEC:Vector.<int> = new Vector.<int>();
		public static var ctr:int = -1;
		// will be placed in SWAP_ORDER_VEC in alphabetical order
		public static const CHARACTER:int = (ctr = ctr + 1); // "default"
		public static const MAP:int = (ctr = ctr + 1); // "default"
		public static const RANDOM:int = (ctr = ctr + 1); // "random"
//		public static const BILL:int = (ctr = ctr + 1);
//		public static const LINK:int = (ctr = ctr + 1);
//		public static const LUIGI:int = (ctr = ctr + 1);
//		public static const MARIO:int = (ctr = ctr + 1);
//		public static const MEGA_MAN:int = (ctr = ctr + 1);
//		public static const RYU:int = (ctr = ctr + 1);
//		public static const SAMUS:int = (ctr = ctr + 1);
//		public static const SIMON:int = (ctr = ctr + 1);
//		public static const SOPHIA:int = (ctr = ctr + 1);
//		public static const SMB3_NES:int = (ctr = ctr + 1);
//		public static const SMB3_SNES:int = (ctr = ctr + 1);
		public static const MAX_NORMAL:int = MAP;
		public static const MAX_VALUE:int = ctr;
		
		public static function setUpSwapOrder():void
		{
			var lst:XMLList = describeType(MusicSets)..constant;
			var lstLen:int = lst.length();
			for (var i:int; i < lstLen; i++)
			{
				var nameVal:int = MusicSets[lst[i].@name] as int;
				if (nameVal)
					SWAP_ORDER_VEC.push(nameVal);
			}
			SWAP_ORDER_VEC.sort(GlobalFunctions.sortNums);
		}
		public static function convNumToStr(num:int):String
		{
			switch(num)
			{
				case CHARACTER:
					return "character";
				case MAP:
					return "map";
				case RANDOM:
					return "random";
				/*case BILL:
					return Bill.CHAR_NAME;
				case LINK:
					return Link.CHAR_NAME;
				case LUIGI:
					return Luigi.CHAR_NAME;
				case MARIO:
					return Mario.CHAR_NAME;
				case MEGA_MAN:
					return MegaMan.CHAR_NAME;
				case RYU:
					return Ryu.CHAR_NAME;
				case SAMUS:
					return Samus.CHAR_NAME;
				case SIMON:
					return Simon.CHAR_NAME;
				case SOPHIA:
					return Sophia.CHAR_NAME;*/
				/*case SMB3_NES:
					return "SMB3 NES";
				case SMB3_SNES:
					return "SMB3 SNES";*/
			}
			return null;
		}
	}
}