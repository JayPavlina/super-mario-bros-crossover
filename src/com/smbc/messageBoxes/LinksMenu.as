package com.smbc.messageBoxes
{
	import com.smbc.data.OnlineData;
	import com.smbc.events.CustomEvents;
	import com.smbc.text.TextFieldContainer;
	
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	public class LinksMenu extends MenuBox
	{
		private var strVec:Vector.<String> = new Vector.<String>();
		private const NORMAL_IND:int = 2;
		public static const YOUTUBE_URL:String = "http://www.youtube.com/TheExplodingRabbit";
		public static const TWITTER_URL:String = "http://www.twitter.com/ExplodingRabbit";
		public static const FACEBOOK_URL:String = "http://www.facebook.com/ExplodingRabbit";
		public static const GOOGLE_PLUS_URL:String = "https://plus.google.com/+explodingrabbit/";
		private static const LINKS_SEP:String = "()";

		private var links:Vector.<String>;
		private var names:Array;
		
		public function LinksMenu()
		{
			super( loadItems(), 0, NaN, false, "Each item will open in \\n a new browser window." );
			strVec = null;
			numItemsThatFitOnScreen = 7;
		}
		private function loadItems():Array
		{
			if (names == null)
				initiateData();
			var arr:Array = names;
			arr.push( [MenuBoxItems.BACK_TO_MAIN_MENU] );
			return arr;
		}
		
		private function initiateData():void
		{
			links = OnlineData.links;
			names = [];
			var websiteLinkNameIndex:int = links.indexOf(OnlineData.WEBSITE_LINK_REPLACEMENT_STRING);
			if (websiteLinkNameIndex >= 0)
			{
				if (OnlineData.newVersionAvailable)
				{
					links[websiteLinkNameIndex] = MenuBoxItems.PLAY_NEW_VERSION;
					links[websiteLinkNameIndex + 1] = OnlineData.gameUrl;
				}
				else if (OnlineData.onOfficialWebsite)
					links.splice(websiteLinkNameIndex, 2);
			}
				
			for (var i:int = 0; i < links.length; i++)
			{
				if (i % 2 == 0) // even
					names.push( [ links[i] ] );
			}
		}
		
//		protected function setNewSelection(nSelNum:int):void
//		{
//			super.setNewSelection(nSelNum);
//		}
		override protected function chooseItem(itemName:String, itemValue:String, itemTfc:TextFieldContainer, gsOvRdNum:int):void
		{
			if (itemName == MenuBoxItems.BACK_TO_MAIN_MENU)
			{
				if (!nextMsgBxToCreate)
					MSG_BX_MNGR.writeNextMainMenu(this);
				cancel();
			}
			else
			{
				var i:int = links.indexOf(itemName);
				navigateToURL( new URLRequest(links[i + 1]), PlainMessageMenuBox.BLANK_PAGE );
			}
			SND_MNGR.playSoundNow(MessageBoxSounds.SN_CHOOSE_ITEM);
			dispatchEvent( new Event( CustomEvents.MSG_BX_CHOOSE_ITEM + itemName) );
		}
		
		override public function pressAtkBtn():void
		{
			MSG_BX_MNGR.writeNextMainMenu(this);
			cancel();
			SND_MNGR.playSoundNow(SN_CANCEL_ITEM);
		}
	}
}