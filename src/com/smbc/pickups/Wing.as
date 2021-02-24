package com.smbc.pickups
{
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.data.AnimationTimers;
	import com.smbc.data.PickupInfo;

	public class Wing extends Pickup
	{
		private const MAIN_ANIM_TMR:CustomTimer = AnimationTimers.ANIM_MODERATE_TMR;
		
		public static const SCORE_VALUE:int = 1000;
		
		public function Wing()
		{
			super(PickupInfo.WING);
			mainAnimTmr = MAIN_ANIM_TMR;
			stopAnim = false;
			playsRegularSound = true;
		}
	}
}