package com.gme
{
	
	import com.explodingRabbit.cross.sound.Song;
	import com.explodingRabbit.utils.ByteArrayUtils;
	import com.smbc.data.GameSettings;
	import com.smbc.data.MusicQuality;
	import com.smbc.events.CustomEvents;
	import com.smbc.managers.SoundManager;
	import com.smbc.sound.MusicEffect;
	import com.smbc.sound.SoundContainer;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.SampleDataEvent;
	import flash.events.TimerEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.sampler.Sample;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import sample.libgme.CModule;
	
	public class GameMusicEmu extends EventDispatcher
	{
		
		public static const BYTE_LENGTH:int = 8192*2;
		public static const SAMPLE_RATE:int = 44100;
		public static const NUM_BYTES_PER_CHANNEL:int = 4;
		public static const NUM_BYTES_PER_SAMPLE:int = 8; 
		public static const NUM_BYTES_PER_SECOND:int = SAMPLE_RATE * NUM_BYTES_PER_SAMPLE; 
		private static const NUM_BYTES_PER_READ:int = SoundContainer.NUM_BYTES_PER_CYCLE;
		
		private static const NUM_SAMPLES:int = 8192*2;
		private static const NUM_BYTES:int = NUM_SAMPLES*2;
		private static const NUM_BYTES_FLOAT:int = NUM_BYTES*2;
		private static const NUM_LOOPS:int = NUM_SAMPLES/2;
		
		private static const FLOAT_DIVIDE:int = 32768;
		private static const FLOAT_MULTIPLY:Number = .000030517578125;
		
		private static const bytesToMsFct:Function = ByteArrayUtils.bytesToMs;
		private static const msToBytesFct:Function = ByteArrayUtils.msToBytes;
		
		private static const TRACK_END_EVENT:Event = new Event(CustomEvents.TRACK_END);
//		public static var EMU_VEC:Vector.<GameMusicEmu> = Vector.<GameMusicEmu>([
//			null,
//			new GameMusicEmu(1),
//			new GameMusicEmu(2)
//			/*new GameMusicEmu(3),
//			new GameMusicEmu(4),
//			new GameMusicEmu(5),
//			new GameMusicEmu(6),
//			new GameMusicEmu(7),
//			new GameMusicEmu(8),
//			new GameMusicEmu(9)*/
//			]);
		private var recordedData:ByteArray = new ByteArray();
		public var fadeTmr:Timer;
		private var fadeDelayTmr:Timer;
		private const FADE_TMR_INT:int = 50;
		private var fadeStartTime:int;
		private var fadeDuration:int;
		private var fadeStartVolume:Number;
		public static const QUALITY_LOW:int = 1;
		public static const QUALITY_MID:int = 128;
		public static const QUALITY_HIGH:int = 0;
		public var currentSndClass:Class;
		public var currentTrack:int;
		public var currentSong:Song;
		public var currentArr:Array;
		public var port1:int = -1;
		public var port2:int = -1;
		public var port3:int = -1;
		public var port4:int = -1;
		private var dataPosition:int;
		private var byteArray:ByteArray;
		private var sample:Sample;
//		public var fctToCallOnTrackEnd:Function;
		private var emuPtr:int;
		
//		testing
		private var testTmr:Timer;
		private static const TEST_TMR_DUR:int = 10000;
		private var playStartTime:int;
		private var accumalatedEmuTime:int;
		
		private var _sound:Sound;
		private var sndMngr:SoundManager;
		
		private var _soundChannel:SoundChannel;
		
		private var _soundTransform:SoundTransform;
		
		private var _urlLoader:URLLoader;
		
		private var _isPlaying:Boolean;
		
		private var _isPaused:Boolean;
		
		private var out:ByteArray;
		
		
		private var _volume:Number;
		
		private var _emulatorType:String;
		
		public function get isPlaying():Boolean
		{
			return _isPlaying;
		}
		private var buffer:ByteArray;
		
		public function get isPaused():Boolean
		{
			return _isPaused;
		}
		
		public function get volume():Number
		{
			return _volume;
		}
		
		public function set volume(value:Number):void
		{
			if (value > 1.0)
				value = 1.0;
			if (value < 0.0)
				value = 0.0;
			_volume = value;
			_soundTransform.volume = _volume;
			
			if (_soundChannel != null) {
				_soundChannel.soundTransform = _soundTransform;
			}
		}
		
		public function get pan():Number
		{
			return _soundTransform.pan;
		}
		
		public function set pan(value:Number):void
		{
			if (value > 1.0)
				value = 1.0;
			if (value < -1.0)
				value = -1.0;
			_soundTransform.pan = value;
			
			if (_soundChannel != null) {
				_soundChannel.soundTransform = _soundTransform;
			}
		}
		
		public function get emulatorType():String
		{
			return _emulatorType;
		}
		
		public var emuInd:int;

		private var bufPtr:int;
		private var floatBufPtr:int;
		private var bytesPtr:int;

		public function GameMusicEmu(emuInd:int) 
		{
			this.emuInd = emuInd;
			sndMngr = SoundManager.SND_MNGR;
			_isPlaying = false;
			_volume = 1.0;
			_sound = new Sound();
			_soundTransform = new SoundTransform();
			_emulatorType = "";
			bufPtr = CModule.malloc(NUM_BYTES);
			floatBufPtr = CModule.malloc(NUM_BYTES_FLOAT);
//			trace("emuInd: "+emuInd+" bufPtr: "+bufPtr+" floatBufPtr: "+floatBufPtr);
			out = new ByteArray();
			out.endian = Endian.LITTLE_ENDIAN;
		}
		
		public function freeEmu(removeAllPointers:Boolean = false):void
		{
			libgme.gme_delete(emuPtr);
			emuPtr = 0;
			if (bytesPtr != 0)
				CModule.free(bytesPtr);
			if (removeAllPointers)
			{
				CModule.free(floatBufPtr);
				CModule.free(bufPtr);
			}
		}
		
		public function init(type:String):void 
		{
			if (_emulatorType == type)
				return;
			if (emuPtr != 0)
				freeEmu();
			_emulatorType = type;
			switch (type) 
			{
//				case EmulatorType.AY:
//					emuPtr = libgme.gme_new_emu( libgme.gme_ay_type, SAMPLE_RATE );
//					break;
				case EmulatorType.GBS:
					emuPtr = libgme.gme_new_emu( libgme.gme_gbs_type, SAMPLE_RATE );
					break;
//				case EmulatorType.GYM:
//					emuPtr = libgme.gme_new_emu( libgme.gme_gym_type, SAMPLE_RATE );
//					break;
//				case EmulatorType.HES:
//					emuPtr = libgme.gme_new_emu( libgme.gme_hes_type, SAMPLE_RATE );
//					break;
				case EmulatorType.KSS:
					emuPtr = libgme.gme_new_emu( libgme.gme_kss_type, SAMPLE_RATE );
					break;
				case EmulatorType.NSF:
					emuPtr = libgme.gme_new_emu( libgme.gme_nsf_type, SAMPLE_RATE );
					break;
				case EmulatorType.NSFE:
					emuPtr = libgme.gme_new_emu( libgme.gme_nsfe_type, SAMPLE_RATE );
					break;
				case EmulatorType.SAP:
					emuPtr = libgme.gme_new_emu( libgme.gme_sap_type, SAMPLE_RATE );
					break;
				case EmulatorType.SPC:
					emuPtr = libgme.gme_new_emu( libgme.gme_spc_type, SAMPLE_RATE );
					break;
//				case EmulatorType.VGM:
//					emuPtr = libgme.gme_new_emu( libgme.gme_vgm_type, SAMPLE_RATE );
//					break;
//				case EmulatorType.VGZ:
//					emuPtr = libgme.gme_new_emu( libgme.gme_vgz_type, SAMPLE_RATE );
//					break;
				default:
					_emulatorType = "";
					break;
			}
		}
		
		public function startTrack(value:int):void 
		{
			if (value < 0)
				value = 0;
			libgme.gme_start_track(emuPtr,value);
//			libgme.startTrack(value, emuInd);
		}
		// 0 high quality, 1 no noise, any other number > 0 sets period limit
//		public function setNsfQuality(quality:int):void
//		{
//			libgme.setNsfQuality(quality);
//		}
		public function setSpcPorts():void
		{
//			trace(port1+" "+port2+" "+port3+" "+port4);
//			_libgme.setSpcPorts(port1,port2,port3,port4);
//			libgme.setSpcPorts(port1,port2,port3,port4);
		}
		public function getVoiceCount():void
		{
//			var n:int = libgme.getVoiceCount();
//			for (var i:int; i < n; i++)
//			{
//				
//			}
		}
		public function getVoiceName(voiceNum:int):String
		{
//			return libgme.getVoiceName(voiceNum);
			return null;
		}
		public function muteVoice(voiceNum:int):void
		{
//			libgme.muteVoice(voiceNum,1);
		}
		public function unmuteVoice(voiceNum:int):void
		{
//			libgme.muteVoice(voiceNum,0);
		}
//		public function setPlayerQuality(oRd:int = -1):void
//		{
//			var newQual:int = GameSettings.musicQuality;
//			if (oRd > -1)
//				newQual = oRd;
//			switch(newQual)
//			{
//				case(MusicQuality.LOW):
//				{
//					setNsfQuality(QUALITY_LOW);
//					break;
//				}
//				case(MusicQuality.MID):
//				{
//					setNsfQuality(QUALITY_MID);
//					break;
//				}
//				case(MusicQuality.HIGH):
//				{
//					setNsfQuality(QUALITY_HIGH);
//					break;
//				}
//			}
//		}
		
		public function trackCount():int 
		{
			return libgme.gme_track_count(emuPtr);
//			return libgme.trackCount();
		}
		
		public function trackEnded():Boolean 
		{
			return Boolean(libgme.gme_track_ended(emuPtr));
//			return libgme.trackEnded(emuInd);
		}
		
		public function trackInfo(track:int):void 
		{
			var infoPtr:int;
			libgme.gme_track_info(emuPtr,infoPtr,track);
			var info:track_info_t = track_info_t.create();
			info.swigCPtr = infoPtr;
			trace( CModule.readString( info.game, 255) );
//			return libgme.gme_track_info(emuPtr,infoPtr,track);
//			return libgme.trackInfo(track);
		}
		
		public function tell():int 
		{
			return libgme.gme_tell(emuPtr);
//			return libgme.tell();
		}
		
		public function seek(msec:uint):void 
		{
			libgme.gme_seek(emuPtr,msec);
//			libgme.seek(msec);
		}
		
		public function setTempo(tempo:Number):void 
		{
			libgme.gme_set_tempo(emuPtr,tempo);
//			libgme.setTempo(tempo);
		}
		
		public function setFade(startMsec:int):void 
		{
			libgme.gme_set_fade(emuPtr,startMsec);
//			libgme.setFade(startMsec,emuInd);
		}
		
		public function setStereoDepth(depth:Number):void 
		{
			libgme.gme_set_stereo_depth(emuPtr,depth);
//			libgme.setStereoDepth(depth);
		}

//		public function load(url:String):void 
//		{
//			// load sound file in URL
//			_urlLoader = new URLLoader();
//			_urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
//			_urlLoader.addEventListener(Event.COMPLETE, onLoadComplete);
//			_urlLoader.load(new URLRequest(url));
//		}
		
//		public function loadData(data:ByteArray):void 
//		{
//			data.endian = Endian.LITTLE_ENDIAN;
//			data.position = 0;
//			
//			// uncompress data if EmulatorType is VGZ.
//			if (_emulatorType == EmulatorType.VGZ) {
//				data.writeBytes(data, 10, data.length - 10);
//				data.inflate();
//			}
//			
//			libgme.load(data, data.length);
//			
//			// dispatch event to parent
//			dispatchLoadCompleteEvent();
//		}
		public static function bytesToMs(numBytes:uint):int
		{
			return Math.round( (numBytes/NUM_BYTES_PER_SECOND)*1000 );
		}
		public static function msToBytes(numMs:int,accuracy:int = NUM_BYTES_PER_SAMPLE):uint
		{
			var numBytes:int = Math.round( (numMs/1000)*NUM_BYTES_PER_SECOND );
			var mod:int = numBytes % accuracy;
			if (mod < accuracy/2)
				numBytes -= mod;
			else
				numBytes += accuracy - mod;
			return numBytes;
		}
		private function recordGme(buffer:ByteArray, trackLength:int = 0):void
		{
			if (trackLength == 0)
				trackLength = int.MAX_VALUE;
			var ctr:int;
			while (!libgme.gme_track_ended(emuPtr) && libgme.gme_tell(emuPtr) < trackLength)
			{
				libgme.gme_play_float(emuPtr, NUM_SAMPLES, bufPtr, floatBufPtr);
				CModule.readBytes(floatBufPtr,NUM_BYTES_FLOAT,buffer);
				ctr++;
			}
		}
		public function recordTrack(buffer:ByteArray,trackLength:int = 0):void
		{
			if (buffer)
			{
				var maxBytes:uint = 0;
				if (trackLength)
					maxBytes = msToBytes(trackLength);
				var bufferTemp:ByteArray = new ByteArray();
				bufferTemp.endian = Endian.LITTLE_ENDIAN;
				var startTime:int = getTimer();
				recordGme(bufferTemp, trackLength);
				var recordTime:int = getTimer() - startTime;
				if (trackLength >= 0)
				{
					bufferTemp.position -= NUM_BYTES_PER_SAMPLE;
					var num:Number = bufferTemp.readFloat();
					while (num == 0 && bufferTemp.position != 0)
					{
						bufferTemp.position -= 12;
						num = bufferTemp.readFloat();
					}
					if (bufferTemp.position == 0)
						throw new Error("recorded sound is silent");
					bufferTemp.position += NUM_BYTES_PER_CHANNEL;
					if (maxBytes && bufferTemp.position > maxBytes)
						bufferTemp.position = maxBytes;
					buffer.writeBytes(bufferTemp,0,bufferTemp.position);
					bufferTemp.clear();
				}
				else
				{
					buffer.writeBytes(bufferTemp);
				}
				buffer.position = 0;
			}
			if (buffer && !buffer.bytesAvailable)
				throw new Error("no bytes recorded");
		}
		
		public function play(buffer:ByteArray = null, playEvenIfMuted:Boolean = false):void 
		{
			if (sndMngr.muteMusic && !playEvenIfMuted)
			{
				pause();
				return;
			}
			if (currentSong && currentSong.fadeStart)
				setFade(currentSong.fadeStart);
//			fctToCallOnTrackEnd = null;
			this.buffer = buffer;
			if (_isPaused) 
			{
				_isPaused = false;
				_isPlaying = true;
				_sound.addEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);
				_soundChannel = _sound.play(0, 1, _soundTransform);
				removeFadeTmr();
			}
			else
			{
//				testing
//				playStartTime = getTimer();
//				accumalatedEmuTime = 0;
//				if (testTmr)
//					removeTestTmr();
//				testTmr = new Timer(TEST_TMR_DUR,1);
//				testTmr.addEventListener(TimerEvent.TIMER_COMPLETE, testTmrHandler, false, 0, true);
//				testTmr.start();
				
				_isPaused = false;
				_isPlaying = true;
				_sound.removeEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);
				_sound.addEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);
				
				_soundTransform.volume = _volume;
				_soundChannel = _sound.play(0, 1, _soundTransform);
				removeFadeTmr();
			}
		}
		
		protected function testTmrHandler(event:TimerEvent):void
		{
			removeTestTmr();
			var now:int = getTimer();
			trace("test length: "+(now - playStartTime)+" emu time: "+accumalatedEmuTime+ " average: "+ ( accumalatedEmuTime / (playStartTime/1000 ) ) );
			stop();
		}
		private function removeTestTmr():void
		{
			testTmr.stop();
			testTmr.removeEventListener(TimerEvent.TIMER_COMPLETE, testTmrHandler);
			testTmr = null;
		}
		
		public function stop():void 
		{
			if (this == sndMngr.curMusicPlayer)
				sndMngr.songCurrentlyPlaying = null;
			_isPaused = false;
			_isPlaying = false;
			_sound.removeEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);
			removeFadeTmr();
