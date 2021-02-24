package com.smbc.data
{
	import com.explodingRabbit.utils.CustomTimer;
	import com.probertson.utils.GZIPBytesEncoder;
	import com.smbc.errors.SingletonError;
	import com.smbc.main.GlobVars;
	
	import flash.crypto.generateRandomBytes;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.utils.Dictionary;

	public class OnlineData extends EventDispatcher
	{
		private static const URL_TO_LOAD:String = "http://data.explodingrabbit.com/super-mario-bros-crossover/data.txt.gz";
		
		public static const FUNDING_BOX_ICONS_REPLACEMENT_STRING:String = "FUNDING_BOX_ICONS",
			CURRENT_MONEY_REPLACEMENT_STRING:String = "CURRENT_MONEY",
			TARGET_MONEY_REPLACEMENT_STRING:String = "TARGET_MONEY",
			TICKER_ITEM_TYPE_SORTED:String = "Sorted",
			TICKER_ITEM_TYPE_UNOFFICIAL_WEBSITE_ONLY:String = "UnofficialWebsiteOnly",
			TICKER_ITEM_TYPE_RANDOM:String = "Random",
			WEBSITE_LINK_REPLACEMENT_STRING:String = "Developer Website";
		
		public static const DEVELOPER_WEBSITE_URL:String = "http://www.explodingrabbit.com/";
		private static const CURRENT_VERSION_NAME:String = "currentVersion";
//		private static const TICKER_ALWAYS_NAME:String = "tickerAlways";
		private static const TICKER_TEXT_NAME:String = "tickerText";
		private static const CURRENT_MONEY_NAME:String = "currentMoney";
		private static const TARGET_MONEY_NAME:String = "targetMoney";
//		private static const TICKER_NOT_OFFICIAL_WEBSITE_NAME:String = "tickerNotOfficialWebsite";
		private static const FUNDING_BOX_TEXT_NAME:String = "fundingBoxText";
		private static const FUNDING_BOX_ICONS_REPLACEMENT_STRING_NAME:String = "fundingBoxIconsReplacementString";
		private static const DISPLAY_FUNDING_BOX_NAME:String = "displayFundingBox";
		private static const FUNDING_BOX_URL_NAME:String = "fundingBoxUrl";
		private static const LINKS_NAME:String = "links";
//		private static const WEBSITE_LINK_NAME:String = "websiteLinkName"; // this is the ER website, and it should be hidden if on the site or replaced if playing an old version
		private static const GAME_URL_NAME:String = "gameUrl";
		private static const OFFICIAL_WEBSITE_URLS:String = "officialWebsiteUrls";
		private static const SEPARATOR:String = "()";
		private var loader:URLLoader;
		private var data:URLVariables;
		private static var _instance:OnlineData;
		
		private static const CONNECTION_ATTEMPTS_TO_TRY_COUNT:int = 5;
		private var connectedAttemptsCount:int;
		
//		private var tickerAlwaysVector:Vector.<String>;
		private var tickerTextVector:Vector.<String>;
//		private var tickerNotOfficialWebsiteVector:Vector.<String>;
		private var fundingBoxTextVector:Vector.<String>;
		private var loadDataDelayTimer:CustomTimer = new CustomTimer(1000, 1);
		
		public static function get instance():OnlineData
		{
			if (_instance == null)
				return new OnlineData();
			else
				return _instance;
		}
		
		private var _onOfficialWebsite:Boolean;

		public static function get onOfficialWebsite():Boolean
		{
			if (!loaded)
				return false;
			return instance._onOfficialWebsite;
		}
		
		
		public function OnlineData()
		{
			if (_instance != null)
				throw new SingletonError();
			_instance = this;
			_instance.loadDataDelayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, loadDataDelayTimerHandler, false, 0, true);
		}
		
		
		public static function initiate():void
		{
			if (GameSettings.forceOfflineDebug && GameSettings.DEBUG_MODE)
				_instance.dispatchEvent( new Event(Event.COMPLETE) );
			else
				_instance.loadData();
		}
		
		private function loadData():void
		{
			try
			{
				trace("load data attempt: "+ (connectedAttemptsCount + 1) );
				loader = null;
				loader = new URLLoader();
				loader.dataFormat = URLLoaderDataFormat.BINARY;
				loader.addEventListener(Event.COMPLETE, urlLoaderHandler, false, 0, true);
				loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true);
				loader.load( new URLRequest(URL_TO_LOAD) );
			}
			catch(error:Error)
			{
				loader.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
				loader.removeEventListener(Event.COMPLETE, urlLoaderHandler);
				data = null;
				loader = null;
				tryLoadDataAgain();
			}
		}
		
		private function tryLoadDataAgain():void
		{
			loadDataDelayTimer.reset();
			loadDataDelayTimer.start();
		}
		
		private function loadDataComplete():void
		{
			loadDataDelayTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, loadDataDelayTimerHandler);
			loadDataDelayTimer.stop();
			loadDataDelayTimer = null;
			if (connectedAttemptsCount < 1)
				connectedAttemptsCount = 1;
			trace("data loaded: "+loaded+" attempts: "+ connectedAttemptsCount );
			dispatchEvent( new Event(Event.COMPLETE) );
		}
		
		protected function loadDataDelayTimerHandler(event:TimerEvent):void
		{
			connectedAttemptsCount++;
			if (connectedAttemptsCount < CONNECTION_ATTEMPTS_TO_TRY_COUNT)
				loadData();
			else
				loadDataComplete();
		}
		
		protected function ioErrorHandler(event:IOErrorEvent):void
		{
			loader.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			loader.removeEventListener(Event.COMPLETE, urlLoaderHandler);
			loader = null;
			tryLoadDataAgain();
		}
		
		private function urlLoaderHandler (event:Event):void 
		{
			loader.removeEventListener(Event.COMPLETE, urlLoaderHandler);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
//			loader.dataFormat = URLLoaderDataFormat.VARIABLES;
			try
			{
//				var variables:URLVariables = new URLVariables(loader.data.toString());
				data = new URLVariables();
				var encoder:GZIPBytesEncoder = new GZIPBytesEncoder();
				data.decode( encoder.uncompressToByteArray(loader.data).toString() );
				loader = null;
//				data.decode(loader.data.toString());
			}
			catch(error:Error)
			{
				data = null;
			}
			if (loaded)
			{
//				trace("online data loaded");
				_onOfficialWebsite = _instance.checkIfOnOfficialWebsite();
				trace("onOfficialWebsite: "+_onOfficialWebsite);
				loadDataComplete();
			}
			else
				tryLoadDataAgain();
		}
		
		private function checkIfOnOfficialWebsite():Boolean
		{
			var currentUrl:String = GlobVars.STAGE.loaderInfo.url;
			if (GameSettings.DEBUG_MODE)
				return GameSettings.onOfficialWebsiteDebug;
//			if (GameSettings.callJavaScript && currentUrl.indexOf("file://") != -1 )
//				GameSettings.callJavaScript = false;
			var urlsToTest:Vector.<String> = officialWebsiteUrls;
//			if (officialWebsiteUrls == null)
//				return false;
			trace("current url: "+currentUrl);
			for each (var str:String in urlsToTest)
			{
				if (currentUrl.substr(0, str.length) == str)
					return true;
			}
			return false;
		}
		
		
		public static function get currentVersion():Number
		{
			if (loaded)
				return instance.data[CURRENT_VERSION_NAME];
			else
				return GameSettings.VERSION_NUMBER;
		}
		
		public static function get newVersionAvailable():Boolean
		{
			return GameSettings.VERSION_NUMBER < currentVersion;
		}
		
		public static function get tickerText():Vector.<String>
		{
			if ( loaded && instance.data.hasOwnProperty(TICKER_TEXT_NAME) )
			{
				if (instance.tickerTextVector == null)
					instance.tickerTextVector = instance.generateTickerText();
				return instance.tickerTextVector;
			}
			
			return Vector.<String>([
				"Please consider playing the game on our website, ExplodingRabbit.com. It helps us in many different ways, and you'll always be playing the newest version.",
				"Please help us to make our first commercial game, Super Retro Squad. Choose Super Retro Squad in the links menu to learn more!",
				"Join the community and talk more about Super Mario Bros. Crossover in the Exploding Rabbit forums. You can find it in the links menu.",
				"Be sure to try all of the map difficulties. Easy mode makes the game more about collecting coins, and hard mode really tests your skills.",
				"The special map set is from a game called Super Mario Bros. Special, made by Hudson in 1986. Be sure to try it out.",
				"There is a hidden bee item in every level of hard mode. Can you find them all?"
			]);
		}
		
		private function generateTickerText():Vector.<String>
		{
			// even items are keys, odd items are values
			var items:Vector.<String> = Vector.<String>( instance.data[TICKER_TEXT_NAME].split(SEPARATOR) );
			var returnVec:Vector.<String> = new Vector.<String>();
			var randomItems:Vector.<String> = new Vector.<String>();
			for (var i:int = 0; i < items.length; i += 2)
			{
				var itemType:String = items[i];
				var itemValue:String = items[i + 1];
				switch (itemType)
				{
					case TICKER_ITEM_TYPE_SORTED:
					{
						returnVec.push(itemValue);
						break;
					}
					case TICKER_ITEM_TYPE_UNOFFICIAL_WEBSITE_ONLY:
					{
						if (!onOfficialWebsite)
							returnVec.push(itemValue);
						break;
					}
					case TICKER_ITEM_TYPE_RANDOM:
					{
						randomItems.push(itemValue);
						break;
					}
				}
			}
			if (randomItems.length > 0)
			{
				randomItems.sort(randomSort);
				returnVec = returnVec.concat(randomItems);
			}
			return returnVec;
		}
		
		private function randomSort(objectA:Object, objectB:Object):int 
		{
			return Math.round(Math.random() * 2) - 1;
		}

