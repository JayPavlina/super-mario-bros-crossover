package com.smbc.level
{
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.enemies.Barrel;
	import com.smbc.main.GlobVars;
	import com.smbc.utils.GameLoopTimer;
	
	import flash.events.TimerEvent;
	import flash.geom.Point;

	public class BarrelSpawner
	{
		private var level:Level = Level.levelInstance;
		private var position:Point;
		private var timer:CustomTimer = new CustomTimer(2000);
		
		public function BarrelSpawner(position:Point)
		{
			position.y += GlobVars.TILE_SIZE;
			position.x += GlobVars.TILE_SIZE*.5;
			this.position = position;
			timer.addEventListener(TimerEvent.TIMER,timerHandler,false,0,true);
			timer.start();
		}
		
		protected function timerHandler(event:TimerEvent):void
		{
			var barrel:Barrel = new Barrel(""); 
			barrel.x = position.x;
			barrel.y = position.y;
			barrel.nx = barrel.x;
			barrel.ny = barrel.y;
			level.addToLevel(barrel);
		}
	}
}