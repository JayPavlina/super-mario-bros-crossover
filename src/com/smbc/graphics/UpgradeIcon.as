package com.smbc.graphics
{
	import com.explodingRabbit.utils.CustomDictionary;
	import com.smbc.characters.Character;
	import com.smbc.characters.Link;
	import com.smbc.data.GameSettings;
	import com.smbc.data.PickupInfo;
	import com.smbc.level.Level;
	import com.smbc.main.SkinObj;
	import com.smbc.managers.StatManager;
	
	import flash.geom.Point;
	
	public class UpgradeIcon extends SkinObj
	{
		protected static const UPGRADE_STR:String = PickupInfo.UPGRADE_STR;
		
		private static const FL_FIRE_FLOWER:String = "fireFlower";
		private static const FL_LIFE:String = "life";
		private static const FL_MUSHROOM:String = "mushroom";
		private static const FL_STAR:String = "star";
		private static var classicLocation:Point;
		private static var nonClassicLocation:Point;
		protected var type:String;
		protected var mainFrameLabel:String;
		
		
		public function UpgradeIcon(type:String,forceClassName:String = null)
		{
			inheritedForceShortClassName = forceClassName;
			super();
			this.type = type;
			mainFrameLabel = type.substr(UPGRADE_STR.length);
			gotoAndStop(mainFrameLabel);
		}
		public function update():void
		{	
			var level:Level = Level.levelInstance;
			if (!level)
			{
				visible = false;
				return;
			}
			var player:Character = level.player;
			if (type == PickupInfo.MUSHROOM)
			{
				setPosition();
				
				var statMngr:StatManager = StatManager.STAT_MNGR;
				var obtainedItemsDct:CustomDictionary = statMngr.getObtainedUpgradesDct(statMngr.curCharNum);
				if ( obtainedItemsDct[PickupInfo.MUSHROOM] )
				{
					visible = true;
					if (GameSettings.classicMode && obtainedItemsDct[PickupInfo.FIRE_FLOWER])
						gotoAndStop(FL_FIRE_FLOWER);
					else
						gotoAndStop(FL_MUSHROOM);
				}
				else
					visible = false;
//				trace("parent: "+parent+" visible: "+visible+"lab: "+currentLabel+" x: "+x+" y: "+y);
			}
//			else if (type == PickupInfo.STAR)
//			{
//				if (player && player.starPwr)
//					visible = true;
//				else
//					visible = false;
//			}
		}
		
		private function setPosition():void
		{
			if (nonClassicLocation == null)
			{
				nonClassicLocation = new Point(x, y);
				classicLocation = TopScreenText.UPG_ICONS_START_PNT; 
			}
			
			if (GameSettings.classicMode)
			{
				x = classicLocation.x;
				y = classicLocation.y;
			}
			else
			{
				x = nonClassicLocation.x;
				y = nonClassicLocation.y;
			}
		}
		
		public function destroy():void
		{
			if (parent)
				parent.removeChild(this);
		}
	}
}