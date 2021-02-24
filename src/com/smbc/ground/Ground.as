package com.smbc.ground
{
	import com.chewtinfoil.utils.StringUtils;
	import com.smbc.characters.*;
	import com.smbc.data.HitTestTypes;
	import com.smbc.enemies.*;
	import com.smbc.level.Level;
	import com.smbc.main.*;
	import com.smbc.managers.GraphicsManager;
	import com.smbc.pickups.*;
	import com.smbc.projectiles.*;
	import com.smbc.sound.*;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.media.*;
	
	public class Ground extends LevObj {

		protected static const GROUND_X_MIN:int = 0;
		protected static var GROUND_Y_MAX:int;
		public static const HT_TOP:String = "top";
		public static const HT_BOTTOM:String = "bottom";
		public static const HT_LEFT:String = "left";
		public static const HT_RIGHT:String = "right";
		public static const HT_NEUTRAL:String = "neutral";
		internal var ao:AnimatedObject;
		public var baseName:String;
		public var xPenType:String;
		public var yPenType:String;
		public var penAmt:Number;
		private var calcCol:Boolean;
		public var marker:String;
		public var disabled:Boolean;
		protected var _animated:Boolean;
		public var afterGround:Boolean;
		public var rowKey:Number;
		public var colKey:Number;
		public var colKey2:Number;
		public var offGrid:Boolean;
		
		public function Ground(stopFrame:String) 
		{
			super();
			if (stopFrame != null)
			{
				var ind:int = stopFrame.indexOf(Level.PROP_SEP);
				if (ind != -1)
					stopFrame = stopFrame.substring(0,ind);
				var indStart:int = 6; // index after word "ground"
				if (stopFrame.indexOf("ground") == -1)
					indStart = 0;
				var n:int = stopFrame.length;
				var indEnd:int = n;
				for (var i:int = indStart; i < n; i++)
				{
					var char:String = stopFrame.charAt(i);
					if (char.toLowerCase() != char && char.toUpperCase() == char)
					{
						if (i == indStart)
							continue;
						indEnd = i;
						break;
					}		
				}
				baseName = stopFrame.substring(0,indEnd);
//				trace("baseName: "+baseName);
				gotoAndStop(stopFrame);
				hitTestTypesDct.addItem(HT_GROUND_NON_BRICK);
				addHitTestableItem(HT_CHARACTER);
				addHitTestableItem(HT_ENEMY);
				addHitTestableItem(HT_PROJECTILE_CHARACTER);
				addHitTestableItem(HT_PICKUP);
			}
		}
		
		override public function initiate():void
		{
			super.initiate();
			setColPoints();
			GROUND_Y_MAX = Level.GLOB_STG_BOT - TILE_SIZE;
		}
		
		override protected function addedToStageHandler(e:Event):void
		{
			level.GROUND_STG_DCT.addItem(this);
			super.addedToStageHandler(e);
		}
		override protected function removedLsr(e:Event):void
		{
			level.GROUND_STG_DCT.removeItem(this);
			super.removedLsr(e);
		}
		public function setColPoints():void
		{
			hTop = this.y; // hits top
			hBot = this.y + TILE_SIZE; // hits bottom
			hLft = this.x; // hits left side
			hRht = this.x + TILE_SIZE; // hits right side
			hMidX = this.x + TILE_SIZE/2;
			hMidY = this.y + TILE_SIZE/2;
		}
		public function pen(_penAmt:Number,_penType:String):void
		{
			if (_penType == "groundAbove" || _penType == "groundBelow")
			{
				yPenAmt = _penAmt;
				yPenType = _penType;
			}
			else if (_penType == "groundOnLeft" || _penType == "groundOnRight")
			{
				xPenAmt = _penAmt;
				xPenType = _penType;
			}
		}
		// HIT
		override public function hit(mc:LevObj,hType:String):void
		{
			if (mc is Projectile)
				hitProj(mc as Projectile);
			else if (hType == "attack")
				hitAttack();
			else if (mc is Character)
				hitCharacter(mc as Character,hType);
			else if (this is Brick && hType == "top" && (mc is Enemy || mc is Pickup))
				standingOnGround(mc as AnimatedObject);
		}
		internal function standingOnGround(ao:AnimatedObject):void
		{
			// for Brick class
		}
		public function hitAttack():void
		{
			// for Brick class
		}
		public function hitProj(proj:Projectile):void
		{
			// blah
		}
		public function hitCharacter(char:Character,hType:String):void
		{
			// blah
		}
		public function updateGround():void
		{
			dt = level.dt;
			// code in Brick class
		}
		override public function cleanUp():void
		{
			super.cleanUp();
			if (level)
			{
				level.GROUND_DCT.removeItem(this);
				level.GROUND_STG_DCT.removeItem(this);
			}
		}
		override public function checkStgPos():void
		{
			if (x >= level.locStgLft - TILE_SIZE*3 && x <= level.locStgRht + TILE_SIZE*2) // shows 3 tiles on both sides
			{
				if (parent != level)
					level.addChild(this);
			}
			else if (parent == level && !updateOffScreen)
				level.removeChild(this);
		}
		public function get animated():Boolean
		{
			return _animated;
		}
	}
}