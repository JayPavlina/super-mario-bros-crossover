package com.smbc.pickups
{
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.data.AnimationTimers;
	import com.smbc.data.PickupInfo;
	import com.smbc.graphics.BmdInfo;
	import com.smbc.messageBoxes.MapSkinMenu;

	public class Atom extends Pickup
	{
		private const MAIN_ANIM_TMR:CustomTimer = AnimationTimers.ANIM_MODERATE_TMR;
		
		public static const SCORE_VALUE:int = 1000;
		
		public function Atom()
		{
			super(PickupInfo.ATOM);
			mainAnimTmr = MAIN_ANIM_TMR;
			stopAnim = false;
			playsRegularSound = true;
		}
	}
}