package com.smbc.level 
{
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.characters.*;
	import com.smbc.data.GameSettings;
	import com.smbc.data.MapDifficulty;
	import com.smbc.enemies.*;
	import com.smbc.main.*;
	
	import flash.events.TimerEvent;
	
	public class LakituSpawner extends EnemySpawner
	{
		protected var spawnDelTmrDur:int = (40*397) //6000;
		protected var spawnDelTmr:CustomTimer;
		protected var spawnedFirst:Boolean;
		protected var middlePosition:Boolean;
		// Constants:
		// Public Properties:
		// Private Properties:
	
		// Initialization:
		public function LakituSpawner(_enemyStartPos:Number,_enemyEndPos:Number, middlePosition:Boolean) 
		{ 
			super(_enemyStartPos,_enemyEndPos);
			this.middlePosition = middlePosition;
			
			switch(GameSettings.mapDifficulty)
			{
				case MapDifficulty.EASY:
					spawnDelTmrDur = 48 * 397;
					break;
				case MapDifficulty.NORMAL:
					spawnDelTmrDur = 40 * 397;
					break;
				case MapDifficulty.HARD:
					spawnDelTmrDur = 16 * 397;
					break;
				default:
					break;
			}
			
			spawnDelTmr = new CustomTimer(spawnDelTmrDur,1);
			addTmr(spawnDelTmr);
			spawnDelTmr.addEventListener(TimerEvent.TIMER_COMPLETE,spawnDelTmrLsr);
		}
		override public function updateSpawner():void
		{
			super.updateSpawner();
			if (inSpawnZone && ENEMY_DCT.length < 1 && !spawnDelTmr.running)
			{
				if (!spawnedFirst)
					spawnEnemy(new Lakitu(this, middlePosition));
				else spawnDelTmr.start();
			}
		}
		private function spawnDelTmrLsr(e:TimerEvent):void
		{
			spawnDelTmr.reset();
			if (inSpawnZone && ENEMY_DCT.length < 1)
			spawnEnemy(new Lakitu(this, middlePosition));
		}
		override protected function spawnEnemy(enemy:Enemy):void
		{
			super.spawnEnemy(enemy);
			spawnedFirst = true;
		}
		override protected function removeListeners():void
		{
			super.removeListeners();
			if (spawnDelTmr && spawnDelTmr.hasEventListener(TimerEvent.TIMER_COMPLETE)) spawnDelTmr.removeEventListener(TimerEvent.TIMER_COMPLETE,spawnDelTmrLsr);
		}
		override protected function reattachLsrs():void
		{
			super.reattachLsrs();
			if (spawnDelTmr && !spawnDelTmr.hasEventListener(TimerEvent.TIMER_COMPLETE)) spawnDelTmr.addEventListener(TimerEvent.TIMER_COMPLETE,spawnDelTmrLsr);
		}
	}
	
}