package com.smbc.ground
{
	import com.explodingRabbit.utils.CustomDictionary;
	import com.explodingRabbit.utils.MathUtils;
	import com.smbc.graphics.BmdSkinCont;
	import com.smbc.level.Level;
	import com.smbc.managers.GraphicsManager;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import flashx.textLayout.formats.BlockProgression;

	public class SimpleGround extends Ground
	{
		public static const BN_BLOCK:String = "groundBlock";
		public static const BN_NORMAL:String = "groundNormal";
		public static const BN_PIPE:String = "groundPipe";
		public static const BN_CORAL:String = "groundCoral";
		private static const BN_WIDE:String = "groundWide";
		private static const BN_MUSHROOM:String = "groundMushroom";
		private static const BN_GROUND_RAIL:String = "groundRail";
		private static const BN_EXCEPTION_DCT_BLOCK:Dictionary = new Dictionary();
		private static const BN_EXCEPTION_DCT_NORMAL:Dictionary = new Dictionary();
		private static const NONTHEME_DCT:CustomDictionary = new CustomDictionary();
		private static const IGNORE_AUTODETECTION_DCT:CustomDictionary = new CustomDictionary();
		
		public static const lftStr:String = "Lft";
		public static const rhtStr:String = "Rht";
		public static const midStr:String = "Mid";
		public static const topStr:String = "Top";
		public static const botStr:String = "Bot";
		public static const sinStr:String = "Sin";
		public static const corStr:String = "Cor";
		public static const dualStr:String = "Dual";
		
		public static const PIPE_SIDE_BOTTOM:String = "groundPipeEndLeftBottom";
		
		private static const HORIZONTAL_ONLY:CustomDictionary = new CustomDictionary();
		private static const VERTICAL_ONLY:CustomDictionary = new CustomDictionary();
		
		private var bnExceptionDct:Dictionary;
		{
			BN_EXCEPTION_DCT_NORMAL["box"] = "box"; // Gray boxes
			BN_EXCEPTION_DCT_BLOCK[BN_NORMAL] = BN_NORMAL;
			
			HORIZONTAL_ONLY.addItem(BN_MUSHROOM);
			HORIZONTAL_ONLY.addItem(BN_GROUND_RAIL);			
			VERTICAL_ONLY.addItem(BN_CORAL);
			
			NONTHEME_DCT.addItem("groundUnbreakableBrick");
			NONTHEME_DCT.addItem("groundPipeUnderwaterTop");
			NONTHEME_DCT.addItem("groundPipeUnderwaterBottom");
			NONTHEME_DCT.addItem("groundBillBlasterMiddle");
			NONTHEME_DCT.addItem("groundBillBlasterBottom");
			NONTHEME_DCT.addItem("groundPipeIntBottom");
			NONTHEME_DCT.addItem("groundPipeIntTop");
			NONTHEME_DCT.addItem("groundPipeIntRightBottom");
			NONTHEME_DCT.addItem("groundPipeIntRightTop");
			NONTHEME_DCT.addItem("groundPipeMidRightSide");
			NONTHEME_DCT.addItem("groundPipeMidLeftSide");
			NONTHEME_DCT.addItem("groundPipeEndRightTop");
			NONTHEME_DCT.addItem("groundPipeEndRightBottom")
			NONTHEME_DCT.addItem("groundPipeEndLeftTop");
			NONTHEME_DCT.addItem("groundPipeEndLeftBottom");
			NONTHEME_DCT.addItem("groundPipeMidLeft");
			NONTHEME_DCT.addItem("groundPipeMidRight");
			NONTHEME_DCT.addItem("groundPipeTopRight");
			NONTHEME_DCT.addItem("groundPipeTopLeft");
			NONTHEME_DCT.addItem("groundPipeBottomLeft");
			NONTHEME_DCT.addItem("groundPipeBottomRight");
			NONTHEME_DCT.addItem("groundBillBlasterMiddle");
			NONTHEME_DCT.addItem("groundBillBlasterBottom");
			
			IGNORE_AUTODETECTION_DCT.addItem("groundMushroomSinLft");
			IGNORE_AUTODETECTION_DCT.addItem("groundMushroomSinMid");
			IGNORE_AUTODETECTION_DCT.addItem("groundMushroomSinRht");
			IGNORE_AUTODETECTION_DCT.addItem("groundMushroomSinSin");
		}
		public function SimpleGround(stopFrame:String)
		{
			stopFrame = Level.RemoveProperties(stopFrame);
			if (!NONTHEME_DCT[stopFrame])
				inheritedForceShortClassName = "GroundTheme";
			else
				inheritedForceShortClassName = "Ground";
			super(stopFrame);
			if (baseName != BN_NORMAL && baseName != BN_BLOCK && HORIZONTAL_ONLY[baseName] == undefined && stopFrame != "groundWideNormal")
				cloneFromMaster([stopFrame]);
			else if (baseName == BN_NORMAL)
				bnExceptionDct = BN_EXCEPTION_DCT_NORMAL;
			else if (baseName == BN_BLOCK)
				bnExceptionDct = BN_EXCEPTION_DCT_BLOCK;
		}
		public function checkNearbyGround():void
		{
			if (IGNORE_AUTODETECTION_DCT[currentFrameLabel] != undefined)
				return;
			
			var aboveLeft:Ground = level.getGroundAt(x - TILE_SIZE,y - TILE_SIZE);
			var above:Ground = level.getGroundAt(x,y - TILE_SIZE);
			var aboveRight:Ground = level.getGroundAt(x + TILE_SIZE,y - TILE_SIZE);
			var left:Ground = level.getGroundAt(x - TILE_SIZE,y);
			var right:Ground = level.getGroundAt(x + TILE_SIZE,y);
			var belowLeft:Ground = level.getGroundAt(x - TILE_SIZE,y + TILE_SIZE);
			var below:Ground = level.getGroundAt(x,y + TILE_SIZE);
			var belowRight:Ground = level.getGroundAt(x + TILE_SIZE,y + TILE_SIZE);
			var bnStr:String;
			if (above)
			{
				bnStr = above.baseName;
				if (bnStr != baseName && !baseNameException(bnStr, bnExceptionDct) ) 
					above = null;						
			}
			if (aboveLeft)
			{
				bnStr = aboveLeft.baseName;
				if (bnStr != baseName && !baseNameException(bnStr, bnExceptionDct) ) 
					aboveLeft = null;						
			}
			if (aboveRight)
			{
				bnStr = aboveRight.baseName;
				if (bnStr != baseName && !baseNameException(bnStr, bnExceptionDct) ) 
					aboveRight = null;						
			}
			if (left)
			{
				bnStr = left.baseName;
				if (bnStr != baseName && !baseNameException(bnStr, bnExceptionDct) ) 
					left = null;						
			}
			if (right)
			{
				bnStr = right.baseName;
				if (bnStr != baseName && !baseNameException(bnStr, bnExceptionDct) ) 
					right = null;						
			}
			if (belowLeft)
			{
				bnStr = belowLeft.baseName;
				if (bnStr != baseName && !baseNameException(bnStr, bnExceptionDct) ) 
					belowLeft = null;						
			}
			if (belowRight)
			{
				bnStr = belowRight.baseName;
				if (bnStr != baseName && !baseNameException(bnStr, bnExceptionDct) ) 
					belowRight = null;						
			}
			if (below)
			{
				bnStr = below.baseName;
				if (bnStr != baseName && !baseNameException(bnStr, bnExceptionDct) ) 
					below = null;						
			}
			if (x == GROUND_X_MIN)
			{
				left = new Ground(null);
				aboveLeft = new Ground(null);
				belowLeft = new Ground(null);
			}
			if (x + TILE_SIZE == level.mapWidth)
			{
				right = new Ground(null);
				aboveRight = new Ground(null);
				belowRight = new Ground(null);
			}
			if (y == GROUND_Y_MAX)
			{
				below = new Ground(null);
				belowLeft = new Ground(null);
				belowRight = new Ground(null);
			}
			if ( HORIZONTAL_ONLY.containsKey(baseName) ) // only needs horizontal ground
			{
				above = null;
				aboveLeft = null;
				aboveRight = null;
				below = null;
				belowLeft = null;
				belowRight = null;
			}
			if ( VERTICAL_ONLY.containsKey(baseName) )
			{
				left = null;
				aboveLeft = null;
				belowLeft = null;
				right = null;
				aboveRight = null;
				belowRight = null;
			}
			var label:String = baseName;
			var labHorz:String;
			var labVert:String;
			var corner:String;

			if (currentLabel == "groundWideNormal")
				getWideGround(left,right);
			if (baseName == BN_NORMAL || baseName == BN_BLOCK || VERTICAL_ONLY[baseName] != undefined || HORIZONTAL_ONLY[baseName] != undefined)
			{
				if (above)
				{
					if (below) // && above
					{
						label += midStr;
						if (left)
						{
							if (right)
							{
								label += midStr;
								if (!aboveLeft && !aboveRight && !belowLeft && !belowRight)
									label += corStr;
								else if (!aboveLeft && !aboveRight && belowLeft && belowRight)
									label += corStr + dualStr + topStr;
								else if (!aboveLeft && aboveRight && !belowLeft && belowRight)
									label += corStr + dualStr + lftStr;
								else if (aboveLeft && !aboveRight && belowLeft && !belowRight)
									label += corStr + dualStr + rhtStr;
								else if (aboveLeft && aboveRight && !belowLeft && !belowRight)
									label += corStr + dualStr + botStr;
								else if (!aboveLeft && aboveRight && belowLeft && belowRight)
									label += corStr + topStr + lftStr;
								else if (aboveLeft && !aboveRight && belowLeft && belowRight)
									label += corStr + topStr + rhtStr;
								else if (aboveLeft && aboveRight && !belowLeft && belowRight)
									label += corStr + botStr + lftStr;
								else if (aboveLeft && aboveRight && belowLeft && !belowRight)
									label += corStr + botStr + rhtStr;
							}
							else
							{
								label += rhtStr;
								if (!aboveLeft && !belowLeft)
									label += corStr + dualStr;
								else if (!aboveLeft && belowLeft)
									label += corStr + topStr;
								else if (aboveLeft && !belowLeft)
									label += corStr + botStr;
							}
						}
						else if (right) // && !left
						{
							label += lftStr;
							if (!aboveRight && !belowRight)
								label += corStr + dualStr;
							else if (!aboveRight && belowRight)
								label += corStr + topStr;
							else if (aboveRight && !belowRight)
								label += corStr + botStr;
						}
						else
							label += sinStr;
					}
					else // if !below
					{
						label += botStr;
						if (left)
						{
							if (right)
							{
								label += midStr;
								if (!aboveLeft && !aboveRight)
									label += corStr + dualStr;
								else if (aboveLeft && !aboveRight)
									label += corStr + rhtStr;
								else if (!aboveLeft && aboveRight)
									label += corStr + lftStr;
							}
							else
							{
								label += rhtStr;
								if (!aboveLeft)
									label += corStr;
							}
						}
						else if (right) // && !left
						{
							label += lftStr;
							if (!aboveRight)
								label += corStr;
						}
						else
							label += sinStr;
						
					}
				}
				else if (below) // && !above
				{
					label += topStr;
					if (left)
					{
						if (right)
						{
							label += midStr;
							if (!belowLeft && !belowRight)
								label += corStr + dualStr;
							else if (belowLeft && !belowRight)
								label += corStr + rhtStr;
							else if (!belowLeft && belowRight)
								label += corStr + lftStr;
						}
						else
						{
							label += rhtStr;
							if (!belowLeft)
								label += corStr;
						}
					}
					else if (right) // && !left
					{
						label += lftStr;
						if (!belowRight)
							label += corStr;
					}
					else
						label += sinStr;
				}
				else
				{
					label += sinStr;
					if (left)
					{
						if (right)
							label += midStr;
						else
							label += rhtStr;
					}
					else if (right) // && !left
						label += lftStr;
					else
						label += sinStr;
				}
//				 hack for bowser levels, remove later
				if (label == "groundNormalMidMidCorDualTop" && above.currentLabel == "boxGray")
					label = "groundNormalTopMid";
				gotoAndStop(label);
			}
		}
		private function getWideGround(left:Ground,right:Ground):void
		{
			var evenFun:Function = MathUtils.isEven;
			var xIsEven:Boolean = evenFun(x / TILE_SIZE);
			var yIsEven:Boolean = evenFun(y / TILE_SIZE);
			var lft:String = "Lft";
			var rht:String = "Rht";
			var suffix:String;
//			var label:String = "groundWide";
			if (xIsEven)
			{
				if (yIsEven)
					suffix = rht;
				else
					suffix = lft;
			}
			else
			{
				if (yIsEven)
					suffix = lft;
				else
					suffix = rht;
			}
			if ( (suffix == lft && !right) || (suffix == rht && !left) )
				suffix = "Sin";
			gotoAndStop("groundWide"+suffix);
			
		}
		private function baseNameException(baseNameStr:String, dct:Dictionary):Boolean
		{
			if (!dct)
				return false;
			for each (var str:String in dct)
			{
				if (str == baseNameStr)
					return true;
			}
			return false;
		}
	}
}