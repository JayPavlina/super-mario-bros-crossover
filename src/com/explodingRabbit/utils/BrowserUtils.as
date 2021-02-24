package com.explodingRabbit.utils
{
	import flash.external.ExternalInterface;
	
	
	public class BrowserUtils 
	{
		
		private static const CHECK_BROWSER:XML = <![CDATA[
			 function( ) { 
				return { userAgent: navigator.userAgent };
				}
			]]>;
		
		private static const CHECK_VERSION:XML = <![CDATA[
					 function( ) { 
						return { version:navigator.appVersion };
						}
					]]>;
		
		public static function get userAgent( ):String 
		{
			if ( !ExternalInterface.available )
				return null;
			
			var nameObject:Object = ExternalInterface.call( CHECK_BROWSER );
			if ( nameObject.hasOwnProperty("userAgent") )
				return nameObject["userAgent"];
			else
				return null;
		}
		
		public static function get version( ):String 
		{
			if ( !ExternalInterface.available )
				return null;            
			
			var nameObject:Object = ExternalInterface.call(CHECK_VERSION);
			if ( nameObject.hasOwnProperty("version") )
				return nameObject["version"];
			else
				return null;
		}
		
	}
}