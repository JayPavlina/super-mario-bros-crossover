package com.smbc.data
{

	import com.smbc.characters.Sophia;
	import com.smbc.enemies.*;
	import com.smbc.level.Level;
	import com.smbc.main.*;
	import com.smbc.pickups.*;
	import com.smbc.projectiles.*;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="HRect")]
	public class HRect extends Sprite
	{
		
		// Constants:
		// Public Properties:
		private var level:Level = Level.levelInstance;
		public var hTop:Number;
		public var hBot:Number;
		public var hLft:Number;
		public var hRht:Number;
		public var hMidX:Number;
		public var hMidY:Number;
		public var hWidth:Number;
		public var hHeight:Number;
		public var rect:Rectangle;
		private var cx:Number;
		private var cy:Number;
		private var levObj:LevObj;
		// Private Properties:
		// Initialization:
		public function HRect() 
		{ 
			visible = false;
			//addEventListener(Event.ADDED_TO_STAGE,addedToStageHandler,false,0,true);
		}
		/*private function addedToStageHandler(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,addedToStageHandler);
			levObj = parent as LevObj;
		}*/
		// GETHITPOINTS
		public function getHitPoints(nx:Number,ny:Number,sx:Number):void
		{
			
			cx = parent.x;
			cy = parent.y;
			parent.x = nx;
			parent.y = ny;
			rect = getBounds(LevObj(parent).level);
			var rot:Number = parent.rotation;
			if (rot == 0 || rot == 180)
			{
				rect.height = height;
				rect.width = width;
			}
			else
			{
				rect.height = width;
				rect.width = height;
			}
			parent.x = cx;
			parent.y = cy;
			hTop = rect.top;
			hBot = rect.bottom;
			hLft = rect.left;
			hRht = rect.right;
			hWidth = rect.width;
			hHeight = rect.height;
			hMidX = rect.left + hWidth*.5;
			hMidY = rect.top + hHeight*.5;
		}
	}
}