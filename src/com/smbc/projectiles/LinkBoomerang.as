﻿package com.smbc.projectiles
	
		{
			super.drawObj();
		}
		override public function confirmedHit(mc:IAttackable,damaged:Boolean = true):void
		{
			
		}
			
		private function movePickups():void
		{
			for each (var pickup:Pickup in GRABBED_ITEMS_DCT)
		{
			if (pickup.boomerangGrabbable && !pickup.destroyed && !GRABBED_ITEMS_DCT[pickup])