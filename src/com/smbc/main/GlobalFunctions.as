package com.smbc.main
{
	import com.smbc.characters.Bill;
	import com.smbc.characters.Character;
	import com.smbc.characters.Link;
	import com.smbc.characters.Mario;
	import com.smbc.characters.MegaMan;
	import com.smbc.characters.Ryu;
	import com.smbc.characters.Samus;
	import com.smbc.characters.Simon;
	import com.smbc.characters.Sophia;
	import com.smbc.data.CharacterInfo;
	import com.smbc.level.Level;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public final class GlobalFunctions
	{
		private static const ZERO_PT:Point = new Point();
		public function GlobalFunctions()
		{
			
		}
		public static function resetColor(obj:MovieClip):void
		{
			var cf:int = obj.currentFrame;
			obj.nextFrame();
			if (obj.currentFrame != cf)
				obj.gotoAndStop(cf);
			else
			{
				obj.prevFrame();
				if (cf != obj.currentFrame)
					obj.gotoAndStop(cf);
				else
					throw new Error("cannot reset color on movieclips with 1 frame");
			}
		}
		public static function recolorChildren(obj:DisplayObjectContainer,inColor:uint,outColor:uint):void
		{
			var n:int = obj.numChildren;
			for (var i:int = 0; i < n; i++)
			{
				var mc:DisplayObject = obj.getChildAt(i);
				if (mc is Bitmap)
				{
					var bmd:BitmapData = Bitmap(mc).bitmapData;
					if (obj is MovieClip)
						bmd.threshold(bmd,bmd.rect,ZERO_PT,"==",inColor,outColor);
				}
			}
		}
		public static function sortStrings(s1:String,s2:String):int
		{
			if (s1 < s2)
				return -1;
			else if (s1 > s2)
				return 1;
			else
				return 0;
		}
		public static function sortNums(n1:Number,n2:Number):int
		{
			if (n1 < n2)
				return -1;
			else if (n1 > n2)
				return 1;
			else
				return 0;
		}
		public static function convCharNameTxtToCaps(str:String):String
		{
			var num:int = CharacterInfo.convNameToNum(str);
			return CharacterInfo.CHAR_ARR[num][CharacterInfo.IND_CHAR_NAME_CAPS];
		}
		public static function convCharNameToCharNameTxt(str:String):String
		{
			var num:int = CharacterInfo.convNameToNum(str);
			return CharacterInfo.CHAR_ARR[num][CharacterInfo.IND_CHAR_NAME_MENUS];
		}
	}
}