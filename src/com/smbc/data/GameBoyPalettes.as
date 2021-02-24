package com.smbc.data
{
	import com.smbc.messageBoxes.MenuBoxItems;


	public class GameBoyPalettes
	{
		public static const VEC:Vector.<String> = Vector.<String>([
			MenuBoxValues.FULL_COLOR,
			MenuBoxValues.CLASSIC,
			MenuBoxValues.BROWN,
			MenuBoxValues.RED,
			MenuBoxValues.DARK_BROWN,
			MenuBoxValues.PASTEL_MIX,
			MenuBoxValues.ORANGE,
			MenuBoxValues.YELLOW,
			MenuBoxValues.BLUE,
			MenuBoxValues.DARK_BLUE,
			MenuBoxValues.GRAY,
			MenuBoxValues.GREEN,
			MenuBoxValues.DARK_GREEN,
			MenuBoxValues.REVERSE,
			MenuBoxValues.RANDOM,
			MenuBoxValues.MAP_PALETTE
		]);
		{ VEC.fixed = true; }
		public static const OBJ:Object = LevelDataTranscoder.makeObjFromVec(VEC,{})
	}
}