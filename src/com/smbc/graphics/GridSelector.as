package com.smbc.graphics
{
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.data.AnimationTimers;
	import com.smbc.level.Level;
	import com.smbc.main.GlobVars;
	import com.smbc.main.SkinObj;
	import com.smbc.managers.GraphicsManager;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	
	public class GridSelector extends SkinObj
	{
		private static const TOP_LEFT_BORDER_POSITION_INTERFACE_SHEET:Point = new Point(178,90);
		private static const BORDER_SPACE_BETWEEN_ITEMS:int = 2;
		private static const SPACE_BETWEEN_FRAMES:int = 6;
		private static const FRAME_COUNT:int = 6;
		private var pixelWidth:Number;
		private var pixelHeight:Number;
		private var animTmr:CustomTimer = new CustomTimer(AnimationTimers.DEL_SLOWEST);
		
		public function GridSelector(pixelWidth:Number, pixelHeight:Number)
		{
			super();
			this.pixelWidth = pixelWidth;
			this.pixelHeight = pixelHeight;
			setNumFrames(FRAME_COUNT);
			setUpFrames();
			scaleX = GlobVars.SCALE;
			scaleY = GlobVars.SCALE;
			stopAnim = false;
//			mainAnimTmr = AnimationTimers.ANIM_SLOWEST_TMR;
			mainAnimTmr = animTmr;
			animTmr.addEventListener(TimerEvent.TIMER,animTmrHandler,false,0,true);
			animTmr.start();
//			ACTIVE_ANIM_TMRS_DCT.addItem(mainAnimTmr);
//			Level.levelInstance.ALWAYS_ANIM_DCT.addItem(this);
		}
		
		private function setUpFrames():void
		{
			var position:Point = TOP_LEFT_BORDER_POSITION_INTERFACE_SHEET.clone();
			var referenceBitmapData:BitmapData = GraphicsManager.INSTANCE.drawingBoardInterfaceSkinCont.bmd;
			var bitmapData:BitmapData = drawBorder(pixelWidth, pixelHeight, position, BORDER_SPACE_BETWEEN_ITEMS, referenceBitmapData);
			
			for (var i:int = 1; i < 4; i++)
				addChildToSingleFrame( new Bitmap(bitmapData), i );
			for (i; i <= totalFrames; i++)
			{
				position.x += SPACE_BETWEEN_FRAMES;
				bitmapData = drawBorder(pixelWidth, pixelHeight, position, BORDER_SPACE_BETWEEN_ITEMS, referenceBitmapData);
				addChildToSingleFrame( new Bitmap(bitmapData), i );
			}
		}
		
		public static function drawBorder(width:Number, height:Number, topLeftPixelLocation:Point, spaceBetweenPixelsOnReferenceSheet:int, referenceBitmapData:BitmapData):BitmapData
		{
			var bitmapData:BitmapData = new BitmapData(width, height, true, 0);
			
			for (var y:int = 0; y < height; y++)
			{
				for (var x:int = 0; x < width; x++)
				{
					var position:Point = topLeftPixelLocation.clone();
					if (x == width - 1)
						position.x += spaceBetweenPixelsOnReferenceSheet*2;
					else if (x != 0)
						position.x += spaceBetweenPixelsOnReferenceSheet;
					if (y == height - 1)
						position.y += spaceBetweenPixelsOnReferenceSheet*2;
					else if (y != 0)
						position.y += spaceBetweenPixelsOnReferenceSheet;
					bitmapData.setPixel32( x, y, referenceBitmapData.getPixel32(position.x, position.y) );
				}
			}
			return bitmapData;
		}
		
		protected function animTmrHandler(event:TimerEvent):void
		{
			animate(animTmr);
			checkFrame();
		}
		
		override public function cleanUp():void
		{
			animTmr.removeEventListener(TimerEvent.TIMER,animTmrHandler);
			super.cleanUp();
		}
	}
}