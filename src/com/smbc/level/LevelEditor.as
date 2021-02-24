package com.smbc.level
{
	import com.smbc.errors.SingletonError;
	import com.smbc.events.CustomEvents;
	import com.smbc.ground.Ground;
	import com.smbc.main.GlobVars;
//	import com.smbcLE.Tile;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	public class LevelEditor
	{
		public static const INSTANCE:LevelEditor = new LevelEditor();
		private static const STG_TOP:int = GlobVars.STAGE_TOP;
		private static const STG_BOT:int = GlobVars.STAGE_HEIGHT;
		private static const STG_LFT:int = GlobVars.STAGE_LEFT;
		private static const STG_RHT:int = GlobVars.STAGE_WIDTH;
		private static const TILE_SIZE:int = GlobVars.TILE_SIZE;
		private const GRID_VEC:Vector.<GridTile> = new Vector.<GridTile>();
		private var level:Level;
		private var grid:Sprite;
		
		public function LevelEditor()
		{
			if (INSTANCE)
				throw new SingletonError();
		}
		public function enterLevelEditorMode():void // called by Level when it starts
		{
			level = Level.levelInstance;
			level.addEventListener(CustomEvents.GAME_LOOP_END,gameLoopEndHandler,false,0,true);
			level.addEventListener(MouseEvent.CLICK,clickHandler,false,0,true);
			drawGrid();
		}
		public function gameLoopEndHandler(event:Event):void
		{
			level.addChild(grid);
			level.setChildIndex(grid,level.numChildren-1);
		}
		private function clickHandler(event:MouseEvent):void
		{
			var point:Point = level.getCurrentGrid(level.mouseX,level.mouseY);
			var tile:GridTile = event.target as GridTile;
			tile.clickTile();
		}
		private function drawGrid():void
		{
			GRID_VEC.length = 0;
			grid = null;
			grid = new Sprite();
			for (var i:int; i < level.numVertTiles; i++)
			{
				var cy:int = i*TILE_SIZE;
				for (var j:int = 0; j < level.numHorzTiles; j++)
				{
					var tile:GridTile = new GridTile();
					var cx:int = j*TILE_SIZE;
					tile.x = cx;
					tile.y = cy;
					grid.addChild(tile);
					GRID_VEC.push(tile);
				}	
			}
			level.addChild(grid);
		}
		public function getTileAt(_x:int,_y:int):GridTile
		{
			_x = level.getNearestGrid(_x,-1);
			_y = level.getNearestGrid(_y,-1);
			trace("x: "+_x+" y: "+_y);
			return GRID_VEC[ (_y/TILE_SIZE)*level.numHorzTiles + _x/TILE_SIZE ];
		}
	}
}