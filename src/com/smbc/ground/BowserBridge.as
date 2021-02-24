package com.smbc.ground{	import com.smbc.data.AnimationTimers;		import flash.display.MovieClip;
	public class BowserBridge extends Ground 	{		private static const FL_NORMAL:String = "normal";		private static const FL_BREAK_START:String = "breakStart";//		public static const NUM_PIECES_IN_BRIDGE:int = 13;				public function BowserBridge(_stopFrame:String):void		{			if (_stopFrame != FL_BREAK_START)				inheritedForceShortClassName = "GroundTheme";			super(_stopFrame);			mainAnimTmr = AnimationTimers.ANIM_MIN_FAST_TMR;			gotoAndStop("bowserBridge");			stopAnim = true;			_animated = true;		}/*		public function getBbVecInd():void
		{
			bbVecInd = level.bbVec.indexOf(this);
		}*/						public function startBreak():void
		{			var newBridge:BowserBridge = new BowserBridge(FL_BREAK_START);//			var bbVec:Vector.<BowserBridge> = level.bbVec;//			var ind:int = bbVec.indexOf(this);//			bbVec[0] = newBridge;			newBridge.x = x;			newBridge.y = y;			destroy();						level.addToLevelNow(newBridge);
			newBridge.stopAnim = false;			newBridge.level.ANIM_DCT.addItem(newBridge);			newBridge.gotoAndStop(FL_BREAK_START);
		}				override public function cleanUp():void
		{
			super.cleanUp();			level.ANIM_DCT.removeItem(this);
		}				override public function checkFrame():void
		{
			if (currentFrame == totalFrames)				destroy();
		}		override public function rearm():void		{			super.rearm();			if (level.bbVec)				level.bbVec.push(this);			else			{				level.bbVec = new Vector.<BowserBridge>();				level.bbVec.push(this);			}		}	}}