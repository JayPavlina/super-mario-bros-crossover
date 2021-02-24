package com.smbc.characters
{
	import com.explodingRabbit.utils.CustomDictionary;
	import com.smbc.characters.base.MegaManBase;
	import com.smbc.data.CharacterInfo;
	import com.smbc.data.GameSettings;
	import com.smbc.data.PaletteTypes;
	import com.smbc.projectiles.MegaManProjectile;
	import com.smbc.utils.CharacterSequencer;
	
	import flash.geom.Point;
	
	public class Bass extends MegaManBase
	{
		public static const CHAR_NAME:String = CharacterInfo.Bass[ CharacterInfo.IND_CHAR_NAME ];
		public static const CHAR_NAME_CAPS:String = CharacterInfo.Bass[ CharacterInfo.IND_CHAR_NAME_CAPS ];
		public static const CHAR_NAME_TEXT:String = CharacterInfo.Bass[ CharacterInfo.IND_CHAR_NAME_MENUS ];
		public static const CHAR_NUM:int = CharacterInfo.Bass[ CharacterInfo.IND_CHAR_NUM ];
		public static const PAL_ORDER_ARR:Array = [ PaletteTypes.FLASH_POWERING_UP ];
		public static const SKIN_APPEARANCE_STATE_COUNT:int = 10;
		public static const OBTAINABLE_UPGRADES_ARR:Array = [
			[ MM_SUPER_ARM, MM_METAL_BLADE, MM_HARD_KNUCKLE, MM_PHARAOH_SHOT, MM_CHARGE_KICK, MM_FLAME_BLAST, MM_MAGMA_BAZOOKA, MM_WATER_SHIELD, MM_SCREW_CRUSHER ]
//			[ MUSHROOM ],
//			[ MM_SUPER_ARM, MM_METAL_BLADE, MM_HARD_KNUCKLE, MM_PHARAOH_SHOT, MM_CHARGE_KICK, MM_FLAME_BLAST, MM_WATER_SHIELD ], // MM_MAGMA_BAZOOKA
//			[ MM_ENERGY_BALANCER ]
		];
		public static const START_WITH_UPGRADES:Array = [ ];
		public static const MUSHROOM_UPGRADES:Array = [ ];
		public static const NEVER_LOSE_UPGRADES:Array = [ MM_ENERGY_BALANCER, MM_SUPER_ARM, MM_METAL_BLADE, MM_HARD_KNUCKLE, MM_PHARAOH_SHOT, MM_CHARGE_KICK, MM_FLAME_BLAST, MM_MAGMA_BAZOOKA, MM_WATER_SHIELD, MM_SCREW_CRUSHER ];
		public static const RESTORABLE_UPGRADES:Array = [ MM_SUPER_ARM, MM_METAL_BLADE, MM_HARD_KNUCKLE, MM_PHARAOH_SHOT, MM_CHARGE_KICK, MM_FLAME_BLAST, MM_MAGMA_BAZOOKA, MM_WATER_SHIELD, MM_SCREW_CRUSHER ]; // actually gets half of these
		public static const SINGLE_UPGRADES_ARR:Array = [ ];
		public static const REPLACEABLE_UPGRADES_ARR:Array = [ 
			[ MM_SUPER_ARM, MM_ENERGY_BALANCER ], [ MM_METAL_BLADE, MM_ENERGY_BALANCER ], [ MM_HARD_KNUCKLE, MM_ENERGY_BALANCER ], 
			[ MM_PHARAOH_SHOT, MM_ENERGY_BALANCER ], [ MM_CHARGE_KICK, MM_ENERGY_BALANCER ], [ MM_FLAME_BLAST, MM_ENERGY_BALANCER ], 
			[ MM_MAGMA_BAZOOKA, MM_ENERGY_BALANCER], [ MM_WATER_SHIELD, MM_ENERGY_BALANCER ], [ MM_SCREW_CRUSHER, MM_ENERGY_BALANCER ]
		];
		public static const ICON_ORDER_ARR:Array = [ MM_SUPER_ARM, MM_METAL_BLADE, MM_HARD_KNUCKLE, MM_PHARAOH_SHOT, MM_CHARGE_KICK, MM_FLAME_BLAST, MM_MAGMA_BAZOOKA, MM_WATER_SHIELD, MM_SCREW_CRUSHER, MM_ENERGY_BALANCER ];
		public static const AMMO_ARR:Array = [ [ MM_SUPER_ARM, MAX_WPN_ENGY, MAX_WPN_ENGY ], [ MM_METAL_BLADE, MAX_WPN_ENGY, MAX_WPN_ENGY ], [  MM_HARD_KNUCKLE, MAX_WPN_ENGY, MAX_WPN_ENGY ],
			[  MM_PHARAOH_SHOT, MAX_WPN_ENGY, MAX_WPN_ENGY ], [  MM_CHARGE_KICK, MAX_WPN_ENGY, MAX_WPN_ENGY ], [  MM_FLAME_BLAST, MAX_WPN_ENGY, MAX_WPN_ENGY ], [  MM_MAGMA_BAZOOKA, MAX_WPN_ENGY, MAX_WPN_ENGY ], [ MM_WATER_SHIELD, MAX_WPN_ENGY, MAX_WPN_ENGY ], [ MM_SCREW_CRUSHER, MAX_WPN_ENGY, MAX_WPN_ENGY ] ];
		public static const AMMO_DCT:CustomDictionary = new CustomDictionary();
		public static const AMMO_DEPLETION_ARR:Array = [ [ MM_SUPER_ARM, 8 ], [ MM_METAL_BLADE, 2 ], [ MM_HARD_KNUCKLE, 8 ], [ MM_PHARAOH_SHOT, 4], 
			[ MegaManProjectile.TYPE_PHARAOH_BALLOON, 8 ], [MM_CHARGE_KICK, 4 ], [MM_FLAME_BLAST, 4 ], [ MM_MAGMA_BAZOOKA, 2 ], [ MegaManProjectile.TYPE_MAGMA_BAZOOKA_CHARGE, 12 ], [ MM_WATER_SHIELD, 16 ], [ MM_SCREW_CRUSHER, 2 ] ];
		public static const DROP_ARR:Array = [			
			[ 0, MM_WEAPON_ENERGY_SMALL ],
			[ .825, MM_WEAPON_ENERGY_BIG ] 
		];
		public static const SKIN_PREVIEW_SIZE:Point = new Point(33,33);
		public static const SKIN_ORDER:Array = [ 
			SKIN_BASS_NES, 
			SKIN_BASS_SNES, 
			SKIN_BASS_GB, 
			SKIN_BASS_X1, 
			SKIN_BASS_ATARI, 
			SKIN_DR_WILY_NES, 
			SKIN_DR_WILY_SNES, 
			SKIN_MR_X_NES, 
			SKIN_MR_X_SNES, 
			SKIN_DR_COSSACK_NES, 
			SKIN_DR_COSSACK_SNES, 
			SKIN_QUICK_MAN_NES, 
			SKIN_QUICK_MAN_SNES, 
			SKIN_GEMINI_MAN_NES, 
			SKIN_GEMINI_MAN_SNES, 
			SKIN_SKULL_MAN_NES 
		];
		
		public static const SKIN_BASS_NES:int = 0;
		public static const SKIN_BASS_SNES:int = 1;
		public static const SKIN_BASS_GB:int = 2;
		public static const SKIN_DR_WILY_NES:int = 3;
		public static const SKIN_DR_WILY_SNES:int = 4;
		public static const SKIN_MR_X_NES:int = 5;
		public static const SKIN_MR_X_SNES:int = 6;
		public static const SKIN_QUICK_MAN_NES:int = 7;
		public static const SKIN_QUICK_MAN_SNES:int = 8;
		public static const SKIN_BASS_ATARI:int = 9;
		public static const SKIN_DR_COSSACK_NES:int = 10;
		public static const SKIN_DR_COSSACK_SNES:int = 11;
		public static const SKIN_BASS_X1:int = 12;
		public static const SKIN_GEMINI_MAN_NES:int = 13;
		public static const SKIN_GEMINI_MAN_SNES:int = 14;
		public static const SKIN_SKULL_MAN_NES:int = 15;
		
		public static const SPECIAL_SKIN_NUMBER:int = SKIN_BASS_X1;
		public static const ATARI_SKIN_NUMBER:int = SKIN_BASS_ATARI;
		
		public static const TITLE_SCREEN_UPGRADES:Array = [ MUSHROOM ];
		public static const AMMO_DEPLETION_DCT:CustomDictionary = new CustomDictionary(); 
		public static const WIN_SONG_DUR:int = 5480;
		public static const CHAR_SEL_END_DUR:int = 1700;
		public static const BULLET_Y_PAD_BOT_ON_GROUND:int = 27;
		public static const BULLET_Y_PAD_BOT_OFF_GROUND:int = 35;
		private const CHOOSE_CHAR_SEQ:Array = [
			[1,pressRhtBtn], [0,pressDwnBtn], [47,pressJmpBtn], [136,relJmpBtn], [220,pressJmpBtn], [83,relDwnBtn], [334,relJmpBtn]  
		];
		public function Bass()
		{
			inheritedForceShortClassName = "MegaMan";
			super();
			if (skinNum != SKIN_QUICK_MAN_NES && skinNum != SKIN_QUICK_MAN_SNES)
			{
				_usesHorzObjs = false;
				_usesVertObjs = false;
			}
			else
			{
				_usesHorzObjs = true;
				_usesVertObjs = true;
			}
			defWeapon = MM_BASS_BUSTER;
			canDashJump = true;
			doubleJumpSkill = true;
			showHead = false;
		}
		override public function chooseCharacter():void
		{
			super.chooseCharacter();
			var seq:CharacterSequencer = new CharacterSequencer();
			seq.startNewSequence(CHOOSE_CHAR_SEQ);
		}
		
		override protected function get classicWeapon():String
		{
			return getClassicWeapon(GameSettings.bassWeapon);
		}
		
		override public function pressSelBtn():void
		{
			super.pressSelBtn();
			if (secondaryWeapon != null && secondaryWeapon != MM_CHARGE_KICK)
				attackButtonsAreSwapped = !attackButtonsAreSwapped;
		}
	}
}