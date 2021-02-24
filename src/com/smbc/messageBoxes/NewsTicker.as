package com.smbc.messageBoxes
{
	import com.smbc.data.OnlineData;
	import com.smbc.errors.SingletonError;
	import com.smbc.events.CustomEvents;
	import com.smbc.graphics.fontChars.FontCharMenu;
	import com.smbc.level.Level;
	import com.smbc.main.GlobVars;
	import com.smbc.text.TextFieldContainer;
	
	import flash.events.Event;
	import flash.text.TextFormatAlign;
	import flash.utils.setInterval;

	public class NewsTicker extends PlainMessageBox
	{
		
		private static const WIDTH:Number = 450,
			HEIGHT:Number = 18,
			Y_POS:Number = 40,
			SCROLL_SPEED:Number = 75;
		private var level:Level;
		private var textField1:TextFieldContainer = new TextFieldContainer(FontCharMenu.FONT_NUM);
		private var textField2:TextFieldContainer = new TextFieldContainer(FontCharMenu.FONT_NUM);
		private static var instance:NewsTicker;
		private static const TEXT_SEPARATOR:String = "()";
		private var initiated:Boolean;
		private static const SPACE_BETWEEN_TEXT_FIELDS:Number = 10;
		
		private var textToDisplay:Vector.<String> = new Vector.<String>();
		private var textIndex:int = -1;
		private var textLeftPosition:Number = 0;
		private var textRightPosition:Number = WIDTH;
		private var frontTextField:TextFieldContainer;
		private var backTextField:TextFieldContainer;
		private var moveBackTextField:Boolean;
//		private var textAlways:Vector.<String>;
//		private var textNotOfficialWebsite:Vector.<String>;
		
		public function NewsTicker()
		{
			super("test",WIDTH,HEIGHT,Y_POS,TextFormatAlign.LEFT);
			if (instance != null)
				throw new SingletonError();
			instance = this;
			nonActive = true;
			nonInteractive = true;
			textField1.text = "temp";
			textField2.text = "temp";
//			gameTfc.y = LINE_SPACE*2;
//			skinNameTfc.y = LINE_SPACE;
			endYPos = Y_POS;
			EVENT_MNGR.addEventListener(CustomEvents.CHANGE_INTERFACE_SKIN, changeInterfaceSkinHandler, false, 0, true);
		}
		
		override public function initiate():void
		{
			super.initiate();
			initiated = true;
//			var textAlwaysVec:Vector.<String> = OnlineData.tickerAlways;
//			var textNotOfficialWebsiteVec:Vector.<String> = OnlineData.tickerNotOfficialWebsite;
//			var count:int = Math.max(textAlwaysVec.length, textNotOfficialWebsiteVec.length);
//			for (var i:int = 0; i < count; i++)
//			{
//				if (i < textAlwaysVec.length)
//					textToDisplay.push(textAlwaysVec[i]);
//				if (!OnlineData.onOfficialWebsite && i < textNotOfficialWebsiteVec.length)
//					textToDisplay.push(textNotOfficialWebsiteVec[i]);
//			}
			textToDisplay = OnlineData.tickerText;
			textField1.text = getNextText();
			frontTextField = textField1;
			backTextField = textField2;
			frontTextField.x = textRightPosition;
			backTextField.x = textRightPosition;
		}
		
		public function initiateLevelHandler():void
		{
			level = Level.levelInstance;
			level.addEventListener(CustomEvents.GAME_LOOP_END, gameLoopEndHandler, false, 0, true);
			if (!initiated)
				initiate();
			if (parent != null)
				parent.setChildIndex(this, parent.numChildren - 1);
		}
		
		public static function getInstance():NewsTicker
		{
			if (instance == null)
				return new NewsTicker();
			return instance;
		}
		
		protected function changeInterfaceSkinHandler(event:Event):void
		{
			changeBackgroundColor();
			resizeBox();
		}
		
		override protected function createGraphics(newWidth:Number = NaN, newHeight:Number = NaN, widthOfs:int = 0, heightOfs:int = 0):void
		{
			super.createGraphics(WIDTH,HEIGHT);
		}
		
		protected function gameLoopEndHandler(event:Event):void
		{
			frontTextField.x -= SCROLL_SPEED*level.dt;
			if (frontTextField.x + frontTextField.width < textRightPosition && !moveBackTextField)
			{
				backTextField.text = getNextText();
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
		
		private function getNextText():String
		{
			if (textIndex + 1 < textToDisplay.length)
				return textToDisplay[++textIndex];
			else
				return textToDisplay[textIndex = 0];
		}
		
		
		override protected function setUpText():void
		{
			TXT_CONT.addChild(textField1);
			TXT_CONT.x = CONTAINER_PADDING;
			TXT_CONT.y = CONTAINER_PADDING;
			TXT_CONT.addChild(textField2);
		}
		
		public function kill():void
		{
			EVENT_MNGR.removeEventListener(CustomEvents.CHANGE_INTERFACE_SKIN, changeInterfaceSkinHandler);
			instance = null;
			destroy();
		}
		
//		public function changeText(name:String,game:String,skinName:String = null):void
//		{
//			var halfWidth:Number = bg.width/2;
//			nameTfc.text = name;
//			gameTfc.text = game;
//			nameTfc.x = halfWidth - (nameTfc.width*.5);
//			gameTfc.x = halfWidth - (gameTfc.width*.5);
//			if (skinName)
//			{
//				skinNameTfc.text = '"'+skinName+'"';
//				skinNameTfc.x = halfWidth - (skinNameTfc.width*.5);
//				gameTfc.y = LINE_SPACE*2;
//			}
//			else
//			{
//				gameTfc.y = LINE_SPACE;
//				skinNameTfc.text = "";
//			}
//		resizeBox(false,true);
//			
//		}
	}
}