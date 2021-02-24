package com.smbc.projectiles
{
	import com.smbc.characters.VicViper;
	import com.smbc.data.DamageValue;
	import com.smbc.data.SoundNames;
	import com.smbc.main.LevObj;
	
	public class VicViperProjectile extends Projectile
	{
		
		public static const SN_SHOOT:String = SoundNames.SFX_VIC_SHOOT;
		
		public function VicViperProjectile(vic:VicViper)
		{
			super(vic,SOURCE_TYPE_PLAYER);
			_damageAmt = DamageValue.VIC_BULLET;
			vx = 600;
			vy = 0;
			x = vic.hRht;
			y = vic.ny - 8;
//			gotoAndStop("starSmallStart");
			stopAnim = true;
			defyGrav = true;
			
			SND_MNGR.playSound(SN_SHOOT);
		}
		override protected function updateStats():void
		{
			super.updateStats();
//			trace("x: "+x+" y: "+y);
		}
	}
}