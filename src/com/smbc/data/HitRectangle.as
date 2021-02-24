package com.smbc.data
{
	import flash.geom.Rectangle;
	
	public class HitRectangle extends Rectangle
	{
		public static const TYPE_HIT:int = 0;
		public static const TYPE_HIT_SECONDARY:int = 1;
		public static const TYPE_ATTACK:int = 2;
		public var type:int;
		
		public function HitRectangle(hRect:HRect)
		{
			super(hRect.x, hRect.y, hRect.width, hRect.height);
			setType(hRect);
		}
		private function setType(hRect:HRect):void
		{
			if (hRect is ARect)
				type = TYPE_ATTACK;
			else if (hRect is SecondaryHRect)
				type = TYPE_HIT_SECONDARY;
			else
				type = TYPE_HIT;
		}
	}
}