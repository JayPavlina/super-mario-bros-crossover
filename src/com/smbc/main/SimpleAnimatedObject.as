package com.smbc.main
{
	public class SimpleAnimatedObject extends LevObj
	{
		public function SimpleAnimatedObject()
		{
			super();
			stopAnim = false;
			stopUpdate = true;
			destroyOffScreen = true;
		}
		override public function destroy():void
		{
			super.destroy();
			if (level)
			{
				level.ANIM_DCT.removeItem(this);
				level.UPDATE_DCT.removeItem(this);
			}
		}
	}
}