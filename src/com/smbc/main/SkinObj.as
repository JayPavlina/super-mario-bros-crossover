package com.smbc.main
{
	import com.explodingRabbit.display.CustomMovieClip;
	
	import flash.display.Sprite;
	
	public class SkinObj extends CustomMovieClip
	{
//		public const BMD_CONT_VEC:Vector.<BmdSkinCont> = new Vector.<BmdSkinCont>();
//		public static const IND_SKIN_VEC_BMP:int = 0;
//		public static const IND_SKIN_VEC_BMD:int = 1;
//		public static const IND_SKIN_VEC_MASK:int = 2;
//		private static const ZERO_PNT:Point = new Point();
//		private const HEIGHT_ARR:Array = [];
//		private const WIDTH_ARR:Array = [];
//		private var realHeight:Number;
//		private var realWidth:Number;
		public var skin:Sprite;
		public var skinMask:Sprite;
//		protected var needsTrueSize:Boolean = false;
		
		public function SkinObj()
		{
			super();
//			if (!BMD_CONT_VEC.length)
//				prepareSkins();
		}
		/*override protected function prepareSkins():void
		{
			var n:int = numChildren;
			BMD_CONT_VEC.fixed = false;
			BMD_CONT_VEC.length = 0;
			for (var i:int; i < n; i++)
			{
				var child:DisplayObject = getChildAt(i);
				if (child is MovieClip)
				{
					var mc:MovieClip = child as MovieClip;
					if (mc.numChildren && mc.getChildAt(0) is Bitmap)
					{
						var lastPar:DisplayObject = this;
						var par:DisplayObjectContainer = parent;
						while ( !(par is Level) && par != null )
						{
							lastPar = par;
							par = parent.parent;
						}
						var bmp:Bitmap = mc.getChildAt(0) as Bitmap;
						var gm:GraphicsManager = GraphicsManager.INSTANCE;
						var bmd:BmdSkinCont = bmp.bitmapData as BmdSkinCont;
						var maskObj:DisplayObject = getChildAt(i+1);
						if (lastPar is Enemy)
						{
							BMD_CONT_VEC.push( new BmdSkinCont(bmp,BmdSkinCont.TYPE_ENEMY,DisplayObjectContainer(lastPar),maskObj) );
							bmp.bitmapData = gm.masterEnemySkinCont.bmd;
						}
						else if (lastPar is Character)
						{
							BMD_CONT_VEC.push( new BmdSkinCont(bmp,BmdSkinCont.TYPE_CHARACTER,DisplayObjectContainer(lastPar),maskObj) );
						}
						else if (lastPar is Scenery || lastPar is Ground || lastPar is Projectile || lastPar is Pickup)
						{
							BMD_CONT_VEC.push( new BmdSkinCont(bmp,BmdSkinCont.TYPE_MAP,DisplayObjectContainer(lastPar),maskObj) );
							bmp.bitmapData = gm.masterMapSkinCont.bmd;
						}
						else // interface
						{
							BMD_CONT_VEC.push( new BmdSkinCont(bmp,BmdSkinCont.TYPE_INTERFACE,DisplayObjectContainer(lastPar),maskObj) );
							bmp.bitmapData = gm.masterInterfaceSkinCont.bmd;
						}
					}
				}
			}
			if (!BMD_CONT_VEC.length)
				BMD_CONT_VEC[0] = new BmdSkinCont( new Bitmap( new BitmapData(10,10)), 0 );
			BMD_CONT_VEC.fixed = true;
			if (!needsTrueSize)
				return;
			for (i = 0; i < totalFrames; i++)
			{
				gotoAndStop(i+1);
				calcRealValues();
				HEIGHT_ARR[currentFrame] = realHeight;
				WIDTH_ARR[currentFrame] = realWidth;
			}
		}
		override public function gotoAndStop(frame:Object, scene:String=null):void
		{
			var cf:int = currentFrame;
			super.gotoAndStop(frame,scene);
			if (cf != currentFrame)
				calcRealValues();

		}
		protected function calcRealValues():void
		{
			var rectsVec:Vector.<Rectangle> = new Vector.<Rectangle>();
			var n:int = BMD_CONT_VEC.length;
			if (n == 0)
				return;
			for (var i:int; i < n; i++)
			{
				var skinMask:DisplayObject = BMD_CONT_VEC[i].mask;
				var maskRect:Rectangle = skinMask.getBounds(BMD_CONT_VEC[i].bmp);
				//trace("maskRect.width: "+maskRect.width+" maskRect.height: "+maskRect.height);
				var frameBmd:BitmapData = new BitmapData(maskRect.width,maskRect.height,true,0);
				frameBmd.copyPixels(BMD_CONT_VEC[i].bmd,maskRect,ZERO_PNT);
				var visibleRect:Rectangle = frameBmd.getColorBoundsRect(0xFF000000,0,false);
				frameBmd.dispose();
				visibleRect.width *= 2;
				visibleRect.height *= 2;
				visibleRect.x += skinMask.x;
				visibleRect.y += skinMask.y;
				rectsVec.push(visibleRect);
				if (this is Character)
					trace("maskRect: "+skinMask.getBounds(this)+" visRect: "+visibleRect);
				var frameBmp:Bitmap = new Bitmap(frameBmd);
				//addChild(frameBmp);
				frameBmp.scaleX = 2;
				frameBmp.scaleY = 2;
				maskRect = skinMask.getBounds(this);
				frameBmp.x = maskRect.x;
				frameBmp.y = maskRect.y;
			}
				var mainRect:Rectangle = rectsVec[0].clone();
				for each (var rect:Rectangle in rectsVec)
				{
					mainRect.union(rect);
				}
				realHeight = mainRect.height;
				realWidth = mainRect.width;
		}
		override public function get height():Number
		{
			//if ( isNaN(realHeight) )
			//	calcRealValues();
			var num:Number = HEIGHT_ARR[currentFrame];
			if (num)
				return num;
			else
				return super.height;
		}
		override public function get width():Number
		{
			//if ( isNaN(realWidth) )
			//	calcRealValues();
			var num:Number = WIDTH_ARR[currentFrame];
			if (num)
				return num;
			else
				return super.width;
		}
*/	}
}