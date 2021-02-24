package com.explodingRabbit.utils
{
	import com.smbc.data.GameSettings;
	
	import flash.utils.*;
	
	public /*abstract*/ class Enum
	{
		public function get Name()  :String { return _name; }
		public function get Index() :int    { return _index; }
		public function get NiceName():String 
		{
			if (_niceName == null)
				return _name;
			else
				return _niceName;
		}
		
		public /*override*/ function toString() :String { return Name; }
		
		public static function GetConstants(i_type :Class):Vector.<Enum>
		{
			var constants :EnumConstants = _enumDb[getQualifiedClassName(i_type)];
			if (constants == null)
				return null;
			
			// return a copy to prevent caller modifications
			return constants.ByIndex.slice();
		}
		
		public static function GetCount(type:Class):int
		{
			var constants :EnumConstants = _enumDb[getQualifiedClassName(type)];
			if (constants == null)
				return 0;
			return constants.ByIndex.length;
		}
		
		public static function GetNames(type:Class, niceNames:Boolean = false):Vector.<String>
		{
			var constants :EnumConstants = _enumDb[getQualifiedClassName(type)];
			if (constants == null)
				return null;
			var namesVec:Vector.<String> = new Vector.<String>();
			for each(var enum:Enum in constants.ByIndex)
			{
				if (niceNames)
					namesVec.push(enum._niceName);
				else
					namesVec.push(enum._name);
			}
			return namesVec;
		}
		
		public function GetAtIndex(newIndex:int, loop:Boolean = false):Enum
		{
			var length:int = _enums.length;
			if (newIndex >= 0)
			{
				if (newIndex >= length)
					throw new Error("Index out of range.");
				return _enums[newIndex] as Enum;
			}
			if (newIndex == GameSettings.DECREASE_SETTING_NUM)
			{
				newIndex = _index - 1;
				if (newIndex < 0)
					newIndex = length - 1;
			}
			else if (newIndex == GameSettings.INCREASE_SETTING_NUM)
			{
				newIndex = _index + 1;
				if (newIndex >= length)
					newIndex = 0;
			}
			return _enums[newIndex] as Enum;
			
		}
		
		public static function ParseConstant(
			i_type			:Class,
			i_constantName  :String,
			i_caseSensitive :Boolean = false) :Enum
		{
			var constants :EnumConstants = _enumDb[getQualifiedClassName(i_type)];
			if (constants == null)
				return null;
			
			var constant :Enum = constants.ByName[i_constantName.toLowerCase()];
			if (i_caseSensitive && (constant != null) && (i_constantName != constant.Name))
				return null;
			
			return constant;
		}
		
		/*-----------------------------------------------------------------*/
		
		/*protected*/ function Enum(niceName:String = null)
		{
			var typeName :String = getQualifiedClassName(this);
			
			// discourage people new'ing up constants on their own instead
			// of using the class constants
			if (_enumDb[typeName] != null)
			{
				throw new Error(
					"Enum constants can only be constructed as static consts " +
					"in their own enum class " + "(bad type='" + typeName + "')");
			}
			
			// if opening up a new type, alloc an array for its constants
			var constants :Array = _pendingDb[typeName];
			if (constants == null)
				_pendingDb[typeName] = constants = [];
			
			// record
			_index = constants.length;
			_enums = constants;
			this._niceName = niceName;
			constants.push(this);
		}
		
		protected static function initEnum(i_type :Class) :void
		{
			var typeName :String = getQualifiedClassName(i_type);
			
			// can't call initEnum twice on same type (likely copy-paste bug)
			if (_enumDb[typeName] != null)
			{
				throw new Error(
					"Can't initialize enum twice (type='" + typeName + "')");
			}
			
			// no constant is technically ok, but it's probably a copy-paste bug
			var constants :Array = _pendingDb[typeName];
			if (constants == null)
			{
				throw new Error(
					"Can't have an enum without any constants (type='" +
					typeName + "')");
			}
			
			// process constants
			var type :XML = flash.utils.describeType(i_type);
			for each (var constant :XML in type.constant)
			{
				// this will fail to coerce if the type isn't inherited from Enum
				var enumConstant :Enum = i_type[constant.@name];
				
				// if the types don't match then probably have a copy-paste error.
				// this is really common so it's good to catch it here.
				var enumConstantType :* = Object(enumConstant).constructor;
				if (enumConstantType != i_type)
				{
					throw new Error(
						"Constant type '" + enumConstantType + "' " +
						"does not match its enum class '" + i_type + "'");
				}
				
				enumConstant._name = constant.@name;
			}
			
			// now seal it
			_pendingDb[typeName] = null;
			_enumDb[typeName] = new EnumConstants( Vector.<Enum>(constants) );
		}
		
		private var _name :String = null;
		private var _niceName:String = null;
		private var _index :int = -1;
		private var _enums:Array;
		
		private static var _pendingDb :Object = {};	// typename -> [constants]
		private static var _enumDb	  :Object = {};	// typename -> EnumConstants
	}
}
import com.explodingRabbit.utils.Enum;

// private support class
class EnumConstants
{
	public function EnumConstants(i_byIndex :Vector.<Enum>)
	{
		ByIndex = i_byIndex;
		
		for (var i :int = 0; i < ByIndex.length; ++i)
		{
			var enumConstant :Enum = ByIndex[i];
			ByName[enumConstant.Name.toLowerCase()] = enumConstant;
		}
	}
	
	public var ByIndex :Vector.<Enum>;
	public var ByName :Object = {};
}
