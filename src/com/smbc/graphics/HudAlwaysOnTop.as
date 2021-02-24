package com.smbc.graphics
{
	import com.smbc.errors.SingletonError;
	
	import flash.display.Sprite;
	
	public class HudAlwaysOnTop extends Sprite
	{
		public static const INSTANCE:HudAlwaysOnTop = new HudAlwaysOnTop();
		public function HudAlwaysOnTop()
		{
			super();
			if (INSTANCE)
				throw new SingletonError();
		}
	}
}