package com.explodingRabbit.utils
{
	public class ColorUtils
	{
		public static function luminance(color:uint):uint 
		{
			//returns a luminance value between 0 and 255
			var R:int = (color >> 16) & 0xFF;
			var G:int = (color >> 8) & 0xFF;
			var B:int = color & 0x000000FF;
			return ( (0.3*R) + (0.59*G) + (0.11*B) );
		}

	}
}