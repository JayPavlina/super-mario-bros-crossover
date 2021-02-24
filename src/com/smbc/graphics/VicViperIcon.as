package com.smbc.graphics
{
	import com.smbc.characters.VicViper;
	import com.smbc.main.SkinObj;
	
	import flash.geom.Point;
	import flash.sampler.getLexicalScopes;
	
	public class VicViperIcon extends SkinObj
	{
		public static const FL_BASE_NAME:String = "nameBar-";
		private static const FL_POWER_UP_BAR:String = "powerUpBar";
		
		private static const FL_POWER_UP_SELECTOR_START:String = "powerUpSelectorStart";
		private static const FL_POWER_UP_SELECTOR_END:String = "powerUpSelectorEnd";
		
		private static const NAME_BAR_PNT:Point = new Point(8,70);
		private static const POWER_UP_BAR_POINT:Point = new Point(48 + TopScreenText.HUD_X_OFS, TopScreenText.THIRD_ROW_Y + 2);
		private static const SELECTOR_PNT:Point = new Point(POWER_UP_BAR_POINT.x + 2, POWER_UP_BAR_POINT.y);
		private static const SELECTOR_WIDTH:int = 16;
		
		private static var powerUpBar:VicViperIcon;
		private static var nameBar:VicViperIcon;
		private static var selector:VicViperIcon;
		
		public function VicViperIcon()
		{
			super();
		}
		
		public static function setUpIcons():void
		{
			if (powerUpBar == null)
				setUpPowerUpBar();
			if (selector == null)
				setUpSelector();
			if (nameBar == null)
				setUpNameBar();
		}
		
		public static function updateIcons(powerLevel:int,showName:Boolean):void
		{
			setUpIcons();
			if (powerLevel == VicViper.PL_ZERO)
				selector.visible = false;
			else
				selector.visible = true;
			selector.x = SELECTOR_PNT.x + (powerLevel - 1)*SELECTOR_WIDTH;
			if (!showName)
				powerLevel = 0;
			nameBar.gotoAndStop( FL_BASE_NAME + powerLevel.toString() );
		}
		
		private static function setUpNameBar():void
		{
			nameBar = new VicViperIcon();
			nameBar.gotoAndStop(FL_BASE_NAME + "0");
			nameBar.stopAnim = true;
			nameBar.x = NAME_BAR_PNT.x;
			nameBar.y = NAME_BAR_PNT.y;
			TopScreenText.instance.addChild(nameBar);
		}
		
		private static function setUpPowerUpBar():void
		{
			powerUpBar = new VicViperIcon();
			powerUpBar.gotoAndStop(FL_POWER_UP_BAR);
			powerUpBar.stopAnim = true;
			powerUpBar.x = POWER_UP_BAR_POINT.x;
			powerUpBar.y = POWER_UP_BAR_POINT.y;
			TopScreenText.instance.addChild(powerUpBar);
		}
		
		private static function setUpSelector():void
		{
			selector = new VicViperIcon();
			selector.stopAnim = true;
			selector.gotoAndStop(FL_POWER_UP_SELECTOR_START);
			selector.x = SELECTOR_PNT.x;
			selector.y = SELECTOR_PNT.y;
			selector.visible = false;
			TopScreenText.instance.addChild(selector);
		}
		
		public static function cleanUp():void
		{
			if (nameBar != null)
			{
				if (nameBar.parent)
					nameBar.parent.removeChild(nameBar);
				nameBar = null;
			}
			if (powerUpBar != null)
			{
				if (powerUpBar.parent)
					powerUpBar.parent.removeChild(powerUpBar);
				powerUpBar = null;
			}
			if (selector != null)
			{
				if (selector.parent)
					selector.parent.removeChild(selector);
				selector = null;
			}
		}
	}
}