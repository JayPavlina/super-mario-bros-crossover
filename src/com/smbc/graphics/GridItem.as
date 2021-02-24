package com.smbc.graphics
{
	import com.explodingRabbit.display.CustomMovieClip;
	import com.smbc.main.GlobVars;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;

	public class GridItem extends Sprite
	{
		private var _borderImage:Bitmap;
//		private var _image:Bitmap;
		private var _image:CustomMovieClip;
		public var row:int;
		public var column:int;
		public var skinNum:int;
		private var borderContainer:Sprite;
		public var recoloredSprite:Sprite;
		
		public function GridItem()
		{

		}
		
		public function set borderImage(value:Bitmap):void
		{
			_borderImage = value;
			
			borderContainer = new Sprite();
			addChildAt(borderContainer, 0);
			borderContainer.addChild(_borderImage);
			borderContainer.scaleX = GlobVars.SCALE;
			borderContainer.scaleY = GlobVars.SCALE;
//			borderContainer.x -= GlobVars.SCALE;
//			borderContainer.y -= GlobVars.SCALE;
		}
		
//		public function get image():Bitmap
//		{
//			return _image;
//		}
		
		public function get image():CustomMovieClip
		{
			return _image;
		}
		
		public function getBmpSprite():Sprite
		{
			recoloredSprite = new Sprite();
			addChildAt(recoloredSprite,1);
			recoloredSprite.addChild(_image);
			return recoloredSprite;
		}
		
//		public function set image(value:Bitmap):void
//		{
//			_image = value;
//			addChild(_image);
//		}
		
		public function set image(value:CustomMovieClip):void
		{
			_image = value;
			addChild(_image);
			_image.x = GlobVars.SCALE;
			_image.y = GlobVars.SCALE;
		}
	}
}