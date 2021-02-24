package com.smbc.graphics
{
	import com.smbc.characters.Bill;
	
	import flash.display.MovieClip;

	public class BillTorso extends SubMc
	{
		public const Y_OV_RI_1:String = "walk-3";
		public const Y_OV_RI_2:String = "walk-6";
		public function BillTorso(bill:Bill,mc:MovieClip = null)
		{
			super(bill);
			if (mc)
				createMasterFromMc(mc);
		}
		override public function setStopFrame(stopFrame:String):void
		{
			gotoAndStop(stopFrame);
			stopAnim = true;
		}
		override public function setPlayFrame(stopFrame:String):void
		{
			gotoAndStop(stopFrame);
			stopAnim = false;
		}
		override public function checkFrame():void
		{
			var cl:String = currentLabel;
			if (cl == "walkEnd")
				setPlayFrame("walk-1");
		}
	}
}