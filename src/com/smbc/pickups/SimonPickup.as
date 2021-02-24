package com.smbc.pickups
{
	import com.smbc.characters.Character;
	import com.smbc.data.PickupInfo;
	import com.smbc.data.SoundNames;
	import com.smbc.ground.Ground;
	
	import neoart.flectrum.Inward;

	public class SimonPickup extends Pickup
	{
		private static const SMALL_HEART_FALL_SPEED:int = 100;
		public static const TYPE_SIMON_HEART_SMALL:String = PickupInfo.SIMON_HEART_SMALL;
		private var centerX:Number;
		private static const WAVE_RANGE:int = 30;
		private static const WAVE_SPEED:int = 5;
		private var waveAngle:Number = 0;
		private var heartStopWaving:Boolean;
		
		public function SimonPickup(type:String)
		{
			super(type);
		}
		
		override public function initiate():void
		{
			super.initiate();
			if (!inBox)
				defyGrav = false;
			addAllGroundToHitTestables();
//			if (type == PickupInfo.SIMON_HEART_SMALL)
//				smallHeartFall();
		}
//		private function smallHeartFall():void
//		{
//			centerX = x;
//			vyMaxPsv = SMALL_HEART_FALL_SPEED;
//			vy = vyMaxPsv;
//		}
		
//		override public function hitGround(mc:Ground, hType:String):void
//		{
//			super.hitGround(mc, hType);
//			heartStopWaving = true;
//		}
//		
//		override public function groundOnSide(g:Ground, side:String):void
//		{
//			if (side == Ground.HT_RIGHT)
//				nx += 8;
//			else
//				nx -= 8;
//		}
		
//		override protected function updateStats():void
//		{
//			super.updateStats();
//			if (type == TYPE_SIMON_HEART_SMALL)
//			{
//				if (!heartStopWaving && !onGround && !wallOnLeft && !wallOnRight && !stuckInWall)
//				{
//					nx = centerX + Math.sin(waveAngle) * WAVE_RANGE;
//					waveAngle += WAVE_SPEED*dt;
//				}
//				if (onGround && stuckInWall)
//				{
////					if (lhLft >= 
//					if (wallOnLeft)
//						nx += 8;
//					else if (wallOnRight)
//						nx -= 8;
//					onGround = false;
//				}
//			}
//		}
		
	}
}