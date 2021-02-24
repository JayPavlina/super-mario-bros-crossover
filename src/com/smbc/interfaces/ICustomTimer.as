package com.smbc.interfaces
{
	import flash.events.IEventDispatcher;

	public interface ICustomTimer extends IEventDispatcher
	{
		function start():void
		function stop():void
		function pause():void
		function resume():void
		function get running():Boolean
		function get delay():Number
		function set delay(n:Number):void
	}
}