//			fctToCallOnTrackEnd = null;
			if (_soundChannel != null) {
				_soundChannel.stop();
			}
		}
		
		public function pause():void 
		{
			_isPaused = true;
			_isPlaying = false;
			_sound.removeEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);
			
			if (_soundChannel != null) {
				_soundChannel.stop();
			}
		}
		public function fadeOut(duration:int,delay:int = 0):void
		{
			if (!isPlaying)
				return;
			fadeDuration = duration;
			fadeStartVolume = _volume;
			if (delay != 0)
			{
				fadeDelayTmr = new Timer(delay,1);
				fadeDelayTmr.addEventListener(TimerEvent.TIMER_COMPLETE,fadeDelayTmrHandler,false,0,true);
				fadeDelayTmr.start();
			}
			else
			{
				fadeTmr = null;
				fadeTmr = new Timer(FADE_TMR_INT);
				fadeTmr.addEventListener(TimerEvent.TIMER,fadeTmrHandler,false,0,true);
				fadeTmr.start();
				fadeStartTime = getTimer();
			}
		}
		private function fadeDelayTmrHandler(event:TimerEvent):void
		{
			fadeDelayTmr.stop();
			fadeDelayTmr.removeEventListener(TimerEvent.TIMER_COMPLETE,fadeDelayTmrHandler);
			fadeDelayTmr = null;
			fadeTmr = new Timer(FADE_TMR_INT);
			fadeTmr.addEventListener(TimerEvent.TIMER,fadeTmrHandler,false,0,true);
			fadeTmr.start();
			fadeStartTime = getTimer();
		}
		private function fadeTmrHandler(event:TimerEvent):void
		{
			if (_soundChannel)
			{
				var timePassed:int = getTimer() - fadeStartTime;
				var percentage:Number = timePassed/fadeDuration;
				if (percentage > 1)
					percentage = 1;
				percentage = 1 - percentage;
				_volume = percentage*fadeStartVolume;
				if (_volume < 0)
					_volume = 0;
				_soundTransform.volume = _volume;
				_soundChannel.soundTransform = _soundTransform;
				if (_volume == 0)
				{
					stop();
					removeFadeTmr();
				}
			}
			else
				removeFadeTmr();
		}
		private function removeFadeTmr():void
		{
			if (fadeTmr)
			{
				fadeTmr.stop();
				fadeTmr.removeEventListener(TimerEvent.TIMER,fadeTmrHandler);
				fadeTmr = null;
			}
			if (fadeDelayTmr)
			{
				fadeDelayTmr.stop();
				fadeDelayTmr.removeEventListener(TimerEvent.TIMER_COMPLETE,fadeDelayTmrHandler);
				fadeDelayTmr = null;
			}
		}
		
