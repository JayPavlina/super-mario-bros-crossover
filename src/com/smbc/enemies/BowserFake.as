package com.smbc.enemies
{
	import com.smbc.level.Level;
	import com.smbc.main.GlobVars;
	import com.smbc.projectiles.BowserFakeFireBall;
	import com.smbc.projectiles.Hammer;

	public class BowserFake extends Bowser
	{
		private static const WALK_DISTANCE:int = GlobVars.TILE_SIZE*5;
		public function BowserFake(frameLabel:String = null)
		{
			super(frameLabel);
			hammerType = Hammer.TYPE_BOWSER_FAKE;
			fireBallClass = BowserFakeFireBall;
		}
		
		override public function setStats():void
		{
			super.setStats();
			setXMinMax();
		}
		
		private function setXMinMax():void
		{
			xMin = nx - WALK_DISTANCE;
			xMax = nx + WALK_DISTANCE;
		}

		override protected function returnToNormalStateFromChase():void
		{
			setXMinMax();
		}
		
		override protected function pastXMax():void
		{
			if (vx > 0 && cState == ST_NORMAL)
				vx = -vx;
		}
	}
}