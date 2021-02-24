package com.smbc.pickups
{
	import com.smbc.characters.Character;
	import com.smbc.characters.Sophia;
	import com.smbc.data.SoundNames;

	public class SophiaPickup extends Pickup
	{
		public function SophiaPickup(type:String=null)
		{
			super(type);
		}
		override public function touchPlayer(char:Character):void
		{
			super.touchPlayer(char);
			SND_MNGR.playSound(SoundNames.SFX_SOPHIA_GET_PICKUP);
		}
	}
}