//		/**
//		 * load complete event for URL Loader
//		 * @param	e
//		 */
//		private function onLoadComplete(e:Event):void 
//		{
//			// sound file's content into ByteArray
//			var data:ByteArray;
//			data = _urlLoader.data as ByteArray;
//			data.endian = Endian.LITTLE_ENDIAN;
//			data.position = 0;
//			
//			// uncompress data if EmulatorType is VGZ.
//			if (_emulatorType == EmulatorType.VGZ) {
//				data.writeBytes(data, 10, data.length - 10);
//				data.inflate();
//			}
//			
//			libgme.load(data, data.length);
//			
//			// dispatch event to parent
//			dispatchLoadCompleteEvent();
//		}
		// added by Exploding Rabbit
		public function loadEmbeddedMusic(musicClass:Class):void
		{
			var data:ByteArray = new musicClass() as ByteArray;
			data.endian = Endian.LITTLE_ENDIAN;
			data.position = 0;
			bytesPtr = CModule.malloc(data.length);
			CModule.writeBytes(bytesPtr, data.length, data as IDataInput);
			handleError( libgme.gme_load_data(emuPtr, bytesPtr, data.length) );
			dispatchLoadCompleteEvent();
		}
		
		private function handleError(err:String):void
		{
			if (err)
				throw new Error(err);
		}
		
		
		private function dispatchLoadCompleteEvent():void 
		{
			var event:Event;
			event = new Event(Event.COMPLETE);
			dispatchEvent(event);
		}
		
		private function onSampleData(e:SampleDataEvent):void 
		{
//			var emuStart:int = getTimer();
			
			handleError( libgme.gme_play_float(emuPtr, NUM_SAMPLES, bufPtr, floatBufPtr) );
			var data:ByteArray = e.data;
			data.endian = Endian.LITTLE_ENDIAN;
			CModule.readBytes(floatBufPtr,NUM_BYTES_FLOAT,data);
			if ( trackEnded() )
				dispatchEvent(TRACK_END_EVENT);
			
//			time testing
//			var now:int = getTimer();
//			accumalatedEmuTime += now - emuStart;
//			var elapsedSincePlay:int = now - playStartTime;
//			trace("emu: "+( now - emuStart )+" test time remaining: "+( testTmr.delay - elapsedSincePlay) );
		}
