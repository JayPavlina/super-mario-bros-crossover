package com.smbc.graphics
{
	import com.explodingRabbit.display.CustomMovieClip;
	import com.smbc.characters.Character;
	import com.smbc.errors.SingletonError;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.sampler.clearSamples;
	
	import nl.stroep.utils.ImageSaver;
	
	public class AllCharactersCmc extends CustomMovieClip
	{
		private static var instance:AllCharactersCmc;
		public function AllCharactersCmc(mc:Sprite=null, masterBmdType:Array=null, forceShortClassName:String=null, dontDrawYet:Boolean=false)
		{
			super(mc, masterBmdType, forceShortClassName, dontDrawYet);
			if (instance)
				throw new SingletonError();
		}
		public static function getInstance():AllCharactersCmc
		{
			if (!instance)
			{
				instance = new AllCharactersCmc(null,null,"Ryu");
			}
//			instance.setNumFrames(Character.NUM_CHARACTERS);
			return instance;
		}
		public function drawCharacter(character:Character):void
		{
			var frameNum:int = character.charNum + 1;
			var bmdNormal:BitmapData = ImageSaver.INSTANCE.getBitmapData(character,0);
			var colorRect:Rectangle = bmdNormal.getColorBoundsRect(0xFFFFFFFF,0,false);
			if (!colorRect.width || !colorRect.height)
				return;
			var bmdTrimmed:BitmapData = new BitmapData(colorRect.width,colorRect.height,true,0);
			bmdTrimmed.copyPixels(bmdNormal,colorRect,new Point());
			var bmp:Bitmap = new Bitmap( bmdTrimmed );
			clearFrame(frameNum);
			addChildToSingleFrame(bmp,frameNum);
			gotoAndStop(frameNum);
		}
		/*public function drawCharacter(char:Character,sourceFrameNum:int):void
		{
			var targetFrameNum:int = char.charNum + 1;
			copySingleFrameFromOtherCmc(char,sourceFrameNum,targetFrameNum);
//			gotoAndStop(targetFrameNum);
		}*/
	}
}