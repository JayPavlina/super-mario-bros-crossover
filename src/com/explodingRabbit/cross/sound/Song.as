package com.explodingRabbit.cross.sound
{
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.games.Game;
	import com.explodingRabbit.cross.games.GameSuperMarioBros3;
	import com.explodingRabbit.cross.games.GameSuperMarioBrosAtari;
	import com.explodingRabbit.utils.StringUtils;
	import com.gme.GameMusicEmu;
	
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;

	public class Song
	{
		public static const EMPTY_SONG:Song = new Song(null);
		
		private var _game:Game;
		private var _track:int;
		private var _volume:int;
		private var _start:int;
		private var _loop:int;
		private var _dataClass:Class;
		private var _name:String;
		private var _format:String;
		private var _fadeStart:int;
		private var dataClassName:String;
		
		public function Song(songClass:Class, track:int = -1, game:Game = null, volume:int = 100, start:int = 0, loop:int = 0, fadeStart:int = 0, fadeDur:int = 0)
		{
			this._dataClass = songClass;
			this._game = game;
			this._track = track;
			this._volume = volume;
			this._start = start;
			this._loop = loop;
			this._name = name;
			this._fadeStart = fadeStart;
			if (songClass)
				dataClassName = StringUtils.getClassNameFromClass(songClass);
			if (game)
				_format = getFormatFromConsole(game.console);
		}
		
		private function getFormatFromConsole(console:String):String
		{
			switch(console)
			{
				case Consoles.nintendo:
				{
					var lastChar:String = dataClassName.charAt( dataClassName.length - 1);
					if ( lastChar.toUpperCase() == "E")
						return MusicFormat.NSFE;
					else
						return MusicFormat.NSF;
				}
				case Consoles.superNintendo:
					return MusicFormat.SPC;
				case Consoles.gameBoy:
					return MusicFormat.GBS;
				case Consoles.segaMasterSystem:
					return MusicFormat.KSS;
				case Consoles.atari:
					return MusicFormat.SAP;
				case Consoles.segaGenesis:
					return MusicFormat.VGM;
			}
			return null;
		}


		public function getSoundData():ByteArray
		{
			return ByteArray( new _dataClass() );
		}

		public function get format():String
		{
			return _format;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function get loop():int
		{
			return _loop;
		}

		public function get start():int
		{
			return _start;
		}

		public function get volume():int
		{
			return _volume;
		}

		public function get track():int
		{
			return _track;
		}

		public function get game():Game
		{
			return _game;
		}

		public function get dataClass():Class
		{
			return _dataClass;
		}

		public function set game(value:Game):void
		{
			if (_game != null)
				throw new Error("game can only be set once");
			_game = value;
			_format = getFormatFromConsole(game.console);
		}

		public function set name(value:String):void
		{
			if (_name != null)
				throw new Error("name can only be set once");
			_name = value;
		}

		public function get fadeStart():int
		{
			return _fadeStart;
		}


	}
}