//		private function onSampleData(e:SampleDataEvent):void 
//		{
//			var emuStart:int = getTimer();
//			handleError( libgme.gme_play(emuPtr, NUM_SAMPLES, bufPtr) );
//			_out.position = 0;
//			CModule.readBytes(bufPtr,NUM_BYTES,_out);
//			var emuEnd:int = getTimer();
//			_out.position = 0;
//			
////			convert to float
//			var data:ByteArray = e.data;
//			
//			for (var i:int = 0; i < NUM_LOOPS; i++) 
//			{
//				data.writeFloat( _out.readShort() / FLOAT_DIVIDE ); // left channel
//				data.writeFloat( _out.readShort() / FLOAT_DIVIDE ); // right channel
//			}
//			var now:int = getTimer();
//			accumalatedEmuTime += now - emuStart;
//			var elapsedSincePlay:int = now - playStartTime;
//			trace("emu : "+( emuEnd - emuStart )+" convert: "+( now - emuEnd )+" test time remaining: "+( testTmr.delay - elapsedSincePlay) );
//		}
		
		/*
		private function onSampleData(e:SampleDataEvent):void 
		{
			var data:ByteArray = e.data;
			
			var length:uint;
			var loop:uint;
			
			switch (_sampleRate) 
			{
				case 44100:
					length = 8192;
					loop = 1;
					break;
				case 22050:
					length = 4096;
					loop = 2;
					break;
				case 11025:
					length = 2048;
					loop = 4;
					break;
			}
			
			// execute SPC emulator for getting wave audio
			_out.position = 0;
			_libgme.play(_out, length);
			_out.position = 0;
			
			// executing while for wave length
			for (var i:int = 0; i < length; i++)
			{
				var s1:Number = 0;
				var s2:Number = 0;
				
				// play() method returned for 16 bit wave sound data
				// but it is not playable for Flash Player.
				// converting float type wave sound data.
				s1 = _out.readShort();
				s1 /= 32768;
				s2 = _out.readShort();
				s2 /= 32768;
				
				// write wave sound buffer
				for (var n:int = 0; n < loop; n++)
				{
					data.writeFloat(s1); // left channel
					data.writeFloat(s2); // right channel
				}
			}
		}
		//*/
		//* modified version
