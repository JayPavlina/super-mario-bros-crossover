package com.explodingRabbit.cross.gameplay.statusEffects
{
	import com.explodingRabbit.utils.CustomDictionary;
	import com.smbc.main.LevObj;

	public class StatusProperty
	{
		private static const AGG_TYPE:String = "Agg_";
		private static const PAS_TYPE:String = "Pas_";
		private static const TYPE_DCT:CustomDictionary = new CustomDictionary();
		
		// DON'T FORGET TO ADD TO PROP ORDER VEC, MAKE SURE STOP DOESN'T STOP IT
		public static const TYPE_FLASH_AGG:String = addType( AGG_TYPE + "flash" );
		public static const TYPE_FREEZE_AGG:String = addType( AGG_TYPE + "freeze" );
		public static const TYPE_UNFREEZE_AGG:String = addType( AGG_TYPE + "unfreeze" );
		public static const TYPE_INVULNERABLE_AGG:String = addType( AGG_TYPE + "invulnerable" );
		public static const TYPE_STOP_AGG:String = addType( AGG_TYPE + "stop" );
		public static const TYPE_KNOCK_BACK_AGG:String = addType( AGG_TYPE + "knockBack" );
		public static const TYPE_PIERCE_AGG:String = addType( AGG_TYPE + "pierce" );
		public static const TYPE_PASS_THROUGH_DEFEAT_AGG:String = addType( AGG_TYPE + "passThroughDefeat" );
		public static const TYPE_PASS_THROUGH_ALWAYS_AGG:String = addType( AGG_TYPE + "passThroughAlways" );
		public static const TYPE_TRANSPARENT_AGG:String = addType( AGG_TYPE + "transparent" );
		public static const TYPE_DAMAGES_PLAYER_AGG:String = addType( AGG_TYPE + "damagesPlayer" );
		public static const TYPE_STOP_ALL_ENEMIES_ACTIVE_AGG:String = addType( AGG_TYPE + "stopAllEnemiesActive" );
		public static const TYPE_INSTANT_KILL_AGG:String = addType( AGG_TYPE + "instantKill" );
		
		public static const TYPE_FREEZE_PAS:String = addType( PAS_TYPE + "freeze" );
		public static const TYPE_PIERCE_PAS:String = addType( PAS_TYPE + "pierce" );
		public static const TYPE_STOP_PAS:String = addType( PAS_TYPE + "stop" );
		public static const TYPE_KNOCK_BACK_PAS:String = addType( PAS_TYPE + "knockBack" );
		public static const TYPE_INSTANT_KILL_PAS:String = addType( PAS_TYPE + "instantKill" );
		
		public static const TYPE_STOMPABLE_PAS:String = addType( PAS_TYPE + "stompable" );
		public static const TYPE_SUPER_ARM_GRABBABLE_PAS:String = addType( PAS_TYPE + "superArmGrabbable" );
		public static const TYPE_PULLABLE_PAS:String = addType( PAS_TYPE + "pullable" );
//		public static const TYPE_CANCEL_KNOCK_BACK:String = addType( "cancelKnockBack" );
		
		// below is for status effects
		public static const PROP_ORDER:Vector.<String> = Vector.<String>([ TYPE_PIERCE_AGG, 
			TYPE_STOP_AGG, TYPE_KNOCK_BACK_AGG, TYPE_INVULNERABLE_AGG, TYPE_TRANSPARENT_AGG, TYPE_FLASH_AGG
		]);
		
		public static function getOpposingType(type:String):String
		{
			// start overrides
			if (type == TYPE_STOP_ALL_ENEMIES_ACTIVE_AGG)
				return TYPE_STOP_PAS;
			// end overrides
			var passive:Boolean = getPassiveFromType(type);
			var testStr:String = getPassiveStringFromBoolean(!passive) + getMainType(type);
			var foundStr:String = TYPE_DCT[testStr];
			if (foundStr)
				return foundStr;
			return null;
		}
		private static function addType(type:String):String
		{
			TYPE_DCT.addItem(type);
			return type;
		}
		
		private static function getMainType(type:String):String
		{
			if (!hasPassiveString(type))
				throw new Error("doesn't have passive string");
			return type.substr(PAS_TYPE.length);
		}
		public static function getPassiveFromType(type:String):Boolean
		{
			if (!hasPassiveString(type))
				throw new Error("doesn't have passive string");
			if (type.substr(0,PAS_TYPE.length) == PAS_TYPE)
				return true;
			return false;
		}
		private static function addPassiveToMainType(type:String,passive:Boolean):String
		{
			if (hasPassiveString(type))
				throw new Error("already has passive string");
			return getPassiveStringFromBoolean(passive) + type;
		}
		private static function getPassiveStringFromBoolean(passive:Boolean):String
		{
			if (passive)
				return PAS_TYPE;
			return AGG_TYPE;
		}
		private static function hasPassiveString(type:String):Boolean
		{
			var suffix:String = type.substr(0,PAS_TYPE.length);
			if (suffix == PAS_TYPE || suffix == AGG_TYPE)
				return true;
			return false;
		}
		
		private var _type:String;
		private var _strength:int;
		private var _passive:Boolean;
		private var _value:*;
		
		public function StatusProperty(type:String,strength:int = 0,value:* = undefined)
		{
			this._type = type;
			this._strength = strength;
			this._value = value;
			_passive = getPassiveFromType(type);
		}
		public function getStatusEffectFromValue(target:LevObj,attacker:LevObj):StatusEffect
		{
			if ( !(value is StatusEffect) )
				return null;
			return StatusEffect(value).clone(target,attacker);
		}

		public function get type():String
		{
			return _type;
		}
		
		public function get strength():int
		{
			return _strength;
		}
		
		public function get value():*
		{
			return _value;
		}

		public function get passive():Boolean
		{
			return _passive;
		}

	}
}