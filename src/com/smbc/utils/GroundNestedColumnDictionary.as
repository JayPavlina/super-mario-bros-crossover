package com.smbc.utils
{	
	import com.explodingRabbit.utils.CustomDictionary;
	import com.smbc.ground.Ground;
	import com.smbc.ground.Platform;
	import com.smbc.main.GlobVars;
	
	import flash.utils.Dictionary;
	
	public final dynamic class GroundNestedColumnDictionary extends CustomDictionary
	{
		public const COL_DCTS:CustomDictionary = new CustomDictionary();
		public const PLATFORM_KEY:String = "platformKey";
		public static const NON_GRID_ITEM_KEY:String = "nonGridItem";
		
		public function GroundNestedColumnDictionary(weakKeys:Boolean=false)
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
			COL_DCTS[PLATFORM_KEY] = new Dictionary(true);
			COL_DCTS[NON_GRID_ITEM_KEY] = new Dictionary(true);
		}
		override public function addItem(key:Object,value:Object = null):void
		{
			if (!this[key])
			{
				_length++;
				this[key] = key;
				if (key is Ground)
				{
					var dct:Dictionary;
					var ground:Ground = key as Ground;
					var keyNum:Number = ground.x;
					if (!ground.offGrid)
					{
						dct = COL_DCTS[keyNum];
						if (dct)
						{
							var keyNum2:Number = ground.y;
							ground.colKey = keyNum;
							ground.colKey2 = keyNum2;
							dct[keyNum2] = key;	
						}
					}
					else // ground is Platform
					{
						dct = COL_DCTS[PLATFORM_KEY];
						if (dct)
							dct[ground] = ground;
					}
					//else
					//	trace(Ground(key).name+" could not be added");
					/*{
						dct = COL_DCTS[NON_GRID_ITEM_KEY];
						if (dct)
							dct[key] = key;
					}*/
				}
			}
		}
		override public function removeItem(key:Object):void
		{
			if (this[key])
			{
				delete this[key];
				_length--;
				if (key is Ground)
				{
					var dct:Dictionary;
					var ground:Ground = key as Ground;
					if (!ground.offGrid)
					{
						var keyNum2:Number = ground.colKey2;
						dct = COL_DCTS[ground.colKey];
						if (dct && dct[keyNum2])
						{
							ground.colKey = NaN;
							ground.colKey2 = NaN;
							delete dct[keyNum2];
						}
					}
					else // platform
					{
						dct = COL_DCTS[PLATFORM_KEY];
						if (dct && dct[ground])
						{
							delete dct[ground];
						}
					}
					//else
					//	trace(Ground(key).name+" could not be removed");
					/*else
					{
						dct = COL_DCTS[NON_GRID_ITEM_KEY];
						if (dct && dct[key])
							delete dct[key];
					}*/
					
				}
			}
		}
		// doesn't work on platforms
		public function getGroundAt(_x:Number,_y:Number):Ground
		{
			var dct:Dictionary = COL_DCTS[_x];
			if (dct)
				return dct[_y];
			else
				return null;
		}
	}
}