package com.smbc.messageBoxes
{
	import com.smbc.graphics.fontChars.FontCharMenu;
	import com.smbc.text.TextFieldContainer;
	
	import flash.text.TextFormatAlign;

	public class CharNameBox extends PlainMessageBox
	{
		private var nameTfc:TextFieldContainer = new TextFieldContainer(FontCharMenu.FONT_NUM);
		private var skinNameTfc:TextFieldContainer = new TextFieldContainer(FontCharMenu.FONT_NUM, FontCharMenu.TYPE_SELECTED);
		private var gameTfc:TextFieldContainer = new TextFieldContainer(FontCharMenu.FONT_NUM, FontCharMenu.TYPE_SELECTED);
		private static const LINE_SPACE:int = 28;
		private var boxyWidth:Number;
		private var boxyHeight:Number;
		public function CharNameBox(messageTemp:String,boxWidth:Number = NaN,boxHeight:Number = NaN,yPos:Number = NaN,align:String = null, instantGrow:Boolean = false)
		{
			super(messageTemp,boxWidth,boxHeight,yPos,align);
			nonActive = true;
			nonInteractive = true;
			this.instantGrow = instantGrow;
			this.boxyWidth = boxWidth;
			this.boxyHeight = boxHeight;
//			trace("boxWidth: "+boxWidth);
//			nameTfc.width = boxWidth;
//			gameTfc.width = boxWidth;
			nameTfc.text = "Mario";
			gameTfc.text = "The Legend of Zelda 2";
			gameTfc.y = LINE_SPACE*2;
			skinNameTfc.y = LINE_SPACE;
			endYPos = yPos;
		}
		override protected function setUpText():void
		{
			TXT_CONT.addChild(nameTfc);
			TXT_CONT.addChild(gameTfc);
			TXT_CONT.addChild(skinNameTfc);
			TXT_CONT.x = CONTAINER_PADDING;
			TXT_CONT.y = CONTAINER_PADDING;
		}
		
		public function changeText(name:String,game:String,skinName:String = null):void
		{
			var halfWidth:Number = bg.width/2;
			nameTfc.text = name;
			gameTfc.text = game;
			nameTfc.x = halfWidth - (nameTfc.width*.5);
			gameTfc.x = halfWidth - (gameTfc.width*.5);
			if (skinName)
			{
				skinNameTfc.text = '"'+skinName+'"';
				skinNameTfc.x = halfWidth - (skinNameTfc.width*.5);
				
				skinNameTfc.y = 0;
				nameTfc.y = LINE_SPACE;				
				gameTfc.y = LINE_SPACE*2;
			}
			else
			{
				nameTfc.y = 0;
				gameTfc.y = LINE_SPACE;
				skinNameTfc.text = "";
			}
			resizeBox(false,true);
			
		}
		
		override public function cancel():void
		{
			endYPos = y + height /2;
			super.cancel();
		}
	}
}