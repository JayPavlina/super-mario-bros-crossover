package com.smbc.data
{
	import flash.geom.Rectangle;
	
	[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="SecondaryHRect")]
	public class SecondaryHRect extends HRect
	{
		private var _lhTop:Number;
		private var _lhBot:Number;
		private var _lhLft:Number;
		private var _lhRht:Number;
		public function SecondaryHRect()
		{
			super();
		}
		override public function getHitPoints(nx:Number,ny:Number,sx:Number):void
		{
			_lhTop = hTop;
			_lhBot = hBot;
			_lhLft = hLft;
			_lhRht = hRht;
			super.getHitPoints(nx,ny,sx);
		}
		public function get lhTop():Number
		{
			return _lhTop;
		}
		public function get lhBot():Number
		{
			return _lhBot;
		}
		public function get lhLft():Number
		{
			return _lhLft;
		}
		public function get lhRht():Number
		{
			return _lhRht;
		}
	}
}