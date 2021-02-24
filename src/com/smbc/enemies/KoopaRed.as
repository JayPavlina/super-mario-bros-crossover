package com.smbc.enemies
{
	import com.smbc.data.EnemyInfo;

	public class KoopaRed extends KoopaGreen
	{
		public static const ENEMY_NUM:int = EnemyInfo.KoopaRed;
		public function KoopaRed(fLab:String)
		{
			super(fLab);
			red = true;
		}
	}
}