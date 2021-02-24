package com.smbc.errors
{
	public class IntToBooleanError extends Error
	{
		public function IntToBooleanError(message:*="value must be -1, 0, or 1 for conversion to Boolean type", id:*=0)
		{
			super(message, id);
		}
	}
}