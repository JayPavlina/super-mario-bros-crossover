package com.smbc.characters
{
	import com.smbc.characters.base.MegaManBase;
	import com.smbc.data.CharacterInfo;
	import com.smbc.data.PaletteTypes;

	public class ProtoMan extends MegaManBase
	{
		/*public static const CHAR_NAME:String = CharacterInfo.ProtoMan[ CharacterInfo.IND_CHAR_NAME ];
		public static const CHAR_NAME_CAPS:String = CharacterInfo.ProtoMan[ CharacterInfo.IND_CHAR_NAME_CAPS ];
		public static const CHAR_NAME_TEXT:String = CharacterInfo.ProtoMan[ CharacterInfo.IND_CHAR_NAME_MENUS ];
		public static const CHAR_NUM:int = CharacterInfo.ProtoMan[ CharacterInfo.IND_CHAR_NUM ];*/
		public static const PAL_ORDER_ARR:Array = [ PaletteTypes.P_STATE,PaletteTypes.FLASH_POWERING_UP, MegaManBase.PAL_TYPE_CHARGE ];
		public static const WIN_SONG_DUR:int = 5480;
		public static const CHAR_SEL_END_DUR:int = 1700;
		public static const BULLET_Y_PAD_BOT_ON_GROUND:int = 20;
		public static const BULLET_Y_PAD_BOT_OFF_GROUND:int = 31;
		
		public function ProtoMan()
		{
			inheritedForceShortClassName = "MegaMan";
			super();
		}
	}
}