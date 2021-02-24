package com.smbc.graphics
{
	import com.explodingRabbit.display.CustomMovieClip;
	import com.explodingRabbit.utils.CustomDictionary;
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.characters.Character;
	import com.smbc.data.AnimationTimers;
	import com.smbc.data.GameSettings;
	import com.smbc.graphics.BmdInfo;
	import com.smbc.graphics.BmdSkinCont;
	import com.smbc.graphics.fontChars.FontCharHud;
	import com.smbc.interfaces.ICustomTimer;
	import com.smbc.level.Level;
	import com.smbc.main.*;
	import com.smbc.managers.GraphicsManager;
	import com.smbc.managers.TextManager;
	import com.smbc.text.TextFieldContainer;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.sampler.getSize;
	import flash.text.TextField;

	public class Scenery extends SkinObj 
	{
		public static const WAVE_Y_POS:int = 64;
		private static const FL_BUSH_GREEN:String = "bushGreen";
		private static const FL_BUSH_GREEN_LEFT:String = "bushGreenLeft";
		private static const FL_BUSH_GREEN_LEFT_END:String = "bushGreenLeftEnd";
		private static const FL_BUSH_GREEN_MID:String = "bushGreenMid";
		private static const FL_BUSH_GREEN_MID_END:String = "bushGreenMidEnd";
		private static const FL_BUSH_GREEN_RIGHT:String = "bushGreenRight";
		private static const FL_BUSH_GREEN_RIGHT_END:String = "bushGreenRightEnd";
		private static const FL_BUSH_GREEN_SMALL:String = "bushGreenSmall";
		private static const FL_BUSH_GREEN_SMALL_END:String = "bushGreenSmallEnd";
		private static const FL_COLOR_RED:String = "colorRed";
		private static const FL_COLOR_LIGHT_BLUE:String = "colorLightBlue";
		
		private static const FL_HILL_SMALL:String = "hillSmall";
		private static const FL_HILL_MEDIUM:String = "hillMedium";
		private static const FL_HILL_BIG:String = "hillBig";
		
		public static const FL_CLOUD_SMALL:String = "cloudSmall";
		private static const FL_CLOUD_SINGLE:String = "cloudSingle";
		private static const FL_CLOUD_DOUBLE:String = "cloudDouble";
		private static const FL_CLOUD_TRIPLE:String = "cloudTriple";
		
		private static const FL_FLAG:String = "flag";
		private static const FL_FLAG_END:String = "flagEnd";
		private static const FL_WAVES_LAVA:String = "wavesLava";
		private static const FL_WAVES_LAVA_END:String = "wavesLavaEnd";
		private static const FL_WAVES_NIGHT:String = "wavesNight";
		private static const FL_WAVES_NIGHT_END:String = "wavesNightEnd";
		private static const FL_WAVES_DAY_ODD:String = "wavesDayOdd";
		private static const FL_WAVES_DAY_ODD_END:String = "wavesDayOddEnd";
		private static const FL_WAVES_DAY_EVEN:String = "wavesDayEven";
		private static const FL_WAVES_DAY_EVEN_END:String = "wavesDayEvenEnd";
		private static const FL_CASTLE_SMALL:String = "castleSmall";
		public static const FL_CASTLE_BIG:String = "castleBig";
		public static const FL_TOAD_BOT:String = "toad";
//		private static const FL_TOAD_TOP:String = "sceneryToadTop";
		public static const FL_PRINCESS_BOT:String = "peach";
//		private static const FL_PRINCESS_TOP:String = "sceneryPrincessTop";
		public static const WAVE_BASE_STR:String = "wavesDay";
		private static const WATER_LAYERED_SKIN_NUM:Array = [ 1, 13 ];
		private static const TEXT_ADD_STR:String = "sceneryText_";
		private static var lastWaveStr:String;
		public var inFrontOfEverything:Boolean;
		public var topLayer:Boolean;
		public var bottomLayer:Boolean;
		public var layerable:Boolean;
		public var level:Level = GlobVars.level;
		protected var TILE_SIZE:int = level.TILE_SIZE;
		protected var HALF_TILE_SIZE:int = TILE_SIZE/2;
		private var GLOB_STG_RHT:int = Level.GLOB_STG_RHT;
		public var colKey:Number;
		public var rowKey:Number;
		protected var bmd:BmdSkinCont;
		protected var bmp:Bitmap;
		public var stopFrame:String;
		private var widthNum:Number;
		public var originalX:Number;
		public static var mapSkin:int; 
		private var animTmrSkinArr:Array;
		
		private static const BACK_LAYER_DCT:CustomDictionary = new CustomDictionary();
		private static const FRONT_LAYER_DCT:CustomDictionary = new CustomDictionary();
		private static const THEME_DCT:CustomDictionary = new CustomDictionary();
		{
			THEME_DCT.addItem(FL_BUSH_GREEN);
			THEME_DCT.addItem(FL_BUSH_GREEN_LEFT);
			THEME_DCT.addItem(FL_BUSH_GREEN_MID);
			THEME_DCT.addItem(FL_BUSH_GREEN_RIGHT);
			THEME_DCT.addItem(FL_BUSH_GREEN_SMALL);
			THEME_DCT.addItem("fence");
			
			THEME_DCT.addItem("standardPlatformStem");
			THEME_DCT.addItem("standardPlatformStemLft");
			THEME_DCT.addItem("standardPlatformStemMid");
			THEME_DCT.addItem("standardPlatformStemRht");
			THEME_DCT.addItem("standardPlatformStemSin");
			
			THEME_DCT.addItem("standardPlatformStemLftTop");
			THEME_DCT.addItem("standardPlatformStemMidTop");
			THEME_DCT.addItem("standardPlatformStemRhtTop");
			THEME_DCT.addItem("standardPlatformStemSinTop");
			
			THEME_DCT.addItem("");
			THEME_DCT.addItem("");
			THEME_DCT.addItem("");
			THEME_DCT.addItem("");
			
			THEME_DCT.addItem("railing");
			THEME_DCT.addItem("treeSmallTop");
			THEME_DCT.addItem("treeBigTop");
//			THEME_DCT.addItem("treeGreenLeavesSmall");
//			THEME_DCT.addItem("treeWhiteLeavesSmall");
//			THEME_DCT.addItem("treeGreenLeavesTop");
//			THEME_DCT.addItem("treeWhiteLeavesTop");
			THEME_DCT.addItem("treeSmallTrunk");
			THEME_DCT.addItem("treeBigTrunk");
			THEME_DCT.addItem("treeGreenLeavesBottom");
			THEME_DCT.addItem("treeWhiteLeavesBottom");
			
			FRONT_LAYER_DCT.addItem("railing");
			FRONT_LAYER_DCT.addItem(FL_CASTLE_BIG);
			FRONT_LAYER_DCT.addItem(FL_CASTLE_SMALL);
			
			BACK_LAYER_DCT.addItem(FL_WAVES_NIGHT);
			BACK_LAYER_DCT.addItem(FL_COLOR_LIGHT_BLUE);
			BACK_LAYER_DCT.addItem(WAVE_BASE_STR);
			BACK_LAYER_DCT.addItem(FL_WAVES_LAVA);
			BACK_LAYER_DCT.addItem(FL_COLOR_RED);
			BACK_LAYER_DCT.addItem(FL_CLOUD_SINGLE);
			BACK_LAYER_DCT.addItem(FL_CLOUD_SMALL);
			BACK_LAYER_DCT.addItem(FL_CLOUD_DOUBLE);
			BACK_LAYER_DCT.addItem(FL_CLOUD_TRIPLE);
			
			BACK_LAYER_DCT.addItem(FL_HILL_SMALL);
			BACK_LAYER_DCT.addItem(FL_HILL_MEDIUM);
			BACK_LAYER_DCT.addItem(FL_HILL_BIG);

			BACK_LAYER_DCT.addItem(FL_BUSH_GREEN);
			BACK_LAYER_DCT.addItem(FL_BUSH_GREEN_LEFT);
			BACK_LAYER_DCT.addItem(FL_BUSH_GREEN_MID);
			BACK_LAYER_DCT.addItem(FL_BUSH_GREEN_RIGHT);
			BACK_LAYER_DCT.addItem(FL_BUSH_GREEN_SMALL);

			BACK_LAYER_DCT.addItem("fence");
			BACK_LAYER_DCT.addItem("treeSmallTop");
			BACK_LAYER_DCT.addItem("treeBigTop");
			BACK_LAYER_DCT.addItem("treeSmallTrunk");
			BACK_LAYER_DCT.addItem("treeBigTrunk");
			BACK_LAYER_DCT.addItem("treeGreenLeavesBottom");
			BACK_LAYER_DCT.addItem("treeWhiteLeavesBottom");
		}
		
		public function Scenery(stopFrame:String)
		{
			if (stopFrame != null)
			{
				var ind:int = stopFrame.indexOf(Level.PROP_SEP);
				if (ind != -1)
					stopFrame = stopFrame.substring(0,ind);
			}
			if (THEME_DCT[stopFrame])
				inheritedForceShortClassName = "SceneryTheme";
			super();
			if (FRONT_LAYER_DCT[stopFrame] != undefined)
				topLayer = true;
			else if (BACK_LAYER_DCT[stopFrame] != undefined)
				bottomLayer = true;
			
			if (stopFrame && stopFrame.indexOf(WAVE_BASE_STR) != -1)
			{
				if (lastWaveStr == FL_WAVES_DAY_EVEN)
					lastWaveStr = FL_WAVES_DAY_ODD;
				else
					lastWaveStr = FL_WAVES_DAY_EVEN;
				stopFrame = lastWaveStr;
			}
//			addEventListener(Event.ADDED_TO_STAGE, addedLsr);
			addEventListener(Event.REMOVED_FROM_STAGE, removedLsr);
			gotoAndStop(stopFrame);
			this.stopFrame = stopFrame;
			var n:int = numChildren;
			if (stopFrame && stopFrame.indexOf(TEXT_ADD_STR) != -1)
			{
				var tfc:TextFieldContainer = new TextFieldContainer(FontCharHud.FONT_NUM);
				var text:String = stopFrame.substr(TEXT_ADD_STR.length);
				if (stopFrame == "sceneryText_WelcomeToWarpZone")
					text = "Welcome to Warp Zone!";
				else
					tfc.y = -16;
				tfc.text = text;
				masterObj.addChildToSingleFrame(tfc,currentFrame);
				masterObj.redraw(currentFrame);
				copySingleFrameFromOtherCmc(masterObj,currentFrame,currentFrame);
//				addChild(tfc);
			}
			/*sceneryText_WelcomeToWarpZone
			for (var i:int = 0; i < n; i++)
			{
				var child:DisplayObject = getChildAt(i);
				if (child is TextField)
					TextManager.INSTANCE.replaceStageTextField(child as TextField,new TextFieldContainer(FontCharHud.FONT_NUM),this);
			}*/
			widthNum = TILE_SIZE;
			checkIfAnimated();
		}
		
		private function checkIfAnimated():void
		{
			mainAnimTmr = null;
			if (stopFrame == FL_BUSH_GREEN_LEFT || stopFrame == FL_BUSH_GREEN_MID || stopFrame == FL_BUSH_GREEN_RIGHT || stopFrame == FL_BUSH_GREEN)
				mainAnimTmr = AnimationTimers.ANIM_SUPER_SLOWEST_TMR;
			else if (stopFrame == FL_WAVES_LAVA)
			{
//				animTmrSkinArr = [];
//				animTmrSkinArr[0] = AnimationTimers.ANIM_SUPER_SLOWEST_TMR;
				mainAnimTmr = AnimationTimers.ANIM_SLOWEST_TMR;
				layerable = true;
			}
			else if (stopFrame == FL_COLOR_RED)
				layerable = true;
			else if (stopFrame == FL_WAVES_NIGHT)
				mainAnimTmr = AnimationTimers.ANIM_SLOWEST_TMR;
			else if (stopFrame == FL_FLAG)
				mainAnimTmr = AnimationTimers.ANIM_SLOWEST_TMR;
//			else if (stopFrame == FL_WAVES_LAVA)
//				mainAnimTmr = AnimationTimers.ANIM_SLOWEST_TMR;
			else if (stopFrame == FL_WAVES_DAY_EVEN || stopFrame == FL_WAVES_DAY_ODD)
			{
				mainAnimTmr = AnimationTimers.ANIM_SLOWEST_TMR;
				layerable = true;
			}
			if (mainAnimTmr)
			{				
				if (animTmrSkinArr)
				{
					var n:int = BmdInfo.NUM_SKIN_SETS;
					for (var i:int = 0; i < n; i++) 
					{
						if (!animTmrSkinArr[i])
							animTmrSkinArr[i] = mainAnimTmr;
					}
				}
				setUpAnimation();
			}
		}
		public function setUpAnimation():void
		{
			stopAnim = false;
			level.ALWAYS_ANIM_DCT.addItem(this);
			ACTIVE_ANIM_TMRS_DCT.addItem(mainAnimTmr);
		}
		override public function animate(ct:ICustomTimer):Boolean
		{
			var cl:String = currentLabel;
			if (cl == FL_BUSH_GREEN_LEFT_END)
				gotoAndStop(FL_BUSH_GREEN_LEFT);
			else if (cl == FL_BUSH_GREEN_MID_END)
				gotoAndStop(FL_BUSH_GREEN_MID);
			else if (cl == FL_BUSH_GREEN_RIGHT_END)
				gotoAndStop(FL_BUSH_GREEN_RIGHT);
			else if (cl == FL_BUSH_GREEN_SMALL_END)
				gotoAndStop(FL_BUSH_GREEN_SMALL);
			else if (cl == FL_FLAG_END)
				gotoAndStop(FL_FLAG);
			else if (cl == FL_WAVES_LAVA_END)
				gotoAndStop(FL_WAVES_LAVA);
			else if (cl == FL_WAVES_DAY_EVEN_END)
				gotoAndStop(FL_WAVES_DAY_EVEN);
			else if (cl == FL_WAVES_DAY_ODD_END)
				gotoAndStop(FL_WAVES_DAY_ODD);
			else if (cl == FL_WAVES_NIGHT_END)
				gotoAndStop(FL_WAVES_NIGHT);
			else
				return super.animate(ct);
			return true;
		}
		
		public function checkStgPos():void
		{
			if (x + widthNum > level.locStgLft && x < level.locStgRht + HALF_TILE_SIZE )
			{
				if (parent != level)
					level.addChild(this);
			}
			else if (parent == level)
				level.removeChild(this);
		}
		public function updateOnSkinChange():Boolean
		{
//			var waterLayerSkin:Boolean;
//			
//			if ( WATER_LAYERED_SKIN_NUM.indexOf(mapSkin) != -1 )
//				waterLayerSkin = true;
//			else
//				waterLayerSkin = false;

			if (layerable)
			{
				if ( WATER_LAYERED_SKIN_NUM.indexOf(mapSkin) != -1 )
					inFrontOfEverything = true;
				else
					inFrontOfEverything = false;
			}
			if (!drawnFramesDct[currentFrame])
				gotoAndStop(currentFrame);
			if ( ( (currentLabel == FL_CASTLE_SMALL && y == 480 - TILE_SIZE*3 ) || currentLabel == FL_CASTLE_BIG ) && (mapSkin == 3 || mapSkin == 4 ) )
			{
				var thing:Bitmap
				if (mapSkin == 3)
				{
					thing = new BackgroundInfo.rep_003_castle();
				}
				else if (mapSkin == 4)
				{
					thing = new BackgroundInfo.rep_004_castle();
				}
				thing.scaleX = 2;
				thing.scaleY = 2;
				thing.y -= thing.height - TILE_SIZE - 64;
				var tileOfs:int = 6;
				if (currentLabel == "castleSmall")
					thing.x -= TILE_SIZE*2;
				else
					thing.x -= TILE_SIZE;
				if (x < 300) // at beginning of level
				{
					thing.scaleX = -thing.scaleX;
					if (currentLabel == "castleSmall")
						thing.x += thing.width/2 + TILE_SIZE*3;
					else
						thing.x += thing.width/2 + TILE_SIZE*4;
					thing.x -= tileOfs;
				}
				else
				{
					if (currentLabel == "castleSmall")
						thing.x += TILE_SIZE - tileOfs;
					else
						thing.x += TILE_SIZE*2;
				}
				if (height < thing.height)
				{
					addChild( thing );
					thing.x -= tileOfs;
//					thing.x = level.getNearestGrid(thing.x);
				}
				trace("thing.x: "+thing.x);
			}
			else if (currentLabel == "castleSmall" && y != 480 - TILE_SIZE*3)
			{
//				if (mapSkin != BmdInfo.SKIN_NUM_DEMON_RETURNS && mapSkin != 3)
				if (BmdInfo.hideTopCastleDct[mapSkin] == undefined)
					visible = true;
				else
					visible = false;
			}
			else if ( !(this is NPC) && (currentLabel == FL_TOAD_BOT || currentLabel == FL_PRINCESS_BOT) )
			{
				level.addToLevel( new NPC(this) );
				cleanUp();
			}
			if (animTmrSkinArr)
			{
				var tmr:CustomTimer = animTmrSkinArr[GameSettings.getMapSkinLimited()];
				if (tmr)
				{
					mainAnimTmr = tmr;
					ACTIVE_ANIM_TMRS_DCT.clear();
					ACTIVE_ANIM_TMRS_DCT.addItem(mainAnimTmr);
				}
			}
				
//			 this will only work on unanimated scenery
			if (width <= TILE_SIZE && currentLabel != "castleSmall" && currentLabel != "castleBig")
				return false;
			if (isNaN(originalX))
			{
				originalX = x;
			}
			x = originalX;
			for (var i:int = 0; i < numChildren; i++)
			{
				var child:DisplayObject = getChildAt(i);
				if (child is Bitmap)
				{
					x += child.x;
					child.x = 0;
				}
			}
			if (width < TILE_SIZE)
				widthNum = TILE_SIZE;
			else
				widthNum = width;
			return true;
//			trace("widthNum: "+widthNum+" width: "+width);
		}
		override protected function addedToStageHandler(event:Event):void
		{
			super.addedToStageHandler(event);
			level.SCENERY_STG_DCT.addItem(this);
		}
		protected function removedLsr(e:Event):void
		{
			level.SCENERY_STG_DCT.removeItem(this);
		}
		override public function cleanUp():void
		{
			level.SCENERY_DCT.removeItem(this);
			if (level.ALWAYS_ANIM_DCT[this])
				level.ALWAYS_ANIM_DCT.removeItem(this);
		}
		
	}
}