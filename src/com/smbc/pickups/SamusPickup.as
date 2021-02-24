package com.smbc.pickups
{
	import com.chewtinfoil.utils.StringUtils;
	import com.explodingRabbit.utils.StringUtils;
	import com.smbc.characters.Character;
	import com.smbc.characters.Samus;
	import com.smbc.data.AnimationTimers;
	import com.smbc.data.PaletteTypes;
	import com.smbc.data.SoundNames;
	import com.smbc.utils.GameLoopTimer;

	public class SamusPickup extends Pickup
	{
		public function SamusPickup(type:String=null,x:Number = NaN,y:Number = NaN)
		{
			super(type);
			if ( !isNaN(x) )
				this.x = x;
			if ( !isNaN(y) )
				this.y = y;
			if (mainFrameLabel)
			{
				flashTmr = new GameLoopTimer(AnimationTimers.DEL_MIN_FAST);
				paletteObjectName = com.chewtinfoil.utils.StringUtils.capitalize( mainFrameLabel );
				paletteObjectName = "Samus" + paletteObjectName;
//				trace("palObjName: "+paletteObjectName);
				palOrderArr = [ PaletteTypes.FLASH_GENERAL ];
			}
		}
	}
}