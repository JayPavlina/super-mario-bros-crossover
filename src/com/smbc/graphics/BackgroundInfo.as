package com.smbc.graphics
{
	import com.explodingRabbit.utils.ArrayUtils;
	import com.explodingRabbit.utils.CustomDictionary;
	import com.explodingRabbit.utils.StringUtils;
	import com.smbc.data.BackgroundNames;
	import com.smbc.data.LevelTypes;
	import com.smbc.data.MovieClipInfo;
	import com.smbc.data.Themes;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.utils.Dictionary;
	
	import org.osmf.net.StreamingURLResource;

	public final class BackgroundInfo
	{
		public static const OBJ:Object = {};
		public static const SEP:String = "_";
		public static const NO_SCROLL:Number = 0;
		public static const SMA_SLOW:Number = .250;
		public static const SMA_MID:Number = .525;
		public static const SMA_FAST:Number = .800;
		public static const REG_SCROLL:int = Background.SCROLL_SPEED_NORMAL;
		private static const BG_ARR:Array = [];
		private static const FG_ARR:Array = [];
		private static const EXTRA_THEME_ARR:Array = [];
		private static const BG_SET_ARR:Array = [];
		private static var bgSetOvrdDct:CustomDictionary = new CustomDictionary();
		public static const THEME_OVRD_VEC:Vector.<Dictionary> = new Vector.<Dictionary>();
		private static const TYPE_BG:String = Background.TYPE_BG;
		private static const TYPE_FG:String = Background.TYPE_FG;
		public static const TYPE_MAP_OVRD:String = "ovrd";
		public static const TYPE_THEME:String = "thm";
		public static const IND_SET_ARR_BG:int = 0;
		public static const IND_SET_ARR_FG:int = 1;
		public static const IND_SET_ARR_MAP_OVRD:int = 2;
		public static const IND_DATA_TYPE:int = StringUtils.IND_DATA_TYPE;
		public static const IND_DATA_SKIN:int = StringUtils.IND_DATA_SKIN;
		public static const IND_DATA_THEME:int = StringUtils.IND_DATA_THEME;
		public static const IND_DATA_SET:int = StringUtils.IND_DATA_SET;
		public static const IND_DATA_LAYER:int = StringUtils.IND_DATA_LAYER;
		public static const NUM_THEMES_ON_SHEET:int = 9;
		private static const THEME_MIN:int = Themes.MIN_THEME;
		public static const SET_MIN:int = 1;
		
//		-------------------------------------------------------------------------------------------------------------------
//		000 Super Mario Bros. NES
//		-------------------------------------------------------------------------------------------------------------------
		[Embed(source="../assets/images/skins/000/backgrounds/bg_000_01_01_00.png")]
		public static const bg_000_01_01_00:Class;		{ addBg( bg_000_01_01_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/000/backgrounds/bg_000_01_02_00.png")]
		public static const bg_000_01_02_00:Class;		{ addBg( bg_000_01_02_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/000/backgrounds/bg_000_01_03_00.png")]
		public static const bg_000_01_03_00:Class;		{ addBg( bg_000_01_03_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/000/backgrounds/bg_000_01_04_00.png")]
		public static const bg_000_01_04_00:Class;		{ addBg( bg_000_01_04_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/000/backgrounds/bg_000_01_05_00.png")]
		public static const bg_000_01_05_00:Class;		{ addBg( bg_000_01_05_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/000/backgrounds/bg_000_01_06_00.png")]
		public static const bg_000_01_06_00:Class;		{ addBg( bg_000_01_06_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/000/backgrounds/bg_000_01_07_00.png")]
		public static const bg_000_01_07_00:Class;		{ addBg( bg_000_01_07_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/000/backgrounds/bg_000_01_08_00.png")]
		public static const bg_000_01_08_00:Class;		{ addBg( bg_000_01_08_00, REG_SCROLL ); }

		[Embed(source="../assets/images/skins/000/backgrounds/bg_000_01_09_00.png")]
		public static const bg_000_01_09_00:Class;		{ addBg( bg_000_01_09_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/000/backgrounds/bg_000_02_01_00.png")]
		public static const bg_000_02_01_00:Class;		{ addBg( bg_000_02_01_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/000/backgrounds/bg_000_02_02_00.png")]
		public static const bg_000_02_02_00:Class;		{ addBg( bg_000_02_02_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/000/backgrounds/bg_000_03_01_00.png")]
		public static const bg_000_03_01_00:Class;		{ addBg( bg_000_03_01_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/000/backgrounds/bg_000_03_02_00.png")]
		public static const bg_000_03_02_00:Class;		{ addBg( bg_000_03_02_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/000/backgrounds/bg_000_03_03_00.png")]
		public static const bg_000_03_03_00:Class;		{ addBg( bg_000_03_03_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/000/backgrounds/bg_000_03_04_00.png")]
		public static const bg_000_03_04_00:Class;		{ addBg( bg_000_03_04_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/000/backgrounds/bg_000_04_01_00.png")]
		public static const bg_000_04_01_00:Class;		{ addBg( bg_000_04_01_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/000/backgrounds/bg_000_04_02_00.png")]
		public static const bg_000_04_02_00:Class;		{ addBg( bg_000_04_02_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/000/backgrounds/bg_000_05_01_00.png")]
		public static const bg_000_05_01_00:Class;		{ addBg( bg_000_05_01_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/000/backgrounds/bg_000_05_02_00.png")]
		public static const bg_000_05_02_00:Class;		{ addBg( bg_000_05_02_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/000/backgrounds/bg_000_06_01_00.png")]
		public static const bg_000_06_01_00:Class;		{ addBg( bg_000_06_01_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/000/backgrounds/bg_000_06_02_00.png")]
		public static const bg_000_06_02_00:Class;		{ addBg( bg_000_06_02_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/000/backgrounds/bg_000_07_01_00.png")]
		public static const bg_000_07_01_00:Class;		{ addBg( bg_000_07_01_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/000/backgrounds/bg_000_07_02_00.png")]
		public static const bg_000_07_02_00:Class;		{ addBg( bg_000_07_02_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/000/backgrounds/bg_000_08_01_00.png")]
		public static const bg_000_08_01_00:Class;		{ addBg( bg_000_08_01_00, NO_SCROLL ); }

//		-------------------------------------------------------------------------------------------------------------------
//		001 Super Mario Bros. SNES
//		-------------------------------------------------------------------------------------------------------------------
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_01_01_00.png")]
		public static const bg_001_01_01_00:Class;		{ addBg( bg_001_01_01_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_01_01_01.png")]
		public static const bg_001_01_01_01:Class;		{ addBg( bg_001_01_01_01, SMA_SLOW ); }

		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_01_01_02.png")]
		public static const bg_001_01_01_02:Class;		{ addBg( bg_001_01_01_02, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_01_02_00.png")]
		public static const bg_001_01_02_00:Class;		{ addBg( bg_001_01_02_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_01_02_01.png")]
		public static const bg_001_01_02_01:Class;		{ addBg( bg_001_01_02_01, SMA_SLOW ); }
		
		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="bg_001_01_02_02")]
		public static const bg_001_01_02_02:Class;		{ addBg( bg_001_01_02_02, SMA_MID, true, 120, "bg_001_01_02_02" ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_01_03_00.png")]
		public static const bg_001_01_03_00:Class;		{ addBg( bg_001_01_03_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_01_03_01.png")]
		public static const bg_001_01_03_01:Class;		{ addBg( bg_001_01_03_01, SMA_SLOW ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_01_03_02.png")]
		public static const bg_001_01_03_02:Class;		{ addBg( bg_001_01_03_02, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_01_04_00.png")]
		public static const bg_001_01_04_00:Class;		{ addBg( bg_001_01_04_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_01_04_01.png")]
		public static const bg_001_01_04_01:Class;		{ addBg( bg_001_01_04_01, SMA_SLOW ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_01_04_02.png")]
		public static const bg_001_01_04_02:Class;		{ addBg( bg_001_01_04_02, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_01_05_00.png")]
		public static const bg_001_01_05_00:Class;		{ addBg( bg_001_01_05_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_01_05_01.png")]
		public static const bg_001_01_05_01:Class;		{ addBg( bg_001_01_05_01, SMA_SLOW ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_01_05_02.png")]
		public static const bg_001_01_05_02:Class;		{ addBg( bg_001_01_05_02, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_01_05_03.png")]
		public static const bg_001_01_05_03:Class;		{ addBg( bg_001_01_05_03, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_01_06_00.png")]
		public static const bg_001_01_06_00:Class;		{ addBg( bg_001_01_06_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_01_06_01.png")]
		public static const bg_001_01_06_01:Class;		{ addBg( bg_001_01_06_01, SMA_SLOW ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_01_06_02.png")]
		public static const bg_001_01_06_02:Class;		{ addBg( bg_001_01_06_02, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_01_07_00.png")]
		public static const bg_001_01_07_00:Class;		{ addBg( bg_001_01_07_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_01_07_01.png")]
		public static const bg_001_01_07_01:Class;		{ addBg( bg_001_01_07_01, SMA_SLOW ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_01_07_02.png")]
		public static const bg_001_01_07_02:Class;		{ addBg( bg_001_01_07_02, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_01_08_00.png")]
		public static const bg_001_01_08_00:Class;		{ addBg( bg_001_01_08_00, NO_SCROLL ); }
		
		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="BgNightStars")]
		public static const bg_001_01_08_01:Class;		{ addBg( bg_001_01_08_01, SMA_SLOW, true, 135, "BgNightStars" ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_01_09_00.png")]
		public static const bg_001_01_09_00:Class;		{ addBg( bg_001_01_09_00, NO_SCROLL ); }
		
		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="BgNightStars")]
		public static const bg_001_01_09_01:Class;		{ addBg( bg_001_01_09_01, SMA_SLOW, true, 135, "BgNightStars" ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_01_09_02.png")]
		public static const bg_001_01_09_02:Class;		{ addBg( bg_001_01_09_02, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_01_10_00.png")]
		public static const bg_001_01_10_00:Class;		{ addBg( bg_001_01_10_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_01_10_01.png")]
		public static const bg_001_01_10_01:Class;		{ addBg( bg_001_01_10_01, SMA_SLOW ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_02_01_00.png")]
		public static const bg_001_02_01_00:Class;		{ addBg( bg_001_02_01_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_02_01_01.png")]
		public static const bg_001_02_01_01:Class;		{ addBg( bg_001_02_01_01, SMA_SLOW ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_02_01_02.png")]
		public static const bg_001_02_01_02:Class;		{ addBg( bg_001_02_01_02, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_02_02_00.png")]
		public static const bg_001_02_02_00:Class;		{ addBg( bg_001_02_02_00, NO_SCROLL ); }
		
		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="BgNightStars")]
		public static const bg_001_02_02_01:Class;		{ addBg( bg_001_02_02_01, SMA_SLOW, true, 135, "BgNightStars" ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_02_02_02.png")]
		public static const bg_001_02_02_02:Class;		{ addBg( bg_001_02_02_02, SMA_MID ); }
		
		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="BgUnderGround")]
		public static const bg_001_03_01_00:Class;		{ addBg( bg_001_03_01_00, SMA_MID, true, 140, "BgUnderGround" ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_03_02_00.png")]
		public static const bg_001_03_02_00:Class;		{ addBg( bg_001_03_02_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_03_02_01.png")]
		public static const bg_001_03_02_01:Class;		{ addBg( bg_001_03_02_01, SMA_SLOW ); }

		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="BgUnderGround")]
		public static const bg_001_03_03_00:Class;		{ addBg( bg_001_03_03_00, SMA_MID, true, 140, "BgUnderGround" ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/fg_001_03_03_00.png")]
		public static const fg_001_03_03_00:Class;		{ addBg( fg_001_03_03_00, NO_SCROLL, true, 0, null, WaterHaze, BlendMode.SCREEN ); }

		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="BgUnderGround")]
		public static const bg_001_03_04_00:Class;		{ addBg( bg_001_03_04_00, SMA_MID, true, 140, "BgUnderGround" ); }

		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_04_01_00.png")]
		public static const bg_001_04_01_00:Class;		{ addBg( bg_001_04_01_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_04_01_01.png")]
		public static const bg_001_04_01_01:Class;		{ addBg( bg_001_04_01_01, SMA_MID, true, 0, null, WaterShiftingBg ); }
		
//		[Embed(source="../assets/images/skins/001/backgrounds/fg_001_04_01_00.png")]
//		public static const fg_001_04_01_00:Class;		{ addBg( fg_001_04_01_00, NO_SCROLL, true, 0, null, WaterHaze ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/fg_001_04_01_00.png")]
		public static const fg_001_04_01_00:Class;		{ addBg( fg_001_04_01_00, NO_SCROLL, true, 0, null, WaterHaze, BlendMode.SCREEN ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_04_02_00.png")]
		public static const bg_001_04_02_00:Class;		{ addBg( bg_001_04_02_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_04_02_01.png")]
		public static const bg_001_04_02_01:Class;		{ addBg( bg_001_04_02_01, SMA_MID, true, 0, null, WaterShiftingBg ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/fg_001_04_02_00.png")]
		public static const fg_001_04_02_00:Class;		{ addBg( fg_001_04_02_00, NO_SCROLL, true, 0, null, WaterHaze, BlendMode.SCREEN ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_05_01_00.png")]
		public static const bg_001_05_01_00:Class;		{ addBg( bg_001_05_01_00, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_05_02_00.png")]
		public static const bg_001_05_02_00:Class;		{ addBg( bg_001_05_02_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_05_02_01.png")]
		public static const bg_001_05_02_01:Class;		{ addBg( bg_001_05_02_01, SMA_MID, true, 0, null, WaterShiftingBg ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/fg_001_05_02_00.png")]
		public static const fg_001_05_02_00:Class;		{ addBg( fg_001_05_02_00, NO_SCROLL, true, 0, null, WaterHaze, BlendMode.SCREEN ); }
		
		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="bg_001_05_03_00")]
		public static const bg_001_05_03_00:Class;		{ addBg( bg_001_05_03_00, SMA_MID, true, 140, "bg_001_05_03_00" ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_06_01_00.png")]
		public static const bg_001_06_01_00:Class;		{ addBg( bg_001_06_01_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_06_01_01.png")]
		public static const bg_001_06_01_01:Class;		{ addBg( bg_001_06_01_01, SMA_SLOW ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_06_01_02.png")]
		public static const bg_001_06_01_02:Class;		{ addBg( bg_001_06_01_02, SMA_MID ); }

		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_06_02_00.png")]
		public static const bg_001_06_02_00:Class;		{ addBg( bg_001_06_02_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_06_02_01.png")]
		public static const bg_001_06_02_01:Class;		{ addBg( bg_001_06_02_01, SMA_SLOW ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_06_02_02.png")]
		public static const bg_001_06_02_02:Class;		{ addBg( bg_001_06_02_02, SMA_MID ); }

		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_06_02_03.png")]
		public static const bg_001_06_02_03:Class;		{ addBg( bg_001_06_02_03, SMA_MID ); }

		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_07_01_00.png")]
		public static const bg_001_07_01_00:Class;		{ addBg( bg_001_07_01_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_07_01_01.png")]
		public static const bg_001_07_01_01:Class;		{ addBg( bg_001_07_01_01, SMA_MID ); }

		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_07_02_00.png")]
		public static const bg_001_07_02_00:Class;		{ addBg( bg_001_07_02_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_07_02_01.png")]
		public static const bg_001_07_02_01:Class;		{ addBg( bg_001_07_02_01, SMA_MID ); }

		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_08_01_00.png")]
		public static const bg_001_08_01_00:Class;		{ addBg( bg_001_08_01_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_08_01_01.png")]
		public static const bg_001_08_01_01:Class;		{ addBg( bg_001_08_01_01, SMA_SLOW ); }

		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_08_02_00.png")]
		public static const bg_001_08_02_00:Class;		{ addBg( bg_001_08_02_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_08_02_01.png")]
		public static const bg_001_08_02_01:Class;		{ addBg( bg_001_08_02_01, SMA_SLOW ); }

		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_08_03_00.png")]
		public static const bg_001_08_03_00:Class;		{ addBg( bg_001_08_03_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_08_03_01.png")]
		public static const bg_001_08_03_01:Class;		{ addBg( bg_001_08_03_01, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_08_03_02.png")]
		public static const bg_001_08_03_02:Class;		{ addBg( bg_001_08_03_02, SMA_SLOW ); }

		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_08_04_00.png")]
		public static const bg_001_08_04_00:Class;		{ addBg( bg_001_08_04_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_08_04_01.png")]
		public static const bg_001_08_04_01:Class;		{ addBg( bg_001_08_04_01, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_08_04_02.png")]
		public static const bg_001_08_04_02:Class;		{ addBg( bg_001_08_04_02, SMA_SLOW ); }

		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_09_01_00.png")]
		public static const bg_001_09_01_00:Class;		{ addBg( bg_001_09_01_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_10_01_00.png")]
		public static const bg_001_10_01_00:Class;		{ addBg( bg_001_10_01_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_10_01_01.png")]
		public static const bg_001_10_01_01:Class;		{ addBg( bg_001_10_01_01, SMA_MID, true, 0, null, WaterShiftingBg ); }

		[Embed(source="../assets/images/skins/001/backgrounds/fg_001_10_01_00.png")]
		public static const fg_001_10_01_00:Class;		{ addBg( fg_001_10_01_00, NO_SCROLL, true, 0, null, WaterHaze, BlendMode.SCREEN ); }

		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_11_01_00.png")]
		public static const bg_001_11_01_00:Class;		{ addBg( bg_001_11_01_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/bg_001_11_01_01.png")]
		public static const bg_001_11_01_01:Class;		{ addBg( bg_001_11_01_01, SMA_MID, true, 0, null, WaterShiftingBg ); }
		
		[Embed(source="../assets/images/skins/001/backgrounds/fg_001_11_01_00.png")]
		public static const fg_001_11_01_00:Class;		{ addBg( fg_001_11_01_00, NO_SCROLL, true, 0, null, WaterHaze, BlendMode.SCREEN ); }

		{(function ():void{
			var bigHills:int = 1;
			var waterFall:int = 2;
			var smallGreenHills:int = 3;
			var goombaStatues:int = 4;
			var forest:int = 5;
			var smallBrownHills:int = 6;
			var castleWalls:int = 7;
			var nightWithoutTrees:int = 8;
			var nightWithTrees:int = 9;
			
			addOvRd(1,"2-1a",Themes.NORMAL,smallGreenHills);
			addOvRd(1,"3-1c",Themes.COIN_HEAVEN,2);
			addOvRd(1,"3-3a",Themes.NORMAL,nightWithoutTrees);
			addOvRd(1,"4-1a",Themes.NORMAL,forest);
			addOvRd(1,"4-2c",Themes.PLATFORM);
			addOvRd(1,"4-3a",Themes.PLATFORM);
			addOvRd(1,"6-2d",Themes.COIN_HEAVEN,2);
			addOvRd(1,"6-3a",Themes.NORMAL,nightWithoutTrees);
			addOvRd(1,"7-1a",Themes.SNOW);
			addOvRd(1,"8-2a",Themes.NORMAL,smallBrownHills);
			addOvRd(1,"8-3a",Themes.NORMAL,castleWalls);
			
			addOvRd(1,"3",Themes.SNOW,2,9);
			addOvRd(1,"5",Themes.SNOW,1,9);
			addOvRd(1,"6",Themes.NORMAL,nightWithTrees,9);
			
			addOvRd(1,LevelTypes.PLATFORM,Themes.NORMAL,waterFall);
			addOvRd(1,LevelTypes.CHEEP_CHEEP,Themes.NORMAL,goombaStatues);
		}() );}
		
//		-------------------------------------------------------------------------------------------------------------------
//		002 Super Mario Land 2
//		-------------------------------------------------------------------------------------------------------------------
//		[Embed(source="../assets/images/skins/002/backgrounds/bg_002_01_01_00.png")]
//		public static const bg_002_01_01_00:Class;		{ addBg( bg_002_01_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="bg_002_01_01_00")]
		public static const bg_002_01_01_00:Class;		{ addBg( bg_002_01_01_00, REG_SCROLL, true, 120, "bg_002_01_01_00" ); }
		
		[Embed(source="../assets/images/skins/002/backgrounds/bg_002_01_02_00.png")]
		public static const bg_002_01_02_00:Class;		{ addBg( bg_002_01_02_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/002/backgrounds/bg_002_01_03_00.png")]
		public static const bg_002_01_03_00:Class;		{ addBg( bg_002_01_03_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/002/backgrounds/bg_002_01_04_00.png")]
		public static const bg_002_01_04_00:Class;		{ addBg( bg_002_01_04_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/002/backgrounds/bg_002_02_01_00.png")]
		public static const bg_002_02_01_00:Class;		{ addBg( bg_002_02_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/002/backgrounds/bg_002_03_01_00.png")]
		public static const bg_002_03_01_00:Class;		{ addBg( bg_002_03_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/002/backgrounds/bg_002_03_02_00.png")]
		public static const bg_002_03_02_00:Class;		{ addBg( bg_002_03_02_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/002/backgrounds/bg_002_04_01_00.png")]
		public static const bg_002_04_01_00:Class;		{ addBg( bg_002_04_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/002/backgrounds/bg_002_05_01_00.png")]
		public static const bg_002_05_01_00:Class;		{ addBg( bg_002_05_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/002/backgrounds/bg_002_06_01_00.png")]
		public static const bg_002_06_01_00:Class;		{ addBg( bg_002_06_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/002/backgrounds/bg_002_07_01_00.png")]
		public static const bg_002_07_01_00:Class;		{ addBg( bg_002_07_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/002/backgrounds/bg_002_08_01_00.png")]
		public static const bg_002_08_01_00:Class;		{ addBg( bg_002_08_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/002/backgrounds/bg_002_09_01_00.png")]
		public static const bg_002_09_01_00:Class;		{ addBg( bg_002_09_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/002/backgrounds/bg_002_10_01_00.png")]
		public static const bg_002_10_01_00:Class;		{ addBg( bg_002_10_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="bg_002_11_01_00")]
		public static const bg_002_11_01_00:Class;		{ addBg( bg_002_11_01_00, REG_SCROLL, true, 140, "bg_002_11_01_00" ); }
		
		[Embed(source="../assets/images/skins/002/backgrounds/bg_002_12_01_00.png")]
		public static const bg_002_12_01_00:Class;		{ addBg( bg_002_12_01_00, REG_SCROLL ); }
		
//		-------------------------------------------------------------------------------------------------------------------
//		003 Super Mario Bros. 3 NES
//		-------------------------------------------------------------------------------------------------------------------
		private static const SKIN_SMB3:int = 3;
		[Embed(source="../assets/images/skins/003/backgrounds/bg_003_01_01_00.png")]
		public static const bg_003_01_01_00:Class;		{ addBg( bg_003_01_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/003/backgrounds/bg_003_01_02_00.png")]
		public static const bg_003_01_02_00:Class;		{ addBg( bg_003_01_02_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/003/backgrounds/bg_003_02_01_00.png")]
		public static const bg_003_02_01_00:Class;		{ addBg( bg_003_02_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/003/backgrounds/bg_003_03_01_00.png")]
		public static const bg_003_03_01_00:Class;		{ addBg( bg_003_03_01_00, REG_SCROLL ); }

		[Embed(source="../assets/images/skins/003/backgrounds/bg_003_03_02_00.png")]
		public static const bg_003_03_02_00:Class;		{ addBg( bg_003_03_02_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/003/backgrounds/bg_003_04_01_00.png")]
		public static const bg_003_04_01_00:Class;		{ addBg( bg_003_04_01_00, REG_SCROLL ); }

		[Embed(source="../assets/images/skins/003/backgrounds/bg_003_04_02_00.png")]
		public static const bg_003_04_02_00:Class;		{ addBg( bg_003_04_02_00, REG_SCROLL ); }

		[Embed(source="../assets/images/skins/003/backgrounds/bg_003_04_03_00.png")]
		public static const bg_003_04_03_00:Class;		{ addBg( bg_003_04_03_00, REG_SCROLL ); }

		[Embed(source="../assets/images/skins/003/backgrounds/bg_003_05_01_00.png")]
		public static const bg_003_05_01_00:Class;		{ addBg( bg_003_05_01_00, REG_SCROLL ); }

		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="fg_003_05_02_00")]
		public static const fg_003_05_01_00:Class;		{ addBg( fg_003_05_01_00, REG_SCROLL, true, 60, "fg_003_05_02_00", RisingWater ); }

		[Embed(source="../assets/images/skins/003/backgrounds/bg_003_05_02_00.png")]
		public static const bg_003_05_02_00:Class;		{ addBg( bg_003_05_02_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/003/backgrounds/bg_003_05_03_00.png")]
		public static const bg_003_05_03_00:Class;		{ addBg( bg_003_05_03_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/003/backgrounds/bg_003_05_04_00.png")]
		public static const bg_003_05_04_00:Class;		{ addBg( bg_003_05_04_00, REG_SCROLL ); }

		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="fg_003_05_02_00")]
		public static const fg_003_05_04_00:Class;		{ addBg( fg_003_05_04_00, REG_SCROLL, true, 60, "fg_003_05_02_00", RisingWater ); }

		[Embed(source="../assets/images/skins/003/backgrounds/bg_003_05_05_00.png")]
		public static const bg_003_05_05_00:Class;		{ addBg( bg_003_05_05_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/003/backgrounds/bg_003_05_06_00.png")]
		public static const bg_003_05_06_00:Class;		{ addBg( bg_003_05_06_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/003/backgrounds/bg_003_05_07_00.png")]
		public static const bg_003_05_07_00:Class;		{ addBg( bg_003_05_07_00, REG_SCROLL ); }

		[Embed(source="../assets/images/skins/003/backgrounds/bg_003_05_08_00.png")]
		public static const bg_003_05_08_00:Class;		{ addBg( bg_003_05_08_00, REG_SCROLL ); }

		[Embed(source="../assets/images/skins/003/backgrounds/bg_003_05_09_00.png")]
		public static const bg_003_05_09_00:Class;		{ addBg( bg_003_05_09_00, REG_SCROLL ); }

		[Embed(source="../assets/images/skins/003/backgrounds/bg_003_05_10_00.png")]
		public static const bg_003_05_10_00:Class;		{ addBg( bg_003_05_10_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/003/backgrounds/bg_003_06_01_00.png")]
		public static const bg_003_06_01_00:Class;		{ addBg( bg_003_06_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/003/backgrounds/bg_003_07_01_00.png")]
		public static const bg_003_07_01_00:Class;		{ addBg( bg_003_07_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/003/backgrounds/bg_003_08_01_00.png")]
		public static const bg_003_08_01_00:Class;		{ addBg( bg_003_08_01_00, REG_SCROLL ); }

		[Embed(source="../assets/images/skins/003/backgrounds/bg_003_08_02_00.png")]
		public static const bg_003_08_02_00:Class;		{ addBg( bg_003_08_02_00, REG_SCROLL ); }

		[Embed(source="../assets/images/skins/003/backgrounds/bg_003_09_01_00.png")]
		public static const bg_003_09_01_00:Class;		{ addBg( bg_003_09_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/003/backgrounds/bg_003_10_01_00.png")]
		public static const bg_003_10_01_00:Class;		{ addBg( bg_003_10_01_00, REG_SCROLL ); }

		[Embed(source="../assets/images/skins/003/backgrounds/bg_003_10_02_00.png")]
		public static const bg_003_10_02_00:Class;		{ addBg( bg_003_10_02_00, REG_SCROLL ); }

		[Embed(source="../assets/images/skins/003/backgrounds/bg_003_10_03_00.png")]
		public static const bg_003_10_03_00:Class;		{ addBg( bg_003_10_03_00, REG_SCROLL ); }

		[Embed(source="../assets/images/skins/003/backgrounds/bg_003_11_01_00.png")]
		public static const bg_003_11_01_00:Class;		{ addBg( bg_003_11_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/003/backgrounds/bg_003_11_02_00.png")]
		public static const bg_003_11_02_00:Class;		{ addBg( bg_003_11_02_00, REG_SCROLL ); }

		[Embed(source="../assets/images/skins/003/backgrounds/bg_003_12_01_00.png")]
		public static const bg_003_12_01_00:Class;		{ addBg( bg_003_12_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/003/backgrounds/bg_003_13_01_00.png")]
		public static const bg_003_13_01_00:Class;		{ addBg( bg_003_13_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/003/backgrounds/bg_003_14_01_00.png")]
		public static const bg_003_14_01_00:Class;		{ addBg( bg_003_14_01_00, REG_SCROLL ); }

		[Embed(source="../assets/images/skins/003/backgrounds/bg_003_15_01_00.png")]
		public static const bg_003_15_01_00:Class;		{ addBg( bg_003_15_01_00, REG_SCROLL ); }

		// replacements
		[Embed(source="../assets/images/skins/003/backgrounds/rep_003_castle.png")]
		public static const rep_003_castle:Class;
		
		/*[Embed(source="../assets/images/skins/003/backgrounds/ovrd_003_00_01.png")]
		public static const ovrd_003_00_01:Class;		{ bgSetOvrdDct.addItem(ovrd_003_00_01); }

		[Embed(source="../assets/images/skins/003/backgrounds/ovrd_003_02_01.png")]
		public static const ovrd_003_02_01:Class;		{ bgSetOvrdDct.addItem(ovrd_003_02_01); }
		
		[Embed(source="../assets/images/skins/003/backgrounds/ovrd_003_04_00.png")]
		public static const ovrd_003_04_00:Class;		{ bgSetOvrdDct.addItem(ovrd_003_04_00); }

		[Embed(source="../assets/images/skins/003/backgrounds/ovrd_003_04_01.png")]
		public static const ovrd_003_04_01:Class;		{ bgSetOvrdDct.addItem(ovrd_003_04_01); }

		[Embed(source="../assets/images/skins/003/backgrounds/ovrd_003_09_01.png")]
		public static const ovrd_003_09_01:Class;		{ bgSetOvrdDct.addItem(ovrd_003_09_01); }*/
		
//		[Embed(source="../assets/images/skins/003/backgrounds/thm_003_10.png")]
//		public static const thm_003_10:Class;			{ addExtraTheme(thm_003_10); }


//		-------------------------------------------------------------------------------------------------------------------
//		004 Super Mario Bros. 3 SNES
//		-------------------------------------------------------------------------------------------------------------------
		[Embed(source="../assets/images/skins/004/backgrounds/bg_004_01_01_00.png")]
		public static const bg_004_01_01_00:Class;		{ addBg( bg_004_01_01_00, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/004/backgrounds/bg_004_01_01_01.png")]
		public static const bg_004_01_01_01:Class;		{ addBg( bg_004_01_01_01, SMA_SLOW ); }
		
		[Embed(source="../assets/images/skins/004/backgrounds/bg_004_01_02_00.png")]
		public static const bg_004_01_02_00:Class;		{ addBg( bg_004_01_02_00, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/004/backgrounds/bg_004_01_03_00.png")]
		public static const bg_004_01_03_00:Class;		{ addBg( bg_004_01_03_00, SMA_MID ); }
		
		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="bg_004_01_03_01")]
		public static const bg_004_01_03_01:Class;		{ addBg( bg_004_01_03_01, SMA_SLOW, true, 140, "bg_004_01_03_01" ); }
		
		[Embed(source="../assets/images/skins/004/backgrounds/bg_004_02_01_00.png")]
		public static const bg_004_02_01_00:Class;		{ addBg( bg_004_02_01_00, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/004/backgrounds/bg_004_02_01_01.png")]
		public static const bg_004_02_01_01:Class;		{ addBg( bg_004_02_01_01, SMA_SLOW ); }
		
		[Embed(source="../assets/images/skins/004/backgrounds/bg_004_02_02_00.png")]
		public static const bg_004_02_02_00:Class;		{ addBg( bg_004_02_02_00, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/004/backgrounds/bg_004_02_02_01.png")]
		public static const bg_004_02_02_01:Class;		{ addBg( bg_004_02_02_01, SMA_SLOW ); }
		
		[Embed(source="../assets/images/skins/004/backgrounds/bg_004_03_01_00.png")]
		public static const bg_004_03_01_00:Class;		{ addBg( bg_004_03_01_00, SMA_MID ); }

		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="bg_004_03_02_00")]
		public static const bg_004_03_02_00:Class;		{ addBg( bg_004_03_02_00, SMA_SLOW, true, 140, "bg_004_03_02_00" ); }
		
		[Embed(source="../assets/images/skins/004/backgrounds/bg_004_03_03_00.png")]
		public static const bg_004_03_03_00:Class;		{ addBg( bg_004_03_03_00, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/004/backgrounds/bg_004_04_01_00.png")]
		public static const bg_004_04_01_00:Class;		{ addBg( bg_004_04_01_00, SMA_MID ); }

		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="fg_004_04_01_01")]
		public static const fg_004_04_01_01:Class;		{ addBg( fg_004_04_01_01, REG_SCROLL, true, 140, "fg_004_04_01_01", null, BlendMode.SCREEN ); }

		[Embed(source="../assets/images/skins/004/backgrounds/bg_004_05_01_00.png")]
		public static const bg_004_05_01_00:Class;		{ addBg( bg_004_05_01_00, SMA_SLOW ); }

		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="bg_004_05_01_01")]
		public static const bg_004_05_01_01:Class;		{ addBg( bg_004_05_01_01, SMA_SLOW, true, 140, "bg_004_05_01_01" ); }

		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="fg_004_05_01_01")]
		public static const fg_004_05_01_01:Class;		{ addBg( fg_004_05_01_01, REG_SCROLL, true, 60, "fg_004_05_01_01", RisingWater ); }
		
		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="bg_004_06_01_00")]
		public static const bg_004_06_01_00:Class;		{ addBg( bg_004_06_01_00, SMA_SLOW, true, 140, "bg_004_06_01_00" ); }

		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="bg_004_06_01_00")]
		public static const bg_004_06_02_00:Class;		{ addBg( bg_004_06_02_00, SMA_SLOW, true, 140, "bg_004_06_01_00" ); }

		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="fg_004_04_01_01")]
		public static const fg_004_06_02_01:Class;		{ addBg( fg_004_06_02_01, REG_SCROLL, true, 140, "fg_004_04_01_01", null, BlendMode.SCREEN ); }
		
		[Embed(source="../assets/images/skins/004/backgrounds/bg_004_07_01_00.png")]
		public static const bg_004_07_01_00:Class;		{ addBg( bg_004_07_01_00, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/004/backgrounds/bg_004_07_02_00.png")]
		public static const bg_004_07_02_00:Class;		{ addBg( bg_004_07_02_00, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/004/backgrounds/bg_004_08_01_00.png")]
		public static const bg_004_08_01_00:Class;		{ addBg( bg_004_08_01_00, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/004/backgrounds/bg_004_08_02_00.png")]
		public static const bg_004_08_02_00:Class;		{ addBg( bg_004_08_02_00, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/004/backgrounds/bg_004_08_03_00.png")]
		public static const bg_004_08_03_00:Class;		{ addBg( bg_004_08_03_00, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/004/backgrounds/bg_004_09_01_00.png")]
		public static const bg_004_09_01_00:Class;		{ addBg( bg_004_09_01_00, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/004/backgrounds/bg_004_09_02_00.png")]
		public static const bg_004_09_02_00:Class;		{ addBg( bg_004_09_02_00, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/004/backgrounds/bg_004_10_01_00.png")]
		public static const bg_004_10_01_00:Class;		{ addBg( bg_004_10_01_00, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/004/backgrounds/bg_004_10_01_01.png")]
		public static const bg_004_10_01_01:Class;		{ addBg( bg_004_10_01_01, SMA_SLOW ); }

		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="bg_004_10_02_00")]
		public static const bg_004_10_02_00:Class;		{ addBg( bg_004_10_02_00, SMA_SLOW, true, 140, "bg_004_10_02_00" ); }
		
		[Embed(source="../assets/images/skins/004/backgrounds/bg_004_10_02_01.png")]
		public static const bg_004_10_02_01:Class;		{ addBg( bg_004_10_02_01, SMA_MID ); }

		[Embed(source="../assets/images/skins/004/backgrounds/bg_004_10_03_00.png")]
		public static const bg_004_10_03_00:Class;		{ addBg( bg_004_10_03_00, SMA_MID ); }

		[Embed(source="../assets/images/skins/004/backgrounds/bg_004_11_01_00.png")]
		public static const bg_004_11_01_00:Class;		{ addBg( bg_004_11_01_00, SMA_SLOW ); }
		
		[Embed(source="../assets/images/skins/004/backgrounds/bg_004_11_01_01.png")]
		public static const bg_004_11_01_01:Class;		{ addBg( bg_004_11_01_01, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/004/backgrounds/bg_004_11_02_00.png")]
		public static const bg_004_11_02_00:Class;		{ addBg( bg_004_11_02_00, SMA_MID ); }

//		[Embed(source="../assets/images/skins/004/backgrounds/bg_004_11_02_01.png")]
//		public static const bg_004_11_02_01:Class;		{ addBg( bg_004_11_02_01, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/004/backgrounds/bg_004_11_03_00.png")]
		public static const bg_004_11_03_00:Class;		{ addBg( bg_004_11_03_00, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/004/backgrounds/bg_004_12_01_00.png")]
		public static const bg_004_12_01_00:Class;		{ addBg( bg_004_12_01_00, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/004/backgrounds/bg_004_12_02_00.png")]
		public static const bg_004_12_02_00:Class;		{ addBg( bg_004_12_02_00, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/004/backgrounds/bg_004_13_01_00.png")]
		public static const bg_004_13_01_00:Class;		{ addBg( bg_004_13_01_00, SMA_SLOW ); }
		
		[Embed(source="../assets/images/skins/004/backgrounds/bg_004_13_01_01.png")]
		public static const bg_004_13_01_01:Class;		{ addBg( bg_004_13_01_01, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/004/backgrounds/bg_004_13_02_00.png")]
		public static const bg_004_13_02_00:Class;		{ addBg( bg_004_13_02_00, SMA_SLOW ); }
		
		[Embed(source="../assets/images/skins/004/backgrounds/bg_004_13_02_01.png")]
		public static const bg_004_13_02_01:Class;		{ addBg( bg_004_13_02_01, SMA_MID ); }

		[Embed(source="../assets/images/skins/004/backgrounds/bg_004_13_03_00.png")]
		public static const bg_004_13_03_00:Class;		{ addBg( bg_004_13_03_00, SMA_SLOW ); }
		
		[Embed(source="../assets/images/skins/004/backgrounds/bg_004_13_03_01.png")]
		public static const bg_004_13_03_01:Class;		{ addBg( bg_004_13_03_01, SMA_MID ); }

		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="fg_004_05_01_01")]
		public static const fg_004_13_03_01:Class;		{ addBg( fg_004_13_03_01, REG_SCROLL, true, 60, "fg_004_05_01_01", RisingWater ); }

		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="fg_004_04_01_01")]
		public static const fg_004_11_02_01:Class;		{ addBg( fg_004_11_02_01, REG_SCROLL, true, 140, "fg_004_04_01_01", null, BlendMode.SCREEN ); }

		[Embed(source="../assets/images/skins/004/backgrounds/bg_004_14_01_00.png")]
		public static const bg_004_14_01_00:Class;		{ addBg( bg_004_14_01_00, SMA_SLOW ); }

		[Embed(source="../assets/images/skins/004/backgrounds/bg_004_14_01_01.png")]
		public static const bg_004_14_01_01:Class;		{ addBg( bg_004_14_01_01, SMA_MID ); }

		[Embed(source="../assets/images/skins/004/backgrounds/bg_004_14_02_00.png")]
		public static const bg_004_14_02_00:Class;		{ addBg( bg_004_14_02_00, SMA_SLOW ); }
		
		[Embed(source="../assets/images/skins/004/backgrounds/bg_004_15_01_00.png")]
		public static const bg_004_15_01_00:Class;		{ addBg( bg_004_15_01_00, SMA_MID ); }

		// replacements
		[Embed(source="../assets/images/skins/004/backgrounds/rep_004_castle.png")]
		public static const rep_004_castle:Class;
		
//		-------------------------------------------------------------------------------------------------------------------
//		005 Demon Returns
//		-------------------------------------------------------------------------------------------------------------------
		[Embed(source="../assets/images/skins/005/backgrounds/bg_005_01_01_00.png")]
		public static const bg_005_01_01_00:Class;		{ addBg( bg_005_01_01_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/005/backgrounds/bg_005_01_02_00.png")]
		public static const bg_005_01_02_00:Class;		{ addBg( bg_005_01_02_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/005/backgrounds/bg_005_01_03_00.png")]
		public static const bg_005_01_03_00:Class;		{ addBg( bg_005_01_03_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/005/backgrounds/bg_005_01_04_00.png")]
		public static const bg_005_01_04_00:Class;		{ addBg( bg_005_01_04_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/005/backgrounds/bg_005_02_01_00.png")]
		public static const bg_005_02_01_00:Class;		{ addBg( bg_005_02_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/005/backgrounds/bg_005_02_02_00.png")]
		public static const bg_005_02_02_00:Class;		{ addBg( bg_005_02_02_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/005/backgrounds/bg_005_02_03_00.png")]
		public static const bg_005_02_03_00:Class;		{ addBg( bg_005_02_03_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/005/backgrounds/bg_005_02_04_00.png")]
		public static const bg_005_02_04_00:Class;		{ addBg( bg_005_02_04_00, REG_SCROLL ); }

		[Embed(source="../assets/images/skins/005/backgrounds/bg_005_02_05_00.png")]
		public static const bg_005_02_05_00:Class;		{ addBg( bg_005_02_05_00, REG_SCROLL ); }
		
		
		[Embed(source="../assets/images/skins/005/backgrounds/bg_005_03_01_00.png")]
		public static const bg_005_03_01_00:Class;		{ addBg( bg_005_03_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/005/backgrounds/bg_005_03_02_00.png")]
		public static const bg_005_03_02_00:Class;		{ addBg( bg_005_03_02_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/005/backgrounds/bg_005_03_03_00.png")]
		public static const bg_005_03_03_00:Class;		{ addBg( bg_005_03_03_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/005/backgrounds/bg_005_03_04_00.png")]
		public static const bg_005_03_04_00:Class;		{ addBg( bg_005_03_04_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/005/backgrounds/fg_005_03_01_01.png")]
		public static const fg_005_03_01_01:Class;		{ addBg( fg_005_03_01_01, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/005/backgrounds/fg_005_03_02_01.png")]
		public static const fg_005_03_02_01:Class;		{ addBg( fg_005_03_02_01, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/005/backgrounds/fg_005_03_03_01.png")]
		public static const fg_005_03_03_01:Class;		{ addBg( fg_005_03_03_01, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/005/backgrounds/fg_005_03_04_01.png")]
		public static const fg_005_03_04_01:Class;		{ addBg( fg_005_03_04_01, REG_SCROLL ); }
		
		
		[Embed(source="../assets/images/skins/005/backgrounds/bg_005_04_01_00.png")]
		public static const bg_005_04_01_00:Class;		{ addBg( bg_005_04_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/005/backgrounds/bg_005_04_02_00.png")]
		public static const bg_005_04_02_00:Class;		{ addBg( bg_005_04_02_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/005/backgrounds/bg_005_04_03_00.png")]
		public static const bg_005_04_03_00:Class;		{ addBg( bg_005_04_03_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/005/backgrounds/bg_005_04_04_00.png")]
		public static const bg_005_04_04_00:Class;		{ addBg( bg_005_04_04_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/005/backgrounds/bg_005_04_05_00.png")]
		public static const bg_005_04_05_00:Class;		{ addBg( bg_005_04_05_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/005/backgrounds/bg_005_05_01_00.png")]
		public static const bg_005_05_01_00:Class;		{ addBg( bg_005_05_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/005/backgrounds/bg_005_05_02_00.png")]
		public static const bg_005_05_02_00:Class;		{ addBg( bg_005_05_02_00, NO_SCROLL ); }
		
		
		[Embed(source="../assets/images/skins/005/backgrounds/bg_005_06_01_00.png")]
		public static const bg_005_06_01_00:Class;		{ addBg( bg_005_06_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/005/backgrounds/bg_005_06_02_00.png")]
		public static const bg_005_06_02_00:Class;		{ addBg( bg_005_06_02_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/005/backgrounds/bg_005_06_03_00.png")]
		public static const bg_005_06_03_00:Class;		{ addBg( bg_005_06_03_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/005/backgrounds/bg_005_06_04_00.png")]
		public static const bg_005_06_04_00:Class;		{ addBg( bg_005_06_04_00, REG_SCROLL ); }

		
		
//		-------------------------------------------------------------------------------------------------------------------
//		006 Blaster Master (3, 6, 14, 16 = 1) (2, 5 = 3) (13 = 4) 
//		-------------------------------------------------------------------------------------------------------------------
		[Embed(source="../assets/images/skins/006/backgrounds/bg_006_01_01_00.png")]
		public static const bg_006_01_01_00:Class;		{ addBg( bg_006_01_01_00, REG_SCROLL ); }

		[Embed(source="../assets/images/skins/006/backgrounds/bg_006_01_02_00.png")]
		public static const bg_006_01_02_00:Class;		{ addBg( bg_006_01_02_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/006/backgrounds/bg_006_02_01_00.png")]
		public static const bg_006_02_01_00:Class;		{ addBg( bg_006_02_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/006/backgrounds/bg_006_02_02_00.png")]
		public static const bg_006_02_02_00:Class;		{ addBg( bg_006_02_02_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/006/backgrounds/bg_006_02_03_00.png")]
		public static const bg_006_02_03_00:Class;		{ addBg( bg_006_02_03_00, REG_SCROLL ); }

		[Embed(source="../assets/images/skins/006/backgrounds/bg_006_02_04_00.png")]
		public static const bg_006_02_04_00:Class;		{ addBg( bg_006_02_04_00, REG_SCROLL ); }

		[Embed(source="../assets/images/skins/006/backgrounds/bg_006_03_01_00.png")]
		public static const bg_006_03_01_00:Class;		{ addBg( bg_006_03_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/006/backgrounds/bg_006_04_01_00.png")]
		public static const bg_006_04_01_00:Class;		{ addBg( bg_006_04_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/006/backgrounds/bg_006_04_02_00.png")]
		public static const bg_006_04_02_00:Class;		{ addBg( bg_006_04_02_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/006/backgrounds/bg_006_05_01_00.png")]
		public static const bg_006_05_01_00:Class;		{ addBg( bg_006_05_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/006/backgrounds/bg_006_05_02_00.png")]
		public static const bg_006_05_02_00:Class;		{ addBg( bg_006_05_02_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/006/backgrounds/bg_006_05_03_00.png")]
		public static const bg_006_05_03_00:Class;		{ addBg( bg_006_05_03_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/006/backgrounds/bg_006_06_01_00.png")]
		public static const bg_006_06_01_00:Class;		{ addBg( bg_006_06_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/006/backgrounds/bg_006_07_01_00.png")]
		public static const bg_006_07_01_00:Class;		{ addBg( bg_006_07_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/006/backgrounds/bg_006_07_02_00.png")]
		public static const bg_006_07_02_00:Class;		{ addBg( bg_006_07_02_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/006/backgrounds/bg_006_08_01_00.png")]
		public static const bg_006_08_01_00:Class;		{ addBg( bg_006_08_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/006/backgrounds/bg_006_08_02_00.png")]
		public static const bg_006_08_02_00:Class;		{ addBg( bg_006_08_02_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/006/backgrounds/bg_006_09_01_00.png")]
		public static const bg_006_09_01_00:Class;		{ addBg( bg_006_09_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/006/backgrounds/bg_006_09_02_00.png")]
		public static const bg_006_09_02_00:Class;		{ addBg( bg_006_09_02_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/006/backgrounds/bg_006_10_01_00.png")]
		public static const bg_006_10_01_00:Class;		{ addBg( bg_006_10_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/006/backgrounds/bg_006_10_02_00.png")]
		public static const bg_006_10_02_00:Class;		{ addBg( bg_006_10_02_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/006/backgrounds/bg_006_11_01_00.png")]
		public static const bg_006_11_01_00:Class;		{ addBg( bg_006_11_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/006/backgrounds/bg_006_11_02_00.png")]
		public static const bg_006_11_02_00:Class;		{ addBg( bg_006_11_02_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/006/backgrounds/bg_006_12_01_00.png")]
		public static const bg_006_12_01_00:Class;		{ addBg( bg_006_12_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/006/backgrounds/bg_006_12_02_00.png")]
		public static const bg_006_12_02_00:Class;		{ addBg( bg_006_12_02_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/006/backgrounds/bg_006_13_01_00.png")]
		public static const bg_006_13_01_00:Class;		{ addBg( bg_006_13_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/006/backgrounds/bg_006_13_02_00.png")]
		public static const bg_006_13_02_00:Class;		{ addBg( bg_006_13_02_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/006/backgrounds/bg_006_13_03_00.png")]
		public static const bg_006_13_03_00:Class;		{ addBg( bg_006_13_03_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/006/backgrounds/bg_006_13_04_00.png")]
		public static const bg_006_13_04_00:Class;		{ addBg( bg_006_13_04_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/006/backgrounds/bg_006_13_05_00.png")]
		public static const bg_006_13_05_00:Class;		{ addBg( bg_006_13_05_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/006/backgrounds/bg_006_14_01_00.png")]
		public static const bg_006_14_01_00:Class;		{ addBg( bg_006_14_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/006/backgrounds/bg_006_15_01_00.png")]
		public static const bg_006_15_01_00:Class;		{ addBg( bg_006_15_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/006/backgrounds/bg_006_15_02_00.png")]
		public static const bg_006_15_02_00:Class;		{ addBg( bg_006_15_02_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/006/backgrounds/bg_006_16_01_00.png")]
		public static const bg_006_16_01_00:Class;		{ addBg( bg_006_16_01_00, REG_SCROLL ); }

//		-------------------------------------------------------------------------------------------------------------------
//		007 Invisible
//		-------------------------------------------------------------------------------------------------------------------
		[Embed(source="../assets/images/skins/007/backgrounds/bg_007_01_01_00.png")]
		public static const bg_007_01_01_00:Class;		{ addBg( bg_007_01_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/007/backgrounds/bg_007_01_02_00.png")]
		public static const bg_007_01_02_00:Class;		{ addBg( bg_007_01_02_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/007/backgrounds/bg_007_01_03_00.png")]
		public static const bg_007_01_03_00:Class;		{ addBg( bg_007_01_03_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/007/backgrounds/bg_007_01_04_00.png")]
		public static const bg_007_01_04_00:Class;		{ addBg( bg_007_01_04_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/007/backgrounds/bg_007_01_05_00.png")]
		public static const bg_007_01_05_00:Class;		{ addBg( bg_007_01_05_00, REG_SCROLL ); }
		
//		[Embed(source="../assets/images/skins/007/backgrounds/bg_007_01_06_00.png")]
//		public static const bg_007_01_06_00:Class;		{ addBg( bg_007_01_06_00, REG_SCROLL ); }
//		
//		[Embed(source="../assets/images/skins/007/backgrounds/bg_007_02_01_00.png")]
//		public static const bg_007_02_01_00:Class;		{ addBg( bg_007_02_01_00, REG_SCROLL ); }
//		
//		[Embed(source="../assets/images/skins/007/backgrounds/bg_007_03_01_00.png")]
//		public static const bg_007_03_01_00:Class;		{ addBg( bg_007_03_01_00, REG_SCROLL ); }
//		
//		[Embed(source="../assets/images/skins/007/backgrounds/bg_007_03_02_00.png")]
//		public static const bg_007_03_02_00:Class;		{ addBg( bg_007_03_02_00, REG_SCROLL ); }
//		
//		[Embed(source="../assets/images/skins/007/backgrounds/bg_007_04_01_00.png")]
//		public static const bg_007_04_01_00:Class;		{ addBg( bg_007_04_01_00, REG_SCROLL ); }
//		
//		[Embed(source="../assets/images/skins/007/backgrounds/bg_007_05_01_00.png")]
//		public static const bg_007_05_01_00:Class;		{ addBg( bg_007_05_01_00, REG_SCROLL ); }
//		
//		[Embed(source="../assets/images/skins/007/backgrounds/bg_007_05_02_00.png")]
//		public static const bg_007_05_02_00:Class;		{ addBg( bg_007_05_02_00, REG_SCROLL ); }
//		
//		[Embed(source="../assets/images/skins/007/backgrounds/bg_007_06_01_00.png")]
//		public static const bg_007_06_01_00:Class;		{ addBg( bg_007_06_01_00, REG_SCROLL ); }

//		-------------------------------------------------------------------------------------------------------------------
//		008 Atari
//		-------------------------------------------------------------------------------------------------------------------
		[Embed(source="../assets/images/skins/008/backgrounds/bg_008_01_01_00.png")]
		public static const bg_008_01_01_00:Class;		{ addBg( bg_008_01_01_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/008/backgrounds/bg_008_01_02_00.png")]
		public static const bg_008_01_02_00:Class;		{ addBg( bg_008_01_02_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/008/backgrounds/bg_008_01_03_00.png")]
		public static const bg_008_01_03_00:Class;		{ addBg( bg_008_01_03_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/008/backgrounds/bg_008_01_04_00.png")]
		public static const bg_008_01_04_00:Class;		{ addBg( bg_008_01_04_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/008/backgrounds/bg_008_01_05_00.png")]
		public static const bg_008_01_05_00:Class;		{ addBg( bg_008_01_05_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/008/backgrounds/bg_008_01_06_00.png")]
		public static const bg_008_01_06_00:Class;		{ addBg( bg_008_01_06_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/008/backgrounds/bg_008_01_07_00.png")]
		public static const bg_008_01_07_00:Class;		{ addBg( bg_008_01_07_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/008/backgrounds/bg_008_01_08_00.png")]
		public static const bg_008_01_08_00:Class;		{ addBg( bg_008_01_08_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/008/backgrounds/bg_008_02_01_00.png")]
		public static const bg_008_02_01_00:Class;		{ addBg( bg_008_02_01_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/008/backgrounds/bg_008_03_01_00.png")]
		public static const bg_008_03_01_00:Class;		{ addBg( bg_008_03_01_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/008/backgrounds/bg_008_03_02_00.png")]
		public static const bg_008_03_02_00:Class;		{ addBg( bg_008_03_02_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/008/backgrounds/bg_008_03_03_00.png")]
		public static const bg_008_03_03_00:Class;		{ addBg( bg_008_03_03_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/008/backgrounds/bg_008_03_04_00.png")]
		public static const bg_008_03_04_00:Class;		{ addBg( bg_008_03_04_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/008/backgrounds/bg_008_04_01_00.png")]
		public static const bg_008_04_01_00:Class;		{ addBg( bg_008_04_01_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/008/backgrounds/bg_008_04_02_00.png")]
		public static const bg_008_04_02_00:Class;		{ addBg( bg_008_04_02_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/008/backgrounds/bg_008_05_01_00.png")]
		public static const bg_008_05_01_00:Class;		{ addBg( bg_008_05_01_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/008/backgrounds/bg_008_05_02_00.png")]
		public static const bg_008_05_02_00:Class;		{ addBg( bg_008_05_02_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/008/backgrounds/bg_008_06_01_00.png")]
		public static const bg_008_06_01_00:Class;		{ addBg( bg_008_06_01_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/008/backgrounds/bg_008_07_01_00.png")]
		public static const bg_008_07_01_00:Class;		{ addBg( bg_008_07_01_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/008/backgrounds/bg_008_07_02_00.png")]
		public static const bg_008_07_02_00:Class;		{ addBg( bg_008_07_02_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/008/backgrounds/bg_008_08_01_00.png")]
		public static const bg_008_08_01_00:Class;		{ addBg( bg_008_08_01_00, NO_SCROLL ); }

//		-------------------------------------------------------------------------------------------------------------------
//		009 Zelda II
//		-------------------------------------------------------------------------------------------------------------------
		[Embed(source="../assets/images/skins/009/backgrounds/bg_009_01_01_00.png")]
		public static const bg_009_01_01_00:Class;		{ addBg( bg_009_01_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/009/backgrounds/bg_009_01_02_00.png")]
		public static const bg_009_01_02_00:Class;		{ addBg( bg_009_01_02_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/009/backgrounds/bg_009_01_03_00.png")]
		public static const bg_009_01_03_00:Class;		{ addBg( bg_009_01_03_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/009/backgrounds/bg_009_02_01_00.png")]
		public static const bg_009_02_01_00:Class;		{ addBg( bg_009_02_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/009/backgrounds/bg_009_02_02_00.png")]
		public static const bg_009_02_02_00:Class;		{ addBg( bg_009_02_02_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/009/backgrounds/bg_009_02_03_00.png")]
		public static const bg_009_02_03_00:Class;		{ addBg( bg_009_02_03_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/009/backgrounds/bg_009_02_04_00.png")]
		public static const bg_009_02_04_00:Class;		{ addBg( bg_009_02_04_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/009/backgrounds/bg_009_02_05_00.png")]
		public static const bg_009_02_05_00:Class;		{ addBg( bg_009_02_05_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/009/backgrounds/bg_009_02_06_00.png")]
		public static const bg_009_02_06_00:Class;		{ addBg( bg_009_02_06_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/009/backgrounds/bg_009_03_01_00.png")]
		public static const bg_009_03_01_00:Class;		{ addBg( bg_009_03_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/009/backgrounds/bg_009_03_02_00.png")]
		public static const bg_009_03_02_00:Class;		{ addBg( bg_009_03_02_00, REG_SCROLL ); }

		[Embed(source="../assets/images/skins/009/backgrounds/bg_009_04_01_00.png")]
		public static const bg_009_04_01_00:Class;		{ addBg( bg_009_04_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/009/backgrounds/bg_009_05_01_00.png")]
		public static const bg_009_05_01_00:Class;		{ addBg( bg_009_05_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/009/backgrounds/bg_009_06_01_00.png")]
		public static const bg_009_06_01_00:Class;		{ addBg( bg_009_06_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/009/backgrounds/bg_009_06_02_00.png")]
		public static const bg_009_06_02_00:Class;		{ addBg( bg_009_06_02_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/009/backgrounds/bg_009_07_01_00.png")]
		public static const bg_009_07_01_00:Class;		{ addBg( bg_009_07_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/009/backgrounds/bg_009_08_01_00.png")]
		public static const bg_009_08_01_00:Class;		{ addBg( bg_009_08_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/009/backgrounds/bg_009_09_01_00.png")]
		public static const bg_009_09_01_00:Class;		{ addBg( bg_009_09_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/009/backgrounds/bg_009_10_01_00.png")]
		public static const bg_009_10_01_00:Class;		{ addBg( bg_009_10_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/009/backgrounds/bg_009_11_01_00.png")]
		public static const bg_009_11_01_00:Class;		{ addBg( bg_009_11_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/009/backgrounds/bg_009_12_01_00.png")]
		public static const bg_009_12_01_00:Class;		{ addBg( bg_009_12_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/009/backgrounds/bg_009_13_01_00.png")]
		public static const bg_009_13_01_00:Class;		{ addBg( bg_009_13_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/009/backgrounds/bg_009_14_01_00.png")]
		public static const bg_009_14_01_00:Class;		{ addBg( bg_009_14_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/009/backgrounds/bg_009_15_01_00.png")]
		public static const bg_009_15_01_00:Class;		{ addBg( bg_009_15_01_00, REG_SCROLL ); }
		
//		-------------------------------------------------------------------------------------------------------------------
//		010 Super Mario World
//		-------------------------------------------------------------------------------------------------------------------
		[Embed(source="../assets/images/skins/010/backgrounds/bg_010_01_01_00.png")]
		public static const bg_010_01_01_00:Class;		{ addBg( bg_010_01_01_00, SMA_SLOW ); }

		[Embed(source="../assets/images/skins/010/backgrounds/bg_010_01_02_00.png")]
		public static const bg_010_01_02_00:Class;		{ addBg( bg_010_01_02_00, SMA_SLOW ); }
		
		[Embed(source="../assets/images/skins/010/backgrounds/bg_010_01_03_00.png")]
		public static const bg_010_01_03_00:Class;		{ addBg( bg_010_01_03_00, SMA_SLOW ); }
		
		[Embed(source="../assets/images/skins/010/backgrounds/bg_010_01_04_00.png")]
		public static const bg_010_01_04_00:Class;		{ addBg( bg_010_01_04_00, SMA_SLOW ); }

		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="bg_010_01_05_00")]
		public static const bg_010_01_05_00:Class;		{ addBg( bg_010_01_05_00, SMA_SLOW, true, 120, "bg_010_01_05_00" ); }
		
		[Embed(source="../assets/images/skins/010/backgrounds/bg_010_01_06_00.png")]
		public static const bg_010_01_06_00:Class;		{ addBg( bg_010_01_06_00, SMA_SLOW ); }
		
		[Embed(source="../assets/images/skins/010/backgrounds/bg_010_01_07_00.png")]
		public static const bg_010_01_07_00:Class;		{ addBg( bg_010_01_07_00, SMA_SLOW ); }
		
		[Embed(source="../assets/images/skins/010/backgrounds/bg_010_01_08_00.png")]
		public static const bg_010_01_08_00:Class;		{ addBg( bg_010_01_08_00, SMA_SLOW ); }
		
		[Embed(source="../assets/images/skins/010/backgrounds/bg_010_01_09_00.png")]
		public static const bg_010_01_09_00:Class;		{ addBg( bg_010_01_09_00, SMA_SLOW ); }
		
		[Embed(source="../assets/images/skins/010/backgrounds/bg_010_01_10_00.png")]
		public static const bg_010_01_10_00:Class;		{ addBg( bg_010_01_10_00, SMA_SLOW ); }
		
		[Embed(source="../assets/images/skins/010/backgrounds/bg_010_01_11_00.png")]
		public static const bg_010_01_11_00:Class;		{ addBg( bg_010_01_11_00, SMA_SLOW ); }

		[Embed(source="../assets/images/skins/010/backgrounds/bg_010_01_12_00.png")]
		public static const bg_010_01_12_00:Class;		{ addBg( bg_010_01_12_00, SMA_SLOW ); }

		[Embed(source="../assets/images/skins/010/backgrounds/bg_010_01_13_00.png")]
		public static const bg_010_01_13_00:Class;		{ addBg( bg_010_01_13_00, SMA_SLOW ); }

		[Embed(source="../assets/images/skins/010/backgrounds/bg_010_01_14_00.png")]
		public static const bg_010_01_14_00:Class;		{ addBg( bg_010_01_14_00, SMA_SLOW ); }

		[Embed(source="../assets/images/skins/010/backgrounds/bg_010_01_15_00.png")]
		public static const bg_010_01_15_00:Class;		{ addBg( bg_010_01_15_00, SMA_SLOW ); }

		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="bg_010_02_01_00")]
		public static const bg_010_02_01_00:Class;		{ addBg( bg_010_02_01_00, SMA_SLOW, true, 120, "bg_010_02_01_00" ); }

		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="bg_010_02_01_00")]
		public static const bg_010_02_02_00:Class;		{ addBg( bg_010_02_02_00, SMA_SLOW, true, 120, "bg_010_02_01_00" ); }
		
		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="bg_010_02_03_00")]
		public static const bg_010_02_03_00:Class;		{ addBg( bg_010_02_03_00, SMA_SLOW, true, 120, "bg_010_02_03_00" ); }

		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="bg_010_02_04_00")]
		public static const bg_010_02_04_00:Class;		{ addBg( bg_010_02_04_00, SMA_SLOW, true, 120, "bg_010_02_04_00" ); }

		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="bg_010_02_01_00")]
		public static const bg_010_02_05_00:Class;		{ addBg( bg_010_02_05_00, SMA_SLOW, true, 120, "bg_010_02_01_00" ); }

		[Embed(source="../assets/images/skins/010/backgrounds/bg_010_03_01_00.png")]
		public static const bg_010_03_01_00:Class;		{ addBg( bg_010_03_01_00, SMA_SLOW ); }
		
		[Embed(source="../assets/images/skins/010/backgrounds/bg_010_03_01_01.png")]
		public static const bg_010_03_01_01:Class;		{ addBg( bg_010_03_01_01, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/010/backgrounds/bg_010_03_02_00.png")]
		public static const bg_010_03_02_00:Class;		{ addBg( bg_010_03_02_00, SMA_SLOW ); }
		
		[Embed(source="../assets/images/skins/010/backgrounds/bg_010_03_02_01.png")]
		public static const bg_010_03_02_01:Class;		{ addBg( bg_010_03_02_01, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/010/backgrounds/bg_010_03_03_00.png")]
		public static const bg_010_03_03_00:Class;		{ addBg( bg_010_03_03_00, SMA_SLOW ); }

		[Embed(source="../assets/images/skins/010/backgrounds/bg_010_03_04_00.png")]
		public static const bg_010_03_04_00:Class;		{ addBg( bg_010_03_04_00, SMA_SLOW ); }

		[Embed(source="../assets/images/skins/010/backgrounds/bg_010_03_04_01.png")]
		public static const bg_010_03_04_01:Class;		{ addBg( bg_010_03_04_01, SMA_MID ); }

		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="bg_010_04_01_00")]
		public static const bg_010_04_01_00:Class;		{ addBg( bg_010_04_01_00, SMA_SLOW, true, 120, "bg_010_04_01_00" ); }

		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="bg_010_04_02_00")]
		public static const bg_010_04_02_00:Class;		{ addBg( bg_010_04_02_00, SMA_SLOW, true, 120, "bg_010_04_02_00" ); }

		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="bg_010_04_03_00")]
		public static const bg_010_04_03_00:Class;		{ addBg( bg_010_04_03_00, SMA_SLOW, true, 120, "bg_010_04_03_00" ); }

		[Embed(source="../assets/images/skins/010/backgrounds/bg_010_04_04_00.png")]
		public static const bg_010_04_04_00:Class;		{ addBg( bg_010_04_04_00, SMA_SLOW ); }

		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="bg_010_05_01_00")]
		public static const bg_010_05_01_00:Class;		{ addBg( bg_010_05_01_00, SMA_SLOW, true, 120, "bg_010_05_01_00" ); }
		
		[Embed(source="../assets/images/skins/010/backgrounds/bg_010_05_02_00.png")]
		public static const bg_010_05_02_00:Class;		{ addBg( bg_010_05_02_00, SMA_SLOW ); }
		
		[Embed(source="../assets/images/skins/010/backgrounds/bg_010_05_03_00.png")]
		public static const bg_010_05_03_00:Class;		{ addBg( bg_010_05_03_00, SMA_SLOW ); }

		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="bg_010_05_04_00")]
		public static const bg_010_05_04_00:Class;		{ addBg( bg_010_05_04_00, SMA_SLOW, true, 120, "bg_010_05_04_00" ); }
		
		[Embed(source="../assets/images/skins/010/backgrounds/bg_010_05_05_00.png")]
		public static const bg_010_05_05_00:Class;		{ addBg( bg_010_05_05_00, SMA_SLOW ); }
		
		[Embed(source="../assets/images/skins/010/backgrounds/bg_010_05_06_00.png")]
		public static const bg_010_05_06_00:Class;		{ addBg( bg_010_05_06_00, SMA_SLOW ); }
		
		[Embed(source="../assets/images/skins/010/backgrounds/bg_010_05_07_00.png")]
		public static const bg_010_05_07_00:Class;		{ addBg( bg_010_05_07_00, SMA_SLOW ); }
		
		[Embed(source="../assets/images/skins/010/backgrounds/bg_010_05_08_00.png")]
		public static const bg_010_05_08_00:Class;		{ addBg( bg_010_05_08_00, SMA_SLOW ); }
		
		[Embed(source="../assets/images/skins/010/backgrounds/bg_010_06_01_00.png")]
		public static const bg_010_06_01_00:Class;		{ addBg( bg_010_06_01_00, SMA_SLOW ); }
		
		[Embed(source="../assets/images/skins/010/backgrounds/bg_010_07_01_00.png")]
		public static const bg_010_07_01_00:Class;		{ addBg( bg_010_07_01_00, SMA_SLOW ); }

		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="bg_010_07_02_00")]
		public static const bg_010_07_02_00:Class;		{ addBg( bg_010_07_02_00, SMA_SLOW, true, 120, "bg_010_07_02_00" ); }

		[Embed(source="../assets/images/skins/010/backgrounds/bg_010_07_03_00.png")]
		public static const bg_010_07_03_00:Class;		{ addBg( bg_010_07_03_00, SMA_SLOW ); }
		
		[Embed(source="../assets/images/skins/010/backgrounds/bg_010_08_01_00.png")]
		public static const bg_010_08_01_00:Class;		{ addBg( bg_010_08_01_00, SMA_SLOW ); }
		
		[Embed(source="../assets/images/skins/010/backgrounds/bg_010_08_02_00.png")]
		public static const bg_010_08_02_00:Class;		{ addBg( bg_010_08_02_00, SMA_SLOW ); }
		
//		[Embed(source="../assets/images/skins/010/backgrounds/fg_010_03_01_01.png")]
//		public static const fg_010_03_01_01:Class;		{ addBg( fg_010_03_01_01, REG_SCROLL ); }
//		
//		[Embed(source="../assets/images/skins/010/backgrounds/fg_010_03_02_01.png")]
//		public static const fg_010_03_02_01:Class;		{ addBg( fg_010_03_02_01, REG_SCROLL ); }

//		-------------------------------------------------------------------------------------------------------------------
//		011 Super Mario Bros.: The Lost Levels
//		-------------------------------------------------------------------------------------------------------------------

		[Embed(source="../assets/images/skins/011/backgrounds/bg_011_01_01_00.png")]
		public static const bg_011_01_01_00:Class;		{ addBg( bg_011_01_01_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/011/backgrounds/bg_011_01_02_00.png")]
		public static const bg_011_01_02_00:Class;		{ addBg( bg_011_01_02_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/011/backgrounds/bg_011_01_03_00.png")]
		public static const bg_011_01_03_00:Class;		{ addBg( bg_011_01_03_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/011/backgrounds/bg_011_01_04_00.png")]
		public static const bg_011_01_04_00:Class;		{ addBg( bg_011_01_04_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/011/backgrounds/bg_011_01_05_00.png")]
		public static const bg_011_01_05_00:Class;		{ addBg( bg_011_01_05_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/011/backgrounds/bg_011_01_06_00.png")]
		public static const bg_011_01_06_00:Class;		{ addBg( bg_011_01_06_00, REG_SCROLL ); }

		[Embed(source="../assets/images/skins/011/backgrounds/bg_011_01_07_00.png")]
		public static const bg_011_01_07_00:Class;		{ addBg( bg_011_01_07_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/011/backgrounds/bg_011_01_08_00.png")]
		public static const bg_011_01_08_00:Class;		{ addBg( bg_011_01_08_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/011/backgrounds/bg_011_01_09_00.png")]
		public static const bg_011_01_09_00:Class;		{ addBg( bg_011_01_09_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/011/backgrounds/bg_011_02_01_00.png")]
		public static const bg_011_02_01_00:Class;		{ addBg( bg_011_02_01_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/011/backgrounds/bg_011_02_02_00.png")]
		public static const bg_011_02_02_00:Class;		{ addBg( bg_011_02_02_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/011/backgrounds/bg_011_03_01_00.png")]
		public static const bg_011_03_01_00:Class;		{ addBg( bg_011_03_01_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/011/backgrounds/bg_011_03_02_00.png")]
		public static const bg_011_03_02_00:Class;		{ addBg( bg_011_03_02_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/011/backgrounds/bg_011_04_01_00.png")]
		public static const bg_011_04_01_00:Class;		{ addBg( bg_011_04_01_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/011/backgrounds/bg_011_04_02_00.png")]
		public static const bg_011_04_02_00:Class;		{ addBg( bg_011_04_02_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/011/backgrounds/bg_011_05_01_00.png")]
		public static const bg_011_05_01_00:Class;		{ addBg( bg_011_05_01_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/011/backgrounds/bg_011_05_02_00.png")]
		public static const bg_011_05_02_00:Class;		{ addBg( bg_011_05_02_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/011/backgrounds/bg_011_05_03_00.png")]
		public static const bg_011_05_03_00:Class;		{ addBg( bg_011_05_03_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/011/backgrounds/bg_011_05_04_00.png")]
		public static const bg_011_05_04_00:Class;		{ addBg( bg_011_05_04_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/011/backgrounds/bg_011_06_01_00.png")]
		public static const bg_011_06_01_00:Class;		{ addBg( bg_011_06_01_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/011/backgrounds/bg_011_06_02_00.png")]
		public static const bg_011_06_02_00:Class;		{ addBg( bg_011_06_02_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/011/backgrounds/bg_011_07_01_00.png")]
		public static const bg_011_07_01_00:Class;		{ addBg( bg_011_07_01_00, NO_SCROLL ); }

//		-------------------------------------------------------------------------------------------------------------------
//		012 Super Mario Bros. 2 NES
//		-------------------------------------------------------------------------------------------------------------------

		[Embed(source="../assets/images/skins/012/backgrounds/bg_012_01_01_00.png")]
		public static const bg_012_01_01_00:Class;		{ addBg( bg_012_01_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/012/backgrounds/bg_012_01_02_00.png")]
		public static const bg_012_01_02_00:Class;		{ addBg( bg_012_01_02_00, REG_SCROLL ); }

		[Embed(source="../assets/images/skins/012/backgrounds/bg_012_01_03_00.png")]
		public static const bg_012_01_03_00:Class;		{ addBg( bg_012_01_03_00, REG_SCROLL ); }

		[Embed(source="../assets/images/skins/012/backgrounds/bg_012_01_04_00.png")]
		public static const bg_012_01_04_00:Class;		{ addBg( bg_012_01_04_00, REG_SCROLL ); }
		
		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="bg_012_01_04_01")]
		public static const bg_012_01_04_01:Class;		{ addBg( bg_012_01_04_01, REG_SCROLL, true, 140, "bg_012_01_04_01" ); }
		
		[Embed(source="../assets/images/skins/012/backgrounds/bg_012_02_01_00.png")]
		public static const bg_012_02_01_00:Class;		{ addBg( bg_012_02_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/012/backgrounds/bg_012_02_02_00.png")]
		public static const bg_012_02_02_00:Class;		{ addBg( bg_012_02_02_00, REG_SCROLL ); }

		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="bg_012_02_02_01")]
		public static const bg_012_02_02_01:Class;		{ addBg( bg_012_02_02_01, REG_SCROLL, true, 140, "bg_012_02_02_01" ); }
		
		[Embed(source="../assets/images/skins/012/backgrounds/bg_012_03_01_00.png")]
		public static const bg_012_03_01_00:Class;		{ addBg( bg_012_03_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/012/backgrounds/bg_012_03_02_00.png")]
		public static const bg_012_03_02_00:Class;		{ addBg( bg_012_03_02_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/012/backgrounds/bg_012_04_01_00.png")]
		public static const bg_012_04_01_00:Class;		{ addBg( bg_012_04_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/012/backgrounds/bg_012_05_01_00.png")]
		public static const bg_012_05_01_00:Class;		{ addBg( bg_012_05_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/012/backgrounds/bg_012_06_01_00.png")]
		public static const bg_012_06_01_00:Class;		{ addBg( bg_012_06_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/012/backgrounds/bg_012_07_01_00.png")]
		public static const bg_012_07_01_00:Class;		{ addBg( bg_012_07_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/012/backgrounds/bg_012_08_01_00.png")]
		public static const bg_012_08_01_00:Class;		{ addBg( bg_012_08_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/012/backgrounds/bg_012_09_01_00.png")]
		public static const bg_012_09_01_00:Class;		{ addBg( bg_012_09_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/012/backgrounds/bg_012_10_01_00.png")]
		public static const bg_012_10_01_00:Class;		{ addBg( bg_012_10_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/012/backgrounds/bg_012_11_01_00.png")]
		public static const bg_012_11_01_00:Class;		{ addBg( bg_012_11_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/012/backgrounds/bg_012_12_01_00.png")]
		public static const bg_012_12_01_00:Class;		{ addBg( bg_012_12_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/012/backgrounds/bg_012_13_01_00.png")]
		public static const bg_012_13_01_00:Class;		{ addBg( bg_012_13_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/012/backgrounds/bg_012_13_02_00.png")]
		public static const bg_012_13_02_00:Class;		{ addBg( bg_012_13_02_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/012/backgrounds/bg_012_14_01_00.png")]
		public static const bg_012_14_01_00:Class;		{ addBg( bg_012_14_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/012/backgrounds/bg_012_15_01_00.png")]
		public static const bg_012_15_01_00:Class;		{ addBg( bg_012_15_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/012/backgrounds/bg_012_15_02_00.png")]
		public static const bg_012_15_02_00:Class;		{ addBg( bg_012_15_02_00, REG_SCROLL ); }

		[Embed(source="../assets/images/skins/012/backgrounds/bg_012_15_03_00.png")]
		public static const bg_012_15_03_00:Class;		{ addBg( bg_012_15_03_00, REG_SCROLL ); }

		[Embed(source="../assets/images/skins/012/backgrounds/bg_012_16_01_00.png")]
		public static const bg_012_16_01_00:Class;		{ addBg( bg_012_16_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/012/backgrounds/bg_012_16_02_00.png")]
		public static const bg_012_16_02_00:Class;		{ addBg( bg_012_16_02_00, REG_SCROLL ); }
//		-------------------------------------------------------------------------------------------------------------------
//		013 Super Mario Bros. 2 SNES
//		-------------------------------------------------------------------------------------------------------------------
		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_01_01_00.png")]
		public static const bg_013_01_01_00:Class;		{ addBg( bg_013_01_01_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_01_01_01.png")]
		public static const bg_013_01_01_01:Class;		{ addBg( bg_013_01_01_01, SMA_SLOW ); }

		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_01_01_02.png")]
		public static const bg_013_01_01_02:Class;		{ addBg( bg_013_01_01_02, SMA_MID ); }

		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_01_02_00.png")]
		public static const bg_013_01_02_00:Class;		{ addBg( bg_013_01_02_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_01_02_01.png")]
		public static const bg_013_01_02_01:Class;		{ addBg( bg_013_01_02_01, SMA_SLOW ); }

		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_01_02_02.png")]
		public static const bg_013_01_02_02:Class;		{ addBg( bg_013_01_02_02, SMA_MID ); }

		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_01_03_00.png")]
		public static const bg_013_01_03_00:Class;		{ addBg( bg_013_01_03_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_01_03_01.png")]
		public static const bg_013_01_03_01:Class;		{ addBg( bg_013_01_03_01, SMA_SLOW ); }
		
		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_01_03_02.png")]
		public static const bg_013_01_03_02:Class;		{ addBg( bg_013_01_03_02, SMA_MID ); }
		
		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="bg_013_water")]
		public static const bg_013_01_03_03:Class;		{ addBg( bg_013_01_03_03, REG_SCROLL, true, 140, "bg_013_water" ); }

		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_01_04_00.png")]
		public static const bg_013_01_04_00:Class;		{ addBg( bg_013_01_04_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_01_04_01.png")]
		public static const bg_013_01_04_01:Class;		{ addBg( bg_013_01_04_01, SMA_MID ); }

		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="bg_013_stars")]
		public static const bg_013_01_04_02:Class;		{ addBg( bg_013_01_04_02, SMA_SLOW, true, 140, "bg_013_stars" ); }

		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_01_05_00.png")]
		public static const bg_013_01_05_00:Class;		{ addBg( bg_013_01_05_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_01_06_00.png")]
		public static const bg_013_01_06_00:Class;		{ addBg( bg_013_01_06_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_02_01_00.png")]
		public static const bg_013_02_01_00:Class;		{ addBg( bg_013_02_01_00, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_02_02_00.png")]
		public static const bg_013_02_02_00:Class;		{ addBg( bg_013_02_02_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_02_02_01.png")]
		public static const bg_013_02_02_01:Class;		{ addBg( bg_013_02_02_01, SMA_MID ); }

		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="bg_013_stars")]
		public static const bg_013_02_02_02:Class;		{ addBg( bg_013_02_02_02, SMA_SLOW, true, 140, "bg_013_stars" ); }
		
		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_02_03_00.png")]
		public static const bg_013_02_03_00:Class;		{ addBg( bg_013_02_03_00, SMA_MID ); }

		[Embed(source="../assets/images/skins/013/backgrounds/fg_013_02_03_00.png")]
		public static const fg_013_02_03_00:Class;		{ addBg( fg_013_02_03_00, NO_SCROLL, true, 0, null, WaterHaze, BlendMode.SCREEN ); }
		
		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_02_04_00.png")]
		public static const bg_013_02_04_00:Class;		{ addBg( bg_013_02_04_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/013/backgrounds/fg_013_02_04_00.png")]
		public static const fg_013_02_04_00:Class;		{ addBg( fg_013_02_04_00, NO_SCROLL, true, 0, null, WaterHaze, BlendMode.SCREEN ); }

		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_03_01_00.png")]
		public static const bg_013_03_01_00:Class;		{ addBg( bg_013_03_01_00, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_03_02_00.png")]
		public static const bg_013_03_02_00:Class;		{ addBg( bg_013_03_02_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_04_01_00.png")]
		public static const bg_013_04_01_00:Class;		{ addBg( bg_013_04_01_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_04_01_01.png")]
		public static const bg_013_04_01_01:Class;		{ addBg( bg_013_04_01_01, SMA_MID ); }

		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="bg_013_stars")]
		public static const bg_013_04_01_02:Class;		{ addBg( bg_013_04_01_02, SMA_SLOW, true, 140, "bg_013_stars" ); }
		
		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_04_02_00.png")]
		public static const bg_013_04_02_00:Class;		{ addBg( bg_013_04_02_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_04_02_01.png")]
		public static const bg_013_04_02_01:Class;		{ addBg( bg_013_04_02_01, SMA_SLOW ); }

		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_04_02_02.png")]
		public static const bg_013_04_02_02:Class;		{ addBg( bg_013_04_02_02, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_05_01_00.png")]
		public static const bg_013_05_01_00:Class;		{ addBg( bg_013_05_01_00, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_06_01_00.png")]
		public static const bg_013_06_01_00:Class;		{ addBg( bg_013_06_01_00, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_07_01_00.png")]
		public static const bg_013_07_01_00:Class;		{ addBg( bg_013_07_01_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_07_01_01.png")]
		public static const bg_013_07_01_01:Class;		{ addBg( bg_013_07_01_01, SMA_SLOW ); }

		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_07_01_02.png")]
		public static const bg_013_07_01_02:Class;		{ addBg( bg_013_07_01_02, SMA_MID ); }

		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_07_02_00.png")]
		public static const bg_013_07_02_00:Class;		{ addBg( bg_013_07_02_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_07_02_01.png")]
		public static const bg_013_07_02_01:Class;		{ addBg( bg_013_07_02_01, SMA_SLOW ); }
		
		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_07_02_02.png")]
		public static const bg_013_07_02_02:Class;		{ addBg( bg_013_07_02_02, SMA_MID ); }

		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="bg_013_water")]
		public static const bg_013_07_02_03:Class;		{ addBg( bg_013_07_02_03, REG_SCROLL, true, 140, "bg_013_water" ); }
		
		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="bg_013_cave_ice")]
		public static const bg_013_08_01_00:Class;		{ addBg( bg_013_08_01_00, SMA_MID, true, 140, "bg_013_cave_ice" ); }
		
		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_09_01_00.png")]
		public static const bg_013_09_01_00:Class;		{ addBg( bg_013_09_01_00, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_10_01_00.png")]
		public static const bg_013_10_01_00:Class;		{ addBg( bg_013_10_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_11_01_00.png")]
		public static const bg_013_11_01_00:Class;		{ addBg( bg_013_11_01_00, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_12_01_00.png")]
		public static const bg_013_12_01_00:Class;		{ addBg( bg_013_12_01_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_12_01_01.png")]
		public static const bg_013_12_01_01:Class;		{ addBg( bg_013_12_01_01, SMA_SLOW ); }
		
		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_12_01_02.png")]
		public static const bg_013_12_01_02:Class;		{ addBg( bg_013_12_01_02, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_13_01_00.png")]
		public static const bg_013_13_01_00:Class;		{ addBg( bg_013_13_01_00, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_13_02_00.png")]
		public static const bg_013_13_02_00:Class;		{ addBg( bg_013_13_02_00, SMA_MID ); }

		[Embed(source="../assets/images/skins/013/backgrounds/fg_013_13_02_00.png")]
		public static const fg_013_13_02_00:Class;		{ addBg( fg_013_13_02_00, NO_SCROLL, true, 0, null, WaterHaze, BlendMode.SCREEN ); }

		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_14_01_00.png")]
		public static const bg_013_14_01_00:Class;		{ addBg( bg_013_14_01_00, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_14_02_00.png")]
		public static const bg_013_14_02_00:Class;		{ addBg( bg_013_14_02_00, SMA_MID ); }

		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="bg_013_cave_ice")]
		public static const bg_013_14_03_00:Class;		{ addBg( bg_013_14_03_00, SMA_MID, true, 140, "bg_013_cave_ice" ); }
		
		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_14_04_00.png")]
		public static const bg_013_14_04_00:Class;		{ addBg( bg_013_14_04_00, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_14_05_00.png")]
		public static const bg_013_14_05_00:Class;		{ addBg( bg_013_14_05_00, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_14_05_01.png")]
		public static const bg_013_14_05_01:Class;		{ addBg( bg_013_14_05_01, SMA_SLOW ); }

		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_14_05_02.png")]
		public static const bg_013_14_05_02:Class;		{ addBg( bg_013_14_05_02, SMA_MID ); }
		
		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_15_01_00.png")]
		public static const bg_013_15_01_00:Class;		{ addBg( bg_013_15_01_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_15_01_01.png")]
		public static const bg_013_15_01_01:Class;		{ addBg( bg_013_15_01_01, SMA_SLOW ); }

		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_15_02_00.png")]
		public static const bg_013_15_02_00:Class;		{ addBg( bg_013_15_02_00, NO_SCROLL ); }

		[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="bg_013_stars")]
		public static const bg_013_15_02_01:Class;		{ addBg( bg_013_15_02_01, SMA_SLOW, true, 140, "bg_013_stars" ); }
		
		[Embed(source="../assets/images/skins/013/backgrounds/bg_013_15_03_00.png")]
		public static const bg_013_15_03_00:Class;		{ addBg( bg_013_15_03_00, NO_SCROLL ); }

//		-------------------------------------------------------------------------------------------------------------------
//		014 Super Mario Bros. Special (Sharp X1)
//		-------------------------------------------------------------------------------------------------------------------
		[Embed(source="../assets/images/skins/014/backgrounds/bg_014_01_01_00.png")]
		public static const bg_014_01_01_00:Class;		{ addBg( bg_014_01_01_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/014/backgrounds/bg_014_01_02_00.png")]
		public static const bg_014_01_02_00:Class;		{ addBg( bg_014_01_02_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/014/backgrounds/bg_014_01_03_00.png")]
		public static const bg_014_01_03_00:Class;		{ addBg( bg_014_01_03_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/014/backgrounds/bg_014_01_04_00.png")]
		public static const bg_014_01_04_00:Class;		{ addBg( bg_014_01_04_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/014/backgrounds/bg_014_01_05_00.png")]
		public static const bg_014_01_05_00:Class;		{ addBg( bg_014_01_05_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/014/backgrounds/bg_014_01_06_00.png")]
		public static const bg_014_01_06_00:Class;		{ addBg( bg_014_01_06_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/014/backgrounds/bg_014_02_01_00.png")]
		public static const bg_014_02_01_00:Class;		{ addBg( bg_014_02_01_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/014/backgrounds/bg_014_03_01_00.png")]
		public static const bg_014_03_01_00:Class;		{ addBg( bg_014_03_01_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/014/backgrounds/bg_014_03_02_00.png")]
		public static const bg_014_03_02_00:Class;		{ addBg( bg_014_03_02_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/014/backgrounds/bg_014_03_03_00.png")]
		public static const bg_014_03_03_00:Class;		{ addBg( bg_014_03_03_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/014/backgrounds/bg_014_04_01_00.png")]
		public static const bg_014_04_01_00:Class;		{ addBg( bg_014_04_01_00, REG_SCROLL ); }

		[Embed(source="../assets/images/skins/014/backgrounds/bg_014_04_02_00.png")]
		public static const bg_014_04_02_00:Class;		{ addBg( bg_014_04_02_00, REG_SCROLL ); }

		[Embed(source="../assets/images/skins/014/backgrounds/bg_014_05_01_00.png")]
		public static const bg_014_05_01_00:Class;		{ addBg( bg_014_05_01_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/014/backgrounds/bg_014_05_02_00.png")]
		public static const bg_014_05_02_00:Class;		{ addBg( bg_014_05_02_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/014/backgrounds/bg_014_06_01_00.png")]
		public static const bg_014_06_01_00:Class;		{ addBg( bg_014_06_01_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/014/backgrounds/bg_014_07_01_00.png")]
		public static const bg_014_07_01_00:Class;		{ addBg( bg_014_07_01_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/014/backgrounds/bg_014_07_02_00.png")]
		public static const bg_014_07_02_00:Class;		{ addBg( bg_014_07_02_00, NO_SCROLL ); }

		[Embed(source="../assets/images/skins/014/backgrounds/bg_014_08_01_00.png")]
		public static const bg_014_08_01_00:Class;		{ addBg( bg_014_08_01_00, NO_SCROLL ); }

//		-------------------------------------------------------------------------------------------------------------------
//		015 Castlevania
//		-------------------------------------------------------------------------------------------------------------------
		[Embed(source="../assets/images/skins/015/backgrounds/bg_015_01_01_00.png")]
		public static const bg_015_01_01_00:Class;		{ addBg( bg_015_01_01_00, REG_SCROLL ); }

		[Embed(source="../assets/images/skins/015/backgrounds/bg_015_02_01_00.png")]
		public static const bg_015_02_01_00:Class;		{ addBg( bg_015_02_01_00, REG_SCROLL ); }

		[Embed(source="../assets/images/skins/015/backgrounds/bg_015_02_02_00.png")]
		public static const bg_015_02_02_00:Class;		{ addBg( bg_015_02_02_00, REG_SCROLL ); }

		[Embed(source="../assets/images/skins/015/backgrounds/bg_015_02_03_00.png")]
		public static const bg_015_02_03_00:Class;		{ addBg( bg_015_02_03_00, REG_SCROLL ); }

		[Embed(source="../assets/images/skins/015/backgrounds/bg_015_02_04_00.png")]
		public static const bg_015_02_04_00:Class;		{ addBg( bg_015_02_04_00, REG_SCROLL ); }

		[Embed(source="../assets/images/skins/015/backgrounds/bg_015_02_05_00.png")]
		public static const bg_015_02_05_00:Class;		{ addBg( bg_015_02_05_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/015/backgrounds/bg_015_03_01_00.png")]
		public static const bg_015_03_01_00:Class;		{ addBg( bg_015_03_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/015/backgrounds/bg_015_03_02_00.png")]
		public static const bg_015_03_02_00:Class;		{ addBg( bg_015_03_02_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/015/backgrounds/bg_015_04_01_00.png")]
		public static const bg_015_04_01_00:Class;		{ addBg( bg_015_04_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/015/backgrounds/bg_015_05_01_00.png")]
		public static const bg_015_05_01_00:Class;		{ addBg( bg_015_05_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/015/backgrounds/bg_015_05_02_00.png")]
		public static const bg_015_05_02_00:Class;		{ addBg( bg_015_05_02_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/015/backgrounds/bg_015_05_03_00.png")]
		public static const bg_015_05_03_00:Class;		{ addBg( bg_015_05_03_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/015/backgrounds/bg_015_06_01_00.png")]
		public static const bg_015_06_01_00:Class;		{ addBg( bg_015_06_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/015/backgrounds/bg_015_06_02_00.png")]
		public static const bg_015_06_02_00:Class;		{ addBg( bg_015_06_02_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/015/backgrounds/bg_015_07_01_00.png")]
		public static const bg_015_07_01_00:Class;		{ addBg( bg_015_07_01_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/015/backgrounds/bg_015_08_01_00.png")]
		public static const bg_015_08_01_00:Class;		{ addBg( bg_015_08_01_00, REG_SCROLL ); }

//		-------------------------------------------------------------------------------------------------------------------
//		016 All Night Nippon Super Mario Bros.
//		-------------------------------------------------------------------------------------------------------------------
		[Embed(source="../assets/images/skins/016/backgrounds/bg_016_01_01_00.png")]
		public static const bg_016_01_01_00:Class;		{ addBg( bg_016_01_01_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/016/backgrounds/bg_016_01_02_00.png")]
		public static const bg_016_01_02_00:Class;		{ addBg( bg_016_01_02_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/016/backgrounds/bg_016_01_03_00.png")]
		public static const bg_016_01_03_00:Class;		{ addBg( bg_016_01_03_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/016/backgrounds/bg_016_01_04_00.png")]
		public static const bg_016_01_04_00:Class;		{ addBg( bg_016_01_04_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/016/backgrounds/bg_016_01_05_00.png")]
		public static const bg_016_01_05_00:Class;		{ addBg( bg_016_01_05_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/016/backgrounds/bg_016_01_06_00.png")]
		public static const bg_016_01_06_00:Class;		{ addBg( bg_016_01_06_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/016/backgrounds/bg_016_01_07_00.png")]
		public static const bg_016_01_07_00:Class;		{ addBg( bg_016_01_07_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/016/backgrounds/bg_016_01_08_00.png")]
		public static const bg_016_01_08_00:Class;		{ addBg( bg_016_01_08_00, REG_SCROLL ); }
		
		[Embed(source="../assets/images/skins/016/backgrounds/bg_016_01_09_00.png")]
		public static const bg_016_01_09_00:Class;		{ addBg( bg_016_01_09_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/016/backgrounds/bg_016_02_01_00.png")]
		public static const bg_016_02_01_00:Class;		{ addBg( bg_016_02_01_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/016/backgrounds/bg_016_02_02_00.png")]
		public static const bg_016_02_02_00:Class;		{ addBg( bg_016_02_02_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/016/backgrounds/bg_016_03_01_00.png")]
		public static const bg_016_03_01_00:Class;		{ addBg( bg_016_03_01_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/016/backgrounds/bg_016_03_02_00.png")]
		public static const bg_016_03_02_00:Class;		{ addBg( bg_016_03_02_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/016/backgrounds/bg_016_03_03_00.png")]
		public static const bg_016_03_03_00:Class;		{ addBg( bg_016_03_03_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/016/backgrounds/bg_016_03_04_00.png")]
		public static const bg_016_03_04_00:Class;		{ addBg( bg_016_03_04_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/016/backgrounds/bg_016_04_01_00.png")]
		public static const bg_016_04_01_00:Class;		{ addBg( bg_016_04_01_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/016/backgrounds/bg_016_04_02_00.png")]
		public static const bg_016_04_02_00:Class;		{ addBg( bg_016_04_02_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/016/backgrounds/bg_016_05_01_00.png")]
		public static const bg_016_05_01_00:Class;		{ addBg( bg_016_05_01_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/016/backgrounds/bg_016_05_02_00.png")]
		public static const bg_016_05_02_00:Class;		{ addBg( bg_016_05_02_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/016/backgrounds/bg_016_06_01_00.png")]
		public static const bg_016_06_01_00:Class;		{ addBg( bg_016_06_01_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/016/backgrounds/bg_016_07_01_00.png")]
		public static const bg_016_07_01_00:Class;		{ addBg( bg_016_07_01_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/016/backgrounds/bg_016_07_02_00.png")]
		public static const bg_016_07_02_00:Class;		{ addBg( bg_016_07_02_00, NO_SCROLL ); }
		
		[Embed(source="../assets/images/skins/016/backgrounds/bg_016_08_01_00.png")]
		public static const bg_016_08_01_00:Class;		{ addBg( bg_016_08_01_00, NO_SCROLL ); }

		//=================== all bgs must be before this line
		{
			addFirstBgSets();
		}
		
		private static function addFirstBgSets():void // adds set 0 containing first background from each layer
		{
			var skin:int;
			var theme:int = THEME_MIN;
			var set:int = SET_MIN;
			var layer:int;
			var bg:Background = bg = getBg(skin,theme,set);
			var fg:Background;
			var bgLayerArr:Array = [];
			var fgLayerArr:Array = [];
			var typeDct:CustomDictionary = new CustomDictionary();
			typeDct.addItem(TYPE_BG);
			typeDct.addItem(TYPE_FG);
			while (bg) // skin
			{
				while (bg) // theme
				{
					while (bg) // set
					{
						while (bg || fg)
						{
							bg = getBg(skin,theme,set,layer,TYPE_BG);
							fg = getBg(skin,theme,set,layer,TYPE_FG);							
							if (bg)
								bgLayerArr.push(bg);
							if (fg)
								fgLayerArr.push(fg);															
							layer++;
						}
//						trace("skin: "+skin+" theme: "+theme+" set: "+set+" bgSetArr: "+bgLayerArr+" fgSetArr: "+fgLayerArr);
						addBgSetItem(skin,theme,set,bgLayerArr,TYPE_BG);
						addBgSetItem(skin,theme,set,fgLayerArr,TYPE_FG);
						bgLayerArr = [];
						fgLayerArr = [];
						layer = 0;
						set++;
						bg = getBg(skin,theme,set);
					}
					theme++;
					set = SET_MIN;
					bg = getBg(skin,theme,set);
				}
				skin++;
				theme = THEME_MIN;
				set = SET_MIN;
				bg = getBg(skin,theme,set);
			}
			THEME_OVRD_VEC.length = skin;
			THEME_OVRD_VEC.fixed = true;
			// add override color sheets
			for each (var cl:Class in bgSetOvrdDct)
			{
				var data:Array = StringUtils.readClassData(cl);
				addBgSetItem( data[IND_DATA_SKIN], data[IND_DATA_THEME], data[IND_DATA_SET], cl, data[IND_DATA_TYPE] );
			}
			
		}
		private static function addBgSetItem(skin:int,theme:int,set:int,value:Object,type:String):void
		{
			/*var skinArr:Array = BG_SET_ARR[skin];
			if (!skinArr)
			{
				skinArr = [];
				BG_SET_ARR[skin] = skinArr;
			}
			var themeArr:Array = skinArr[theme];
			if (!themeArr)
			{
				themeArr = [];
				skinArr[theme] = themeArr;
			}
			var setArr:Array = themeArr[set];
			if (!setArr)
			{
				setArr = [];
				themeArr[set] = setArr;
			}
			if (type == TYPE_BG || type == TYPE_FG)
			{
				var vec:Vector.<Background> = Vector.<Background>(value).concat();
				setArr[getTypeInd(type)] = vec;
			}
			else
				setArr[getTypeInd(type)] = Bitmap( new value() ).bitmapData;
			*/
			if (type == TYPE_BG || type == TYPE_FG)
				value = Vector.<Background>(value).concat();
			else
				value = Bitmap( new value() ).bitmapData;
			ArrayUtils.writeNestedArray( BG_SET_ARR,value,skin,theme,set,getTypeInd(type) );
		} 
		public static function getBgSetItem(skin:int,theme:int,set:int,type:String = null):Object
		{
			if (!type)
				type = TYPE_BG;
			/*var skinArr:Array = BG_SET_ARR[skin];
//			trace("getting bg set skin: "+skin+" theme: "+theme+" set: "+set+" type: "+type);
//			if (set == 1)
//				trace("break");
			if (!skinArr)
				return null;
			var themeArr:Array = skinArr[theme];
			if (!themeArr)
				return null;
			var setArr:Array = themeArr[set];
			if (!setArr)
				return null;
			return setArr[ getTypeInd(type) ];*/
			return ArrayUtils.readNestedArr( BG_SET_ARR, skin, theme, set, getTypeInd(type) );
		}
		public static function getSetBmdOvrd(skin:int,theme:int,set:int,type:String):BitmapData
		{
//			trace("getting bitmap skin: "+skin+" theme: "+theme+" set: "+set+" type: "+type);
			return getBgSetItem(skin,theme,set,type) as BitmapData;
		}
		public static function addBg(bgClass:Class,scrollSpeed:Number, repeat:Boolean = true, animSpeed:int = 0, shortClassName:String = null, classOvrd:Class = null, blendMode:String = BlendMode.NORMAL):void
		{
			if (!classOvrd)
				classOvrd = Background;
			var data:Array = StringUtils.readClassData(bgClass);
			var type:String = data[IND_DATA_TYPE];
			var skin:int = data[IND_DATA_SKIN];
			var theme:int = data[IND_DATA_THEME];
			var set:int = data[IND_DATA_SET];
			var layer:int = data[IND_DATA_LAYER];
//			trace("str: "+str+" type: "+type+" skin: "+skin+" theme: "+theme+" layer: "+layer+" file: "+file);
			var bg:Background = new classOvrd( bgClass, scrollSpeed, repeat, animSpeed, shortClassName );
			bg.skinNum = skin;
			bg.themeNum = theme;
			bg.setNum = set;
			bg.layerNum = layer;
			bg.type = type;
			bg.blendMode = blendMode;
			ArrayUtils.writeNestedArray(BG_ARR,bg,skin,theme,set,layer,getTypeInd(type));
			/*var skinArr:Array = BG_ARR[skin];
			if (!skinArr)
			{
				skinArr = [];
				BG_ARR[skin] = skinArr;
			}
			var themeArr:Array = skinArr[theme];
			if (!themeArr)
			{
				themeArr = [];
				skinArr[theme] = themeArr;
			}
			var setArr:Array = themeArr[set];
			if (!setArr)
			{
				setArr = [];
				themeArr[set] = setArr;
			}
			setArr[layer] = bg;*/
		}
		public static function getBg(skin:int,theme:int,set:int,layer:int = 0,type:String = null):Background
		{
			if (!type)
				type = TYPE_BG;
			/*var skinArr:Array = BG_ARR[skin];
			if (!skinArr)
				return null;
			var themeArr:Array = skinArr[theme];
			if (!themeArr)
				return null;
			var setArr:Array = themeArr[set];
			if (!setArr)
				return null;
			return setArr[layer];*/
			return ArrayUtils.readNestedArr(BG_ARR, skin, theme, set, layer, getTypeInd(type) );
		}
		private static function getTypeInd(type:String):int
		{
			switch(type)
			{
				case TYPE_BG:
					return IND_SET_ARR_BG;
				case TYPE_FG:
					return IND_SET_ARR_FG;
				case TYPE_MAP_OVRD:
					return IND_SET_ARR_MAP_OVRD;
			}
			return -1;
		} 
		/*private static function addExtraTheme(themeCl:Class):void
		{
			var data:Array = StringUtils.readClassData(themeCl);
			var type:String = data[IND_DATA_TYPE];
			var skin:int = data[IND_DATA_SKIN];
			var theme:int = data[IND_DATA_THEME];
			var skinArr:Array = EXTRA_THEME_ARR[skin];
			if (!skinArr)
			{
				skinArr = [];
				EXTRA_THEME_ARR[skin] = skinArr;
			}
			skinArr[theme] = Bitmap(new themeCl() ).bitmapData;
		}*/
		public static function getExtraTheme(skin:int,theme:int):BitmapData
		{
			var skinArr:Array = EXTRA_THEME_ARR[skin];
			if (!skinArr)
				return null;
			return skinArr[theme];
		}
		private static function addOvRd(skin:int,key:String,theme:int,set:int = SET_MIN,priority:int = 5):void
		{
			if (THEME_OVRD_VEC.length < skin + 1)
				THEME_OVRD_VEC.length = skin + 1;
			var dct:Dictionary = THEME_OVRD_VEC[skin];
			if (!dct)
			{
				dct = new Dictionary();
				THEME_OVRD_VEC[skin] = dct;
			}
			dct[key] = [ theme, set, priority ];
		}
	}
}