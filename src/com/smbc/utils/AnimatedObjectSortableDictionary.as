package com.smbc.utils
{
	import __AS3__.vec.Vector;
	
	import com.explodingRabbit.utils.CustomDictionary;
	import com.smbc.main.AnimatedObject;

	public final dynamic class AnimatedObjectSortableDictionary extends CustomDictionary
	{
		public const AO_VEC:Vector.<AnimatedObject> = new Vector.<AnimatedObject>();
		public function AnimatedObjectSortableDictionary(weakKeys:Boolean=false)
		{
			super(weakKeys);
		}
		override public function addItem(key:Object,value:Object = null):void
		{
			if (!this[key])
			{
				_length++;
				this[key] = key;
				AO_VEC.push(key);
			}
		}
		override public function removeItem(key:Object):void
		{
			if (this[key])
			{
				delete this[key];
				_length--;
				var ind:int = AO_VEC.indexOf(key);
				if (ind != -1)
					AO_VEC.splice(ind,1);
			}
		}
		
	}
}