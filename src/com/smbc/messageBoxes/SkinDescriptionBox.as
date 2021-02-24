package com.smbc.messageBoxes
{
	import com.customClasses.TDCalculator;
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.characters.Bill;
	import com.smbc.data.GameSettings;
	import com.smbc.data.OnlineData;
	import com.smbc.errors.SingletonError;
	import com.smbc.events.CustomEvents;
	import com.smbc.graphics.fontChars.FontCharMenu;
	import com.smbc.level.Level;
	import com.smbc.main.GlobVars;
	import com.smbc.managers.StatManager;
	import com.smbc.text.TextFieldContainer;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextFormatAlign;
	import flash.utils.setInterval;
	
	public class SkinDescriptionBox extends PlainMessageBox
	{
		
		private static const WIDTH:Number = 450,
			HEIGHT:Number = 16,
			Y_POS:Number = 450,
			SCROLL_SPEED:Number = 120;
		private var level:Level;
		private const SCROLL_DELAY_TIMER:CustomTimer = new CustomTimer(2000, 1);
		private const SCROLL_TIMER:CustomTimer = new CustomTimer(1000/60);
		private var textField1:TextFieldContainer = new TextFieldContainer(FontCharMenu.FONT_NUM);
		private var textField2:TextFieldContainer = new TextFieldContainer(FontCharMenu.FONT_NUM);
		private static var instance:NewsTicker;
		private static const TEXT_SEPARATOR:String = "()";
		private var initiated:Boolean;
		private static const SPACE_BETWEEN_TEXT_FIELDS:Number = 120;
		
		private var textToDisplay:Vector.<String> = new Vector.<String>();
		private var textIndex:int = -1;
		private var textLeftPosition:Number = 0;
		private var textRightPosition:Number = WIDTH;
//		private var textMidPosition:Number = textRightPosition/2;
		private var frontTextField:TextFieldContainer;
		private var backTextField:TextFieldContainer;
		private var moveBackTextField:Boolean;
		private var statManager:StatManager;
		private var timeDifferenceCalculator:TDCalculator;
		private var dt:Number = .03;
		private static const DT_MAX:Number = .045;
		
		public function SkinDescriptionBox()
		{
			super("test",WIDTH,HEIGHT,0,TextFormatAlign.LEFT);
			
			nonActive = true;
			nonInteractive = true;
			textField1.text = "temp";
			endYPos = Y_POS;
			statManager = StatManager.STAT_MNGR;
			timeDifferenceCalculator = new TDCalculator();
//			EVENT_MNGR.addEventListener(CustomEvents.CHANGE_INTERFACE_SKIN, changeInterfaceSkinHandler, false, 0, true);
		}
		
		override public function initiate():void
		{
			super.initiate();
			frontTextField = textField1;
			backTextField = textField2;
//			frontTextField.x = textRightPosition;
//			backTextField.x = textRightPosition;
			
			level = Level.levelInstance;
//			level.addEventListener(CustomEvents.GAME_LOOP_END, gameLoopEndHandler, false, 0, true);
			SCROLL_DELAY_TIMER.addEventListener(TimerEvent.TIMER_COMPLETE, scrollDelayTimerHandler, false, 0, true);
			SCROLL_TIMER.addEventListener(TimerEvent.TIMER, scrollTimerHandler, false, 0, true);
			SCROLL_TIMER.start();
		}
		
		protected function scrollDelayTimerHandler(event:TimerEvent):void
		{
			SCROLL_DELAY_TIMER.reset();
		}
		
		public function updateText():void
		{
			var skinDescription:String = statManager.getCurrentBmc(statManager.curCharNum).skinDescription;
			if (GameSettings.classicMode && statManager.curCharNum == Bill.CHAR_NUM)
				skinDescription = null; // hack to hide bill description on classic
			
			if (skinDescription != null)
			{
				frontTextField.text = skinDescription;
				backTextField.text = skinDescription;
				frontTextField.x = textLeftPosition;
				backTextField.x = textRightPosition;
				visible = true;
				SCROLL_DELAY_TIMER.start();
//				SCROLL_TIMER.stop();
				moveBackTextField = false;
			}
			else
				visible = false;
		}
		
		override protected function createGraphics(newWidth:Number = NaN, newHeight:Number = NaN, widthOfs:int = 0, heightOfs:int = 0):void
		{
			super.createGraphics(WIDTH,HEIGHT);
		}
		
		protected function scrollTimerHandler(event:Event):void
		{
			dt = timeDifferenceCalculator.getTD();
			if (dt > DT_MAX)
				dt = DT_MAX;
			if (SCROLL_DELAY_TIMER.running || frontTextField.width < bg.width)
				return;
			frontTextField.x -= SCROLL_SPEED*dt;
			if (frontTextField.x + frontTextField.width < WIDTH - SPACE_BETWEEN_TEXT_FIELDS && !moveBackTextField)
			{
				backTextField.x = textRightPosition;
				moveBackTextField = true;
			}
			else if (frontTextField.x + frontTextField.width < textLeftPosition)
			{
				moveBackTextField = false;
				var lastFrontTextField:TextFieldContainer = frontTextField;
				frontTextField = backTextField;
				backTextField = lastFrontTextField;
				backTextField.x = textRightPosition;
			}
			if (moveBackTextField)
				backTextField.x = frontTextField.x + frontTextField.width + SPACE_BETWEEN_TEXT_FIELDS;
		}
		
		override protected function setUpText():void
		{
			TXT_CONT.addChild(textField1);
			TXT_CONT.x = CONTAINER_PADDING;
			TXT_CONT.y = CONTAINER_PADDING;
			TXT_CONT.addChild(textField2);
		}
		
		override public function cancel():void
		{
			super.cancel();
//			if (level != null)
//				level.removeEventListener(CustomEvents.GAME_LOOP_END, gameLoopEndHandler);
			SCROLL_TIMER.removeEventListener(TimerEvent.TIMER, scrollTimerHandler);
			SCROLL_DELAY_TIMER.removeEventListener(TimerEvent.TIMER_COMPLETE, scrollDelayTimerHandler);
		}
	}
}