//		public static function get tickerAlways():Vector.<String>
//		{
//			if ( loaded && instance.data.hasOwnProperty(TICKER_ALWAYS_NAME) )
//			{
//				if (instance.tickerAlwaysVector == null)
//					instance.tickerAlwaysVector = Vector.<String>( instance.data[TICKER_ALWAYS_NAME].split(SEPARATOR) );
//				return instance.tickerAlwaysVector;
//			}
//			
//			return Vector.<String>([
//				"Please help us to make our first commercial game, Super Retro Squad. Choose Super Retro Squad in the links menu to learn more!",
//				"Join the community and talk more about Super Mario Bros. Crossover in the Exploding Rabbit forums. You can find it in the links menu.",
//				"Be sure to try all of the map difficulties. Easy mode makes the game more about collecting coins, and hard mode really tests your skills.",
//				"The special map set is from a game called Super Mario Bros. Special, made by Hudson in 1986. Be sure to try it out."
//			]);
//		}
		
		public static function get currentMoney():int
		{
			var value:int = 0;
			if ( loaded && instance.data.hasOwnProperty(CURRENT_MONEY_NAME) )
			{
				value = instance.data[CURRENT_MONEY_NAME];
				if (value < 0)
					value = 0;
				else if (value > targetMoney)
					value = targetMoney;
				return value;
			}
			else
				return value;
		}
		
		public static function get targetMoney():int
		{
			var value:int = 0;
			if ( loaded && instance.data.hasOwnProperty(TARGET_MONEY_NAME) )
			{
				value = instance.data[TARGET_MONEY_NAME]; 
				if (value < 0)
					value = 0;
				return value;
			}
			else
				return value;
		}
		
