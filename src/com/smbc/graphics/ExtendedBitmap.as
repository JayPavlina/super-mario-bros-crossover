package com.smbc.graphics
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	public class ExtendedBitmap extends Bitmap
	{
		public function ExtendedBitmap(bitmapData:BitmapData=null, pixelSnapping:String="auto", smoothing:Boolean=false)
		{
			super(bitmapData, pixelSnapping, smoothing);
		}
	}
}