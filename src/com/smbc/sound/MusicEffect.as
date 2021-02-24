package com.smbc.sound {
	import flash.media.SoundTransform;
	import flash.utils.ByteArray;
	
	public class MusicEffect extends SoundContainer
	{
		
		public function MusicEffect(soundName:String, soundData:ByteArray = null)
		{ 
			super(soundName,soundData);
			if (!SND_MNGR.muteMusic)
				playSound();
			else
				cleanUp();
		}
		override protected function setUpSoundTransform():void
		{
			var volInt:int = SND_MNGR.SND_LEV_DCT[this.soundName] - SND_MNGR.musicVolMinusNum;
			if (volInt < 0)
				volInt = 0;
			var volDec:Number = 0;
			if (volInt > 0)
				volDec = volInt / SND_MNGR.SND_LEV_DIVISOR;
			transform = new SoundTransform(volDec);
			super.setUpSoundTransform();
		}
	}
	
}