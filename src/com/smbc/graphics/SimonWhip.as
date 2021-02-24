package com.smbc.graphics
{
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.characters.Character;
	import com.smbc.characters.Simon;
	import com.smbc.data.AnimationTimers;
	import com.smbc.data.PaletteTypes;
	import com.smbc.utils.GameLoopTimer;
	
	import flash.display.MovieClip;
	import flash.events.Event;

	public class SimonWhip extends SubMc
	{
		private static const SUFFIX_VEC:Vector.<String> = Vector.<String>(["_0","_1","_2"]);
		private static const PAL_ORDER_ARR:Array = [ PaletteTypes.FLASH_GENERAL ];
		private var simon:Simon;
		
		public function SimonWhip(simon:Simon,mc:MovieClip = null)
		{
			super(simon);
			this.simon = simon;
			if (mc)
				createMasterFromMc(mc);
			suffixVec = SUFFIX_VEC.concat();
			palOrderArr = PAL_ORDER_ARR.concat();
			flashTmr = new GameLoopTimer(AnimationTimers.DEL_FAST);
		}
		override public function flash(incCtr:Boolean = true):void
		{
			if (!parent || simon.whipLevel != 3)
				return;
			super.flash(incCtr);
		}
		
		override public function convLab(_fLab:String):String
		{
			return _fLab + "_" + simon.whipLevel.toString();
		}
		
		override public function gotoAndStop(frame:Object, scene:String=null):void
		{
			if (parChar.replaceColor)
				resetColor();
			super.cmcGotoAndStop(frame, scene);
		}
		
		/*override public function setStopFrame(stopFrame:String):void
		{
			super.setStopFrame(stopFrame);
			trace("stopFrame: "+convLab(stopFrame));
		}*/
	}
}