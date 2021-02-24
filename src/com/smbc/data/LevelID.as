package com.smbc.data
{
	import flash.utils.Dictionary;

	public class LevelID
	{
		public static const SEPARATOR:String = "-";
		public static const DEFAULT_AREA:String = "a";
		private static const MAX_WORLD_BEFORE_USING_LETTERS:int = 10;
		private static const LETTERS_FOR_WORLD:Vector.<String> = Vector.<String>([
			"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N",
			"O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"
		]);
		private static const LETTERS_DCT:Dictionary = new Dictionary();
		
		// static constructor
		{
			initiateClass();
		}
		
		private var _world:int;
		private var _stage:int; 
		private var _area:String;
		
		private var _nameWithoutArea:String;
		private var _fullName:String;
		
		public static function initiateClass():void
		{
			for (var i:int = 0; i < LETTERS_FOR_WORLD.length; i++)
				LETTERS_DCT[ LETTERS_FOR_WORLD[i] ] = i;
			
		}
		public function LevelID(world:int, stage:int, area:String = DEFAULT_AREA)
		{
			this._world = world;
			this._stage = stage;
			this._area = area;
			
			_nameWithoutArea = _world.toString() + SEPARATOR + _stage.toString();
			_fullName = _nameWithoutArea + area;
		}
		
		public static function Create(fullLevelString:String):LevelID
		{
			var separatorIndex:int = fullLevelString.indexOf(SEPARATOR);
			var firstCharacter:String = fullLevelString.charAt(0);
			
			var world:int;
			if (LETTERS_DCT[firstCharacter] == undefined)
				world = int( fullLevelString.substr(0, separatorIndex) );
			else
				world = int(LETTERS_DCT[firstCharacter]) + MAX_WORLD_BEFORE_USING_LETTERS;
			var stage:int = int( fullLevelString.charAt(separatorIndex + 1) );
			
			var area:String;
			if (fullLevelString.length > separatorIndex + 2)
				area = fullLevelString.charAt(separatorIndex + 2);
			if (area == null)
				area = DEFAULT_AREA;
			
			return new LevelID(world, stage, area);	
		}

		public function get world():int
		{
			return _world;
		}
		
		public function get worldDisplay():String
		{
			return ToDisplay(_world);
		}
		
		public function get nameWithoutAreaDisplay():String
		{
			return worldDisplay + SEPARATOR + _stage.toString();
		}

		public function get stage():int
		{
			return _stage;
		}

		public function get area():String
		{
			return _area;
		}

		public function get fullName():String
		{
			return _fullName;
		}

		public function get nameWithoutArea():String
		{
			return _nameWithoutArea;
		}
		
		public static function getWorldNumber(levelString:String):int
		{
			var separatorIndex:int = levelString.indexOf(SEPARATOR);
			return int( levelString.substr(0, separatorIndex) );
		}
		
		public static function ToDisplay(number:int):String
		{
			if (number < MAX_WORLD_BEFORE_USING_LETTERS)
				return number.toString();
			else
				return LETTERS_FOR_WORLD[number - MAX_WORLD_BEFORE_USING_LETTERS];
		}


	}
}