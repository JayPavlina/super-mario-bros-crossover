package com.smbc.enemies
{
	import com.smbc.data.HealthValue;
	import com.smbc.data.ScoreValue;
	import com.smbc.events.CustomEvents;
	import com.smbc.ground.Brick;
	import com.smbc.ground.Ground;
	import com.smbc.main.GlobVars;
	import com.smbc.main.LevObj;
	
	import flash.events.Event;
	
	public class Icicle extends Enemy
	{
		private static const GRAVITY:int = 400;
		private var defaultGravity:Number;
		private static const DETECTION_ZONE_OFFSET:Number = -GlobVars.TILE_SIZE*3;
		private var fallStartX:Number;
		private var brickAttachedTo:Brick;
		
		public function Icicle(itemText:String)
		{
			super();
			removeAllHitTestableItems();
			addHitTestableItem(HT_CHARACTER);
			addHitTestableItem(HT_PROJECTILE_CHARACTER);
		}
		
		override protected function overwriteInitialStats():void
		{
			super.overwriteInitialStats();
			_health = HealthValue.ICICLE;
			scoreAttack = ScoreValue.GOOMBA_ATTACK;
			scoreBelow = ScoreValue.GOOMBA_BELOW;
			scoreStar = ScoreValue.GOOMBA_STAR;
			scoreStomp = ScoreValue.GOOMBA_STOMP;
		}
		
		override public function setStats():void
		{
			super.setStats();
			defaultGravity = gravity;
			gravity = GRAVITY;
			defyGrav = true;
			fallStartX = nx + DETECTION_ZONE_OFFSET;
			var groundAbove:Ground = level.getGroundAt( Math.round(x - TILE_SIZE/2), y - TILE_SIZE*2);
			if (groundAbove is Brick)
			{
				brickAttachedTo = groundAbove as Brick;
				brickAttachedTo.addEventListener(CustomEvents.BRICK_BREAK, brickBreakHandler, false, 0, true);
				brickAttachedTo.addEventListener(CustomEvents.BRICK_BOUNCE, brickBounceHandler, false, 0, true);
			}
		}
		
		protected function brickBreakHandler(event:Event):void
		{
			defyGrav = false;
		}
		
		protected function brickBounceHandler(event:Event):void
		{
			defyGrav = false;
		}
		
		override protected function activateBouncyPit():void
		{
			// doesn't do anything
		}
		
		override protected function reattachLsrs():void
		{
			super.reattachLsrs();
			if (defyGrav && brickAttachedTo != null)
			{
				brickAttachedTo.addEventListener(CustomEvents.BRICK_BREAK, brickBreakHandler, false, 0, true);
				brickAttachedTo.addEventListener(CustomEvents.BRICK_BOUNCE, brickBounceHandler, false, 0, true);
			}
		}
		
		override protected function removeListeners():void
		{
			super.removeListeners();
			if (brickAttachedTo != null)
			{
				brickAttachedTo.removeEventListener(CustomEvents.BRICK_BREAK, brickBreakHandler);
				brickAttachedTo.removeEventListener(CustomEvents.BRICK_BOUNCE, brickBounceHandler);
			}
		}
		
		override protected function updateStats():void 
		{
			super.updateStats();
			if (player.nx > fallStartX)
			{
				if (brickAttachedTo != null)
				{
					brickAttachedTo.removeEventListener(CustomEvents.BRICK_BREAK, brickBreakHandler);
					brickAttachedTo.removeEventListener(CustomEvents.BRICK_BOUNCE, brickBounceHandler);
				}
				defyGrav = false;
			}
		}
		
		override public function die(dmgSrc:LevObj = null):void
		{
			gravity = defaultGravity;
			super.die(dmgSrc);
		}
	}
}