package com.smbc.messageBoxes
{
	import com.smbc.graphics.TitleBmp;
	import com.smbc.level.TitleLevel;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class MessageBoxTitleContainer extends PlainMessageBox
	{
		private var contents:TitleBmp;
		private const END_Y:int = 200;
		public static var currentInstance:MessageBoxTitleContainer;
		
		public function MessageBoxTitleContainer()
		{
			currentInstance = this;
			super("");
			endYPos = END_Y;
		}
		override public function initiate():void
		{
			contents = new TitleBmp();
			super.initiate();
			while (scaleX < 1)
			{
				grow();
			}
			TitleLevel.instance.addChild(this);
		}
		override protected function setUpText():void
		{
			TXT_CONT.addChild(contents);
			var dObj:DisplayObject = contents.getChildAt(0);
			contents.x -= dObj.x;
			contents.y -= dObj.y;
			trace("contents: "+contents.getChildAt(0).x +" contents: "+y);
			TXT_CONT.x = CONTAINER_PADDING;
			TXT_CONT.y = CONTAINER_PADDING;
		}
		override public function pressUpBtn():void
		{
			
		}
		override public function pressDwnBtn():void
		{
			
		}
		override public function pressLftBtn():void
		{
			
		}
		override public function pressRhtBtn():void
		{
			
		}
		override public function pressJmpBtn():void
		{
			
		}
		override public function pressAtkBtn():void
		{
			
		}
		override public function pressSpcBtn():void
		{
			
		}
		override public function pressPseBtn():void
		{
			
		}
		override protected function destroy():void
		{
			MSG_BX_MNGR.writeNextMainMenu(this);
			super.destroy();
			TXT_CONT.removeChild(contents);
			contents = null;
			currentInstance = null;
		}
		
	}
}