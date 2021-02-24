package com.smbc.projectiles
{

	import com.customClasses.*;
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.main.AnimatedObject;
	import com.smbc.main.LevObj;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	
	public class Bubble extends Projectile
	{
		
		// Constants:
		// Public Properties:
		protected var riseSpeed:Number = 100;
		// Private Properties:
		// Initialization:
		public function Bubble() 
		{		
			super(null,SOURCE_TYPE_NEUTRAL);
			stopAnim = true;
			vx = 0;
			vy = -riseSpeed;
			x = player.nx;
			y = player.ny - player.height*.75;
			defyGrav = true;
			mainAnimTmr = null;
		}
		override protected function updateStats():void 
		{
			super.updateStats();
			if (ny <= GLOB_STG_TOP + TILE_SIZE*2.4) destroy();
		}
	}
}