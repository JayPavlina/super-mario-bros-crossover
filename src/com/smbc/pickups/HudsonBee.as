package com.smbc.pickups
{
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.data.AnimationTimers;
	import com.smbc.data.PickupInfo;

	public class HudsonBee extends Pickup
	{
		private const MAIN_ANIM_TMR:CustomTimer = AnimationTimers.ANIM_MODERATE_TMR;
		
		public static const SCORE_VALUE:int = 8000;
				
		public function HudsonBee()
		{
			super(PickupInfo.HUDSON_BEE);
			mainAnimTmr = MAIN_ANIM_TMR;
			stopAnim = false;
			playsRegularSound = true;
		}
	}
}