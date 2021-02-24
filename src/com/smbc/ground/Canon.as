package com.smbc.ground
{
	import com.explodingRabbit.utils.CustomDictionary;
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.characters.*;
	import com.smbc.data.Cheats;
	import com.smbc.data.GameStates;
	import com.smbc.data.SoundNames;
	import com.smbc.enemies.*;
	import com.smbc.events.CustomEvents;
	import com.smbc.graphics.CanonSmoke;
	import com.smbc.level.Level;
	import com.smbc.projectiles.*;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.media.*;

	public class Canon extends Ground
	{
		public static const BILL_DCT:CustomDictionary = new CustomDictionary();
		protected var shootTmr:CustomTimer;
		private const SHOOT_TMR_DUR_MIN:int = 1000;
		private const SHOOT_TMR_DUR_MAX:int = 3500;
		private const MAX_BULLET_BILLS:int = 2;
		private const GS_PLAY:String = GameStates.PLAY;
		private const STOP_SHOOT_DIST:int = Level.levelInstance.TILE_SIZE*2;
		private var stopShootLft:Number;
		private var stopShootRht:Number;
		private var readyToShoot:Boolean;
		
		public function Canon() 
		{
			super("nothing");
		}
		override public function initiate():void
		{
			super.initiate();
			setColPoints();
			stopShootLft = hMidX - STOP_SHOOT_DIST;
			stopShootRht = hMidX + STOP_SHOOT_DIST;
			var del:int = int(Math.random()*(SHOOT_TMR_DUR_MAX- SHOOT_TMR_DUR_MIN) + SHOOT_TMR_DUR_MIN);
			shootTmr = new CustomTimer(del,1);
			addTmr(shootTmr);
			shootTmr.addEventListener(TimerEvent.TIMER_COMPLETE,shootTmrLsr);
			shootTmr.start();
		}
		private function shootTmrLsr(e:TimerEvent):void
		{
			var smoke:CanonSmoke;
			shootTmr.reset();
			if (BILL_DCT.length < MAX_BULLET_BILLS && GS_MNGR.gameState == GS_PLAY && (player.nx < stopShootLft || player.nx > stopShootRht) )
			{
				var billRht:Boolean = false;
				var xPos:int = 0;
				if (player.nx >= hMidX)
					billRht = true;
				if (Cheats.allHammerBros)
				{
					var hb:HammerBro = new HammerBro(null,true);
					level.addToLevelNow(hb);
					if (billRht)
					{
						hb.x = x + TILE_SIZE + hb.hWidth/2;
						hb.vx = BulletBill.SPEED;
						hb.scaleX = 1;
					}
					else
					{
						hb.x = x - hb.hWidth/2;
						hb.vx = -BulletBill.SPEED;
						hb.scaleX = -1;
					}
					hb.y = y + TILE_SIZE - 2;
					hb.vy = 0;
					hb.destroyOffScreen = true;
					hb.addEventListener(CustomEvents.CLEAN_UP,enemyCleanUpHandler,false,0,true);
					smoke = new CanonSmoke();
					smoke.explode(this,billRht);
					BILL_DCT.addItem(hb);
					SND_MNGR.playSound(SoundNames.SFX_GAME_CANON);
				}
				else
				{
					var bullBill:BulletBill = new BulletBill(x + TILE_SIZE/2,y + TILE_SIZE,billRht,this);
					level.addToLevel(bullBill);
					smoke = new CanonSmoke();
					smoke.explode(this,billRht);
					BILL_DCT.addItem(bullBill);
				}
			}
			shootTmr.delay = int(Math.random()*(SHOOT_TMR_DUR_MAX- SHOOT_TMR_DUR_MIN) + SHOOT_TMR_DUR_MIN);
			shootTmr.start();
		}
		private function enemyCleanUpHandler(event:Event):void
		{
			var enemy:Enemy = event.target as Enemy;
			enemy.removeEventListener(CustomEvents.CLEAN_UP,enemyCleanUpHandler);
			BILL_DCT.removeItem(enemy);
		}
		override protected function removeListeners():void
		{
			super.removeListeners();
			if (shootTmr && shootTmr.hasEventListener(TimerEvent.TIMER_COMPLETE)) shootTmr.removeEventListener(TimerEvent.TIMER_COMPLETE,shootTmrLsr);
		}
		override protected function reattachLsrs():void
		{
			super.reattachLsrs();
			if (shootTmr && !shootTmr.hasEventListener(TimerEvent.TIMER_COMPLETE)) shootTmr.addEventListener(TimerEvent.TIMER_COMPLETE,shootTmrLsr);
		}
	}
}