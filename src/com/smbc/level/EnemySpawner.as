package com.smbc.level 
{
	import com.explodingRabbit.utils.CustomDictionary;
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.characters.*;
	import com.smbc.enemies.*;
	import com.smbc.main.*;
	
	import flash.events.TimerEvent;
	
	public class EnemySpawner extends LevObj
	{
		
		// Constants:
		protected var _enemyStartPos:Number;
		protected var _enemyEndPos:Number;
		protected var inSpawnZone:Boolean;
		public const ENEMY_DCT:CustomDictionary = new CustomDictionary(true);
		protected var _active:Boolean = true;
		// Public Properties:
		// Private Properties:
	
		// Initialization:
		public function EnemySpawner(enemyStartPosTmp:Number,enemyEndPosTmp:Number) 
		{ 
			_enemyStartPos = enemyStartPosTmp;
			_enemyEndPos = enemyEndPosTmp;
		}
		public function updateSpawner():void
		{
			dt = level.dt;
			if (player.nx > _enemyStartPos && player.nx < _enemyEndPos)
				inSpawnZone = true;
			else 
				inSpawnZone = false;
		}
		protected function spawnEnemy(enemy:Enemy):void
		{
			level.addToLevel(enemy);
			ENEMY_DCT.addItem(enemy);
		}
		override public function disarm():void
		{
			super.disarm();
			_active = false;
		}
		override public function rearm():void
		{
			super.rearm();
			_active = true;
		}
		public function get active():Boolean
		{
			return _active;
		}
		public function get enemyEndPos():Number
		{
			return _enemyEndPos;
		}
		public function get enemyStartPos():Number
		{
			return _enemyStartPos;
		}
	}
	
}