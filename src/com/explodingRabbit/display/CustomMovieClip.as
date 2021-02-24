package com.explodingRabbit.display
{
	
	import com.customClasses.MCAnimator;
	import com.explodingRabbit.utils.CustomDictionary;
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.characters.Bill;
	import com.smbc.characters.Character;
	import com.smbc.characters.Link;
	import com.smbc.characters.Mario;
	import com.smbc.characters.MegaMan;
	import com.smbc.characters.Ryu;
	import com.smbc.characters.Sophia;
	import com.smbc.characters.WarriorOfLight;
	import com.smbc.data.ARect;
	import com.smbc.data.AnimationTimers;
	import com.smbc.data.CharacterInfo;
	import com.smbc.data.EnemyInfo;
	import com.smbc.data.GameSettings;
	import com.smbc.data.HRect;
	import com.smbc.data.HitRectangle;
	import com.smbc.data.InterfaceInfo;
	import com.smbc.data.MapInfo;
	import com.smbc.data.MovieClipInfo;
	import com.smbc.data.PaletteTypes;
	import com.smbc.data.SecondaryHRect;
	import com.smbc.data.Themes;
	import com.smbc.enemies.Enemy;
	import com.smbc.enemies.Fly;
	import com.smbc.enemies.Goomba;
	import com.smbc.enemies.KoopaGreen;
	import com.smbc.graphics.BillTorso;
	import com.smbc.graphics.MasterObjects;
	import com.smbc.graphics.MegaManHead;
	import com.smbc.graphics.Palette;
	import com.smbc.graphics.PaletteSheet;
	import com.smbc.graphics.Scenery;
	import com.smbc.graphics.SimonWhip;
	import com.smbc.graphics.SkinMask;
	import com.smbc.graphics.SophiaBackWheel;
	import com.smbc.graphics.SophiaBase;
	import com.smbc.graphics.SubMc;
	import com.smbc.graphics.ThemeGroup;
	import com.smbc.graphics.BmdInfo;
	import com.smbc.graphics.BmdSkinCont;
	import com.smbc.ground.Ground;
	import com.smbc.ground.ItemBlock;
	import com.smbc.ground.SimpleGround;
	import com.smbc.interfaces.ICustomTimer;
	import com.smbc.interfaces.ITimeline;
	import com.smbc.main.GlobVars;
	import com.smbc.main.SkinObj;
	import com.smbc.managers.GraphicsManager;
	import com.smbc.managers.StatManager;
	import com.smbc.pickups.FlagPole;
	import com.smbc.pickups.Pickup;
	import com.smbc.projectiles.FireBar;
	import com.smbc.projectiles.Projectile;
	import com.smbc.projectiles.SophiaBullet;
	import com.smbc.utils.GameLoopTimer;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.filters.DisplacementMapFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.sampler.getLexicalScopes;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import flash.utils.flash_proxy;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import mx.core.MovieClipAsset;
	
//	import starling.display.Sprite;
	
	public class CustomMovieClip extends Sprite
	{
		public static const CHARACTER_MASTER_OBJ_DCT:CustomDictionary = new CustomDictionary();
		public static const ENEMY_MASTER_OBJ_DCT:CustomDictionary = new CustomDictionary();
		public static const THEME_MASTER_OBJ_DCT:CustomDictionary = new CustomDictionary();
		public static const MAP_MASTER_OBJ_DCT:CustomDictionary = new CustomDictionary();
		public static const INTERFACE_MASTER_OBJ_DCT:CustomDictionary = new CustomDictionary();
		public static const IND_FLASH_ARR_PAL_IN:int = 0;
		public static const IND_FLASH_ARR_PAL_OUT:int = 1;
		public static const IND_FLASH_ARR_IN_COLOR:int = 2;
		public static const IND_FLASH_ARR_OUT_COLOR:int = 3;
		public static const IND_MBMDT_TYPE:int = 0;
		public static const IND_MBMDT_CHAR_NUM:int = 1;
		private static const IND_MATRIX_SRC:int = 0;
		private static const IND_SCALE_X_SRC:int = 1;
		private static const IND_SCALE_Y_SRC:int = 2;
		private static const IND_ROTATION_SRC:int = 3;
		private static const IND_MATRIX_TEMP:int = 4;
		private static const IND_MASK_RECT_SRC:int = 0;
		private static const IND_MASK_RECT_TMP:int = 1;
		private static const IND_TRIM_BMD:int = 0;
		private static const IND_TRIM_RECT:int = 1;
		private static const IND_TRIM_MATRIX:int = 2;
		private static const PAL_LEN_ARR_IND_TYPE:int = 0;
		private static const PAL_LEN_ARR_IND_LENGTH:int = 1;
		private static const PAL_TYPE_FLASH_POWERING_UP:String = PaletteTypes.FLASH_POWERING_UP;
		private static const PAL_TYPE_FLASH_STAR:String = PaletteTypes.FLASH_STAR;
		private static const PAL_TYPE_P_STATE:String = PaletteTypes.P_STATE;
		protected var FRAME_VEC:Vector.< Vector.<DisplayObject> > = new Vector.<Vector.<DisplayObject>>();
		private var LAB_VEC:Vector.<String> = new Vector.<String>();
		protected var rectVec:Vector.<Dictionary> = new Vector.<Dictionary>();
		private var drawVec:Vector.<Dictionary>; // holds bitmap mask and colorRect
		public var renderedFramesDct:Dictionary = new Dictionary(); // contains frame numbers that have been rendered
		public var drawnFramesDct:Dictionary = new Dictionary(); // contains frames that have been redrawn to match master graphics
		private static const ZERO_PNT:Point = new Point();
		protected const ANIMATOR:MCAnimator = GlobVars.ANIMATOR;
		/**
		 * This is a palette that should contain two rows. The first row is the default colors on the sheet. The second
		 * row is the default colors currently being used. This is important when things need to flash to default colors.
		 */		
		public var defColors:Palette;
		public var flashPalette:Palette;
		protected static const IND_DEF_COLORS_IN:int = 0; 
		protected static const IND_DEF_COLORS_OUT:int = 1; 
		public var stopAnim:Boolean;
		public var mainAnimTmr:CustomTimer = AnimationTimers.ANIM_SLOW_TMR;
		protected var accurateAnimTmr:ICustomTimer;
		public var noAnimThisCycle:Boolean;
		public var checkFrameDuringStopAnim:Boolean;
		private var labObj:Object = {};
		public var STAT_VEC:Vector.<Dictionary> = new Vector.<Dictionary>();
		private var _currentFrame:int = 1;
		private var _currentFrameLabel:String;
		private var _currentLabels:Array = [];
		private var numFrames:int;
		private var mcClassObj:Class;
		public var shortClassName:String;
		protected var paletteObjectName:String;
//		public var shouldBeRedrawn:Boolean;
		public var fullClassName:String;
		public var classObj:Object;
		public var mcReplaceArr:Array;
		protected const currentBmpDct:CustomDictionary = new CustomDictionary(true);
		protected var useDefaultCreation:Boolean = true;
		public var masterObj:CustomMovieClip;
		public var masterBmdType:Array;
		public var masterBmdSkinCont:BmdSkinCont;
		public const ACTIVE_ANIM_TMRS_DCT:CustomDictionary = new CustomDictionary();
		public var masterBmd:BitmapData; // this is the bmd that data is read from
		protected var inheritedForceShortClassName:String;
		private var hRectDct:CustomDictionary = new CustomDictionary();
		private var dontDrawYet:Boolean;
		protected var copyPixelsOfsPnt:Point;
		protected var trim:Boolean = true;
		protected var thisIsMaster:Boolean;
		public var masterChildrenDct:Dictionary;  // for masters only, contains custommovieclips that need their bitmapdata relinked when master changes
		protected var curFlashPalType:String; // the current palette type being used for flashing
		public var palOrderArr:Array; // order of palettes on sheet
		protected var palLenArr:Array; // length of each palette type [ [ palType, length ], [ palType, length ] ];
		/**
		 * [ palArr:Array,inColorRow:int,outColorRow:int ]
		 */		
		protected var flashArr:Array; // [ palArr:Array,inColorRow:int,outColorRow:int ]
		protected var flashCtr:int;
		public var flashTmr:ICustomTimer;
		protected var palettePnt:Point;
		
		// I wish I could make the master CustomMovieClips into a separate class!

//		public static var skinInfoStr:String = '====================JSON Start======================\n{\n"spriteData":[';
//		public static var cmcInfoStr:String = '\n],\n"cmcData":[';
		public function CustomMovieClip(mc:Sprite = null, masterBmdType:Array = null, forceShortClassName:String = null, dontDrawYet:Boolean = false)
		{
			super();
			this.masterBmdType = masterBmdType;
			this.dontDrawYet = dontDrawYet;
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler, false, 0, true);
			if (mc)
				fullClassName = getQualifiedClassName(mc);
			else
				fullClassName = getQualifiedClassName(this);
			classObj = getDefinitionByName(fullClassName);
			if (forceShortClassName)
				shortClassName = forceShortClassName;
			else if (inheritedForceShortClassName)
				shortClassName = inheritedForceShortClassName;
			else
			{
				shortClassName = fullClassName.substr(fullClassName.indexOf("::") + 2);
				if (shortClassName.indexOf("MovieClipInfo_") != -1)
				{
					shortClassName = shortClassName.substr(14,shortClassName.length - 16); // also takes off Mc at end
				}
			}
			if (shortClassName.charAt(0) == "F")
			{
//				 turns off trim for Fonts
				if (shortClassName.indexOf("FontChar") != -1)
					trim = false;
			}
			//trace("full name: "+fullClassName+" name: "+shortClassName+" object: "+classObj);
			firstCall();
			if (!masterBmdType)
			{
				if ( (this is SkinObj || forceShortClassName || mc) && !(this is Character || this is SubMc) )
				{
					masterObj = MasterObjects[shortClassName+"Master"];
					if (masterObj)
					{
						this.masterBmdType = masterObj.masterBmdType;
						masterBmd = masterObj.masterBmd;
						masterBmdSkinCont = masterObj.masterBmdSkinCont;
						cloneFromMaster();
						return;
					}
				}
			}
			thisIsMaster = true;
			if (mc)
				createMasterFromMc(mc);
			else
			{
				 
				mcClassObj = MovieClipInfo[shortClassName+"Mc"]; 
				//trace("name: "+name+" classObj: "+classObj);
				if (mcClassObj)
					createMasterFromMc( new mcClassObj() );
				else
					createMasterFromMc( this );
			}
		}
		
		protected function addedToStageHandler(event:Event):void
		{
			if (!drawnFramesDct[_currentFrame])
				gotoAndStop(_currentFrame);
		}
		protected function firstCall():void // first function called, for children
		{
			
		}
		protected function prepareSkins():void
		{
			// for SkinObj
		}
		protected function mcReplacePrep(thisMc:MovieClip):void
		{
			// for characters mostly
		}
		public function cloneFromMaster(framesArr:Array = null):void
		{
			if (framesArr)
				return;
			setNumFrames(masterObj.numFrames,true);
			LAB_VEC = masterObj.LAB_VEC;
			_currentLabels = masterObj.currentLabels;
			labObj = masterObj.labObj;
			gotoAndStop(_currentFrame);
			masterObj.masterChildrenDct[this] = true;
			return;
			var n:int;
			var i:int;
			var num:int;
			if (framesArr)
			{
				n = framesArr.length;
				setNumFrames(n);
				for (i = 0; i < n; i++)
				{
					framesArr[i] = masterObj.convFrameToInt(framesArr[i]);
				}
				framesArr.sort(Array.NUMERIC);
				for (i = 0; i < n; i++)
				{
					num = framesArr[i];
					var newFrameNum:int = i+1;
					var lab:String = masterObj.LAB_VEC[num];
					LAB_VEC[newFrameNum] = lab;
					labObj[lab] = newFrameNum;
					_currentLabels[newFrameNum] = masterObj.currentLabels[num];
				}
				
				i = 0; // because not iterating directly over frames
				n--;
			}
			else
			{
				n = masterObj.totalFrames;
				setNumFrames(n);
				LAB_VEC = masterObj.LAB_VEC;
				_currentLabels = masterObj.currentLabels;
				labObj = masterObj.labObj;
				i = 1;
			}
			
		}
		/*public function setUpFlashPaletteOrder(palOrderArrOvRd:Array = null):void
		{			
			if (palOrderArrOvRd)
				palOrderArr = palOrderArrOvRd.concat();
			var palette:Palette = getPaletteByRow(0);
			var n:int = palette.length - 1; // -1 because last index is just a number
			var curLen:int = -1;
			palLenArr = null;
			for (var i:int = 0; i < n; i++) 
			{
				var color:uint = palette[i][0];
				curLen++;
				if (color == GraphicsManager.COLOR_NEW_FLASH_PALETTE)
				{
					if (!palLenArr) // first new palette
					{
						palLenArr = [];
						if (curLen > 0)
							palLenArr.push( [ PaletteTypes.UNKNOWN, curLen ] );
						curLen = 0;
					}
					else
					{
						palLenArr.push( [ palOrderArr[0], curLen ] );
						palOrderArr.shift();
						curLen = 0;
					}
				}
			}
			if (palLenArr)
				palLenArr.push( [ palOrderArr[0], curLen ] );
		}*/
		public function getPaletteByRow(row:int):Palette
		{
			var paletteSheet:PaletteSheet = getPaletteSheet();
//			if (!paletteSheet)
//				return null;
			var itemNum:int = getItemNum();
			var themeType:int = getThemeType();
			return paletteSheet.getPaletteFromRow( itemNum ,row, themeType, true );
		}
		protected function getThemeType():int
		{
			switch(masterBmdType[IND_MBMDT_TYPE])
			{
				case BmdSkinCont.TYPE_CHARACTER:
					return PaletteSheet.THEME_TYPE_CHARACTER;
				case BmdSkinCont.TYPE_ENEMY:
					return PaletteSheet.THEME_TYPE_ENEMY;
				case BmdSkinCont.TYPE_MAP:
					return PaletteSheet.THEME_TYPE_MAP;
				case BmdSkinCont.TYPE_THEME:
					return PaletteSheet.THEME_TYPE_MAP;
				case BmdSkinCont.TYPE_INTERFACE:
					return PaletteSheet.THEME_TYPE_INTERFACE;
			}
			return -1;
		}
		public function masterBmdTypeToStr(type:Array):String
		{
			if (!type)
			{
				if (shortClassName == "Ryu")
					return "ryu";
			}
			switch(type[IND_MBMDT_TYPE])
			{
				case BmdSkinCont.TYPE_CHARACTER:
					return CharacterInfo.convNumToName( type[IND_MBMDT_CHAR_NUM] );
				case BmdSkinCont.TYPE_ENEMY:
					return "enemy";
				case BmdSkinCont.TYPE_MAP:
					return "map";
				case BmdSkinCont.TYPE_THEME:
					return "theme";
				case BmdSkinCont.TYPE_INTERFACE:
					return "interface";
				case BmdSkinCont.TYPE_BACKGROUND:
					return "background";
			}
			return null;
		}
		protected function getPaletteSheet():PaletteSheet
		{
			switch(masterBmdType[IND_MBMDT_TYPE])
			{
				case BmdSkinCont.TYPE_CHARACTER:
					return BmdInfo.getCharPaletteSheet( masterBmdType[IND_MBMDT_CHAR_NUM ] );
				case BmdSkinCont.TYPE_ENEMY:
					return BmdInfo.getMainPaletteSheet( GameSettings.getEnemySkinLimited() );
				case BmdSkinCont.TYPE_MAP:
					return BmdInfo.getMainPaletteSheet( GameSettings.getMapSkinLimited() );
				case BmdSkinCont.TYPE_THEME:
					return BmdInfo.getMainPaletteSheet( GameSettings.getMapSkinLimited() );
				case BmdSkinCont.TYPE_INTERFACE:
					return BmdInfo.getMainPaletteSheet( GameSettings.getInterfaceSkinLimited() );
			}
			return null;
		}
		protected function getItemNum():int // won't work on some stuff
		{
			var num:int = 1;
			var name:String = shortClassName;
			if (paletteObjectName)
				name = paletteObjectName;
			switch(masterBmdType[IND_MBMDT_TYPE])
			{
				case BmdSkinCont.TYPE_CHARACTER:
				{
//					if ( !(this is Character) )
						return CharacterInfo.getCharClassFromNum( masterBmdType[IND_MBMDT_CHAR_NUM ],false )[Character.IND_CI_NAME+name];
//					return GraphicsManager.CHAR_INFO_VEC[ masterBmdType[IND_MBMDT_CHAR_NUM ] ][num];
				}
				case BmdSkinCont.TYPE_ENEMY:
					return EnemyInfo[ name ];
				case BmdSkinCont.TYPE_MAP:
					return MapInfo[ name ];
				case BmdSkinCont.TYPE_THEME:
					return MapInfo[ name ];
				case BmdSkinCont.TYPE_INTERFACE:
					return InterfaceInfo[ name ];
			}
			return -1;
		}
		public function resetColor(useCleanBmd:Boolean = false):void
		{
			relinkBmdToMasterSingleFrame(currentFrame);
		}
		protected function previousFrameLabelIs(lab:String):Boolean
		{
			if (currentFrame == convFrameToInt(lab) + 1)
				return true;
			return false;
		}
		public function initiate():void
		{
			if (flashTmr)
			{
				flashTmr.addEventListener(TimerEvent.TIMER,flashTmrHandler,false,0,true);
				flashTmr.start();
//				setUpFlashPaletteOrder();
			/*	var n:int = palOrderArr.length;
				for (var i:int = 0; i < n; i++) 
				{
					var palType:String = palOrderArr[i];
					if (palType.indexOf(PaletteTypes.PREFIX_FLASH) != -1)
						curFlashPalType = palType;
				}
				if (!curFlashPalType)
					curFlashPalType = palOrderArr[0];*/
			}
		}
		public function cleanUp():void
		{
			if (flashTmr)
				flashTmr.removeEventListener(TimerEvent.TIMER,flashTmrHandler);
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			/*if (masterObj)
			{
				var dct:CustomDictionary = masterObj.masterChildrenDct;
				if (dct)
					dct.removeItem(this);
			}*/
		}
		protected function flashTmrHandler(event:TimerEvent):void
		{
			flash();
		}
		public function resetFlashCtr():void
		{
			flashCtr = 0; // this will start on first row, not row 0
		}
		public function flash(incCtr:Boolean = true):void
		{
			if (incCtr)
				flashCtr++;
//			var palette:Palette = getPaletteByRow(0);
//			var flashPalette:Palette = palette.extractPaletteByColorType( Palette.COLOR_NEW_FLASH_PALETTE );
//			if (!defColors)
//				defColors = palette.extractRowsAsPalette(0,0);
			var numColorRows:int = flashPalette.numRows;
			var rowOfs:int;
			if ( flashCtr > numColorRows - 1 )
				flashCtr = 0;
//			trace("flashCtr: "+flashCtr+" rowOfs: "+rowOfs);
			setFlashArr(defColors, flashPalette, 1, rowOfs + flashCtr);
			recolorBmps(flashArr[IND_FLASH_ARR_PAL_IN], flashArr[IND_FLASH_ARR_PAL_OUT], flashArr[IND_FLASH_ARR_IN_COLOR], flashArr[IND_FLASH_ARR_OUT_COLOR]);
		}
		protected function setFlashArr(inPalette:Palette,outPalette:Palette,inColorRow:int = 0,outColorRow:int = 0):void
		{
			flashArr = [];
			flashArr[IND_FLASH_ARR_PAL_IN] = inPalette;
			flashArr[IND_FLASH_ARR_PAL_OUT] = outPalette;
			flashArr[IND_FLASH_ARR_IN_COLOR] = inColorRow;
			flashArr[IND_FLASH_ARR_OUT_COLOR] = outColorRow;
		}
		public function recolorBmps(inPalette:Palette,outPalette:Palette,inColorRow:int = 0,outColorRow:int = 0,defColorsOvrd:Palette = null):void
		{
			var gm:GraphicsManager = GraphicsManager.INSTANCE;
			if (outPalette.readColor(outColorRow,1) == GraphicsManager.COLOR_STANDARD_PALETTE) // this means it should use current colors
			{
				resetColor();
				return;
			}
			var defPalette:Palette = defColors;
			if (defColorsOvrd)
				defPalette = defColorsOvrd;
			var useGbColors:Boolean = Boolean( gm.getPalNumFromType( masterBmdSkinCont.type ) );
			var palNum:int;
			var palGroupNum:int;
			if (useGbColors)
			{
				useGbColors = gm.shouldBeRecoloredToGb( masterBmdSkinCont );
				if (useGbColors)
				{
					palNum = gm.getGBPalette(masterBmdSkinCont.type);
					palGroupNum = gm.getPaletteGroup(this);
					if ( !(this is Character || this is SubMc) )
						inPalette = inPalette.convToGameBoy( palNum, palGroupNum );
				}
			}
			resetColor(true);
			var bmpVec:Vector.<Bitmap> = getBmpsFromFrame();
			if (useGbColors)
				outPalette = outPalette.convToGameBoy( palNum, palGroupNum );
			for each (var bmp:Bitmap in bmpVec)
			{
				var bmd:BitmapData = bmp.bitmapData.clone();
				bmp.bitmapData = bmd;
				gm.recolorSingleBitmap(bmd,defPalette,defPalette,IND_DEF_COLORS_IN,IND_DEF_COLORS_OUT);
				gm.recolorSingleBitmap(bmd,inPalette,outPalette,inColorRow,outColorRow);
//				if (useGbColors)
//				{
//					gm.recolorToStanGbPalette(bmd,bmd.rect);
//					gm.recolorStanGbPalToCurGbPalSingle(bmd,masterBmdSkinCont.type,gm.getPaletteGroup(this));
//				}
			}
		}
		public function getBmpsFromFrame(frameNum:int = -1):Vector.<Bitmap>
		{
			var cf:int = currentFrame;
			if (frameNum == -1)
				frameNum = cf;
			if (cf != frameNum)
				gotoAndStop(frameNum);
			var vec:Vector.<Bitmap> = new Vector.<Bitmap>();
			for (var i:int = 0; i < numChildren; i++) 
			{
				var child:DisplayObject = getChildAt(i);
				if (child is Bitmap)
					vec.push(child as Bitmap);
			}
			if (cf != frameNum)
				gotoAndStop(cf);
			return vec;
		}
		protected function getNumPalRows(type:String):int
		{
			var n:int = palLenArr.length;
			for (var i:int = 0; i < n; i++) 
			{
				var curArr:Array = palLenArr[i];
				var curType:String = curArr[PAL_LEN_ARR_IND_TYPE];
				if (curType == type)
					return curArr[PAL_LEN_ARR_IND_LENGTH];
			}
			return 0;
		}
		protected function getPalRowOfs(type:String):int // returns y offset of row
		{
			var n:int = palLenArr.length;
			var lenCtr:int;
			for (var i:int = 0; i < n; i++) 
			{
				var curArr:Array = palLenArr[i];
				var curType:String = curArr[PAL_LEN_ARR_IND_TYPE];
				if (curType == type)
					return lenCtr; // 1 is added for standard palette row
				lenCtr += curArr[PAL_LEN_ARR_IND_LENGTH];
			}
			return 0;
		}
		public function clearFrame(frame:Object):void
		{
			var frameNum:int = convFrameToInt(frame);
			var currentFrameVec:Vector.<DisplayObject> = FRAME_VEC[frameNum];
			var statDct:Dictionary = STAT_VEC[frameNum];
			while (currentFrameVec.length)
			{
				var dispObj:DisplayObject = currentFrameVec.shift();
				delete statDct[dispObj];
			}
			if (currentFrame == frameNum)
				removeAllChildren();
		}
		protected function copySingleFrameFromOtherCmc(sourceObj:CustomMovieClip,sourceFrameNum:int,targetFrameNum:int):void
		{
			var hRectClass:Class;
			var newHRect:HRect;
			var sourceObjVec:Vector.<DisplayObject> = sourceObj.FRAME_VEC[sourceFrameNum];
			if (!sourceObjVec)
			{
				sourceObj.gotoAndStop(sourceFrameNum);
				sourceObjVec = sourceObj.FRAME_VEC[sourceFrameNum];
			}
			var sourceStatDct:Dictionary = sourceObj.STAT_VEC[sourceFrameNum];
			var objVec:Vector.<DisplayObject> = new Vector.<DisplayObject>(sourceObjVec.length);
			var statDct:Dictionary = new Dictionary();
			var foundHRect:Boolean;
			var n:int = sourceObjVec.length;
			for (var i:int = 0; i < n; i++)
			{
				var obj:DisplayObject = sourceObjVec[i];
				if (obj is Bitmap)
				{
					var newBmp:Bitmap = new Bitmap( Bitmap(obj).bitmapData );
					objVec[i] = newBmp;
					statDct[newBmp] = sourceStatDct[obj];
				}
				else if (obj is HRect)
				{
					hRectClass = Object(obj).constructor;
					for each (var child:DisplayObject in hRectDct)
					{
						if ( Object(child).constructor == hRectClass)
						{
							objVec[i] = child;
							statDct[child] = sourceStatDct[obj];
							foundHRect = true;
						}
					}
					if (!foundHRect)
					{
						newHRect = new hRectClass();
						hRectDct[newHRect] = newHRect;
						objVec[i] = newHRect;
						statDct[newHRect] = sourceStatDct[obj];
					}
				}
				else if (obj is CustomMovieClip)
				{
//					var newCmc:CustomMovieClip = new CustomMovieClip(null,null,"FireBarChild"); // specifically for FireBarChild... sorry!
					var newCmc:CustomMovieClip = new CustomMovieClip(null,null,CustomMovieClip(obj).shortClassName);
					objVec[i] = newCmc;
					statDct[newCmc] = sourceStatDct[obj];
				}
				else
				{
					objVec[i] = obj;
					statDct[obj] = sourceStatDct[obj];
				}
			}
			FRAME_VEC[targetFrameNum] = objVec;
			STAT_VEC[targetFrameNum] = statDct;
			renderedFramesDct[targetFrameNum] = targetFrameNum;
			gotoAndStop(_currentFrame);
		}
		public function relinkBmdToMasterSingleFrame(frame:Object = null):void
		{
//			if (!masterObj)
//				return;
			if (!frame)
				frame = currentFrame;
			var num:int = convFrameToInt(frame);
			if (!masterObj.renderedFramesDct[num])
				masterObj.redraw(num);
			drawnFramesDct[num] = num;
			var masterObjVec:Vector.<DisplayObject> = masterObj.FRAME_VEC[num];
			var objVec:Vector.<DisplayObject> = FRAME_VEC[num];
			var n:int = objVec.length;
			for (var i:int = 0; i < n; i++) 
			{
				var masterChild:DisplayObject = masterObjVec[i];
				if (masterChild is Bitmap)
				{
					var localChild:Bitmap = objVec[i] as Bitmap;
					localChild.bitmapData = (masterChild as Bitmap).bitmapData;
				}
			}
		}
		protected function getCleanMasterBmdSkinForReading():BmdSkinCont
		{
			var gm:GraphicsManager = GraphicsManager.INSTANCE;
			if (!masterBmdType)
				return null;
			switch(masterBmdType[IND_MBMDT_TYPE])
			{
				case BmdSkinCont.TYPE_CHARACTER:
					return gm.CLEAN_BMC_VEC_CHARACTER[ masterBmdType[IND_MBMDT_CHAR_NUM] ][ masterBmdSkinCont.skinNum ];
				case BmdSkinCont.TYPE_ENEMY:
					return gm.CLEAN_BMD_VEC_ENEMY[ GameSettings.getEnemySkinLimited(false, true) ]; 
				case BmdSkinCont.TYPE_MAP:
					return gm.CLEAN_BMD_VEC_MAP[ GameSettings.getMapSkinLimited() ];
				case BmdSkinCont.TYPE_THEME:
					return gm.CLEAN_BMD_VEC_THEME[ GameSettings.getMapSkinLimited() ];
				case BmdSkinCont.TYPE_INTERFACE:
					return gm.CLEAN_BMC_VEC_INTERFACE[ GameSettings.getInterfaceSkinLimited(false, true) ];
					/*case BmdSkinCont.TYPE_BACKGROUND:
					{
					var mc:MovieClip = obj as MovieClip;
					var n:int = mc.numChildren;
					for (var i:int = 0; i < n; i++)
					{
					var child:DisplayObject = mc.getChildAt(i);
					if (child is Bitmap)
					return Bitmap(child).bitmapData.clone();
					}
					}*/
			}
			return null;
		}
		private function getMasterBmd(obj:DisplayObjectContainer = null):BitmapData
		{
			var gm:GraphicsManager = GraphicsManager.INSTANCE;
			if (this is Character || this is SubMc)
				masterBmdType = [ BmdSkinCont.TYPE_CHARACTER, this["charNum"] ];
			if (!masterBmdType)
				return null;
			switch(masterBmdType[IND_MBMDT_TYPE])
			{
				case BmdSkinCont.TYPE_CHARACTER:
				{
					CHARACTER_MASTER_OBJ_DCT.addItem(shortClassName,this);
//					return gm.masterCharSkinVec[ this["charNum"] ].bmd;
					masterBmdSkinCont = gm.drawingBoardCharSkinVec[ masterBmdType[IND_MBMDT_CHAR_NUM] ];
					return masterBmdSkinCont.bmd;
				}
				case BmdSkinCont.TYPE_ENEMY:
				{
					ENEMY_MASTER_OBJ_DCT.addItem(this);
					masterBmdSkinCont = gm.drawingBoardEnemySkinCont;
					return masterBmdSkinCont.bmd; 
				}
				case BmdSkinCont.TYPE_MAP:
				{
					MAP_MASTER_OBJ_DCT.addItem(this);
					masterBmdSkinCont = gm.drawingBoardMapSkinCont;
					return masterBmdSkinCont.bmd;
				}
				case BmdSkinCont.TYPE_THEME:
				{
					THEME_MASTER_OBJ_DCT.addItem(this);
					masterBmdSkinCont = gm.drawingBoardThemeSkinCont;
					return masterBmdSkinCont.bmd;
				}
				case BmdSkinCont.TYPE_INTERFACE:
				{
					INTERFACE_MASTER_OBJ_DCT.addItem(this);
					masterBmdSkinCont = gm.drawingBoardInterfaceSkinCont;
					return masterBmdSkinCont.bmd;
				}
				/*case BmdSkinCont.TYPE_BACKGROUND:
				{
					var mc:MovieClip = obj as MovieClip;
					var n:int = mc.numChildren;
					for (var i:int = 0; i < n; i++)
					{
						var child:DisplayObject = mc.getChildAt(i);
						if (child is Bitmap)
							return Bitmap(child).bitmapData.clone();
					}
				}*/
			}
			return null;
		}
		protected function draw():void
		{
			//setUpLabelsFromMc(obj);
			var bmdScale:Number = GraphicsManager.BMD_SCALE;
			for (var i:int = 1; i <= numFrames; i++)
			{
				var currentFrameVec:Vector.<DisplayObject> = FRAME_VEC[i];
				var cDct:Dictionary = STAT_VEC[i];
				var bmpDct:Dictionary = new Dictionary();
				//gotoAndStop(i);
				var n:int = currentFrameVec.length;
				for (var j:int = 0; j < n; j++)
				{
					var child:DisplayObject = currentFrameVec[j];
					if (child is DisplayObjectContainer && !(child is HRect || child is CustomMovieClip) )
					{
						var doc:DisplayObjectContainer = child as DisplayObjectContainer;
						if (doc.numChildren && doc.getChildAt(0) is Bitmap)
						{
							var bmp:Bitmap = doc.getChildAt(0) as Bitmap;
							var skinMask:DisplayObject = currentFrameVec[j+1];
							moveSingleObjectToFrame(skinMask,i);
							moveSingleObjectToFrame(child,i);
							//gotoAndStop(i);
							//var maskStatArr: = Dictionary(STAT_VEC[i+1])[skinMask];
							//skinMask.x = 
							//var skinMask:DisplayObject = 
							var maskRect:Rectangle = skinMask.getBounds(bmp);
							var targetBmd:BitmapData = new BitmapData(maskRect.width,maskRect.height,true,0);
//							if (LAB_VEC[i] == "groundNormalTopLft")
//							{
//								infoStr += "class="+shortClassName+" name="+child.name+" label="+LAB_VEC[i]+" maskRect: "+maskRect+" globX="+skinMask.x/2+" globY="+skinMask.y/2+"\n";
//							var cmcName:String;
//							if (child is CustomMovieClip)
//								cmcName = CustomMovieClip(child.).shortClassName;
//							skinInfoStr += '\n{\n"className":"'+shortClassName+'",\n"instanceName":"'+child.name+'",\n"skinType":"'+masterBmdTypeToStr(masterBmdType)+'",\n"label":"'+LAB_VEC[i]+'",\n"currentFrame":'+i+',\n"x":'+Math.round(skinMask.x)/2+',\n"y":'+(-Math.round(skinMask.y)/2 )+',\n"rotation":'+Math.round(child.rotation*2)/2+',\n"uvX":'+Math.round(maskRect.x)+',\n"uvY":'+Math.round(maskRect.y)+',\n"uvWidth":'+Math.round(maskRect.width)+',\n"uvHeight":'+Math.round(maskRect.height)+'\n},';
//							}
							if (copyPixelsOfsPnt)
							{
//								trace("copyPixelsOfsPnt: "+copyPixelsOfsPnt);
								var orgXNum:Number = maskRect.x;
								var orgYNum:Number = maskRect.y;
								maskRect.x += copyPixelsOfsPnt.x;
								maskRect.y += copyPixelsOfsPnt.y;
								targetBmd.copyPixels(masterBmd,maskRect,ZERO_PNT);
								maskRect.x = orgXNum;
								maskRect.y = orgYNum;
							}
							else
								targetBmd.copyPixels(masterBmd,maskRect,ZERO_PNT);
							var colorBounds:Rectangle;
							var trimArr:Array;
							var matrix:Matrix = child.transform.matrix;
							matrix.scale(bmdScale,bmdScale);
							matrix.tx = skinMask.x;
							matrix.ty = skinMask.y;
							var transformArr:Array = [ matrix, child.scaleX, child.scaleY, child.rotation ];
							var maskRectArr:Array = [];
							if (trim)
								trimArr = trimBmp(targetBmd,maskRect,transformArr);
							var targetBmp:Bitmap;
							if (trimArr)
							{
								targetBmp = new Bitmap(trimArr[IND_TRIM_BMD]);
								maskRectArr[IND_MASK_RECT_TMP] = trimArr[IND_TRIM_RECT];
								transformArr[IND_MATRIX_TEMP] = trimArr[IND_TRIM_MATRIX];
							}
							else
								targetBmp = new Bitmap(targetBmd);
							maskRectArr[IND_MASK_RECT_SRC] = maskRect;
							bmpDct[targetBmp] = maskRectArr;
							cDct[targetBmp] = transformArr;
							targetBmp.name = child.name;
							currentFrameVec.push( targetBmp );
						}
					}
//					else if (child is CustomMovieClip && !(child is HRect) )
//					{
//						var cmc:CustomMovieClip = child as CustomMovieClip;
//						moveSingleObjectToFrame(child,i);
////						cmcInfoStr += '\n{\n"className":"'+shortClassName+'",\n"instanceName":"'+child.name+'",\n"cmcName":"'+cmc.shortClassName+'",\n"skinType":"'+masterBmdTypeToStr(masterBmdType)+'",\n"label":"'+LAB_VEC[i]+'",\n"currentFrame":'+i+',\n"x":'+Math.round(child.x)/2+',\n"y":'+(-Math.round(child.y)/2 )+',\n"rotation":'+Math.round(child.rotation*2)/2+'\n},';
//					}
//					else if (child is HRect && !(child is ARect) )
//					{
//						var cmc:CustomMovieClip = child as CustomMovieClip;
//						moveSingleObjectToFrame(child,i);
////						skinInfoStr += '\n{\n"className":"'+shortClassName+'",\n"instanceName": "hRect",\n"skinType":"'+masterBmdTypeToStr(masterBmdType)+'",\n"label":"'+LAB_VEC[i]+'",\n"currentFrame":'+i+',\n"x":'+Math.round(child.x)/2+',\n"y":'+(-Math.round( (child.y + child.height) )/2 )+',\n"uvWidth":'+Math.round(child.width)/2+',\n"uvHeight":'+Math.round(child.height)/2+'\n},';
//					}
					if ( !(child is HRect || child is CustomMovieClip) ) // same code as above
					{
						var ind:int = currentFrameVec.indexOf(child);
						currentFrameVec.splice(j,1);
						j--;
						n--;
						delete cDct[child];
					}
					if (child is MegaManHead)
						child.visible = false;
				}
				drawVec[i] = bmpDct;
			}
			setObjsToRemoveFromFrames();
		}
		/**
		 *This returns an array with the new bitmap, new rectangle, and the new matrix 
		 * @param tempBmd
		 * @param maskRect
		 * @param skinMask
		 * @param child
		 * @return 
		 * 
		 */		
		protected function trimBmp(tempBmd:BitmapData,maskRect:Rectangle,transformArr:Array):Array
		{
			var colorBounds:Rectangle = tempBmd.getColorBoundsRect(0xFFFFFFFF, 0, false);
			if (!colorBounds.height || !colorBounds.width)
				colorBounds = new Rectangle(0,0,1,1);
			var targetBmd:BitmapData;
			var difX:Number = 0;
			var difY:Number = 0;
			targetBmd = new BitmapData(colorBounds.width,colorBounds.height,true,0);
			targetBmd.copyPixels(tempBmd,colorBounds,ZERO_PNT);
			var tempRect:Rectangle = tempBmd.rect;
			difX = colorBounds.x - tempRect.x;
			difY = colorBounds.y - tempRect.y;
//			difX = tempRect.width - colorBounds.width
//			difY = tempRect.height - colorBounds.height;
			colorBounds.x = maskRect.x + difX;
			colorBounds.y = maskRect.y + difY; 
			difX *= transformArr[IND_SCALE_X_SRC];
			difY *= transformArr[IND_SCALE_Y_SRC];
			var rot:Number = transformArr[IND_ROTATION_SRC];
			if (rot != 0)
			{
//				I have no idea why, but this fixes sophia's rotations
				var num:Number;
				num = difX;
				if (rot == 180)
				{
					difX = -difX;
					difY = -difY;
				}
				else if (rot > 0)
				{
					difX = -difY;
					difY = num;
				}
				else
				{
					difX = difY;
					difY = -num;
				}
				
			}
			var matrix:Matrix = Matrix(transformArr[IND_MATRIX_SRC]).clone();
			var bmdScale:Number = GraphicsManager.BMD_SCALE;
			matrix.tx += difX*bmdScale;
			matrix.ty += difY*bmdScale;
//			bmpDct[targetBmp] = colorBounds;
			tempBmd.dispose();
			return [targetBmd, colorBounds, matrix ];
		}
		public function markForRedraw():void
		{
//			shouldBeRedrawn = true;
			drawnFramesDct = null;
			drawnFramesDct = new Dictionary();
			var ctr:int = 0;
			for (var obj:Object in masterChildrenDct)
			{
				var cmc:CustomMovieClip = obj as CustomMovieClip;
				cmc.drawnFramesDct = null;
				cmc.drawnFramesDct = new Dictionary();
				ctr++;
			}
//			if (shortClassName == "Ground" || shortClassName == "FontCharHud" || shortClassName == "FontCharMenu")
//				trace("----- "+shortClassName+": "+ctr);
		}
		public function redraw(frameNum:int = -1,bmdSub:BitmapData = null):void
		{
//			shouldBeRedrawn = false;
			var n:int = numFrames;
			var i:int = 1;
			var bmdToRead:BitmapData = masterBmd;
			if (bmdSub)
				bmdToRead = bmdSub;
			if (frameNum != -1)
			{
				i = frameNum;
				n = frameNum;
			}
			for (i; i <= n; i++)
			{
				var bmpDct:Dictionary = drawVec[i];
				var cTransformDct:Dictionary = STAT_VEC[i];
				drawnFramesDct[i] = i;
				for (var bmpObj:Object in bmpDct)
				{
					var maskRectArr:Array = bmpDct[bmpObj];
					var maskRectSrc:Rectangle = maskRectArr[IND_MASK_RECT_SRC];
//					var maskRectTmp:Rectangle = maskRectArr[IND_MASK_RECT_TMP];
					var bmp:Bitmap = Bitmap(bmpObj);
					var bmd:BitmapData;
					if (trim)
						bmd = new BitmapData(maskRectSrc.width,maskRectSrc.height,true,0);
					else
						bmd = bmp.bitmapData;
					if (copyPixelsOfsPnt)
					{
						var orgXNum:Number = maskRectSrc.x;
						var orgYNum:Number = maskRectSrc.y;
						maskRectSrc.x += copyPixelsOfsPnt.x;
						maskRectSrc.y += copyPixelsOfsPnt.y;
						bmd.copyPixels(masterBmd,maskRectSrc,ZERO_PNT);
						maskRectSrc.x = orgXNum;
						maskRectSrc.y = orgYNum;
					}
					else
						bmd.copyPixels(bmdToRead,maskRectSrc,ZERO_PNT);
					var transformArr:Array = cTransformDct[bmpObj];
					if (transformArr && trim)
					{
						var trimArr:Array = trimBmp(bmd,maskRectSrc,transformArr);
						if (trimArr)
						{
							transformArr[IND_MATRIX_TEMP] = trimArr[IND_TRIM_MATRIX];
							maskRectArr[IND_MASK_RECT_TMP] = trimArr[IND_TRIM_RECT];
							bmp.bitmapData = trimArr[IND_TRIM_BMD];
						}
					}
//					bmd.fillRect(bmd.rect,0);
				}
			}
//			if (thisIsMaster && trim)
//				relinkChildBitmaps();
		}
		
//		/**
//		 *for masters only, this relinks the bitmapdata of the children to the master 
//		 * 
//		 */		
		/*private function relinkChildBitmaps():void
		{
			for each (var cmc:CustomMovieClip in masterChildrenDct)
			{
				cmc.setUpCommonPalettes();
				for each (var frameNum:int in cmc.renderedFramesDct)
				{
					var masterObjVec:Vector.<DisplayObject> = FRAME_VEC[frameNum];
					var objVec:Vector.<DisplayObject> = cmc.FRAME_VEC[frameNum];
					if (!objVec)
						continue;
					var n:int = objVec.length;
					for (var i:int = 0; i < n; i++) 
					{
						var masterChild:DisplayObject = masterObjVec[i];
						if (masterChild is Bitmap)
						{
							var localChild:Bitmap = objVec[i] as Bitmap;
							localChild.bitmapData = (masterChild as Bitmap).bitmapData;
						}
					}
				}
				cmc.gotoAndStop(cmc.currentFrame);
			}
		}*/
		public function setUpCommonPalettes():void
		{
			if (!masterBmdType || masterBmdType[IND_MBMDT_TYPE] == BmdSkinCont.TYPE_BACKGROUND || this is Character)
				return;
			var sheetRowNum:int;
			var curColorsRow:int;
			var themeGroup:ThemeGroup;
			var characterType:Boolean;
			if (!masterBmdType)
				return;
			if (masterBmdType[IND_MBMDT_TYPE] == BmdSkinCont.TYPE_CHARACTER)
			{
				sheetRowNum = StatManager.STAT_MNGR.getCharSkinNum(masterBmdType[IND_MBMDT_CHAR_NUM]);
				characterType = true;
			}
			else
			{
				themeGroup = Themes.getThemeBySkinNum( GraphicsManager.INSTANCE.getSkinNum( masterBmdType[IND_MBMDT_TYPE] ) );
				sheetRowNum = themeGroup.setNum;
				curColorsRow = themeGroup.theme;
			}
			var palette:Palette = getPaletteByRow(sheetRowNum);
			defColors = palette.extractRowsAsPalette(0,curColorsRow);
			if (defColors.numRows < 2)
				defColors = palette.extractRowsAsPalette(0,0);
			if (sheetRowNum != 0 && !characterType)
				palette = getPaletteByRow(0);
			flashPalette = palette.extractPaletteByColorType( Palette.COLOR_NEW_FLASH_PALETTE );
		}
		protected function setObjsToRemoveFromFrames():void
		{
			
		}
		/**
		 * 
		 * @param obj
		 * @param framesArr
		 * @param keepTheseFrames
		 * @param changeVisOnly - 0 means invisible, 1 means visible
		 * 
		 */		
		protected function removeObjsFromFrames(obj:Object,framesArr:Array,keepTheseFrames:Boolean = false, changeVisOnly:int = -1):void
		{
			var n:int;
			var i:int;
			var frameNum:int;
			framesArr = framesArr.concat();
			n = framesArr.length;
			for (i=0; i < n; i++)
			{
				framesArr[i] = convFrameToInt(framesArr[i]);
			}
			framesArr.sort(Array.NUMERIC);
			var frameRemovalArr:Array = framesArr;
			if (keepTheseFrames)
			{
				frameRemovalArr = [];
				for (i=1; i <= totalFrames; i++)
				{
					frameNum = framesArr[0];
					if (i == frameNum)
						framesArr.shift();
					else
						frameRemovalArr.push(i);
				}
			}
			
			n = frameRemovalArr.length;
			for (i=0; i < n; i++)
			{
				frameNum = frameRemovalArr[i];
				var objVec:Vector.<DisplayObject> = FRAME_VEC[frameNum];
				var n2:int = objVec.length;
				for (var j:int = 0; j < n2; j++)
				{
					var child:DisplayObject = objVec[j];
					if (child == obj || (obj is Class && child is Class(obj) ) || ( obj is String && child.name == String(obj) ) )
					{
						if (changeVisOnly != -1)
						{
							if (changeVisOnly == 0)
								child.visible = false;
							else
								child.visible = true;
							continue;
						}
						objVec.splice(j,1);
						j--;
						n2--;
						var statDct:Dictionary = STAT_VEC[frameNum];
						delete statDct[child];
						if (contains(child))
							removeChild(child);
						//trace("removed "+child+" from frame "+frameNum);
					}
				}
			}
		}
		public function convFrameToInt(frame:Object):int
		{
			var num:int;
			if (frame is int)
				num = int(frame);
			else
				num = labObj[frame];
			if (num < 1 || num > numFrames)
				throw new Error("frame is outside of range");
			return num;
		}
		protected function createMasterFromMc(obj:DisplayObjectContainer):void
		{
			masterChildrenDct = new Dictionary(true);
			drawVec = new Vector.<Dictionary>();
			setUpLabelsFromMc(obj);
			var mc:MovieClip;
			if (obj is MovieClip)
				mc = obj as MovieClip;
		//	trace("create "+classObj);
			mcReplacePrep(mc);
			masterBmd = getMasterBmd(obj);
			for (var i:int = 1; i <= numFrames; i++)
			{
				if (mc)
					mc.gotoAndStop(i);
				var currentFrameVec:Vector.<DisplayObject> = new Vector.<DisplayObject>();
				var rectDct:Dictionary = new Dictionary();
				var cDct:Dictionary = new Dictionary(true);
				var n:int = obj.numChildren;
				for (var j:int = 0; j < n; j++)
				{
					var child:DisplayObject = obj.getChildAt(j);
					if (child is SkinMask)
						DisplayObject(obj.getChildAt(j-1)).mask = child;
					else if (child is HRect)
					{
						var hRect:Rectangle = new HitRectangle(child as HRect);
						rectDct[hRect] = hRect;
					}
					else if (!masterBmd)
					{
						var cont:DisplayObjectContainer = null;
						if (child is DisplayObjectContainer)
							cont = child as DisplayObjectContainer;
						if (cont && cont.numChildren && cont.getChildAt(0) is Bitmap)
							masterBmd = Bitmap(cont.getChildAt(0)).bitmapData.clone();
					}
					currentFrameVec.push( child );
					//cDct[child] = [ child.x, child.y, child.scaleX, child.scaleY, child.rotation ];
					cDct[child] = [ child.transform.matrix ];
				}
				FRAME_VEC[i] = currentFrameVec;
				var lab:String;
				if (mc)
					lab = mc.currentFrameLabel;
				LAB_VEC[i] = lab;
				labObj[lab] = i;
				STAT_VEC[i] = cDct;
				rectVec[i] = rectDct;
			}
			if (mcReplaceArr)
				replaceSubMovieClips();
			if (!dontDrawYet)
				finalCreateMaster();
		}
		public function finalCreateMaster():void
		{
			draw();
			if (this is Character && Character(this).putSubMcsOnTop)
				reorderItems();
			gotoAndStop(1);
			prepareSkins();			
		}
		private function reorderItems():void
		{
			for (var i:int = 1; i <= numFrames; i++)
			{
				var currentFrameVec:Vector.<DisplayObject> = FRAME_VEC[i];
				currentFrameVec.sort(sortDisplayObjects);
			}
		}
		protected function sortDisplayObjects(obj1:DisplayObject,obj2:DisplayObject):int
		{
			if (obj1 is Bitmap && obj2 is SubMc)
				return -1;
			else if (obj1 is SubMc && obj2 is Bitmap)
				return 1
			else
				return 0;
		}
		private function moveSingleObjectToFrame(obj:DisplayObject,frameNum:int):void
		{
			var arr:Array = STAT_VEC[frameNum][obj];
			/*obj.x = arr[IND_X];
			obj.y = arr[IND_Y];
			obj.scaleX = arr[IND_SCALE_X];
			obj.scaleY = arr[IND_SCALE_Y];
			obj.rotation = arr[IND_ROTATION];*/
			obj.transform.matrix = arr[0];
			//trace("x: "+obj.x+" y: "+obj.y+" width: "+obj.width+" height: "+obj.height);
		}
		public function frameIsEmpty(frame:Object):Boolean
		{
			var num:int = convFrameToInt(frame);
			var currentFrameVec:Vector.<DisplayObject> = FRAME_VEC[num];
			if (!currentFrameVec)
			{
				copySingleFrameFromOtherCmc(masterObj,num,num);
//				gotoAndStop(num);
				currentFrameVec = FRAME_VEC[num];
			}
			var isEmpty:Boolean;
			var n:int = currentFrameVec.length;
			var vec:Vector.<Bitmap> = getBmpsFromFrame(num);
			for each (var bmp:Bitmap in vec)
			{
				if (!bmp.visible)
					continue;
				var bmd:BitmapData = bmp.bitmapData;
				var bounds:Rectangle = bmd.getColorBoundsRect(0xFF000000,0xFF000000);
				if (bounds.width != 0 || bounds.height != 0)
					return false;
			}
			return true;
		}
		private function setUpLabelsFromMc(obj:DisplayObjectContainer):void
		{
			var mc:MovieClip;
			if (!(obj is MovieClip) )
			{
				setNumFrames(1);
				_currentLabels = [null];
			}
			else
			{
				mc = MovieClip(obj);
				setNumFrames(mc.totalFrames);
				_currentLabels = mc.currentLabels.concat();
			}
		}
		public function replaceSubMovieClips():void
		{
			var n:int = STAT_VEC.length;
			var numMatched:int = 0;
			var matchTemp:Array = mcReplaceArr;
			for (var i:int = 1; i < n; i++)
			{
				var dct:Dictionary = STAT_VEC[ i ];
				var currentFrameVec:Vector.<DisplayObject> = FRAME_VEC[ i ];
//				if (this is Sophia)
//					trace("length: "+currentFrameVec.length);
				numMatched = 0;
				var keysToReplace:Array = [];
				var keysToDelete:Array = [];
				for (var key:Object in dct)
				{
					var child:DisplayObject = key as DisplayObject;
					var arr:Array = dct[child];
					//if (!arr)
					//	throw new Error();
					var n2:int = mcReplaceArr.length;
					for ( var j:int = 0; j < n2; j++)
					{
						var mcToBeReplaced:MovieClip = mcReplaceArr[j];
						//trace("mcToBeReplaced: "+mcToBeReplaced);
						if (child == mcToBeReplaced)
						{
							numMatched++;
							var mcReplacer:DisplayObject = mcReplaceArr[j+1];
//							trace("mcToBeReplaced: "+mcToBeReplaced+" mcReplacer: "+mcReplacer);
							keysToReplace.push( [ mcReplacer, arr ] );
							keysToDelete.push( child );
//							dct[mcReplacer] = arr;
//							delete dct[child];
							var n3:int = currentFrameVec.length;
							for ( var k:int = 0; k < n3; k++)
							{
								var vecChild:DisplayObject = currentFrameVec[k];
								if (vecChild == mcToBeReplaced)
									currentFrameVec[k] = mcReplacer;
							}
							//trace("mc: "+mcToBeReplaced+" replacer: "+mcReplacer+" arr: "+arr);
						}
						j++;
					}
				}
//				modify dct
				for each( var arr1:Array in keysToReplace)
				{
					dct[ arr1[0] ] = arr1[1];
				}
				for each( var delObj:DisplayObject in keysToDelete)
				{
					delete dct[delObj];
				}
//				if (this is Sophia && numMatched < 3)
//					trace("berak");
			}
			if (this is Bill)
				DisplayObject(mcReplaceArr[3]).transform.matrix = DisplayObject(mcReplaceArr[2]).transform.matrix;
			mcReplaceArr = null;
		}
		public function addChildToSingleFrame(child:DisplayObject,frame:Object):void
		{
			var frameNum:int = convFrameToInt(frame);
			if (FRAME_VEC[frameNum] == null)
				FRAME_VEC[frameNum] = new Vector.<DisplayObject>();
			FRAME_VEC[frameNum].push(child);
			if (STAT_VEC[frameNum] == null)
				STAT_VEC[frameNum] = new Dictionary();
			STAT_VEC[frameNum][child] = [ child.transform.matrix, child.scaleX, child.scaleY, child.rotation ];
		}
		
		/*public function removeChildFromSingleFrame(child:DisplayObject,frame:Object):void
		{
			var frameNum:int = convFrameToInt(frame);
			FRAME_VEC[frameNum].splice(
			STAT_VEC[frameNum][child] = [ child.transform.matrix, child.scaleX, child.scaleY, child.rotation ];
		}*/
		public function setChildPoperty(child:DisplayObject,property:String,value:Number,singleFrame:Object = null):void
		{
//			throw new Error("not set up");
			var frameNum:int;
			var cf:int = currentFrame;
			if (singleFrame)
			{
				if (singleFrame is String)
					frameNum = convFrameToInt(singleFrame);
				else
					frameNum = int(singleFrame);
			}			
			var n:int = numFrames;
			var i:int = 1;
//			if (singleFrame = -1)
			if (frameNum)
			{
				i = frameNum;
				n = frameNum;
				gotoAndStop(frameNum);
			}
			child[property] = value;
			var matrix:Matrix = child.transform.matrix;
			for (i; i <= n; i++)
			{
				var dct:Dictionary = STAT_VEC[ i ];
				var arr:Array = dct[child];
				arr[IND_MATRIX_SRC] = matrix;
			}
//			if (frameNum)
//				gotoAndStop(cf);
		}
		public function setNumFrames(value:int,cloning:Boolean = false):void
		{
			numFrames = value;
			var arr:Array;
			if (!cloning)
			{
				arr = [ FRAME_VEC, LAB_VEC, STAT_VEC, rectVec ];
				if (drawVec)
					arr.push(drawVec);
				labObj = {};
				_currentLabels.length = 0;
				_currentLabels.length = n;
			}
			else
				arr = [FRAME_VEC, STAT_VEC];
			var n:int = arr.length;
			for (var i:int; i < n; i++)
			{
				var vec:* = arr[i];
				vec.fixed = false;
				vec.length = 0; // removes everything
				vec.length = value + 1;
				vec.fixed = true;
			}
		}
		public function gotoAndPlay(frame:Object, scene:String = null):void
		{
			
		}
		public function gotoAndStop(frame:Object, scene:String = null):void
		{
			if (frame is int)
				_currentFrame = int(frame);
			else if (frame is String)
				_currentFrame = labObj[frame];
			if (_currentFrame <= 0)
				_currentFrame = 1;
			else if (_currentFrame > numFrames)
				_currentFrame = numFrames;
			_currentFrameLabel = LAB_VEC[_currentFrame];
			removeAllChildren();
			currentBmpDct.clear();
			var vec:Vector.<DisplayObject> = FRAME_VEC[_currentFrame];
			if (!vec)
			{
				copySingleFrameFromOtherCmc(masterObj,_currentFrame,_currentFrame);
				return;
			}
			else if (!drawnFramesDct[_currentFrame])
			{
				if (thisIsMaster)
					redraw(_currentFrame);
				else
					relinkBmdToMasterSingleFrame();
			}
			var statDct:Dictionary = STAT_VEC[_currentFrame];
//			var rectDct:Dictionary = rectVec[_currentFrame];
			var n:int = vec.length;
			for (var i:int; i < n; i++)
			{
				var child:DisplayObject = vec[i];
				addChild(child);
				var arr:Array = statDct[child];
				//trace("child: "+child+" arr: "+arr+" currentFrame: "+_currentFrame);
				/*child.x = arr[IND_X];
				child.y = arr[IND_Y];
				child.scaleX = arr[IND_SCALE_X];
				child.scaleY = arr[IND_SCALE_Y];
				child.rotation = arr[IND_ROTATION];*/
				var matrix:Matrix = arr[IND_MATRIX_TEMP];
				if (!matrix)
					matrix = arr[IND_MATRIX_SRC];
				child.transform.matrix = matrix;
				//child.visible = arr[IND_VISIBLE];
				/*if (this is FlagPole)
				{
					trace("child: "+child+" x: "+child.x+" y: "+child.y+" height: "+child.height+" width: "+child.width);
					if (child is MegaManHead)
						removeChild(child);
					else if (child is Bitmap)
						currentBmpDct.addItem(child);
				}*/
			}
		}
		public function play():void
		{
			
		}
		public function stop():void
		{
			
		}
		public function animate(ct:ICustomTimer):Boolean
		{
			if (!stopAnim)
			{
				if (ct == mainAnimTmr || ct == accurateAnimTmr)
				{
					if (!noAnimThisCycle)
					{
						ANIMATOR.animate(this);
						return true;
					}
					else
						noAnimThisCycle = false;
				}
			}
			return false;
		}
		private function removeAllChildren():void
		{
			var n:int = numChildren;
			for (var i:int; i < n; i++)
			{
				removeChildAt(0);
			}
		}
		public function checkFrame():void
		{
			// for Character class
		}
		private function getVisibleBounds():Rectangle
		{
			var vec:Vector.<DisplayObject> = FRAME_VEC[_currentFrame];
			var rect:Rectangle;
			for each (var obj:DisplayObject in vec)
			{
				if (obj is Bitmap)
					rect = Bitmap(obj).bitmapData.getColorBoundsRect(0xFFFFFFFF,0x000000, false);
			}
			return rect;
		}
		// getters
		override public function get height():Number
		{
			//if (!(this is Character))
				return super.height;
			/*var num:Number = getVisibleBounds().height * scaleY;
			if (num < 0)
				num = -num;
			return num;*/
		}
		override public function get width():Number
		{
			return super.width;
			/*var num:Number = getVisibleBounds().width * scaleX;
			if (num < 0)
				num = -num;
			return num;*/
		}
		public function get currentFrame():int
		{
			return _currentFrame;
		}

		public function get currentLabel():String
		{
			if (_currentFrameLabel != null)
				return _currentFrameLabel;
			var label:String;
			for (var i:int = _currentFrame; i > 0; i--)
			{
				label = LAB_VEC[i];
				if (label != null)
					break;
			}
			return label;
		}
		public function get currentFrameLabel():String
		{
			return _currentFrameLabel;
		}

		public function get totalFrames():int
		{
			return numFrames;
		}
		public function get currentLabels():Array
		{
			return _currentLabels;
		}

	}
}