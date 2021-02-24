package com.smbc.graphics
{
	import com.adobe.protocols.dict.Dict;
	import com.caurina.transitions.properties.CurveModifiers;
	import com.explodingRabbit.display.CustomMovieClip;
	import com.explodingRabbit.utils.CustomDictionary;
	import com.smbc.main.GlobVars;
	import com.smbc.utils.GameLoopTimer;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;

	public class WaterShiftingBg extends Background
	{
		private static const Y_OFS:int = 7;
		private static const Y_VALUES_SET:Array = [ 241 + Y_OFS, 242 + Y_OFS, 243 + Y_OFS, 244 + Y_OFS, 245 + Y_OFS ];
		private static const SPACE_BTW_SETS:int = 15;
		private static const NUM_VALUES_PER_SET:int = 5;
		private static const MOVE_TMR_DEL:int = 85;
		private var moveTmr:GameLoopTimer;
		private var IND_BMD:int = 0;
		private var IND_OFS:int = 1;
		private var IND_INCREASING:int = 2;
		private var IND_RECT:int = 3;
		private var arr:Array;
		private static var masterBmd:BitmapData;
		private static const Y_MIN:int = 105 + Y_OFS;
		private static const Y_MAX:int = 240 + Y_OFS;
		private static const SHIFT_VAL_MIN:int = 0;
		private static const SHIFT_VAL_MAX:int = 5;
		private static const ZERO_PNT:Point = new Point();
		private var yValsDct:Dictionary;
		private var yCtr:int = Y_MAX/SPACE_BTW_SETS;
		private static const Y_CTR_DEF:int = Y_MAX/SPACE_BTW_SETS;
		public function WaterShiftingBg(graphicClass:Class, scrollSpeed:Number=1, repeat:Boolean=true, animSpeed:int=0, shortClassName:String=null)
		{
			super(graphicClass, scrollSpeed, repeat, animSpeed, shortClassName);
		}
		
		override public function activate():void
		{
			super.activate();
			if (!arr)
			{
				arr = [];
				var n:int = GlobVars.STAGE_HEIGHT/2;
				var srcBmd:BitmapData = Bitmap(getChildAt(0)).bitmapData.clone();
				masterBmd = new BitmapData(width + SHIFT_VAL_MAX,srcBmd.height,true,0);
				var rect:Rectangle = srcBmd.rect;
				var width:int = rect.width;
				rect.height = 1;
				var zeroPnt5:Point = new Point(SHIFT_VAL_MAX,0);
				var smallRect:Rectangle = new Rectangle(width - SHIFT_VAL_MAX,0,SHIFT_VAL_MAX,1);
				for (var i:int = Y_MIN; i <= Y_MAX; i++) 
				{
					var bmd:BitmapData = new BitmapData(width + SHIFT_VAL_MAX,1,true,0);
					rect.y = i;
					smallRect.y = i;
					bmd.copyPixels(srcBmd,rect,zeroPnt5);
					bmd.copyPixels(srcBmd,smallRect,ZERO_PNT);
					masterBmd.copyPixels(bmd,bmd.rect,rect.topLeft);
					var containerArr:Array = [];
					arr[i] = containerArr;
					containerArr[IND_BMD] = bmd;
					containerArr[IND_INCREASING] = true;
					rect.x = 0;
					rect.width += SHIFT_VAL_MAX;
					containerArr[IND_RECT] = rect.clone();
				}
			}
			else // already activated
			{
				for (i = Y_MIN; i <= Y_MAX; i++) 
				{
					moveTmrHandler(null);
				}
			}
//			yValsDct = null;
//			yCtr = Y_CTR_DEF;
			if (!yValsDct)
			{
				yValsDct = new Dictionary();
				var ctr:int = (Y_MAX - Y_OFS)/SPACE_BTW_SETS;
				for (i = Y_MAX; i >= Y_MIN; i--)
				{
					if (i == SPACE_BTW_SETS*ctr + Y_OFS && i != Y_MIN)
					{
						addNextSet();
						ctr--;
					}
					moveTmrHandler(null);
				}
			}
			if (!moveTmr)
			{
				moveTmr = new GameLoopTimer(MOVE_TMR_DEL);
				moveTmr.addEventListener(TimerEvent.TIMER,moveTmrHandler,false,0,true);
				moveTmr.start();
			}
		}		
		
		override public function deactivate():void
		{
			super.deactivate();
			moveTmr.stop();
			moveTmr.removeEventListener(TimerEvent.TIMER,moveTmrHandler);
			moveTmr = null;
		}
		protected function moveTmrHandler(event:Event):void
		{
			var newYValuesDct:Dictionary = new Dictionary();
			for each (var yPos:int in yValsDct) 
			{
				if (yPos <= Y_MAX)
				{
					var n:int = numChildren;
					for (var i:int = 0; i < n; i++) 
					{
						var targetBmd:BitmapData = Bitmap(getChildAt(0)).bitmapData;
						var curArr:Array = arr[yPos];
						var srcBmd:BitmapData = curArr[IND_BMD];
						ZERO_PNT.x = getShiftValue(curArr) - SHIFT_VAL_MAX;
						ZERO_PNT.y = yPos;
						targetBmd.fillRect( curArr[IND_RECT], 0 );
						targetBmd.copyPixels( srcBmd,srcBmd.rect,ZERO_PNT );
					}
				}
				delete yValsDct[yPos];
				yPos = getNextY(yPos);
				newYValuesDct[yPos] = yPos;
			}
			yValsDct = null;
			yValsDct = newYValuesDct;
//			if (yValsDct[217])
//				addNextSet();
		}
		private function getNextY(curY:int):int
		{
			/*if (!yValsDct[Y_MAX] && curY == SPACE_BTW_SETS*yCtr && yCtr > Y_MIN/SPACE_BTW_SETS)
				addNextSet();*/
			curY--;
			if (curY < Y_MIN)
				curY = Y_MAX;
			return curY;
		}
		private function addNextSet():void
		{
			yCtr--;
			for each (var num:int in Y_VALUES_SET)
			{
				if (yValsDct[num])
					return;
			}
			for each (num in Y_VALUES_SET)
			{
				yValsDct[num] = num;
			}
		}
		private function getShiftValue(arr:Array):int
		{
			var curOfs:int = arr[IND_OFS];
			var curIncreasing:Boolean = arr[IND_INCREASING];
			if (curOfs == SHIFT_VAL_MAX)
			{
				curOfs--;
				arr[IND_INCREASING] = false;
			}
			else if (curOfs == SHIFT_VAL_MIN)
			{
				curOfs++;
				arr[IND_INCREASING] = true;
			}
			else
			{
				if (curIncreasing)
					curOfs++;
				else
					curOfs--;
			}
			arr[IND_OFS] = curOfs;
			return curOfs;
		}
	}
}