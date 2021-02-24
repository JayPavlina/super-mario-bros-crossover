package com.smbc.graphics
{
	import com.explodingRabbit.cross.games.Game;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	public class BmdSkinCont
	{
		public static const TYPE_MAP:int = 0;
		public static const TYPE_CHARACTER:int = 1;
		public static const TYPE_ENEMY:int = 2;
		public static const TYPE_INTERFACE:int = 3;
		public static const TYPE_BACKGROUND:int = 4;
		public static const TYPE_NEUTRAL:int = 5;
		public static const TYPE_PALETTE:int = 6;
		public static const TYPE_THEME:int = 7;
		public static const IND_NAME_ARR_FULL:int = 0;
		public static const IND_NAME_ARR_SHORT:int = 1;
		public static const IND_NAME_ARR_PRINCESS:int = 2;
		public static const IND_GAME_SOURCE:int = 3;
		public var bmp:Bitmap;
		public var bmd:BitmapData;
		public var sprite:Sprite;
		public var skinNum:int;
		public var gbPal:int; // the current gameboy Palette being used
		public const SPRITE_POS_VEC:Vector.<Point> = new Vector.<Point>();
		public var type:int;
		public var parent:DisplayObjectContainer;
		public var mask:DisplayObject;
		public var games:Vector.<Game>;
		public var charArr:Array;
		public var namesArr:Array;
		public var consoleType:int;
		public var specialSettings:Object;
		public var soundReplaceDct:Dictionary;
		public var skinDescription:String;

		public function BmdSkinCont(bmp:Bitmap,skinNum:int,type:int,parent:DisplayObjectContainer=null, mask:DisplayObject=null, consoleType:int = 0, charArr:Array = null, gameArr:Array = null, namesArr:Array = null, specialSettings:Object = null, soundReplaceDct:Object = null, skinDescription:String = null)
		{
			this.bmp = bmp;
			this.skinNum = skinNum;
			bmd = bmp.bitmapData;
			this.parent = parent;
			this.mask = mask;
			this.consoleType = consoleType;
			this.charArr = charArr;
			if (gameArr)
				this.games = Vector.<Game>(gameArr);
			this.namesArr = namesArr;
			this.specialSettings = specialSettings;
			this.type = type;
			this.skinDescription = skinDescription;
//			this.soundReplaceDct = soundReplaceDct;
			if (!charArr)
				charArr = [];
			if (!gameArr)
				gameArr = [];
			sprite = Sprite(bmp.parent);
			SPRITE_POS_VEC.push(null);
		}
		public function clone():BmdSkinCont
		{
			return new BmdSkinCont( new Bitmap( bmd.clone() ), skinNum, type, parent, mask, consoleType, charArr, games as Array, namesArr, specialSettings, soundReplaceDct, skinDescription );
		}
		public function copyStatsFrom(bmc:BmdSkinCont):void
		{
			skinNum = bmc.skinNum;
			type = bmc.type;
			parent = bmc.parent;
			mask = bmc.mask;
			consoleType = bmc.consoleType;
			charArr = bmc.charArr;
			games = bmc.games;
			gbPal = bmc.gbPal;
			specialSettings = bmc.specialSettings;
			soundReplaceDct = bmc.soundReplaceDct;
			skinDescription = bmc.skinDescription;
		}
		
		public function get charNum():int
		{
			if (type != TYPE_CHARACTER)
				return -1;
			else
				return charArr[0];
		}
	}
}