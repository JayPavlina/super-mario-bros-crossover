package com.smbc.graphics
{
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.data.AnimationTimers;
	import com.smbc.enemies.BulletBill;
	import com.smbc.ground.Canon;
	import com.smbc.main.SimpleAnimatedObject;
	import com.smbc.projectiles.FlyingCoin;
	
	public class CanonSmoke extends SimpleAnimatedObject
	{
		private static const FL_END:String = "end";
		private static const FL_START:String = "start";
		public function CanonSmoke()
		{
			super();
			stopAnim = false;
			accurateAnimTmr = new CustomTimer(AnimationTimers.DEL_SLOWEST);
		}
		public function explode(exploder:Canon,rightSide:Boolean):void
		{
			gotoAndStop(FL_START);
			if (rightSide)
				x = exploder.x + TILE_SIZE*.3 + TILE_SIZE;
			else
				x = exploder.x - TILE_SIZE*.3;
			y = exploder.y + TILE_SIZE/2;
			level.addToLevel(this);
		}
		override public function checkFrame():void
		{
			if (currentLabel == FL_END)
				destroy();
		}
	}
}