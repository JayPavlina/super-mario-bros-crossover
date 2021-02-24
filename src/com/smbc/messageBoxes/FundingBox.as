package com.smbc.messageBoxes
{
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.data.OnlineData;
	import com.smbc.errors.SingletonError;
	import com.smbc.events.CustomEvents;
	import com.smbc.graphics.FundingIcon;
	import com.smbc.graphics.fontChars.FontCharMenu;
	import com.smbc.level.Level;
	import com.smbc.main.GlobVars;
	import com.smbc.text.TextFieldContainer;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	public class FundingBox extends PlainMessageBox
	{
		private static var instance:FundingBox;
		
		private static const WIDTH:Number = 282,
			HEIGHT:Number = 16,
			X_POS:Number = 350,
			Y_POS:Number = 452,
			SCROLL_SPEED:Number = 40,
			SPACE_BETWEEN_TEXT_FIELDS:int = 20,
			SPACE_BETWEEN_ICONS:int = 8,
			TEXT_FIELD_POSITION:int = 0,
			PADDING_FROM_EDGE_OF_SCREEN:int = 8,
			ICON_COUNT:int = 10;
		
		private var startTransitionTimer:CustomTimer = new CustomTimer(4000, 1);
		
		private var iconContainer:Sprite;
		
		private var textField1:TextFieldContainer = new TextFieldContainer(FontCharMenu.FONT_NUM);
		private var textField2:TextFieldContainer = new TextFieldContainer(FontCharMenu.FONT_NUM);
		
		private var longestTextField:TextFieldContainer = new TextFieldContainer(FontCharMenu.FONT_NUM); // this determines size of box
		
		private var textToDisplay:Vector.<String> = new Vector.<String>();
		private var textIndex:int = -1;
		
		private var topItemContainer:Sprite; // the text field currently being displayed
		private var bottomItemContainer:Sprite;
		private var level:Level;
		private var initiated:Boolean;
		private var icons:Vector.<FundingIcon>;
		
		public function FundingBox()
		{
			super("");
			if (instance != null)
				throw new SingletonError();
			instance = this;
			instantGrow = true;
			nonActive = true;
			nonInteractive = true;
			endXPos = X_POS;
			endYPos = Y_POS;
			EVENT_MNGR.addEventListener(CustomEvents.CHANGE_INTERFACE_SKIN, changeInterfaceSkinHandler, false, 0, true);
		}
		
		protected function changeInterfaceSkinHandler(event:Event):void
		{
			changeBackgroundColor();
			resizeBox(true, false);
			arrangeIcons();
			x = GlobVars.STAGE_WIDTH - width - PADDING_FROM_EDGE_OF_SCREEN;
			y = GlobVars.STAGE_HEIGHT - height - PADDING_FROM_EDGE_OF_SCREEN;
		}
		
		override public function initiate():void
		{
			super.initiate();
			initiated = true;
			startTransitionTimer.addEventListener(TimerEvent.TIMER_COMPLETE, startTransitionTimerHandler, false, 0, true);
//			startTransitionTimer.start();
			topItemContainer = new Sprite();
			bottomItemContainer = new Sprite();
			TXT_CONT.addChild(topItemContainer);
			TXT_CONT.addChild(bottomItemContainer);
			startTransitionTimerHandler(null);
			bottomItemContainer.y = TEXT_FIELD_POSITION;
			gameLoopEndHandler(null);
			topItemContainer.y = TEXT_FIELD_POSITION;
			changeInterfaceSkinHandler(null);
			addEventListener(MouseEvent.CLICK, mouseClickHandler, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler, false, 0, true);
		}
		
		protected function mouseOverHandler(event:MouseEvent):void
		{
			if (textField1 != null)
				textField1.changeType(FontCharMenu.TYPE_SELECTED);
			if (textField2 != null)
				textField2.changeType(FontCharMenu.TYPE_SELECTED);
			for each(var icon:FundingIcon in icons)
				icon.mouseIn();
		}
		
		protected function mouseOutHandler(event:MouseEvent):void
		{
			if (textField1 != null)
				textField1.changeType(FontCharMenu.TYPE_NORMAL);
			if (textField2 != null)
				textField2.changeType(FontCharMenu.TYPE_NORMAL);
			for each(var icon:FundingIcon in icons)
				icon.mouseOut();
		}
		
		
		protected function mouseClickHandler(event:MouseEvent):void
		{
			navigateToURL(new URLRequest(OnlineData.fundingBoxUrl), PlainMessageMenuBox.BLANK_PAGE);
		}
		
		protected function gameLoopEndHandler(event:Event):void
		{
			if (!startTransitionTimer.running) // currently transitioning
			{
				topItemContainer.y -= SCROLL_SPEED*level.dt;
				bottomItemContainer.y = topItemContainer.y + SPACE_BETWEEN_TEXT_FIELDS;
				if (bottomItemContainer.y <= TEXT_FIELD_POSITION)
				{
					bottomItemContainer.y = TEXT_FIELD_POSITION;
					TXT_CONT.removeChild(topItemContainer);
					topItemContainer.removeChildren();
					swapItemContainers();
					startTransitionTimer.start();
				}
			}
		}
		
		private function swapItemContainers():void
		{
			var lastTopItemContainer:Sprite = topItemContainer;
			topItemContainer = bottomItemContainer;
			bottomItemContainer = lastTopItemContainer;
		}
		
		protected function startTransitionTimerHandler(event:TimerEvent):void
		{
			startTransitionTimer.reset();
			TXT_CONT.addChild(bottomItemContainer);
			var text:String = getNextText();
			if (text == OnlineData.FUNDING_BOX_ICONS_REPLACEMENT_STRING)
				bottomItemContainer.addChild(iconContainer);
			else
			{
				var textFieldContainer:TextFieldContainer = getTextFieldContainerThatIsOffScreen();
				textFieldContainer.text = text;
				bottomItemContainer.addChild(textFieldContainer);
			}
			bottomItemContainer.x = bg.width/2 - bottomItemContainer.width/2;
			bottomItemContainer.y = topItemContainer.y + SPACE_BETWEEN_TEXT_FIELDS;
		}
		
		private function getTextFieldContainerThatIsOffScreen():TextFieldContainer
		{
			if (textField1.parent == null)
				return textField1;
			else
				return textField2;
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
			textToDisplay = OnlineData.fundingBoxText;
			var longestText:String = "";
			
			for (var i:int = 0; i < textToDisplay.length; i++)
			{
				var text:String = textToDisplay[i];
				if (text != OnlineData.FUNDING_BOX_ICONS_REPLACEMENT_STRING && text.length > longestText.length)
					longestText = text;
			}
			longestTextField.text = longestText + "0";
			setUpIcons();
		}
		
		private function setUpIcons():void
		{
			iconContainer = new Sprite();
			icons = new Vector.<FundingIcon>(ICON_COUNT, true);
			var percentFull:Number = 0;
			var currentMoney:int = OnlineData.currentMoney;
			var targetMoney:int = OnlineData.targetMoney;
			if (targetMoney > 0)
				percentFull = currentMoney / targetMoney;
			if (targetMoney <= 0)
				percentFull = 0;
			if (percentFull < 0)
				percentFull = 0;
			else if (percentFull > 1)
				percentFull = 1;
			
			percentFull *= ICON_COUNT;
			for (var i:int = 0; i < ICON_COUNT; i++)
			{
				var label:String = FundingIcon.FL_FULL;
				if (i <= percentFull )
				{
					if (i + 1 <= percentFull)
						label = FundingIcon.FL_FULL;
					else
					{
						if (i + .5 <= percentFull)
							label = FundingIcon.FL_HALF;
						else
							label = FundingIcon.FL_EMPTY;
					}
				}
				else
					label = FundingIcon.FL_EMPTY;
				var icon:FundingIcon = new FundingIcon(label);
				iconContainer.addChild(icon);
				icons[i] = icon;
			}
			arrangeIcons();
		}
		
		private function arrangeIcons():void
		{
			var iconWidth:Number = MessageBox.getVisibleBounds(icons[0]).width;
			for (var i:int = 0; i < ICON_COUNT; i++)
			{
				var icon:FundingIcon = icons[i];
				icon.x = i *(iconWidth + SPACE_BETWEEN_ICONS);
				icon.gotoAndStop(icon.currentFrame);
			}
		}
		
		public static function getInstance():FundingBox
		{
			if (instance == null)
				return new FundingBox();
			return instance;
		}
		
		public function kill():void
		{
			EVENT_MNGR.removeEventListener(CustomEvents.CHANGE_INTERFACE_SKIN, changeInterfaceSkinHandler);
			instance = null;
			destroy();
		}
		
		override protected function createGraphics(newWidth:Number = NaN, newHeight:Number = NaN, widthOfs:int = 0, heightOfs:int = 0):void
		{
			TXT_CONT.addChild(longestTextField);
			super.createGraphics(newWidth, newHeight, widthOfs, heightOfs);
			TXT_CONT.removeChild(longestTextField);
			if (bottomItemContainer != null && bottomItemContainer.parent != null)
				bottomItemContainer.x = bg.width/2 - bottomItemContainer.width/2;
			if (topItemContainer != null &&  topItemContainer.parent != null)
				topItemContainer.x = bg.width/2 - topItemContainer.width/2;
//			iconContainer.x = bg.width/2 - iconContainer.width/2;
//			trace("iconContainer.x: "+iconContainer.x+" txt_width: "+TXT_CONT.width+" iconWidth: "+iconContainer.width);
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
		
		override protected function reachedMaxSize():void
		{
			super.reachedMaxSize();
//			x = 400;
		}
	}
}