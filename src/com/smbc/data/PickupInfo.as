package com.smbc.data
{
	import com.adobe.protocols.dict.Dict;
	import com.smbc.characters.Bass;
	import com.smbc.characters.MegaMan;
	import com.smbc.pickups.BassPickup;
	import com.smbc.pickups.BillPickup;
	import com.smbc.pickups.FireFlower;
	import com.smbc.pickups.LinkPickup;
	import com.smbc.pickups.LuigiPickup;
	import com.smbc.pickups.MarioPickup;
	import com.smbc.pickups.MegaManPickup;
	import com.smbc.pickups.Mushroom;
	import com.smbc.pickups.Pickup;
	import com.smbc.pickups.PitPickup;
	import com.smbc.pickups.RyuPickup;
	import com.smbc.pickups.SamusPickup;
	import com.smbc.pickups.SimonPickup;
	import com.smbc.pickups.SophiaPickup;
	import com.smbc.pickups.VicViperPickup;
	import com.smbc.projectiles.RyuProjectile;
	
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;

	public class PickupInfo
	{
		public static const UPGRADE_STR:String = "UPG_";
		public static const REGULAR_STR:String = "REG_";
		public static const FAKE_STR:String = "NON_";
		private static const PICKUP_DCT:Dictionary = new Dictionary();
		private static const PICKUP_ARR:Array = [];
		
		public static const MAIN_TYPE_UPGRADE:String = "upgrade";
		public static const MAIN_TYPE_FAKE:String = "fake";
		public static const MAIN_TYPE_REGULAR:String = "regular";
		
//		Game --------------------------------------------------
		public static const MUSHROOM:String = "UPG_mushroom",
			FIRE_FLOWER:String = "UPG_fireFlower",
			POISON_MUSHOOM:String = "REG_poisonMushroom",
			GREEN_MUSHROOM:String = "REG_greenMushroom",
			ATOM:String = "REG_atom",
			HUDSON_BEE:String = "REG_hudsonBee",
			HAMMER:String = "REG_hammer",
			WING:String = "REG_wing",
			CLOCK:String = "REG_clock",
			STAR:String = "REG_star",
			COIN:String = "REG_coin",
			EXPLODING_RABBIT:String = "REG_explodingRabbit";
		
//		Bill ---------------------------------------------------------------------
		public static const BILL_FLARE:String = "UPG_flare";
		public static const BILL_LASER:String = "UPG_laser";
		public static const BILL_MACHINE:String = "UPG_machine";
		public static const BILL_RAPID_1:String = "UPG_rapid1";
		public static const BILL_RAPID_2:String = "UPG_rapid2";
		public static const BILL_SPREAD:String = "UPG_spread";
		
//		Link -----------------------------------------------------------------------
		public static const LINK_LADDER:String = "UPG_ladder";
		public static const LINK_BOW:String = "UPG_bow";
		public static const LINK_BOMB:String = "UPG_bomb";
		public static const LINK_BOMB_BAG:String = "UPG_bombBag";
		public static const LINK_BLUE_RING:String = "UPG_blueRing";
		public static const LINK_SHORT_BOOMERANG:String = "UPG_shortBoomerang";
		public static const LINK_MAGIC_BOOMERANG:String = "UPG_magicBoomerang";
		public static const LINK_MAGIC_SHIELD:String = "UPG_magicShield";
		public static const LINK_MAGIC_SWORD:String = "UPG_magicSword";
		public static const LINK_RED_RING:String = "UPG_redRing";
		public static const LINK_QUIVER:String = "UPG_quiver";

		public static const LINK_ARROW_AMMO:String = "REG_arrowAmmo";
		public static const LINK_BOMB_AMMO:String = "REG_bombAmmo";
		
//		Mario ----------------------------------------------------------
		public static const MARIO_FIRE_FLOWER:String = "UPG_fireFlower";
		
//		Mega Man ---------------------------------------------------------------------
		public static const MEGA_MAN_BASS_BUSTER:String = "UPG_bassBuster";
		public static const MEGA_MAN_CHARGE_KICK:String = "UPG_chargeKick";
		public static const MEGA_MAN_CHARGE_SHOT:String = "UPG_chargeShot";
		public static const MEGA_MAN_ENERGY_BALANCER:String = "UPG_energyBalancer"; 
		public static const MEGA_MAN_FLAME_BLAST:String = "UPG_flameBlast";
		public static const MEGA_MAN_HARD_KNUCKLE:String = "UPG_hardKnuckle";
		public static const MEGA_MAN_MAGMA_BAZOOKA:String = "UPG_magmaBazooka";
		public static const MEGA_MAN_MEGA_BUSTER:String = "UPG_megaBuster";
		public static const MEGA_MAN_METAL_BLADE:String = "UPG_metalBlade";
		public static const MEGA_MAN_PHARAOH_SHOT:String = "UPG_pharaohShot";
		public static const MEGA_MAN_RUSH_COIL:String = "UPG_rushCoil";
		public static const MEGA_MAN_RUSH_JET:String = "UPG_rushJet";
		public static const MEGA_MAN_RUSH_MARINE:String = "UPG_rushMarine";
		public static const MEGA_MAN_SCREW_CRUSHER:String = "UPG_screwCrusher";
		public static const MEGA_MAN_SUPER_ARM:String = "UPG_superArm";
		public static const MEGA_MAN_WATER_SHIELD:String = "UPG_waterShield";
		
 		public static const MEGA_MAN_WEAPON_ENERGY_BIG:String = "REG_weaponEnergyBig";
		public static const MEGA_MAN_WEAPON_ENERGY_SMALL:String = "REG_weaponEnergySmall";
		
//		Pit --------------------------------------------------------------------------
		public static const PIT_FIRE_ARROW:String = "UPG_fireArrow";
		public static const PIT_FEATHER:String = "UPG_feather";
		public static const PIT_LONG_ARROW:String = "UPG_longArrow";
		public static const PIT_BARRIER:String = "UPG_barrier";
		public static const PIT_HAMMER:String = "UPG_hammer";
		
//		Ryu --------------------------------------------------------------------------
		public static const RYU_ART_OF_FIRE_WHEEL:String = "UPG_artOfFireWheel";
		public static const RYU_SHURIKEN:String = "UPG_shuriken";
		public static const RYU_WINDMILL_SHURIKEN:String = "UPG_windmillShuriken";
		public static const RYU_FIRE_DRAGON_BALL:String = "UPG_fireDragonBall";
		public static const RYU_INFINITE_JUMP_SLASH:String = "UPG_infiniteJumpSlash";
		public static const RYU_JUMP_SLASH:String = "UPG_jumpSlash";
		public static const RYU_SCROLL:String = "UPG_scroll";
		public static const RYU_SWORD_EXTENSION:String = "UPG_swordExtension";
		
		public static const RYU_NINJITSU_AMMO_BIG:String = "REG_ninjitsuAmmoBig";
		public static const RYU_NINJITSU_AMMO_SMALL:String = "REG_ninjitsuAmmoSmall";
		
//		Samus ---------------------------------------------------------------------
		public static const SAMUS_BOMB:String = "UPG_bomb";
		public static const SAMUS_HIGH_JUMP:String = "UPG_highJump";
		public static const SAMUS_ICE_BEAM:String = "UPG_iceBeam";
		public static const SAMUS_LONG_BEAM:String = "UPG_longBeam";
		public static const SAMUS_MISSILE:String = "UPG_missile";
		public static const SAMUS_MISSILE_EXPANSION:String = "UPG_missileExpansion";
		public static const SAMUS_MORPH_BALL:String = "UPG_morphBall";
		public static const SAMUS_SCREW_ATTACK:String = "UPG_screwAttack";
		public static const SAMUS_VARIA_SUIT:String = "UPG_variaSuit";
		public static const SAMUS_WAVE_BEAM:String = "UPG_waveBeam";

		public static const SAMUS_MISSILE_AMMO:String = "REG_missileAmmo";
		
//		Simon ---------------------------------------------------------------------
		public static const SIMON_AXE:String = "UPG_axe";
		public static const SIMON_STOP_WATCH:String = "UPG_stopWatch";
		public static const SIMON_CROSS:String = "UPG_cross";
		public static const SIMON_DOUBLE:String = "UPG_double";
		public static const SIMON_DAGGER:String = "UPG_dagger";
		public static const SIMON_HOLY_WATER:String = "UPG_holyWater";
		public static const SIMON_TRIPLE:String = "UPG_triple";
		public static const SIMON_WHIP_LEVEL_2:String = "UPG_whipLevel2";
		public static const SIMON_WHIP_LEVEL_3:String = "UPG_whipLevel3";
		
		public static const SIMON_HEART_BIG:String = "REG_heartBig";
		public static const SIMON_HEART_SMALL:String = "REG_heartSmall";
		public static const SIMON_PORK_CHOP:String = "REG_porkChop";
		
//		Sophia ----------------------------------------------------------------------
		public static const SOPHIA_CEILING_CLIMB:String = "UPG_ceilingClimb";
		public static const SOPHIA_HOMING_MISSILE:String = "UPG_homingMissile";
		public static const SOPHIA_MISSILE:String = "UPG_missile";
		public static const SOPHIA_HOVER:String = "UPG_hover";
		public static const SOPHIA_WALL_CLIMB:String = "UPG_wallClimb";
		public static const SOPHIA_WALL_JUMP:String = "UPG_wallJump";
		public static const SOPHIA_CRUSHER:String = "UPG_crusher";
		public static const SOPHIA_HYPER:String = "UPG_hyper";
		
		public static const SOPHIA_HOMING_MISSILE_AMMO:String = "REG_homingMissileAmmo";
		public static const SOPHIA_MISSILE_AMMO:String = "REG_missileAmmo";
		
//		VicViper ----------------------------------------------------------------------
		public static const VIC_POWER_UP_1:String = "UPG_powerUp1";
		public static const VIC_POWER_UP_2:String = "UPG_powerUp2";
		public static const VIC_POWER_UP_3:String = "UPG_powerUp3";
		public static const VIC_POWER_UP_4:String = "UPG_powerUp4";
		public static const VIC_POWER_UP_5:String = "UPG_powerUp5";
		public static const VIC_POWER_UP_6:String = "UPG_powerUp6";
		
		public static const VIC_SPEED_1:String = "UPG_speed1";
		public static const VIC_SPEED_2:String = "UPG_speed2";
		public static const VIC_SPEED_3:String = "UPG_speed3";
		public static const VIC_SPEED_4:String = "UPG_speed4";
		public static const VIC_SPEED_5:String = "UPG_speed5";
		
		public static const VIC_MISSILE:String = "UPG_missile";
		
		public static const VIC_DOUBLE_1:String = "UPG_double1";
		public static const VIC_DOUBLE_2:String = "UPG_double2";
		
		public static const VIC_LASER_1:String = "UPG_laser1";
		public static const VIC_LASER_2:String = "UPG_laser2";
		
		public static const VIC_OPTION_1:String = "UPG_option1";
		public static const VIC_OPTION_2:String = "UPG_option2";
		public static const VIC_OPTION_3:String = "UPG_option3";
		public static const VIC_OPTION_4:String = "UPG_option4";
		
		public static const VIC_SHIELD:String = "UPG_shield";
		

		// shouldn't be pickups but are currently
		public static const PIPE_TRANSPORTER:String = "NON_pipeTransporter";
		public static const TELEPORTER:String = "NON_teleporter";
		public static const VINE:String = "NON_vine";
		public static const LEVEL_EXIT:String = "NON_levelExit";
		public static const RUSH:String = "NON_rush";
		public static const FLAG_POLE:String = "NON_flagPole";
		
		public static const AMMO_DCT:Dictionary = new Dictionary();
		public static function initiate():void
		{
			var bassPickup:BassPickup;
			var billPickup:BillPickup;
			var linkPickup:LinkPickup;
			var luigiPickup:LuigiPickup;
			var marioPickup:MarioPickup;
			var megaManPickup:MegaManPickup;
//			var pitPickup:PitPickup;
			var ryuPickup:RyuPickup;
			var samusPickup:SamusPickup;
			var simonPickup:SimonPickup;
			var sophiaPickup:SophiaPickup;
			var vicViperPickup:VicViperPickup;
			setUpNums();
			setUpAmmoDct();
		}
		
		private static function setUpAmmoDct():void
		{
			var ammoTypes:Array = [
				LINK_ARROW_AMMO, LINK_BOMB_AMMO, MEGA_MAN_WEAPON_ENERGY_BIG, MEGA_MAN_WEAPON_ENERGY_SMALL,
				RYU_NINJITSU_AMMO_BIG, RYU_NINJITSU_AMMO_SMALL, SAMUS_MISSILE_AMMO, SOPHIA_MISSILE_AMMO,
				SOPHIA_HOMING_MISSILE_AMMO, SIMON_HEART_BIG, SIMON_HEART_SMALL
			];
			for each (var obj:Object in ammoTypes)
			{
				AMMO_DCT[obj] = obj;
			}
		}
		private static function setUpNums():void
		{
			var lst:XMLList = describeType(PickupInfo)..constant;
			var n:int = lst.length();
			for (var i:int; i < n; i++)
			{
				var nameVal:Object = lst[i].@name;
				var val:Object = PickupInfo[nameVal];
				if (val is String)
				{
					var nameStr:String =  val as String;
					if ( nameStr.indexOf(UPGRADE_STR) != -1)
					{
						PICKUP_ARR.push(nameStr);
					}
				}
			}
			PICKUP_ARR.sort();
			n = PICKUP_ARR.length;
			for (i = 0; i < n; i++)
			{
				nameStr = PICKUP_ARR[i];
				PICKUP_DCT[nameStr] = i;
			}
		}
		public static function getPickupClass(charNum:int):Class
		{
//			if (charNum == Bass.CHAR_NUM)
//				charNum = MegaMan.CHAR_NUM;
			var name:String = "com.smbc.pickups."+CharacterInfo.getCharClassName(charNum) + "Pickup";
			return getDefinitionByName(name) as Class;
		}
		
		public static function getPickupClassFromUpgradeType(type:String):Class
		{
			switch(type)
			{
				case MUSHROOM:
					return Mushroom;
				case FIRE_FLOWER:
					return FireFlower;
			}
			return Pickup;
		}
		public static function convToInt(upgradeType:String):int
		{
			trace("convert: "+upgradeType+" to "+PICKUP_DCT[upgradeType]);
			return PICKUP_DCT[upgradeType];
		}
		public static function convToString(num:int):String
		{
			trace("convert: "+num+" to "+PICKUP_ARR[num]);
			return PICKUP_ARR[num];
		}
//		private static const CLASS_LINK_PICKUP:Class = LinkPickup;
		
//		public static const CLASS_LINK_PICKUP:Class = 
	}
}