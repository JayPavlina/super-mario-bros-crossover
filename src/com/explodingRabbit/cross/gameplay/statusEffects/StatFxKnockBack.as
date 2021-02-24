package com.explodingRabbit.cross.gameplay.statusEffects
{
	import com.smbc.enemies.Enemy;
	import com.smbc.ground.Ground;
	import com.smbc.main.AnimatedObject;
	import com.smbc.main.LevObj;
	import com.smbc.projectiles.LinkProjectile;
	
	public class StatFxKnockBack extends StatusEffect
	{
		public static const DIR_UP:String = "up";
		public static const DIR_DOWN:String = "down";
		public static const DIR_LEFT:String = "left";
		public static const DIR_RIGHT:String = "right";
		private var vxStart:Number;
		private var vxNew:Number;
		private var vyStart:Number;
		private var vyNew:Number;
		private var attacker:LevObj;
		private static const SPEED:int = 500;
		private static const DISTANCE:int = 64;
		private var boostEndX:Number;
		private var boostEndY:Number;
		private var boostDirX:int;
		private var boostDirY:int;
		private var dir:String;
		
		
		public function StatFxKnockBack(target:LevObj,attacker:LevObj)
		{
			super(TYPE_KNOCK_BACK, target);
			this.attacker = attacker;
		}
		override public function clone(newTarget:LevObj,attacker:LevObj = null):StatusEffect
		{
			var knockBackFx:StatFxKnockBack = new StatFxKnockBack(newTarget,attacker);
			knockBackFx.setDir(dir);
			return knockBackFx;
		}
		override public function apply():void
		{
			super.apply();
			/*if ( _target.getStatusEffect(TYPE_STOP) )
			{
				destroy();
				return;
			}*/
//			_target.addStatusEffect( new StatFxStop(_target) );
			_target.addReasonOvRd(LevObj.NAME_STOP_UPDATE,true, TYPE_KNOCK_BACK);
//			_target.addReasonOvRd(LevObj.NAME_STOP_TIMERS,true, TYPE_KNOCK_BACK);
			
			if (dir)
			{
				if (dir == DIR_UP)
					boostDirY = -1;
				else if (dir == DIR_DOWN)
					boostDirY = 1;
				else if (dir == DIR_LEFT)
					boostDirX = -1;
				else if (dir == DIR_RIGHT)
					boostDirX = 1;
			}
			else if (attacker.nx > _target.nx)
				boostDirX = -1;
			else
				boostDirX = 1;
			if (boostDirX != 0)
			{
				vxStart = _target.vx;
				vyStart = _target.vy;
				_target.vy = 0;
				vxNew = SPEED*boostDirX;
				_target.vx = vxNew;
				boostEndX = _target.nx + DISTANCE*boostDirX;
			}
			else
			{
				vyStart = _target.vy;
				vxStart = _target.vx;
				_target.vx = 0;
				vyNew = SPEED*boostDirY;
				_target.vy = vyNew;
				boostEndY = _target.ny + DISTANCE*boostDirY;
			}
			trace("boost Dir: "+dir);
		}
		public function setDir(value:String):void
		{
			dir = value;
		}
		
		public function setDirFromSpeed(vx:Number,vy:Number):void
		{
			if (vx > 0)
				setDir(DIR_RIGHT);
			else if (vx < 0)
				setDir(DIR_LEFT);
			else if (vy > 0)
				setDir(DIR_DOWN);
			else if (vy < 0)
				setDir(DIR_UP);
		}
		public function hitWall(g:Ground, side:String):void
		{
//			if ( (damageBoostDir < 0 && side == Ground.HT_LEFT) || ( damageBoostDir > 0 && side == Ground.HT_RIGHT ) )
//				destroy();
		}
		public function hitEnemy(enemy:Enemy, hType:String):void
		{
//			destroy();
		}
		override public function targetUpdate():void
		{
			super.targetUpdate();
			if (boostDirX != 0)
			{
				var xPos:Number = _target.nx;
				if ( (boostDirX > 0 && xPos > boostEndX) || (boostDirX < 0 && xPos < boostEndX) )
				{
					_target.nx = boostEndX;
					destroy();
				}
				else if (_target.vx != vxNew)
					destroy();
			}
			else if (boostDirY != 0)
			{
				var yPos:Number = _target.ny;
				if ( (boostDirY > 0 && yPos > boostEndY) || (boostDirY < 0 && yPos < boostEndY) )
				{
					_target.ny = boostEndY;
					destroy();
				}
				else if (_target.vy != vyNew)
					destroy();
			}
			AnimatedObject(_target).updateLoc();
		}
		
		override public function destroy():void
		{
			super.destroy();
//			var stopFx:StatFxStop = _target.getStatusEffect(
//			_target.removeStatusEffect(TYPE_STOP);
			_target.removeReasonOvRd(LevObj.NAME_STOP_UPDATE,true, TYPE_KNOCK_BACK);
//			_target.removeReasonOvRd(LevObj.NAME_STOP_TIMERS,true, TYPE_KNOCK_BACK);
//			if ( !isNaN(vxStart) )
				_target.vx = vxStart;
//			else if ( !isNaN(vyStart) )
				_target.vy = vyStart;
			if (dir == DIR_UP)
				_target.vy = 0;
		}
	}
}