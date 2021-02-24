package com.smbc.graphics 
{
	import com.smbc.main.*;
	import com.smbc.level.Level;
	
	[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="PullyRope")]
	public class PullyRope extends Scenery
	{
		
		// Constants:
		// Public Properties:
		// Private Properties:
		// Initialization:
		public function PullyRope(stopFrame:String):void
		{
			super(stopFrame);
			if (stopFrame.indexOf("Pink") != -1) gotoAndStop("pink");
			else if (stopFrame.indexOf("Gray") != -1) gotoAndStop("gray");
		}
	
		// Public Methods:
		// Protected Methods:
	}
	
}