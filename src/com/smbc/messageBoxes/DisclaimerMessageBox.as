package com.smbc.messageBoxes
{
	import com.smbc.SuperMarioBrosCrossover;
	import com.smbc.data.GameSettings;
	import com.smbc.level.TitleLevel;
	import com.smbc.managers.ScreenManager;
	import com.smbc.managers.SoundManager;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import flashx.textLayout.events.UpdateCompleteEvent;

	public class DisclaimerMessageBox extends PlainMessageBox
	{
		private static const TIME_ON_SCREEN:int = 4000;
		private const DUR_TMR:Timer = new Timer(TIME_ON_SCREEN,1);
		private var reachedMaxSizeTime:int;
		public static var instance:DisclaimerMessageBox; 
		
		public function DisclaimerMessageBox()
		{
			super(MessageBoxMessages.DISCLAIMER);
			nonInteractive = true;
			instance = this;
		}
		override protected function reachedMaxSize():void
		{
			super.reachedMaxSize();
			_interactive = false;
			GAME.stage.addEventListener(Event.RENDER, renderHandler, false, 0, true);
			GAME.stage.invalidate();
			reachedMaxSizeTime = getTimer();
		}
		public function allowCancel():void
		{
			var timePassed:int = getTimer() - reachedMaxSizeTime; 
			if (timePassed >= TIME_ON_SCREEN)
				cancel();
			else
			{
				DUR_TMR.addEventListener(TimerEvent.TIMER_COMPLETE,durTmrHandler,false,0,true);
				DUR_TMR.delay = TIME_ON_SCREEN - timePassed;
				DUR_TMR.start();
			}
		}
		protected function renderHandler(event:Event):void
		{
			GAME.stage.removeEventListener(Event.RENDER, renderHandler);
			GAME.stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler, false, 0, true);
		}
		
		protected function enterFrameHandler(event:Event):void
		{
			GAME.stage.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			SoundManager.SND_MNGR.recordSoundsPhase2();
		}
		private function durTmrHandler(event:TimerEvent):void
		{
			DUR_TMR.stop();
			DUR_TMR.removeEventListener(TimerEvent.TIMER_COMPLETE,durTmrHandler);
			cancel();
		}
		
		override protected function destroy():void
		{
			super.destroy();
			instance = null;
			DUR_TMR.removeEventListener(TimerEvent.TIMER_COMPLETE,durTmrHandler);
//			var tl:TitleLevel = new TitleLevel();
//			SuperMarioBrosCrossover.game.addChild(tl);
			GameSettings.setTitleMapSkin();
			ScreenManager.SCRN_MNGR.restartGame();
		}
		
		
	}
}