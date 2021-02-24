package com.smbc.errors
{
	public class SingletonError extends Error
	{
		public function SingletonError(message:String="You can only create one instance of a Singleton.", id:int=0)
		{
			super(message, id);
		}
		
	}
}