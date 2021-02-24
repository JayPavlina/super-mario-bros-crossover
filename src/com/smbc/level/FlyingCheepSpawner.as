package com.smbc.level 
{
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.data.Cheats;
	import com.smbc.data.GameSettings;
	import com.smbc.data.GameStates;
	import com.smbc.data.MapDifficulty;
	import com.smbc.enemies.*;
	import com.smbc.events.CustomEvents;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class FlyingCheepSpawner extends EnemySpawner
	{
		private const MAX_CHEEP_EASY:int = 2;
		private const MAX_CHEEP_NORMAL:int = 3;
		private const MAX_CHEEP_HARD:int = 4;
		private var maxCheep:int = 0;
		private const GS_PLAY:String = GameStates.PLAY;
		private const MIN_SPWN_DEL:int = 150;
		private const MAX_SPWN_DEL:int = 600;
		private const SPWN_DEL_TMR:CustomTimer = new CustomTimer(1,1);
		
		private var canReverseDirectionTimer:CustomTimer;
		private static const CAN_REVERSE_DIRECTION_DELAY:int = 2000;
		
		public function FlyingCheepSpawner(_enemyStartPos:Number,_enemyEndPos:Number) 
		{ 
			super(_enemyStartPos,_enemyEndPos);
			SPWN_DEL_TMR.addEventListener(TimerEvent.TIMER_COMPLETE,spwnDelTmrHandler,false,0,true);
			addTmr(SPWN_DEL_TMR);
			canReverseDirectionTimer = new CustomTimer(CAN_REVERSE_DIRECTION_DELAY);
			canReverseDirectionTimer.start();

			switch(GameSettings.mapDifficulty)
			{
				case MapDifficulty.EASY:
					maxCheep = MAX_CHEEP_EASY;
					break;
				case MapDifficulty.NORMAL:
					maxCheep = MAX_CHEEP_NORMAL;
					break;
				case MapDifficulty.HARD:
					maxCheep = MAX_CHEEP_HARD;
					break;
				default:
					break;
			}
		}
		override public function updateSpawner():void
		{
			if (GS_MNGR.gameState != GS_PLAY)
				return;
			super.updateSpawner();

			if (inSpawnZone && (ENEMY_DCT.length < maxCheep) && !SPWN_DEL_TMR.running)
			{
				SPWN_DEL_TMR.delay = Math.random()*(MAX_SPWN_DEL - MIN_SPWN_DEL) + MAX_SPWN_DEL;
				SPWN_DEL_TMR.start();
			}
			if (player && player.vx > 0)
			{
				canReverseDirectionTimer.reset();
				canReverseDirectionTimer.start();
			}
		}
		private function spwnDelTmrHandler(event:TimerEvent):void
		{
			SPWN_DEL_TMR.reset();
			if (GS_MNGR.gameState != GS_PLAY)
				return;
			if (inSpawnZone && (ENEMY_DCT.length < maxCheep))
			{
				//if (!Cheats.allHammerBros)
					spawnEnemy(new CheepFlying("flying",this));
				/*else
				{
					var en:Enemy = new HammerBro();
					en.vy = -1500;
					spawnEnemy( en );
				}*/
			}
		}
		public function get canReverseDirection():Boolean
		{
//			trace("delay: "+canReverseDirectionTimer.
			if (canReverseDirectionTimer.currentCount > 0)
				return true;
			else
				return false;
		}
		
		public function addHammerBro(hb:HammerBro):void
		{
			ENEMY_DCT.addItem(hb);
			hb.addEventListener(CustomEvents.CLEAN_UP,hammerBroCleanUpHandler,false,0,true);
		}
		private function hammerBroCleanUpHandler(event:Event):void
		{
			var enemy:Enemy = event.target as Enemy;
			enemy.removeEventListener(CustomEvents.CLEAN_UP,hammerBroCleanUpHandler);
			ENEMY_DCT.removeItem(enemy);
		}
		override protected function removeListeners():void
		{
			super.removeListeners();
			SPWN_DEL_TMR.removeEventListener(TimerEvent.TIMER_COMPLETE,spwnDelTmrHandler);
		}
		override protected function reattachLsrs():void
		{
			super.reattachLsrs();
			SPWN_DEL_TMR.addEventListener(TimerEvent.TIMER_COMPLETE,spwnDelTmrHandler,false,0,true);
		}
	
		// Public Methods:
		// Protected Methods:
	}
	
}

