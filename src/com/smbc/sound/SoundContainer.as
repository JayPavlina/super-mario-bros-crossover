package com.smbc.sound
{
	import com.explodingRabbit.cross.data.ConsoleType;
	import com.explodingRabbit.utils.ByteArrayUtils;
	import com.gme.GameMusicEmu;
	import com.smbc.data.Cheats;
	import com.smbc.data.GameSettings;
	import com.smbc.data.GameStates;
	import com.smbc.data.SoundNames;
	import com.smbc.enums.CoinSoundType;
	import com.smbc.managers.GameStateManager;
	import com.smbc.managers.SoundManager;
	
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.events.SampleDataEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import flash.utils.getTimer;

	public class SoundContainer
	{
		public static const NUM_BYTES_PER_CYCLE:int = 65536;
		public static const VT_MUSIC:String = "music";
		public static const VT_SFX:String = "sfx"; // VT = Volume Type
		public static const BT_BGM:String = "bgm";
		public static const BT_LOOPING_SFX:String = "loopingSfx";
		public static const BT_MUSIC_EFFECT:String = "musicEffect";
		public static const BT_OVERRIDE:String = "override"; // for custom classes that override this one
		public static const BT_SFX:String = "sfx"; // BT = Behavior Type
		private static const QUIET_COINS_VOLUME:Number = .25;
		public var loop:Boolean;
//		private static const bytesToMsFct:Function = ByteArrayUtils.bytesToMs;
		private static const msToBytesFct:Function = ByteArrayUtils.msToBytes;
		private var loopPnt:int; // the point the sound loops back to
		protected var volType:String;// volume type
		public var soundType:String; // behavior type
		private var offset:uint;
		public static var volume:int;
		private var startTime:int;
		protected var channel:SoundChannel = new SoundChannel();
		protected var _cPos:Number = 0;
		protected const SND_MNGR:SoundManager = SoundManager.SND_MNGR;
		protected const SND_NAME_SUFFIX:String = SoundManager.SND_NAME_SUFFIX;
		protected const SND_LOC_STR:String = SoundManager.SND_LOC_STR;
		private static const SOUND_COMPLETE_EVENT:Event = new Event(Event.SOUND_COMPLETE);
		private static const SOUND_TRANSFORM_ZERO:SoundTransform = new SoundTransform(0);
		private var _soundName:String;
		public var soundClass:Class;
		private var soundData:ByteArray;
		protected var transform:SoundTransform;
		public var sound:Sound;
		protected var _paused:Boolean;
		private var musicArr:Array;
		private static const ZERO_BYTE_ARRAY:ByteArray = new ByteArray();
		private static const MAX_LOOPS_IN_ONE_CYCLE:int = 5;
		private static var IND_VOLUME:int; // initialized by sound manager
		{
			(function ():void
			{
				while (ZERO_BYTE_ARRAY.length < NUM_BYTES_PER_CYCLE)
				{
					ZERO_BYTE_ARRAY.writeFloat(0);
				}
				ZERO_BYTE_ARRAY.position = 0;
			}() );
		}
//		public var byte
		public static function initiateClass():void // called once by sound manager
		{
			IND_VOLUME = MusicInfo.IND_VOLUME;
		}
		
		public function SoundContainer(soundName:String, soundData:ByteArray = null)
		{
			this._soundName = soundName;
			soundClass = SoundInfo[_soundName] as Class;
			initiate();
			if (soundData)
			{
//				this.soundData = new ByteArray();
//				this.soundData.endian = Endian.LITTLE_ENDIAN;
//				this.soundData.writeBytes(soundData);
				this.soundData = soundData;
				soundData.position = 0;
				startTime = getTimer();
//				trace("soundData.length: "+soundData.length);
				sound = new Sound();
				setUpSoundTransform();
				playSound();
			}
			else
			{
				sound = Sound( new soundClass() );
				setUpSoundTransform();
			}
		}
		protected function initiate():void
		{
			musicArr = SND_MNGR.getMusicArr(soundName,ConsoleType.BIT_8);
			if (musicArr)
				soundType = musicArr[MusicInfo.IND_SOUND_TYPE];
//			trace("soundType: "+soundType);
			switch(soundType)
			{
				case BT_SFX:
				{
					volType = VT_SFX;
					break;
				}
				case BT_LOOPING_SFX:
				{
					volType = VT_SFX;
					loop = true;
					break;
				}
				case BT_MUSIC_EFFECT:
				{
					volType = VT_MUSIC;
					break;
				}
			}
			if (loop)
			{
				loopPnt = msToBytesFct(musicArr[MusicInfo.IND_LOOP_PNT]);
			}
		}
		protected function setUpSoundTransform():void
		{
			var minusNum:int = SND_MNGR.sfxVolMinusNum;
			if (volType == VT_MUSIC)
				minusNum = SND_MNGR.musicVolMinusNum;
			var volInt:int
			if (musicArr)
				volInt = musicArr[IND_VOLUME] - minusNum;
			else
				volInt = SND_MNGR.SND_LEV_DCT[this.soundName] - minusNum;
			if (volInt < 0)
				volInt = 0;
			var volDec:Number = 0;
			if (volInt > 0)
				volDec = volInt / SND_MNGR.SND_LEV_DIVISOR;
			if (GameSettings.coinSoundType != CoinSoundType.Normal && _soundName == SoundNames.SFX_GAME_COIN && GameStateManager.GS_MNGR.gameState != GameStates.PAUSE)
			{
				if (GameSettings.coinSoundType == CoinSoundType.Quiet)
					volDec = QUIET_COINS_VOLUME;
				else
					volDec = 0;
			}
			transform = new SoundTransform(volDec);
		}
		protected function playSound():void
		{
			if (soundData)
				sound.addEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData, false, 0, true);
			if (loop && !soundData)
				channel = sound.play(_cPos,int.MAX_VALUE);
			else
				channel = sound.play(_cPos);
			if (channel)
			{
				channel.addEventListener(Event.SOUND_COMPLETE,soundCompleteLsr,false,0,true);
				if (transform)
				{
//					channel.soundTransform = new SoundTransform();
//					channel.soundTransform.volume = 1;
					channel.soundTransform = transform;
				}
			}
			else
				cleanUp();
		}
		public function pauseSound():void
		{
			if (_paused || !channel)
				return;
			if (soundData)
				_cPos = soundData.position;
			else
				_cPos = channel.position;
			stopSound();
			_paused = true;			
		}
		public function resumeSound():void
		{
			if (!_paused)
				return;
			_paused = false;
			if (soundData)
			{
				soundData.position = _cPos;
				_cPos = 0;
			}
			playSound();
		}
		public function stopSound():void
		{
			if (soundData && sound)
			{
				sound.removeEventListener(SampleDataEvent.SAMPLE_DATA,onSampleData);
				soundData.position = 0;
			}
			if (channel)
			{
				channel.soundTransform = SOUND_TRANSFORM_ZERO;
					channel.removeEventListener(Event.SOUND_COMPLETE,soundCompleteLsr);
				channel.stop();
			}
			_paused = false;
			_cPos = 0;
		}
		public function cleanUp():void
		{
			stopSound();
//			if (soundData)
//				soundData.clear();
			sound = null;
			channel = null;
			SND_MNGR.SOUNDS_TO_PLAY_DCT.removeItem(soundName);
			SND_MNGR.CUR_SNDS_DCT.removeItem(soundName);
			SND_MNGR.P_SND_DCT.removeItem(soundName);
		}
		protected function onSampleData(event:SampleDataEvent):void
		{
			var data:ByteArray = event.data;
			data.endian = Endian.LITTLE_ENDIAN;
			if (soundData.bytesAvailable >= NUM_BYTES_PER_CYCLE)
			{
				soundData.readBytes( data, 0, NUM_BYTES_PER_CYCLE);
				data.position += NUM_BYTES_PER_CYCLE;
//				trace("soundData.bytesAvailable: "+soundData.bytesAvailable );
			}
			else if (soundData.bytesAvailable || loop) // writes extra stuff at end of loop
			{
//				var bytesWritten:int = writeRemainingBytes(data);
				var numBytesWritten:int = soundData.bytesAvailable;
				soundData.readBytes( data, 0, soundData.bytesAvailable);
				var numBytesToWrite:int = NUM_BYTES_PER_CYCLE - numBytesWritten;
				if (loop)
				{
					var numLoops:int;
					while (numBytesWritten < NUM_BYTES_PER_CYCLE && numLoops < MAX_LOOPS_IN_ONE_CYCLE)
					{
						numBytesToWrite = NUM_BYTES_PER_CYCLE - numBytesWritten;
						soundData.position = loopPnt;
						if (soundData.bytesAvailable < numBytesToWrite)
							numBytesToWrite = soundData.bytesAvailable;
						soundData.readBytes( data, numBytesWritten, numBytesToWrite);
						numBytesWritten += numBytesToWrite;
						numLoops++;
					}					
				}
				else if (numBytesWritten < NUM_BYTES_PER_CYCLE)
				{
					ZERO_BYTE_ARRAY.readBytes( data, numBytesWritten, numBytesToWrite);
					ZERO_BYTE_ARRAY.position = 0;
				}
				data.position = numBytesWritten;
			}
		}
		/*private function writeRemainingBytes(data:ByteArray,numBytesToWrite:int = NUM_BYTES_PER_CYCLE):int
		{
			var bytesWritten:int
			while (soundData.bytesAvailable && bytesWritten < numBytesToWrite)
			{
				var sample:Number = soundData.readFloat();
				data.writeFloat( sample );
				data.writeFloat( sample );
				soundData.position += 4;
				bytesWritten += 8;	
			}
			return bytesWritten;
		}*/
		protected function soundCompleteLsr(e:Event):void
		{
			soundIsFinishedPlaying();
		}
		private function soundIsFinishedPlaying():void
		{
//			trace("sound time: "+ (getTimer() - startTime ));
			if (loop)
			{
				if (soundData)
					soundData.position = loopPnt;
				else
					playSound();
			}
			else
				cleanUp();
		}
		public function get soundName():String
		{
			return _soundName;
		}
		public function get cPos():Number
		{
			return _cPos;
		}
		public function get paused():Boolean
		{
			return _paused;
		}
		public static function initateCustomSoundClasses():void
		{
			var megaManChargeStartSnd:MegaManChargeStartSnd;
		}
	}
}