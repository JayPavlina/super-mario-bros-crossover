﻿package com.smbc.characters
	
		{
			return _skinShootHeightOffset;
		}
		{
			return _skinShootSound;
		}
		{
			if (upgradeIsActive(SAMUS_VARIA_SUIT) || (GameSettings.classicMode && upgradeIsActive(FIRE_FLOWER) ) )
		}
		{
			super.prepareDrawCharacter(skinAppearanceState);
		}
		{
			takeDamageEnd();
		}
		{
//			if (REPOSITION_BULLETS_DCT[skinNum] != undefined && (currentLabel == FL_WALK_SHOOT_START || currentLabel == FL_WALK_SHOOT_2 || currentLabel == FL_WALK_SHOOT_END ) )
		}
		{
			if (upgradeIsActive(SAMUS_HIGH_JUMP))
		}
		override public function hitEnemy(enemy:Enemy, side:String):void
		{
				super.hitEnemy(enemy, side);
		}
		override protected function attackObjPiercing(obj:IAttackable):void
		
		{
				setMaxAmmo(SAMUS_MISSILE,MISSILE_EXPANSION_MAX_AMMO);
		}
		{
					dropArr = DROP_ARR_MISSILES;
		}
		{
			if ( !upgradeIsActive(SAMUS_MISSILE) )
		}
		{
			flip = true;
		}
		{
			flip = false;
		}
		{
			var infiniteAmmo:Boolean = false;
		}
		{
			super.charSelectInitiate();