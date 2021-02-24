package com.smbc.messageBoxes
{
	import com.smbc.data.OnlineData;
	import com.smbc.events.CustomEvents;
	import com.smbc.managers.ScreenManager;
	import com.smbc.text.TextFieldContainer;
	
	import flash.events.Event;

	public class SettingsMenuBox extends MenuBox
	{
		protected var alwaysResizeWhenOptionsChanged:Boolean;
		
		public function SettingsMenuBox(arr:Array, selectorStartIndex:int=0, txtContStartY:Number=NaN, centerChoices:Boolean=false, preTxtStr:String=null)
		{
			super(arr, selectorStartIndex, txtContStartY, centerChoices, preTxtStr);
		}
		protected function convertToOnOffStr(value:Boolean):String
		{
			if (value)
				return ON_STR;
			else
				return OFF_STR;
		}
		protected function afterChooseItem(itemName:String, newValueStr:String, itemTfc:TextFieldContainer, disableSnd:Boolean = false):void
		{
			var widthNum:Number = TXT_CONT.width;
			if (newValueStr)
			{
				itemTfc.text = itemName + VALUE_SEP + newValueStr;
				if (TXT_CONT.width > widthNum || alwaysResizeWhenOptionsChanged)
					resizeBox(true,false);
			}
			if (!disableSnd)
			{
				if (itemName != MenuBoxItems.BACK_TO_MAIN_MENU)
					SND_MNGR.playSoundNow(SN_CHOOSE_ITEM);
				else
					SND_MNGR.playSoundNow(SN_CANCEL_ITEM);
			}
			EVENT_MNGR.dispatchEvent(new Event(CustomEvents.MSG_BX_CHOOSE_ITEM + itemName));
		}
		
		protected function tryEnterFullScreen():void
		{
			if ( ScreenManager.SCRN_MNGR.enterFullScreen() )
				nextMsgBxToCreate = new PlainMessageBox(MessageBoxMessages.HOW_TO_CANCEL_FULL_SCREEN);
			else if (!OnlineData.onOfficialWebsite)
				nextMsgBxToCreate = new PlainMessageMenuBox(MessageBoxMessages.FULL_SCREEN_ONLY_AVAILABLE_ON_DEVELOPER_WEBSITE, Vector.<String>([MenuBoxItems.NO, MenuBoxItems.YES]), 1 );
			else
				nextMsgBxToCreate = new PlainMessageBox(MessageBoxMessages.FULL_SCREEN_MODE_NOT_WORKING);
			var next:SettingsMenuBox;
			if (this is NewGameOptionsMenu)
				next = new NewGameOptionsMenu(_cSelNum);
			else
				next = new GeneralOptions(_cSelNum);
			nextMsgBxToCreate.nextMsgBxToCreate = next;
			cancel();
		}
		
		override public function pressAtkBtn():void
		{
			if (nextMsgBxToCreate)
			{
				cancel();
				SND_MNGR.playSoundNow(SN_CANCEL_ITEM);
			}
		}	
	}
}