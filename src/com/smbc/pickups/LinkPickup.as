package com.smbc.pickups
{
	import com.smbc.characters.Character;
	import com.smbc.data.PickupInfo;
	
	import flash.utils.Endian;

	public class LinkPickup extends Pickup
	{
		public function LinkPickup(type:String)
		{
			super(type);
		}
		
		override public function touchPlayer(char:Character):void
		{
			if (mainType != MAIN_TYPE_UPGRADE && type != PickupInfo.MUSHROOM && type != PickupInfo.LINK_BOMB_AMMO)
				destroy();
		}
		
		
	}
}