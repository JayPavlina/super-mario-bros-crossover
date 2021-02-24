package com.smbc.utils
{	
	import com.explodingRabbit.utils.CustomDictionary;
	import com.smbc.graphics.Scenery;
	import com.smbc.ground.Ground;
	import com.smbc.ground.Platform;
	import com.smbc.main.GlobVars;
	
	import flash.display.MovieClip;
	import flash.display.Scene;
	import flash.utils.Dictionary;
	
	public final dynamic class SceneryNestedColumnDictionary extends CustomDictionary
	{
		public const COL_DCTS:CustomDictionary = new CustomDictionary();
		public static const NON_GRID_ITEM_KEY:String = "nonGridItem";
		private static const TILE_SIZE:int = GlobVars.TILE_SIZE;
		
		public function SceneryNestedColumnDictionary(weakKeys:Boolean=false)
		{
			super(weakKeys);
		}
		public function prepLevDcts(numColsLev:int,tileSize:int):void
		{
			var ts:int = tileSize;
			var numCols:int = numColsLev;
			var curPos:int = 0;
			var i:int = 0;
			for (i = 0; i < numCols; i++)
			{
				COL_DCTS.addItem(curPos,new Dictionary(true));
				curPos += ts;
			}
			COL_DCTS[NON_GRID_ITEM_KEY] = new Dictionary(true);
		}
		override public function addItem(key:Object,value:Object = null):void
		{
			if (!this[key])
			{
				_length++;
				this[key] = key;
				if (key is Scenery)
				{
					var scenery:Scenery = key as Scenery;
					var colKey:Number = scenery.x;
					var rowKey:Number = scenery.y;
					var dct:Dictionary = COL_DCTS[colKey];
					var sceneryDct:CustomDictionary;
					if (dct && scenery.width <= TILE_SIZE)
					{
						scenery.colKey = colKey;
						scenery.rowKey = rowKey;
						sceneryDct = dct[rowKey];
						if (sceneryDct == null)
						{
							sceneryDct = new CustomDictionary();
							dct[rowKey] = sceneryDct;
						}
						sceneryDct.addItem(scenery);
					}
					else
					{
						dct = COL_DCTS[NON_GRID_ITEM_KEY];
						if (dct)
						{
							scenery.colKey = colKey;
							dct[scenery] = scenery;
						}
					}
				}
				else throw new Error("adding an object to SCENERY_DCT that is not Scenery");
			}
		}
		override public function removeItem(key:Object):void
		{
			if (this[key])
			{
				delete this[key];
				_length--;
				if (key is Scenery)
				{
					var scenery:Scenery = key as Scenery;
					var dct:Dictionary = COL_DCTS[scenery.colKey];
					var sceneryDct:CustomDictionary;
					if (dct && dct[scenery.rowKey])
					{
						scenery.colKey = NaN;
						sceneryDct = dct[scenery.rowKey];
						if (sceneryDct.length <= 1)
							delete dct[scenery.rowKey];
						else
							sceneryDct.removeItem(scenery);
						scenery.rowKey = NaN;
					}
					else
					{
						dct = COL_DCTS[NON_GRID_ITEM_KEY];
						if (dct && dct[scenery])
						{
							scenery.colKey = NaN;
							delete dct[scenery];
						}
					}
				}
			}
		}
		public function getSceneryAt(_x:Number,_y:Number):CustomDictionary
		{
			var dct:Dictionary = COL_DCTS[_x];
			if (dct)
				return dct[_y];
			else
				return null;
		}
	}
}