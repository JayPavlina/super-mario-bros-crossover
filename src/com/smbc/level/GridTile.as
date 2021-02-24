package com.smbc.level
{
	import com.explodingRabbit.utils.CustomDictionary;
	import com.smbc.ground.Ground;
	import com.smbc.main.GlobVars;
	import com.smbc.main.LevObj;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;

	public class GridTile extends Sprite {
		private static const TILE_SIZE:int = GlobVars.TILE_SIZE;
		private var fill:Shape = new Shape();
		private var level:Level = Level.levelInstance;
		public const ITEMS_DCT:CustomDictionary = new CustomDictionary(true);
		public function GridTile() {
			graphics.lineStyle(2,0x000000);
			graphics.drawRect(0,0,TILE_SIZE,TILE_SIZE);
			fill.graphics.beginFill(0xFFFFFF);
			fill.graphics.drawRect(0,0,TILE_SIZE,TILE_SIZE);
			addChild(fill);
			fill.alpha = .01;
		}
		public function addItem(item:DisplayObject):void
		{
			ITEMS_DCT.addItem(item);
		}
		public function clickTile():void
		{
			for each (var item:DisplayObject in ITEMS_DCT)
			{
				if (item is Ground)
				{
					ITEMS_DCT.removeItem(item);
					level.destroy(item as Ground);
					return;
				}
			}
			item = new Ground("groundBrown");
			item.x = x;
			item.y = y;
			addItem(item);
			level.addToLevel(item as MovieClip);
		}
	}
}