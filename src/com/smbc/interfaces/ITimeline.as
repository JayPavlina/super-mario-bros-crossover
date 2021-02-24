package com.smbc.interfaces
{
	public interface ITimeline
	{
		function get currentFrame():int
		function get currentLabel():String
		function get totalFrames():int
		function gotoAndStop(frame:Object, scene:String = null):void
		function gotoAndPlay(frame:Object, scene:String = null):void
		function play():void
		function stop():void
	}
}