//		private function onSampleData(e:SampleDataEvent):void 
//		{	
//			var data:ByteArray = e.data;
//			data.endian = Endian.LITTLE_ENDIAN;
//			libgme.play(data, BYTE_LENGTH, emuInd);
//			if ( fctToCallOnTrackEnd != null && trackEnded() )
//			{
//				fctToCallOnTrackEnd();
//				fctToCallOnTrackEnd = null;
//			}
			/*if (buffer)
			{
//				sndMngr.soundBuffer.writeBytes(data);
				buffer.writeBytes(data);
				if ( trackEnded() )
				{
					trace("track ended");
					bufferTemp.position = 0;
					buffer.position = 0;
					while (bufferTemp.bytesAvailable)
					{
						var sample:Number = bufferTemp.readFloat();
						buffer.writeFloat(sample);
						bufferTemp.position += 4;
					}
//					buffer.writeBytes(bufferTemp);
					stop();
//					sndMngr.cacheByteArray(buffer,currentArr);
				}
			}*/
			
//			_soundTransform.volume = 0;
//		}
		
		/*public function initByteArray():void
		{
			return;
			dataPosition = libgme.initByteArray(12); //This is the position of the data 
		}
		public function writeData():void
		{
			return;
			libgme.writeData("Hello "); //example function to write data in C
			byteArray.position = dataPosition + 6; //Move to the next free location
			byteArray.writeUTFBytes("World!"); //write text at the current position
			byteArray.position = dataPosition; //reset position
			trace(byteArray.readUTFBytes(12));//read bytearray
		}
		public function clearByteArray():void
		{
			
		}*/
		
		
		//*/
	}

}