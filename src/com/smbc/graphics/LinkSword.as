package com.smbc.graphics
{
	import com.smbc.characters.Link;
	
	import flash.display.MovieClip;
	
	import flashx.textLayout.formats.LineBreak;

	public class LinkSword extends SubMc
	{
		private static const SUFFIX_VEC:Vector.<String> = Vector.<String>(["","",""]);
		
		public function LinkSword(link:Link, mc:MovieClip = null)
		{
			super(link);
			stopAnim = true;
//			if (mc)
//				createMasterFromMc(mc);
			suffixVec = SUFFIX_VEC.concat();
		}
		
		override public function recolorBmps(inPalette:Palette,outPalette:Palette,inColorRow:int = 0,outColorRow:int = 0,defColorsOvrd:Palette = null):void
		{
			// something is recoloring this but I can't figure out what so I'm just cancelling it
		}
		
		
	}
}