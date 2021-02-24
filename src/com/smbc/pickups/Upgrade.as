package com.smbc.pickups
{
	import com.smbc.characters.Character;
	import com.smbc.characters.Link;
	import com.smbc.data.GameSettings;
	import com.smbc.data.PickupInfo;
	import com.smbc.level.Level;
	import com.smbc.managers.StatManager;

	public class Upgrade extends Pickup
	{

		
		public function Upgrade(type:String)
		{
			super();
			this.type = type;
			mainType = PickupInfo.MAIN_TYPE_UPGRADE;
			gotoAndStop(type);
			stopAnim = true;
		}
	}
}