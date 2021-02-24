package com.smbc.pickups
{
	import com.explodingRabbit.cross.gameplay.statusEffects.StatusProperty;
	import com.explodingRabbit.utils.CustomDictionary;
	import com.smbc.data.PickupInfo;

	public class MegaManPickup extends Pickup
	{
		private static const INITIAL_VY:int = -200;
		private static var playTypesArr:Array = [ PickupInfo.MEGA_MAN_WEAPON_ENERGY_BIG,
			PickupInfo.MEGA_MAN_WEAPON_ENERGY_SMALL, PickupInfo.MEGA_MAN_ENERGY_BALANCER ];
		private static const PLAY_TYPES:CustomDictionary = new CustomDictionary();
		{(function ():void{
			for each (var item:String in playTypesArr)
			{
				PLAY_TYPES.addItem(item);
			}
			playTypesArr = null;
		}() );}
		public function MegaManPickup(type:String=null)
		{
			super(type);
		}
		override public function initiate():void
		{
			super.initiate();
			if (!inBox)
			{
				defyGrav = false;
				vy = INITIAL_VY;
			}
			if (PLAY_TYPES[type])
				stopAnim = false;
			addAllGroundToHitTestables();
			trace("pickup x: "+x);
//			addHitTestableItem(HT_PROJECTILE_CHARACTER);
//			addProperty( new StatusProperty(
		}
		
		override public function checkFrame():void
		{
			if (previousFrameLabelIs( mainFrameLabel + "End" ) )
				gotoAndStop(mainFrameLabel);
		}
	}
}