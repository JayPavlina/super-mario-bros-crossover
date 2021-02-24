package com.smbc.projectiles
{
	import com.explodingRabbit.display.CustomMovieClip;
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.data.*;
	import com.smbc.graphics.MasterObjects;
	import com.smbc.interfaces.ICustomTimer;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	public class FireBar extends Projectile
	{
		// game: three rotations 10 seconds
		private const ROTATE_SPEED:int = 106;
		protected var clockwise:Boolean;
		public var bmd2:BitmapData;
		public var bRect:Rectangle;
		public var offsetMx:Matrix;
		public var topLeftPt:Point = new Point();
		public function FireBar(fLab:String)
		{
			super(null,SOURCE_TYPE_ENEMY);
			gotoAndStop(1);
			checkFrameDuringStopAnim = true;
//			stopAnim = true;
			addReasonOvRd(NAME_STOP_ANIM,true,RSN_NONSPECIFIC);
			defyGrav = true;
			destroyOffScreen = false;
			dosTop = false;
			dosBot = false;
			dosLft = false;
			dosRht = false;
			if (fLab.indexOf("Left") != -1)
			{
				clockwise = false;
				scaleX = -1;
			}
			else if (fLab.indexOf("Right") != -1)
			{
				clockwise = true;
			}
			if (fLab.indexOf("Long") != -1)
			{
				gotoAndStop(2);
			}
			hitDistOver = height;
			var totChildren:Number = numChildren;
		}
		
		override protected function mcReplacePrep(thisMc:MovieClip):void
		{
			super.mcReplacePrep(thisMc);
		}
		private function stopAllAnim():void
		{
			
		}
		public static function getSubCmcs(cmc:CustomMovieClip):void
		{
			var dct:Dictionary = cmc.STAT_VEC[ 2 ];
			cmc.mcReplaceArr = [];
			for (var key:Object in dct)
			{
				var child:DisplayObject = key as DisplayObject;
				if ( !(child is HRect) )
				{
					cmc.mcReplaceArr.push(child);
					cmc.mcReplaceArr.push(new CustomMovieClip(null, null, "FireBarChild" ) );
//					cmc.mcReplaceArr.push(new CustomMovieClip( new MovieClipInfo.FireBarChildMc() ) );		
				}
			}
			cmc.replaceSubMovieClips();
			cmc.finalCreateMaster();
		}
		override public function initiate():void
		{
			super.initiate();
			y -= TILE_SIZE/2;
			ny = y;
			bRect = getBounds(level);
			offsetMx = transform.matrix;
			offsetMx.tx = x - bRect.x;
			offsetMx.ty = y - bRect.y;
			bmd2 = new BitmapData(bRect.width, bRect.height,true,0);
			var n:int = numChildren;
			for (var i:int = 0; i < n; i++)
			{
				var dObj:DisplayObject = getChildAt(i);
				if ( !(dObj is HRect) )
					dObj.visible = false;
				else
					dObj.visible = true;
			}
			bmd2.draw(this,offsetMx);
			for (i = 0; i < n; i++)
			{
				dObj = getChildAt(i);
				if ( !(dObj is HRect) )
					dObj.visible = true;
				else
					dObj.visible = false;
			}
		}
		override public function setHitPoints():void
		{
			super.setHitPoints();
			bRect = getBounds(level);
			offsetMx = transform.matrix;
			offsetMx.tx = x - bRect.x;
			offsetMx.ty = y - bRect.y;
			bmd2.dispose();
			bmd2 = new BitmapData(bRect.width, bRect.height,true,0);
			var n:int = numChildren;
			for (var i:int = 0; i < n; i++)
			{
				var dObj:DisplayObject = getChildAt(i);
				if ( !(dObj is HRect) )
					dObj.visible = false;
				else
					dObj.visible = true;
			}
			bmd2.draw(this,offsetMx);
			for (i = 0; i < n; i++)
			{
				dObj = getChildAt(i);
				if ( !(dObj is HRect) )
					dObj.visible = true;
				else
					dObj.visible = false;
			}
		}
		override public function checkStgPos():void
		{
			if (nx > level.locStgLft - TILE_SIZE*3 && nx < level.locStgRht + TILE_SIZE*2)
			{
				if (parent != level)
					level.addChild(this);
			}
			else if (parent == level && !updateOffScreen)
				level.removeChild(this);
			if (destroyOffScreen || dosTop || dosBot || dosLft || dosRht)
				checkDosSides();
		}
		override protected function updateStats():void
		{
			super.updateStats();
			rotate();
		}
		private function rotate():void
		{
			if (clockwise)
				rotation += ROTATE_SPEED*dt;
			else
				rotation += -ROTATE_SPEED*dt;
		}
		override public function checkFrame():void
		{
			var totChildren:Number = numChildren;
			for (var i:int = 0; i < totChildren; i++)
			{
				var dispObj:DisplayObject = DisplayObject(getChildAt(i));
				if (!(dispObj is HRect))
				{
					var cmc:CustomMovieClip = CustomMovieClip(dispObj);
					if (cmc.currentFrameLabel == "end")
						cmc.gotoAndStop("start");
				}
			}
		}
		override public function animate(ct:ICustomTimer):Boolean
		{
			if (stopUpdate && GS_MNGR.gameState != GameStates.PAUSE)
				return false;
			if (ct == mainAnimTmr)
			{
				var totChildren:Number = numChildren;
				for (var i:int = 0; i < totChildren; i++)
				{
					var dObj:DisplayObject = DisplayObject(getChildAt(i));
					if (!(dObj is HRect))
					{
						ANIMATOR.animate(CustomMovieClip(dObj));
					}
				}
			}
			return super.animate(ct);
		}
	}
	
}