package com.smbc.graphics
{
	import com.smbc.characters.Link;
	
	import flash.display.MovieClip;

	public class LinkShield extends SubMc
	{
		private var link:Link;
		
		public function LinkShield(link:Link, mc:MovieClip = null)
		{
			super(link);
			this.link = link;
			if (mc)
				createMasterFromMc(mc);
		}
		
		override public function convLab(_fLab:String):String
		{
			return _fLab + "_" + link.shieldLevel.toString();
		}
		
		
	}
}