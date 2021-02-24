package com.smbc.data
{
	public final class DamageValue
	{
		/*
		weakest weapon is MEGA_MAN_BASS_BUSTER = 50 (not counting HOLY_WATER_BOTTLE)
		strongest weapon is tied between LINK_BOMB and MEGA_MAN_HARD_KNUCKLE = 800 (not counting MARIO_FIRE_BALL and SAMUS_SCREW_ATTACK)
		*/
		
		public static var dmgMult:Number;
		
		public static const BILL_NORMAL_SHOT:int = 100;
		public static const BILL_LASER:int = 100;
		public static const BILL_FLARE:int = 200;
		public static const BILL_MACHINE_GUN:int = 125;
		public static const BILL_SPREAD:int = 125;
				
		public static const LINK_ARROW:int = 350;
		public static const LINK_BOMB:int = 800;
		public static const LINK_SWORD_1:int = 200;
		public static const LINK_SWORD_2:int = 275;
		public static const LINK_SWORD_3:int = 400;
		public static const LINK_SHOOTING_SWORD:int = 200;
		
		public static const MARIO_FIRE_BALL:int = 1000;
		
		public static const MEGA_MAN_BASS_BUSTER:int = 50;
		public static const MEGA_MAN_MEGA_BUSTER:int = 100;
		public static const MEGA_MAN_SUPER_ARM:int = 800;
		public static const MEGA_MAN_SUPER_ARM_DEBRIS:int = 250;
		public static const MEGA_MAN_CHARGE_KICK:int = 350;
		public static const MEGA_MAN_FLAME_BLAST_BULLET:int = 350; //up from 300, to improve damage/cost ratio in relation to other weapons
		public static const MEGA_MAN_FLAME_BLAST_FLAME:int = 350; //up from 300, to improve damage/cost ratio in relation to other weapons
		public static const MEGA_MAN_METAL_BLADE:int = 150;
		public static const MEGA_MAN_HARD_KNUCKLE:int = 800;
		public static const MEGA_MAN_MAGMA_BAZOOKA:int = 100;
		public static const MEGA_MAN_MAGMA_BAZOOKA_CHARGE:int = 300;
		public static const MEGA_MAN_PHARAOH_SHOT_SMALL:int = 150;
		public static const MEGA_MAN_PHARAOH_SHOT_MEDIUM:int = 200;
		public static const MEGA_MAN_PHARAOH_SHOT_BIG:int = 400;
		public static const MEGA_MAN_SCREW_CRUSHER:int = 175;
		public static const MEGA_MAN_WATER_SHIELD:int = 275;
		public static const MEGA_MAN_WEAK_CHARGE_NORMAL:int = 200;
		public static const MEGA_MAN_FULL_CHARGE_NORMAL:int = 300;

//		Old Mega Man fire shot values
		public static const MEGA_MAN_SHOT_FIRE:int = 150;
		public static const MEGA_MAN_WEAK_CHARGE_FIRE:int = 200;
		public static const MEGA_MAN_FULL_CHARGE_FIRE:int = 400;
		
		public static const PIT_SHORT_ARROW:int = 300; // 125;
		public static const PIT_LONG_ARROW:int = 300; // 225;
		public static const PIT_FIRE_ARROW:int = 300;
		public static const PIT_FIREBALL:int = 300;
		public static const PIT_SHIELD:int = 300; // 100;
		
		public static const RYU_ART_OF_FIRE_WHEEL:int = 400;
		public static const RYU_FIRE_DRAGON_BALL:int = 400;
		public static const RYU_SWORD:int = 400;
		public static const RYU_SHURIKEN:int = 300;
		public static const RYU_WINDMILL_SHURIKEN:int = 300;
		public static const RYU_JUMP_SLASH:int = 800;
		
		public static const SAMUS_SCREW_ATTACK:int = int.MAX_VALUE / 4;
		public static const SAMUS_SHORT_BEAM:int = 150;
		public static const SAMUS_ICE_BEAM:int = 125;
		public static const SAMUS_LONG_BEAM:int = 150;
		public static const SAMUS_MISSILE:int = 400;
		public static const SAMUS_WAVE_BEAM:int = 225;
		public static const SAMUS_BOMB:int = 400;
		
		public static const SIMON_SHORT_WHIP:int = 200;
		public static const SIMON_MORNING_STAR:int = 275;
		public static const SIMON_FLAME_WHIP:int = 400;
		public static const SIMON_AXE:int = 350;
		public static const SIMON_CROSS:int = 300;
		public static const SIMON_DAGGER:int = 300;
		public static const SIMON_HOLY_WATER_BOTTLE:int = 50;
		public static const SIMON_HOLY_WATER_FLAME:int = 200;
		
		public static const SOPHIA_BULLET_NORMAL:int = 100;
		public static const SOPHIA_BULLET_HYPER:int =  200;
		public static const SOPHIA_BULLET_CRUSHER:int = 300;
		public static const SOPHIA_MISSILE:int = 400;
		
		public static const VIC_BULLET:int = 200;
		
		public static const FIGHTER_SWORD:int = 300;
		public static const THIEF_ATTACK:int = 50;
		public static const BLACK_MAGE_ICE:int = 400;
		public static const BLACK_MAGE_FIRE:int = 400;
		public static const BLACK_MAGE_BOLT:int = 600;
	}
}