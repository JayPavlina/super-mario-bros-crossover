package com.smbc.sound {

	import com.smbc.level.Level;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.media.*;
	import flash.utils.ByteArray;

	
	public class SoundEffect extends SoundContainer
	{
		
		public function SoundEffect(soundName:String, soundData:ByteArray = null)
		{ 
			super(soundName,soundData);
			if (!SND_MNGR.muteSfx)
				playSound();
			else
				cleanUp();
		}
		override protected function setUpSoundTransform():void
		{
			var volInt:int = SND_MNGR.SND_LEV_DCT[this.soundName] - SND_MNGR.sfxVolMinusNum;
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