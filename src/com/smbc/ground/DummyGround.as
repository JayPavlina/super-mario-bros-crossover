package com.smbc.ground
{
	public class DummyGround extends Ground
	{
		public function DummyGround()
		{
			inheritedForceShortClassName = "Ground";
			super(null);
			alpha = 0;
			stopHit = true;
			stopAnim = true;
			stopUpdate = true;
			removeAllHitTestableItems();
		}
	}
}