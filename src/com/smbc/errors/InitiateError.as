package com.smbc.errors
{
	public class InitiateError extends Error
	{
		public function InitiateError(message:String="An object can only be initiated once.", id:int=0)
		{
			super(message, id);
		}
		
	}
}