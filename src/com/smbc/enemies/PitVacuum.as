package com.smbc.enemies
{

	import com.smbc.characters.*;
	import com.smbc.characters.base.MarioBase;
	import com.smbc.level.Level;
	import com.smbc.main.*;
	
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="PitVacuum")]
	public class PitVacuum extends Enemy
	{
		public var dir:String;
		private var horzPullPwr:int = 400;
		private var vertPullPwr:int = 600;
		public function PitVacuum() 
		{
			super();
			removeAllHitTestableItems();
		}
		public function setVacDir(_dir:String):void
		{
			dir = _dir;
		}
		// SETSTATS sets statistics and initializes character
		override public function setStats():void
		{
			//numColors = 0;
			//stompable = false;
			defyGrav = true;
			stopHit = true;
			stopAnim = true;
			vx = 0;
			vy = 0;
			super.setStats();
			
		}
		override protected function updateStats():void 
		{
			super.updateStats();
			player.setHitPoints();
			setHitPoints();
			if (player is MarioBase && player.hRht >= hLft && player.hLft <= hRht) pull();
		}
		private function pull():void
		{
			if (dir == "down-left" && !player.pulledLeft)
			{
				player.vx -= horzPullPwr*dt;
				player.pulledLeft = true;
			}
			else if (dir == "down-right" && !player.pulledRight)
			{
				player.vx += horzPullPwr*dt;
				player.pulledRight = true;
			}
			if (!player.pulledDown)
			{
				player.vy += vertPullPwr*dt;
				player.pulledDown = true;
			}
		}
	}
}