//		public static function get tickerNotOfficialWebsite():Vector.<String>
//		{
//			if ( loaded && instance.data.hasOwnProperty(TICKER_NOT_OFFICIAL_WEBSITE_NAME) )
//			{
//				if (instance.tickerNotOfficialWebsiteVector == null)
//					instance.tickerNotOfficialWebsiteVector = Vector.<String>( instance.data[TICKER_NOT_OFFICIAL_WEBSITE_NAME].split(SEPARATOR) );
//				return instance.tickerNotOfficialWebsiteVector;
//			}
//			
//			return Vector.<String>([
//				"Please consider playing the game on our website, ExplodingRabbit.com. It helps us in many different ways, and you'll always be playing the newest version."
//			]);
//		}
		
		public static function get fundingBoxText():Vector.<String>
		{
			if ( loaded && instance.data.hasOwnProperty(FUNDING_BOX_TEXT_NAME) )
			{
				if (instance.fundingBoxTextVector == null)
				{
					instance.fundingBoxTextVector = Vector.<String>( instance.data[FUNDING_BOX_TEXT_NAME].split(SEPARATOR) );
					for (var i:int = 0; i < instance.fundingBoxTextVector.length; i++)
					{
						instance.fundingBoxTextVector[i] = instance.fundingBoxTextVector[i].replace( CURRENT_MONEY_REPLACEMENT_STRING, "$" + addCommas(currentMoney) );
						instance.fundingBoxTextVector[i] = instance.fundingBoxTextVector[i].replace( TARGET_MONEY_REPLACEMENT_STRING, "$" + addCommas(targetMoney) );
					}
				}
				return instance.fundingBoxTextVector;
			}
			return new Vector.<String>();
		}
		
		private static function addCommas(number:Number):String
		{
			var numString:String = number.toString()
			var result:String = ''
			
			while (numString.length > 3)
			{
				var chunk:String = numString.substr(-3)
				numString = numString.substr(0, numString.length - 3)
				result = ',' + chunk + result
			}
			
			if (numString.length > 0)
			{
				result = numString + result
			}
			
			return result
		}
		
		public static function get displayFundingBox():Boolean
		{
			if ( loaded && instance.data.hasOwnProperty(DISPLAY_FUNDING_BOX_NAME) )
				return instance.data[DISPLAY_FUNDING_BOX_NAME];
			else
				return false;
		}
		
		public static function get links():Vector.<String>
		{
			trace("loaded: "+loaded);
			if ( loaded && instance.data.hasOwnProperty(LINKS_NAME) )
				return Vector.<String>( instance.data[LINKS_NAME].toString().split(SEPARATOR) );
			
			return Vector.<String>([
				"Super Retro Squad", "http://www.explodingrabbit.com/games/super-retro-squad",
				WEBSITE_LINK_REPLACEMENT_STRING, "http://www.explodingrabbit.com", // this will get replaced if new version available or removed if on official website
				"Forum", "http://www.explodingrabbit.com/forum/forums/super-mario-bros-crossover.32/",
				"Wiki", "http://www.explodingrabbit.com/wiki/Super_Mario_Bros._Crossover",
				"Youtube", "http://www.youtube.com/theexplodingrabbit",
				"Twitter", "http://www.twitter.com/explodingrabbit",
				"Facebook", "http://www.facebook.com/ExplodingRabbit",
				"Google Plus", "https://plus.google.com/+explodingrabbit"
			]);
		}
		
		private static function get officialWebsiteUrls():Vector.<String>
		{
			if ( loaded && instance.data.hasOwnProperty(OFFICIAL_WEBSITE_URLS) )
				return Vector.<String>( instance.data[OFFICIAL_WEBSITE_URLS].toString().split(SEPARATOR) );
			else
				return Vector.<String>([
					gameUrl
				]);
		}
		
//		public static function get websiteLinkName():String
//		{
//			if ( loaded && instance.data.hasOwnProperty(WEBSITE_LINK_NAME) )
//				return instance.data[WEBSITE_LINK_NAME];
//			else
//				return "Developer Website";
//		}
		
		public static function get gameUrl():String
		{
			if ( loaded && instance.data.hasOwnProperty(GAME_URL_NAME) )
				return instance.data[GAME_URL_NAME];
			else
				return "http://www.explodingrabbit.com/games/super-mario-bros-crossover";
		}
		
		public static function get fundingBoxUrl():String
		{
			if ( loaded && instance.data.hasOwnProperty(FUNDING_BOX_URL_NAME) )
				return instance.data[FUNDING_BOX_URL_NAME];
			else
				//return "http://www.explodingrabbit.com/games/super-retro-squad";
				return "not loaded";
		}
		
		public static function get loaded():Boolean
		{
			return !(instance.data == null || instance.data.toString().length == 0);
		}
	}
}