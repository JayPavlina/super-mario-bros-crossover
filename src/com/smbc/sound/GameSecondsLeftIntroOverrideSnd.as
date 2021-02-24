package com.smbc.sound
{
	import com.smbc.managers.EventManager;
	
	import flash.events.Event;
	
	public final class GameSecondsLeftIntroOverrideSnd extends BackgroundMusic
	{
		public function GameSecondsLeftIntroOverrideSnd(soundName:String)
		{
			super(soundName);
		}
		override protected function playSound():void
		{
			channel = sound.play();
			if (channel)
			{
				channel.addEventListener(Event.SOUND_COMPLETE,soundCompleteLsr,false,0,true);
				if (transform)
					channel.soundTransform = transform;
			}
		}
		override protected function soundCompleteLsr(e:Event):void
		{
			super.originalSoundCompleteLsr(e);
			EventManager.EVENT_MNGR.secondsLeftStart();
		}
	}
}