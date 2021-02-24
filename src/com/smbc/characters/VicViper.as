package com.smbc.characters
{
	import com.explodingRabbit.utils.CustomDictionary;
	import com.smbc.data.CharacterInfo;
	import com.smbc.data.PaletteTypes;
	import com.smbc.data.PickupInfo;
	import com.smbc.data.SoundNames;
	import com.smbc.graphics.VicViperIcon;
	import com.smbc.level.Level;
	import com.smbc.pickups.BowserAxe;
	import com.smbc.pickups.Pickup;
	import com.smbc.pickups.PipeTransporter;
	import com.smbc.projectiles.VicViperProjectile;
	
	import flash.display.PixelSnapping;
	import flash.display.StageQuality;

	public class VicViper extends Character
	{
		
//		public static const CHAR_NAME:String = CharacterInfo.VicViper[ CharacterInfo.IND_CHAR_NAME ];
//		public static const CHAR_NAME_CAPS:String = CharacterInfo.VicViper[ CharacterInfo.IND_CHAR_NAME_CAPS ];
//		public static const CHAR_NAME_TEXT:String = CharacterInfo.VicViper[ CharacterInfo.IND_CHAR_NAME_MENUS ];
//		public static const CHAR_NUM:int = CharacterInfo.VicViper[ CharacterInfo.IND_CHAR_NUM ];
		public static const PAL_ORDER_ARR:Array = [ PaletteTypes.FLASH_POWERING_UP ]; 
		
//		upgrades
		private static const VIC_POWER_UP_1:String = PickupInfo.VIC_POWER_UP_1;
		private static const VIC_POWER_UP_2:String = PickupInfo.VIC_POWER_UP_2;
		private static const VIC_POWER_UP_3:String = PickupInfo.VIC_POWER_UP_3;
		private static const VIC_POWER_UP_4:String = PickupInfo.VIC_POWER_UP_4;
		private static const VIC_POWER_UP_5:String = PickupInfo.VIC_POWER_UP_5;
		private static const VIC_POWER_UP_6:String = PickupInfo.VIC_POWER_UP_6;
		
		private static const VIC_SPEED_1:String = PickupInfo.VIC_SPEED_1;
		private static const VIC_SPEED_2:String = PickupInfo.VIC_SPEED_2;
		private static const VIC_SPEED_3:String = PickupInfo.VIC_SPEED_3;
		private static const VIC_SPEED_4:String = PickupInfo.VIC_SPEED_4;
		private static const VIC_SPEED_5:String = PickupInfo.VIC_SPEED_5;
		
		private static const VIC_MISSILE:String = PickupInfo.VIC_MISSILE;
		
		private static const VIC_DOUBLE_1:String = PickupInfo.VIC_DOUBLE_1;
		private static const VIC_DOUBLE_2:String = PickupInfo.VIC_DOUBLE_2;
		
		private static const VIC_LASER_1:String = PickupInfo.VIC_LASER_1;
		private static const VIC_LASER_2:String = PickupInfo.VIC_LASER_2;
		
		private static const VIC_OPTION_1:String = PickupInfo.VIC_OPTION_1;
		private static const VIC_OPTION_2:String = PickupInfo.VIC_OPTION_2;
		private static const VIC_OPTION_3:String = PickupInfo.VIC_OPTION_3;
		private static const VIC_OPTION_4:String = PickupInfo.VIC_OPTION_4;
		
		private static const VIC_SHIELD:String = PickupInfo.VIC_SHIELD;
		
//		there are 10 speed ups in life force
//		infinite speed ups in gradius, 13 with noticeable difference
//		7 speeds ups in gradius 2
		
		public static const OBTAINABLE_UPGRADES_ARR:Array = [ [ VIC_POWER_UP_1, VIC_POWER_UP_2, VIC_POWER_UP_3, VIC_POWER_UP_4, VIC_POWER_UP_5, VIC_POWER_UP_6 ] ];
		public static const MUSHROOM_UPGRADES:Array = [ ];
		public static const NEVER_LOSE_UPGRADES:Array = [ ];
		public static const RESTORABLE_UPGRADES:Array = [ ];
		public static const START_WITH_UPGRADES:Array = [ ];
		public static const SINGLE_UPGRADES_ARR:Array = [ ];
		public static const REPLACEABLE_UPGRADES_ARR:Array = [ ];
		public static const TITLE_SCREEN_UPGRADES:Array = [ ];
		public static const ICON_ORDER_ARR:Array = [ ];
		public static const AMMO_ARR:Array = [ [ ] ];
		public static const AMMO_DEPLETION_ARR:Array = [ [ ] ];
		public static const AMMO_DCT:CustomDictionary = new CustomDictionary();
		public static const AMMO_DEPLETION_DCT:CustomDictionary = new CustomDictionary();
		
		public static const PL_ZERO:int = 0;
		private static const PL_SPEED:int = 1;
		private static const PL_MISSILE:int = 2;
		private static const PL_DOUBLE:int = 3;
		private static const PL_LASER:int = 4;
		private static const PL_OPTION:int = 5;
		private static const PL_SHIELD:int = 6;
		
		private static const MAX_POWER_LEVEL:int = 6;
		private var vicPowerUpDct:CustomDictionary = new CustomDictionary(); // this is a dictionary of vic's power up upgrade strings
		
//		sound effects
		private static const SN_GET_POWER_UP:String = SoundNames.SFX_VIC_GET_POWER_UP;
		
		public static const WIN_SONG_DUR:int = 5400;
		public static const CHAR_SEL_END_DUR:int = 1700;
		private static const IDLE_X_SPEED:int = Level.SCROLL_SPEED_AUTO;
		private static const MOVEMENT_SPEED:int = 200;
		
		private static const FL_DOWN:String = "down";
		private static const FL_IDLE:String = "idle";
		private static const FL_UP:String = "up";
		
		public static const SKIN_ORDER:Array = [ ];
		
		public function VicViper()
		{
			super();
			
//			sets up power ups
			for each (var str:String in OBTAINABLE_UPGRADES_ARR[0])
			{
				vicPowerUpDct.addItem(str);
			}
			brickState = BRICK_NONE;
			canGetMushroom = false;
		}
		
		override public function setStats():void
		{
			defyGrav = true;
			xSpeed = MOVEMENT_SPEED;
			super.setStats();
			canEnterPipesUngrounded = true;
			level.autoScrollStart();
		}
		
		override protected function startAndDamageFcts(start:Boolean = false):void
		{
			if (start)
				updatePowerLevel();
		}
		
		override protected function enterPipeVert():void
		{
			super.enterPipeVert();
			level.autoScrollStop(true);
		}
		
		override public function exitPipeVert(pt:PipeTransporter):void
		{
			level.autoScrollStop();
			super.exitPipeVert(pt);
			defyGrav = true;
		}
		
		override protected function completePipeExit():void
		{
			super.completePipeExit();
			level.autoScrollStart();
		}
		
		override protected function enterPipeHorz():void
		{
			super.enterPipeHorz();
			level.autoScrollStop(true);
		}
		
		override public function getAxe(axe:BowserAxe):void // it's called after the game freezes if bowser exists
		{
			super.getAxe(axe);
			level.disableScreenScroll = false;
			pressDwnBtn();
		}
		override protected function movePlayer():void 
		{
			if (rhtBtn && !lftBtn && !wallOnRight)
				vx = MOVEMENT_SPEED;
			else if (lftBtn && !rhtBtn && !wallOnLeft)
			{
				vx = -MOVEMENT_SPEED;
				if (level.autoScroll)
					vx -= IDLE_X_SPEED;
			}
			else if ( (lftBtn && rhtBtn) || (!lftBtn && !rhtBtn) )
				vx = 0;
			if (upBtn && !dwnBtn)
				vy = -MOVEMENT_SPEED;
			else if (dwnBtn && !upBtn)
				vy = MOVEMENT_SPEED;
			else if ( (dwnBtn && upBtn) || (!dwnBtn && !upBtn) )
				vy = 0;
		}
		
		override protected function checkState():void
		{
			if (upBtn && !dwnBtn)
				gotoAndStop(FL_UP);
			else if (dwnBtn && !upBtn)
				gotoAndStop(FL_DOWN);
			else
				gotoAndStop(FL_IDLE);
		}
		
		override public function hitPickup(pickup:Pickup,showAnimation:Boolean = true):void
		{
			if ( pickupIsVicPowerUp(pickup.type) )
			{
				trace("picked up: "+pickup.type+" current pickups: "+STAT_MNGR.getObtainedUpgradesDct(charNum));
				updatePowerLevel(true);
				SND_MNGR.playSound(SN_GET_POWER_UP);
			}
			super.hitPickup(pickup,showAnimation);
		}
		
		private function pickupIsVicPowerUp(pickupType:String):Boolean
		{
			return vicPowerUpDct[pickupType] != undefined;
		}
		
		private function resetPowerLevel():void
		{
			for each( var pickupType:String in vicPowerUpDct)
			{
				STAT_MNGR.removeCharUpgrade(charNum, pickupType);
			}
			VicViperIcon.updateIcons(0,false);
		}
		
//		if returns true, power level needs to be reset
		private function updatePowerLevel(addOne:Boolean = false):void
		{
			var numPowerUps:int;
			if (addOne)
				numPowerUps++;
			var curUpgrades:CustomDictionary = STAT_MNGR.getObtainedUpgradesDct(charNum);
			for each (var type:String in curUpgrades)
			{
				if (pickupIsVicPowerUp(type))
					numPowerUps++;
			}
			var powerLevel:int = 0;
			for (var i:int = 0; i < numPowerUps; i++)
			{
				var levelTemp:int = powerLevel;
				powerLevel = getNextAvailablePowerLevel(powerLevel);
				if (addOne && powerLevel == levelTemp)
				{
					powerLevel = 0;
					resetPowerLevel();
					break;
				}
			}
			VicViperIcon.updateIcons(powerLevel, powerLevelIsAvailable(powerLevel) );
		}
		
		private function getNextAvailablePowerLevel(powerLevel:int):int
		{
			var powerLevelStart:int = powerLevel;
			while (powerLevel < MAX_POWER_LEVEL)
			{
				powerLevel++;
				if (powerLevelIsAvailable(powerLevel))
					return powerLevel;
			}
			return powerLevelStart;
		}
		private function powerLevelIsAvailable(num:int):Boolean
		{
			switch(num)
			{
				case PL_ZERO:
					return true;
				case PL_SPEED:
					return !upgradeIsActive(VIC_SPEED_5);
				case PL_MISSILE:
					return !upgradeIsActive(VIC_MISSILE);
				case PL_DOUBLE:
					return !upgradeIsActive(VIC_DOUBLE_2);
				case PL_LASER:
					return !upgradeIsActive(VIC_LASER_2);
				case PL_OPTION:
					return !upgradeIsActive(VIC_OPTION_4);
				case PL_SHIELD:
					return !upgradeIsActive(VIC_SHIELD);
			}
			return false;
		}
		
		override public function pressAtkBtn():void
		{
			super.pressAtkBtn();
			level.addToLevel(new VicViperProjectile(this));
		}
		
		override public function cleanUp():void
		{
			VicViperIcon.cleanUp();
			if (level)
				level.autoScrollStop();
			super.cleanUp();
		}
		
		
		
	}
}