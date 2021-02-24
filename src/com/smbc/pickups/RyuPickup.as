package com.smbc.pickups
{
	public class RyuPickup extends Pickup
	{
		public function RyuPickup(type:String=null)
		{
			super(type);
		}
		
		override public function initiate():void
		{
			super.initiate();
			if (!inBox)
			{
				defyGrav = false;
				addAllGroundToHitTestables();
				level.checkCollisions(this);
				traceHitItems();
			}
		}
	}
}