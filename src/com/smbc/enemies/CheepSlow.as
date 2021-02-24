package com.smbc.enemies
{
	import com.smbc.data.EnemyInfo;
	import com.smbc.data.HealthValue;
	import com.smbc.data.ScoreValue;
	import com.smbc.level.FlyingCheepSpawner;
	
	public class CheepSlow extends CheepFast
	{
		public static const ENEMY_NUM:int = EnemyInfo.CheepSlow;
		public function CheepSlow(fLab:String, flyingCheepSpawner:FlyingCheepSpawner=null)
		{
			super(fLab, flyingCheepSpawner);
		}
		
		override protected function overwriteInitialStats():void
		{
			super.overwriteInitialStats();
			_health = HealthValue.CHEEP_SWIMMING;
			scoreAttack = ScoreValue.CHEEP_ATTACK;
			scoreBelow = ScoreValue.CHEEP_BELOW;
			scoreStar = ScoreValue.CHEEP_STAR;
			scoreStomp = ScoreValue.CHEEP_STOMP;
		}
	}
}