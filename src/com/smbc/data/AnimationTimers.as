package com.smbc.data
{
	import com.explodingRabbit.utils.CustomTimer;
	
	public class AnimationTimers
	{
		public static const DEL_SLOWEST:int = 130;
		public static const DEL_SUPER_SLOWEST:int = 280;
		public static const DEL_VERY_SLOW:int = 115;
		public static const DEL_SLOW:int = 1000/10;
		public static const DEL_MODERATE:int = 75;
		public static const DEL_MIN_FAST:int = 1000/20;
		public static const DEL_FAST:int = 1000/30;
		public static const ANIM_SLOWEST_TMR:CustomTimer = new CustomTimer(DEL_SLOWEST,0,"animSlowestTmr"); // item blocks
		public static const ANIM_SUPER_SLOWEST_TMR:CustomTimer = new CustomTimer(DEL_SUPER_SLOWEST,0,"animSuperSlowestTmr"); // used for grass
		public static const ANIM_VERY_SLOW_TMR:CustomTimer = new CustomTimer(DEL_VERY_SLOW,0,"animVerySlowTmr");
		public static const ANIM_SLOW_TMR:CustomTimer = new CustomTimer(DEL_SLOW,0,"animSlowTmr"); // 100 ms
		public static const ANIM_MODERATE_TMR:CustomTimer = new CustomTimer(DEL_MODERATE,0,"animModerateTmr");
		public static const ANIM_MIN_FAST_TMR:CustomTimer = new CustomTimer(DEL_MIN_FAST,0,"animMinFastTmr"); // 50 ms 20fps
		public static const ANIM_FAST_TMR:CustomTimer = new CustomTimer(DEL_FAST,0,"animFastTmr"); // 30fps 33.33 ms
	}
}