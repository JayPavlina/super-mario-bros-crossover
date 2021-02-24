package com.smbc.utils
{	
	import com.explodingRabbit.utils.CustomDictionary;
	import com.smbc.ground.Ground;

	public final dynamic class GroundSortableDictionary extends CustomDictionary
	{
		public const GROUND_VEC:Vector.<Ground> = new Vector.<Ground>();
		public function GroundSortableDictionary(weakKeys:Boolean=false)
		{
			super(weakKeys);
		}
		override public function addItem(key:Object,value:Object = null):void
		{
			if (!this[key])
			{
				_length++;
				this[key] = key;
				GROUND_VEC.push(key);
			}
		}
		override public function removeItem(key:Object):void
		{
			if (this[key])
			{
				delete this[key];
				_length--;
				var ind:int = GROUND_VEC.indexOf(key);
				if (ind != -1)
					GROUND_VEC.splice(ind,1);
			}
		}
		
	}
}