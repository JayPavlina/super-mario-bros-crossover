package com.smbc.graphics
{
	import com.smbc.characters.Character;
	import com.smbc.characters.Sophia;
	import com.smbc.interfaces.ICustomTimer;
	import com.smbc.level.Level;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	public class SophiaWheel extends SubMc
	{
		private var frontWheel:SophiaFrontWheel;
		private var backWheel:SophiaBackWheel;
		private var sophia:Sophia;
		private var level:Level;
		private static const FL_START:String = Sophia.FL_WHEEL_START;
		private static const FL_END:String = Sophia.FL_WHEEL_END; // includes extra frame; loop when you reach this frame
		public function SophiaWheel(sophia:Sophia)
		{
			super(sophia);
			this.sophia = sophia;
		}
		override public function initiate():void
		{
			super.initiate();
			level = Level.levelInstance;
			frontWheel = sophia.frontWheel;
			backWheel = sophia.backWheel;
			if (this == frontWheel)
				setStopFrame(FL_START);
			else
			{
				setStopFrame(FL_END)
				gotoAndStop(currentFrame - 1);
			}
			hasPState2 = true;
		}
		override public function gotoAndStop(frame:Object, scene:String=null):void
		{
			super.gotoAndStop(frame,scene);
			if (level)
			{
				if (!level.RECOLOR_OBJS_DCT[sophia])
					level.RECOLOR_OBJS_DCT.addItem(sophia);
				recolor = true;
			}
		}
		override public function animate(ct:ICustomTimer):Boolean
		{
			if (!stopAnim)
			{
				ANIMATOR.animate(this);
				checkFrame();
				return true;
			}
			return false
		}
		override public function checkFrame():void
		{
			var str:String;
			if (!sophia.hover && ( (!sophia.underWater || (!sophia.classic && sophia.jumpRise) ) || sophia.onGround) )
			{
				if (this == frontWheel)
				{
					str = currentLabel;
					if ( str == convLab(FL_END) )
						setPlayFrame(FL_START);
				}
				else
				{
					str = frontWheel.currentLabel;
					if (str != FL_START)
						setPlayFrame(str);
					else
						setPlayFrame(FL_END);
					gotoAndStop(currentFrame - 1);
				}
			}
		}
		
		override public function recolorBmps(inPalette:Palette,outPalette:Palette,inColorRow:int = 0,outColorRow:int = 0,defColorsOvrd:Palette = null):void
		{
			// makes sure hover flames don't get colored
			var flameBmp:Bitmap;
			if (currentLabel == Sophia.FL_WHEEL_HOVER_BIG_FLAME || currentLabel == Sophia.FL_WHEEL_HOVER_SMALL_FLAME)
			{
				var n:int = numChildren;
				var otherChild:DisplayObject;
				for (var i:int = 0; i < n; i++) 
				{
					var child:DisplayObject = getChildAt(i);
					if (child is Bitmap)
					{
						if (!otherChild)
							otherChild = child;
						else
						{
							if (otherChild.y > child.y)
								flameBmp = otherChild as Bitmap;
							else
								flameBmp = child as Bitmap;
						}
					}
				}
				removeChild(flameBmp);
			}
			super.recolorBmps(inPalette, outPalette, inColorRow, outColorRow, defColorsOvrd);
			if (flameBmp)
				addChild(flameBmp);
		}
		
		
		override public function convLab(_fLab:String):String
		{
			return _fLab;
		}
	}
}