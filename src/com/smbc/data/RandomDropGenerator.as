package com.smbc.data
{
	import com.smbc.characters.Bass;
	import com.smbc.characters.Character;
	import com.smbc.characters.MegaMan;
	import com.smbc.characters.Samus;
	import com.smbc.characters.Sophia;
	import com.smbc.enemies.Enemy;
	import com.smbc.ground.Brick;
	import com.smbc.level.CharacterSelect;
	import com.smbc.level.Level;
	import com.smbc.level.TitleLevel;
	import com.smbc.main.LevObj;
	import com.smbc.managers.StatManager;
	import com.smbc.pickups.Pickup;
	import com.smbc.pickups.SamusPickup;
	import com.smbc.utils.GameLoopTimer;
	
	import flash.events.TimerEvent;

	public class RandomDropGenerator extends PickupInfo
	{
		private static const IND_DR:int = 0;
		private static const IND_PU_TYPE:int = 1;
		private static const DROP_RATE_NAME:String = "_DROP_RATE";
		private static const DROPS_ARR_NAME:String = "_DROPS_ARR";
		private static const FL_SAMUS_MISSILE_END:String = "samusMissileEnd";
		private static const LINK_DROP_RATE:Number = .25;
		private static const MEGA_MAN_DROP_RATE:Number = .25;
		private static const RYU_DROP_RATE:Number = .25;
		private static const SAMUS_DROP_RATE:Number = .25;
		private static const SIMON_DROP_RATE:Number = .25;
		private static const SOPHIA_DROP_RATE:Number = .25;
		private static const DROP_RATE_BRICK_MULTIPLIER:Number = .25;
		private static const DROP_RATE_COIN_BLOCK_MULTIPLIER:Number = .5;
//		if random num is greater than number next to pickup, it will pick it
		
		

		public static function checkDropItem(type:String,source:LevObj):Boolean
		{
			if (type == Bass.CHAR_NAME_CAPS)
				type = MegaMan.CHAR_NAME_CAPS;
			var level:Level = Level.levelInstance;
			if (level == null)
				return false;
			var player:Character = level.player;
			if (player == null)
				return false;
			var dropRate:Number = player.dropRate + GameSettings.itemDropRate.dropRateOffset;
			if (source is Brick)
			{
				if ( (source as Brick).item == null)
					dropRate *= DROP_RATE_BRICK_MULTIPLIER;
				else
					dropRate *= DROP_RATE_COIN_BLOCK_MULTIPLIER;
			}
			if (GameSettings.DEBUG_MODE && GameSettings.ALWAYS_DROP_ITEMS)
				dropRate = 1;
			var ran:Number = Math.random();
			if ( ran > dropRate || level is CharacterSelect || level is TitleLevel )
				return false;
			var dropArr:Array = player.dropArr;
			if (!dropArr || !dropArr.length)
				return false;
			var n:int = dropArr.length;
			var puType:String;
			ran = Math.random();
			for (var i:int = n - 1; i >= 0; i--) 
			{
				if (ran >= dropArr[i][IND_DR])
				{
					puType = dropArr[i][IND_PU_TYPE];
					break;
				}
			}
			var pickupClass:Class = getPickupClass( StatManager.STAT_MNGR.curCharNum );
			var pickup:Pickup = new pickupClass(puType);
			pickup.appearFromObject(source);
			level.addToLevel( pickup );
			return true;
		}
	}
}