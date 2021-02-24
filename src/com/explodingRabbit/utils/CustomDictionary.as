package com.explodingRabbit.utils
{
	import flash.utils.Dictionary;

	public dynamic class CustomDictionary extends Dictionary
	{
		protected var _length:int;
		protected var useWeakKeys:Boolean;
		public function CustomDictionary(weakKeys:Boolean=false)
		{
			super(weakKeys);
			useWeakKeys = weakKeys;
		}
		public function clear():void
		{
			for (var key:Object in this)
			{
				delete this[key];
				_length--;
			}
		}
		public function addItem(key:Object,value:Object = null):void
		{
			if (key != null && !this[key])
			{
				_length++;
				if (value)
					this[key] = value;
				else
					this[key] = key;
			}
		}
		public function removeItem(key:Object):void
		{
			if (key != null && this[key])
			{
				delete this[key];
				_length--;
			}
		}
		/*public function duplicate():CustomDictionary
		{
			var dct:CustomDictionary = new CustomDictionary(useWeakKeys);
			for (var key:Object in this)
			{
				dct.addItem(key,this[key]);
			}
			return dct;
		}*/
		public function clone(targetDct:CustomDictionary = null):CustomDictionary
		{
			
			if (!targetDct)
				targetDct = new CustomDictionary(useWeakKeys);
			for (var obj:Object in this)
			{
				targetDct.addItem(obj,this[obj]);
			}
			return targetDct;
		}
		public function get length():int
		{
			return _length;
		}
		public function listItems():String
		{
			var str:String = "";
			for (var key:Object in this)
			{
				str += key.toString() + ": "+ this[key].toString();
			}
			return str;
		}
		
		public function containsKey(key:Object):Boolean
		{
			if (key != null)
				return this[key] != undefined;
			return false;
		}
		
		public function containsValue(value:Object):Boolean
		{
			for each (var obj:Object in this)
			{
				if (obj == value)
					return true;
			}
			return false;
		}
		public function toString():String
		{
			var str:String = "";
			if (!length)
				return "empty";
			for each (var obj:Object in this)
			{
				str += obj;
				str += ",";
			}
			return str;
		}
		
		public function fromArray(arr:Array):void
		{
			clear();
			var n:int = arr.length;
			for (var i:int = 0; i < n; i++)
			{
				var obj:Object = arr[i];
				addItem(obj,obj);
			}
		}
	}
}