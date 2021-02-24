package com.smbc.enemies
{
	import com.smbc.data.EnemyInfo;
	
//	[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="Piranha")]
	public class PiranhaRed extends PiranhaGreen
	{
		public static const ENEMY_NUM:int = EnemyInfo.PiranhaRed;
		public function PiranhaRed(fLab:String)
		{
			super(fLab);
//			riseWhenNearPlayer = true;
		}
		
		override public function setStats():void
		{
			super.setStats();
			stopRiseLeftX = x - TILE_SIZE*1.4;
			stopRiseRightX = x + TILE_SIZE*1.4;
		}
	}
}