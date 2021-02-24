package com.smbc.graphics
{
	
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.graphics.BmdSkinCont;
	import com.smbc.main.GlobVars;
	import com.smbc.managers.GraphicsManager;
	
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;

	public class WaterHaze extends Background
	{
		private static const MOVE_TMR_DEL:int = 180;
		private static const NUM_PAUSE_COUNTS:int = 1;
		private static const MOVE_AMT:int = GraphicsManager.BMD_SCALE;
		private static const ST_UP:String = "up";
		private static const ST_DOWN:String = "down";
		private static const ST_WAIT:String = "wait";
		private static const MASK_RECT:Rectangle = new Rectangle(0*MOVE_AMT,40*MOVE_AMT,256*MOVE_AMT,200*MOVE_AMT);
		private var state:String = ST_UP;
		private var moveTmr:CustomTimer;
		private var maxY:Number;
		private var minY:Number;
		private var pauseCtr:int;
		private var movingDown:Boolean;
		public function WaterHaze( graphicClass:Class, scrollSpeed:Number = 1, repeat:Boolean = true, animSpeed:int = 0, shortClassName:String = null)
		{
			super(graphicClass, scrollSpeed, repeat, animSpeed, shortClassName);
//			blendMode = BlendMode.SCREEN;
			var maskSprite:Sprite = new Sprite();
			maskSprite.graphics.beginFill(0xFFFFFF);
			maskSprite.graphics.drawRect(0,0,MASK_RECT.width,MASK_RECT.height);
			maskSprite.graphics.endFill();
			mask = maskSprite;
			mask.x = MASK_RECT.x;
			mask.y = MASK_RECT.y;
			
		}
		protected function moveTmrHandler(event:TimerEvent):void
		{
			if (y >= maxY)
			{
				if (state == ST_DOWN)
				{
					state = ST_WAIT;
					pauseCtr = 0;
				}
				else if (pauseCtr == NUM_PAUSE_COUNTS)
					state = ST_UP;
				else
					pauseCtr++;
			}
			else if (y <= minY)
			{
				if (state == ST_UP)
				{
					state = ST_WAIT;
					pauseCtr = 0;
				}
				else if (pauseCtr == NUM_PAUSE_COUNTS)
					state = ST_DOWN;
				else
					pauseCtr++;
			}
			if (state == ST_DOWN)
				y += MOVE_AMT;
			else if (state == ST_UP)
				y -= MOVE_AMT;
		}
		
		override public function activate():void
		{
			super.activate();
			if (isNaN(maxY))
				maxY = y;
			if (isNaN(minY))
				minY = y - (MOVE_AMT*4);
			if (!moveTmr)
			{
				moveTmr = new CustomTimer(MOVE_TMR_DEL);
				moveTmr.addEventListener(TimerEvent.TIMER,moveTmrHandler,false,0,true);
				moveTmr.start();
			}
		}
		
		
		override public function deactivate():void
		{
			super.deactivate();
			trace("deactivate");
			moveTmr.stop();
			moveTmr.removeEventListener(TimerEvent.TIMER,moveTmrHandler);
			moveTmr = null;
		}
		
		
	}
}