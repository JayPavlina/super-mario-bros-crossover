package com.smbc.graphics
{
	import com.explodingRabbit.cross.games.Game;

	public class ThemeGroup
	{
		private var _theme:int;
		private var _setNum:int;
		private var _musicType:String;
		private var _game:Game;
		public function ThemeGroup(theme:int, set:int, musicType:String = null)
		{
			_setNum = set;
			_theme = theme;
			_musicType = musicType;
		}

		public function get setNum():int
		{
			return _setNum;
		}

		public function get theme():int
		{
			return _theme;
		}

		public function get musicType():String
		{
			return _musicType;
		}

		public function get game():Game
		{
			return _game;
		}

		public function set game(value:Game):void
		{
			if (_game != null)
				throw new Error("Can only set value of game once");
			_game = value;
		}


	}
}