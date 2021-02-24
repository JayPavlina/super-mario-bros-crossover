package com.smbc.characters
{
	public class WhiteMage extends WarriorOfLight
	{
		private static const COPY_PIXELS_Y_OFS:int = 47*6;
		
		public function WhiteMage()
		{
			copyPixelsYOfs = COPY_PIXELS_Y_OFS;
			super();
		}
	}
}