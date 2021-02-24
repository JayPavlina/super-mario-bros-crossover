package com.explodingRabbit.cross.gameplay.statusEffects
{
	import com.explodingRabbit.utils.CustomDictionary;
	import com.smbc.main.LevObj;
	
	import flash.utils.Dictionary;

	public class StatusEffect
	{
		private static const PRE_TYPE:String = "StatFx_";
		public static const TYPE_KNOCK_BACK:String = PRE_TYPE + "knockBack";
		public static const TYPE_INVULNERABLE:String = PRE_TYPE + "invulnerable";
		public static const TYPE_STOP:String = PRE_TYPE + "stop";
		public static const TYPE_FLASH:String = PRE_TYPE + "flash";
		public static const TYPE_FREEZE:String = PRE_TYPE + "freeze";
		public static const TYPE_TRANSPARENT:String = PRE_TYPE + "transparent";
		
		protected var _type:String;
		protected var _target:LevObj;
		private var _destroyed:Boolean; 
		protected var reason:String;
		private var _applied:Boolean;
		
		public function StatusEffect(type:String,target:LevObj)
		{
			this._type = type;
			this._target = target;
//			this.reason = reason;
		}
		public function apply():void
		{
			_applied = true;
		}
		/**
		 *This is called when the target's update function is called 
		 * 
		 */		
		public function targetUpdate():void
		{
			
		}
		public function clone(newTarget:LevObj,attacker:LevObj = null):StatusEffect
		{
			return new StatusEffect(_type,newTarget);
		}

		public function checkIfReplaceWithSameType(effect:StatusEffect):Boolean
		{
			destroy();
			return true;
		}
		public function destroy():void
		{
			_destroyed = true;
			if ( _target.getStatusEffect(_type) )
				_target.removeStatusEffect(_type);
		}
		public function get type():String
		{
			return _type;
		}

		public function get destroyed():Boolean
		{
			return _destroyed;
		}

		public function get applied():Boolean
		{
			return _applied;
		}


	}
}