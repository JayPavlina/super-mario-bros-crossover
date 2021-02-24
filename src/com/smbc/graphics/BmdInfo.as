package com.smbc.graphics
{
	import com.explodingRabbit.cross.data.ConsoleType;
	import com.explodingRabbit.cross.games.Games;
	import com.explodingRabbit.display.CustomMovieClip;
	import com.explodingRabbit.utils.StringUtils;
	import com.smbc.characters.Bass;
	import com.smbc.characters.Bill;
	import com.smbc.characters.Character;
	import com.smbc.characters.Link;
	import com.smbc.characters.Luigi;
	import com.smbc.characters.Mario;
	import com.smbc.characters.MegaMan;
	import com.smbc.characters.Ryu;
	import com.smbc.characters.Samus;
	import com.smbc.characters.Simon;
	import com.smbc.characters.Sophia;
	import com.smbc.characters.VicViper;
	import com.smbc.characters.base.MegaManBase;
	import com.smbc.data.CharacterInfo;
	import com.smbc.data.SkinDescriptions;
	import com.smbc.data.SoundNames;
	import com.smbc.graphics.PaletteSheet;
	import com.smbc.main.GlobVars;
	import com.smbc.managers.GraphicsManager;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;

	public class BmdInfo
	{
		public static const NUM_SKIN_SETS:int = 17;
		private static const ST_CHAR:int = BmdSkinCont.TYPE_CHARACTER;
		private static const ST_ENEMY:int = BmdSkinCont.TYPE_ENEMY;
		private static const ST_MAP:int = BmdSkinCont.TYPE_MAP;
		private static const ST_INTERFACE:int = BmdSkinCont.TYPE_INTERFACE;
		private static const ST_PALETTE:int = BmdSkinCont.TYPE_PALETTE;
		private static const ST_THEME:int = BmdSkinCont.TYPE_THEME;
		public static const CT_8B:int = ConsoleType.BIT_8;
		public static const CT_16B:int = ConsoleType.BIT_16;
		public static const CT_GB:int = ConsoleType.GB;
		public static const BMC_VEC:Vector.<BmdSkinCont> = new Vector.<BmdSkinCont>();
		public static const IND_BMP:int = 0;
		public static const IND_SHEET_TYPE:int = 1;
		public static const IND_CONSOLE_TYPE:int = 2;
		public static const IND_CHARACTERS:int = 3; // also used for games unless games overrides it
		public static const IND_GAMES:int = 4; // this limits sheet to games specified
		public static var drawingBoardEnemyBmc:BmdSkinCont;
		public static var drawingBoardMapBmc:BmdSkinCont;
		public static var drawingBoardInterfaceBmc:BmdSkinCont;
		public static var drawingBoardThemeBmc:BmdSkinCont = new BmdSkinCont( new Bitmap( new BitmapData(222,228) ), 0, ST_THEME);
		public static const MASTER_CHAR_BMP_VEC:Vector.<Bitmap> = new Vector.<Bitmap>(Character.NUM_CHARACTERS,true);
		private static var MAIN_PALETTE_VEC:Vector.<PaletteSheet> = new Vector.<PaletteSheet>();
		private static const CHAR_PALETTE_VEC:Vector.<PaletteSheet> = new Vector.<PaletteSheet>(Character.NUM_CHARACTERS,true);
		private static const CHARACTER_PREVIEW_VEC:Vector.<Bitmap> = new Vector.<Bitmap>(Character.NUM_CHARACTERS,true);
		public static const THEME_VEC:Vector.<BmdSkinCont> = new Vector.<BmdSkinCont>();
		private static var mapSkinPreviews:Vector.<CustomMovieClip>;
		public static const MAP_SKIN_PREVIEW_RECTANGLE:Rectangle = new Rectangle(154, 7, 32, 32);
		
		public static const SKIN_NUM_SMB_NES:int = 0;
		public static const SKIN_NUM_SMB_SNES:int = 1;
		public static const SKIN_NUM_SML2:int = 2;
		public static const SKIN_NUM_SMB3_NES:int = 3;
		public static const SKIN_NUM_SMB3_SNES:int = 4;
		public static const SKIN_NUM_DEMON_RETURNS:int = 5;
		public static const SKIN_NUM_BLASTER_MASTER:int = 6;
		public static const SKIN_NUM_INVISIBLE:int = 7;
		public static const SKIN_NUM_SMB_ATARI:int = 8;
		public static const SKIN_NUM_ZELDA_2:int = 9;
		public static const SKIN_NUM_SMW:int = 10;
		public static const SKIN_NUM_SMB_LL:int = 11;
		public static const SKIN_NUM_SMB2_NES:int = 12;
		public static const SKIN_NUM_SMB2_SNES:int = 13;
		public static const SKIN_NUM_SMB_SPECIAL:int = 14;
		public static const SKIN_NUM_CASTLEVANIA:int = 15;
		public static const SKIN_NUM_SMB_ANN:int = 16;
		
		public static const MAIN_SKIN_ORDER:Array = [ 
			SKIN_NUM_SMB_NES, 
			SKIN_NUM_SMB_SNES, 
			SKIN_NUM_SMB2_NES, 
			SKIN_NUM_SMB2_SNES, 
			SKIN_NUM_SMB3_NES, 
			SKIN_NUM_SMB3_SNES, 
			SKIN_NUM_SMW, 
			SKIN_NUM_SML2, 
			SKIN_NUM_SMB_LL, 
			SKIN_NUM_SMB_ANN, 
			SKIN_NUM_SMB_SPECIAL, 
			SKIN_NUM_SMB_ATARI, 
			SKIN_NUM_BLASTER_MASTER, 
			SKIN_NUM_CASTLEVANIA, 
			SKIN_NUM_ZELDA_2, 
			SKIN_NUM_DEMON_RETURNS, 
			SKIN_NUM_INVISIBLE 
		];

		public static const HIDE_TOP_CASTLES:Array = [ 
			SKIN_NUM_SMB2_NES, 
			SKIN_NUM_SMB2_SNES, 
			SKIN_NUM_SMB3_NES, 
			SKIN_NUM_SMW, 
			SKIN_NUM_BLASTER_MASTER, 
			SKIN_NUM_CASTLEVANIA, 
			SKIN_NUM_ZELDA_2, 
			SKIN_NUM_DEMON_RETURNS 
		];
		public static var hideTopCastleDct:Dictionary = new Dictionary();

//		public static const SKIN_NUM_SMB_ANN:int = ??;
//		public static const SKIN_NUM_CASTLEVANIA:int = ??;

		/*
		to add a map, add here (and adjust NUM_SKIN_SETS above), then add bgs in BackgroundInfo, add name to MenuBoxItems, add to LevelDataTranscoder.SKIN_VEC
		*/

		// [ bmd, sheetType, consoleType, [ characters ], [ games ] ]
		
//		-------------------------------------------------------------------------------------------------------------------
//		enemies
//		-------------------------------------------------------------------------------------------------------------------
		[Embed(source="../assets/images/skins/000/enemy_000.png")]
		private static const Enemy000:Class;
		{
			BMC_VEC.push( new BmdSkinCont( new Enemy000(), 0, ST_ENEMY, null, null, CT_8B, [ Mario.CHAR_NUM ], [ Games.superMarioBros ] ) ) 
			drawingBoardEnemyBmc = BMC_VEC[BMC_VEC.length - 1].clone();
		}
		
		[Embed(source="../assets/images/skins/001/enemy_001.png")]
		private static const Enemy001:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Enemy001(), 1, ST_ENEMY, null, null, CT_16B, [ Mario.CHAR_NUM ], [ Games.superMarioAllStars ] ) ) }
		
		[Embed(source="../assets/images/skins/002/enemy_002.png")]
		private static const Enemy002:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Enemy002(), 2, ST_ENEMY, null, null, CT_GB, [ Mario.CHAR_NUM ], [ Games.superMarioLand2 ] ) ) }
		
		[Embed(source="../assets/images/skins/003/enemy_003.png")]
		private static const Enemy003:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Enemy003(), 3, ST_ENEMY, null, null, CT_8B, [ Mario.CHAR_NUM ], [  ] ) ) }
		
		[Embed(source="../assets/images/skins/004/enemy_004.png")]
		private static const Enemy004:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Enemy004(), 4, ST_ENEMY, null, null, CT_16B, [ Mario.CHAR_NUM ], [  ] ) ) }
		
		[Embed(source="../assets/images/skins/005/enemy_005.png")]
		private static const Enemy005:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Enemy005(), 5, ST_ENEMY, null, null, CT_8B, [ Mario.CHAR_NUM ], [  ] ) ) }

		[Embed(source="../assets/images/skins/006/enemy_006.png")]
		private static const Enemy006:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Enemy006(), 6, ST_ENEMY, null, null, CT_8B, [ Mario.CHAR_NUM ], [  ] ) ) }

		[Embed(source="../assets/images/skins/007/enemy_007.png")]
		private static const Enemy007:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Enemy007(), 7, ST_ENEMY, null, null, CT_8B, [ Mario.CHAR_NUM ], [  ] ) ) }
		
		[Embed(source="../assets/images/skins/008/enemy_008.png")]
		private static const Enemy008:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Enemy008(), 8, ST_ENEMY, null, null, CT_8B, [ Mario.CHAR_NUM ], [  ] ) ) }
		
		[Embed(source="../assets/images/skins/009/enemy_009.png")]
		private static const Enemy009:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Enemy009(), 9, ST_ENEMY, null, null, CT_8B, [ Link.CHAR_NUM ], [  ] ) ) }
		
		[Embed(source="../assets/images/skins/010/enemy_010.png")]
		private static const Enemy010:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Enemy010(), 10, ST_ENEMY, null, null, CT_16B, [ Mario.CHAR_NUM ], [  ] ) ) }
		
		[Embed(source="../assets/images/skins/011/enemy_011.png")]
		private static const Enemy011:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Enemy011(), 11, ST_ENEMY, null, null, CT_8B, [ Mario.CHAR_NUM ], [  ] ) ) }
		
		[Embed(source="../assets/images/skins/012/enemy_012.png")]
		private static const Enemy012:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Enemy012(), 12, ST_ENEMY, null, null, CT_8B, [ Mario.CHAR_NUM ], [  ] ) ) }
		
		[Embed(source="../assets/images/skins/013/enemy_013.png")]
		private static const Enemy013:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Enemy013(), 13, ST_ENEMY, null, null, CT_16B, [ Mario.CHAR_NUM ], [  ] ) ) }
		
		[Embed(source="../assets/images/skins/014/enemy_014.png")]
		private static const Enemy014:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Enemy014(), 14, ST_ENEMY, null, null, CT_8B, [ Mario.CHAR_NUM ], [  ] ) ) }
		
		[Embed(source="../assets/images/skins/015/enemy_015.png")]
		private static const Enemy015:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Enemy015(), 15, ST_ENEMY, null, null, CT_8B, [ Simon.CHAR_NUM ], [  ] ) ) }
		
		[Embed(source="../assets/images/skins/016/enemy_016.png")]
		private static const Enemy016:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Enemy016(), 16, ST_ENEMY, null, null, CT_8B, [ Mario.CHAR_NUM ], [  ] ) ) }

//		-------------------------------------------------------------------------------------------------------------------
//		 maps
//		-------------------------------------------------------------------------------------------------------------------
		[Embed(source="../assets/images/skins/000/map_000.png")]
		private static const Map000:Class;
		{
			BMC_VEC.push( new BmdSkinCont( new Map000(), 0, ST_MAP, null, null, CT_8B, [ Mario.CHAR_NUM ], [ Games.superMarioBros, Games.superMarioBrosSnes, Games.superMarioBrosDeluxe, Games.superMarioBros ] ) ) 
			drawingBoardMapBmc = BMC_VEC[BMC_VEC.length - 1].clone();
		}
		
		[Embed(source="../assets/images/skins/001/map_001.png")]
		private static const Map001:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Map001(), 1, ST_MAP, null, null, CT_16B, [ Mario.CHAR_NUM ], [ Games.superMarioBros, Games.superMarioBrosSnes, Games.superMarioBrosDeluxe, Games.superMarioBrosSnes ] ) ) }
		
		[Embed(source="../assets/images/skins/002/map_002.png")]
		private static const Map002:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Map002(), 2, ST_MAP, null, null, CT_GB, [ Mario.CHAR_NUM ], [ Games.superMarioBros, Games.superMarioBrosSnes, Games.superMarioLand2, Games.superMarioLand2 ] ) ) }
		
		[Embed(source="../assets/images/skins/003/map_003.png")]
		private static const Map003:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Map003(), 3, ST_MAP, null, null, CT_8B, [ Luigi.CHAR_NUM ], [ Games.superMarioBros3, Games.superMarioBros3Snes, Games.superMarioLand2, Games.superMarioBros3 ] ) ) }
		
		[Embed(source="../assets/images/skins/004/map_004.png")]
		private static const Map004:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Map004(), 4, ST_MAP, null, null, CT_16B, [ Luigi.CHAR_NUM ], [ Games.superMarioBros3, Games.superMarioBros3Snes, Games.superMarioLand2, Games.superMarioBros3Snes ] ) ) }
		
		[Embed(source="../assets/images/skins/005/map_005.png")]
		private static const Map005:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Map005(), 5, ST_MAP, null, null, CT_8B, [ Mario.CHAR_NUM ], [ Games.demonReturns, Games.demonReturns, Games.demonReturns, Games.demonReturns ] ) ) }
		
		[Embed(source="../assets/images/skins/006/map_006.png")]
		private static const Map006:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Map006(), 6, ST_MAP, null, null, CT_8B, [ Sophia.CHAR_NUM ], [ Games.blasterMaster, Games.blasterMasterSnes, Games.blasterMasterEnemyBelow, Games.blasterMaster ] ) ) }
		
		[Embed(source="../assets/images/skins/007/map_007.png")]
		private static const Map007:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Map007(), 7, ST_MAP, null, null, CT_8B, [ Mario.CHAR_NUM ], [ Games.superMarioBros, Games.superMarioBrosSnes, Games.superMarioBrosDeluxe, Games.gameInvisible ] ) ) }
		
		[Embed(source="../assets/images/skins/008/map_008.png")]
		private static const Map008:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Map008(), 8, ST_MAP, null, null, CT_8B, [ Mario.CHAR_NUM ], [ Games.superMarioBrosAtari, Games.superMarioBrosAtari, Games.superMarioBrosAtari, Games.superMarioBrosAtari ] ) ) }
		
		[Embed(source="../assets/images/skins/009/map_009.png")]
		private static const Map009:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Map009(), 9, ST_MAP, null, null, CT_8B, [ Link.CHAR_NUM ], [ Games.zeldaAdventureOfLink, Games.zeldaLinkToThePast, Games.zeldaLinksAwakening, Games.zeldaAdventureOfLink ] ) ) }
		
		[Embed(source="../assets/images/skins/010/map_010.png")]
		private static const Map010:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Map010(), 10, ST_MAP, null, null, CT_16B, [ Mario.CHAR_NUM ], [ Games.superMarioBros3, Games.superMarioWorld, Games.superMarioLand2, Games.superMarioWorld ] ) ) }
		
		[Embed(source="../assets/images/skins/011/map_011.png")]
		private static const Map011:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Map011(), 11, ST_MAP, null, null, CT_8B, [ Mario.CHAR_NUM ], [ Games.superMarioBros, Games.superMarioBrosSnes, Games.superMarioBrosDeluxe, Games.superMarioBrosLostLevels ] ) ) }
		
		[Embed(source="../assets/images/skins/012/map_012.png")]
		private static const Map012:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Map012(), 12, ST_MAP, null, null, CT_8B, [ Mario.CHAR_NUM ], [ Games.superMarioBros2, Games.superMarioBros2Snes, Games.superMarioLand, Games.superMarioBros2 ] ) ) }
		
		[Embed(source="../assets/images/skins/013/map_013.png")]
		private static const Map013:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Map013(), 13, ST_MAP, null, null, CT_16B, [ Mario.CHAR_NUM ], [ Games.superMarioBros2, Games.superMarioBros2Snes, Games.superMarioLand, Games.superMarioBros2Snes ] ) ) }
		
		[Embed(source="../assets/images/skins/014/map_014.png")]
		private static const Map014:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Map014(), 14, ST_MAP, null, null, CT_8B, [ Mario.CHAR_NUM ], [ Games.superMarioBrosSpecial, Games.superMarioBrosSnes, Games.superMarioLand, Games.superMarioBrosSpecial ] ) ) }
		
		[Embed(source="../assets/images/skins/015/map_015.png")]
		private static const Map015:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Map015(), 15, ST_MAP, null, null, CT_8B, [ Simon.CHAR_NUM ], [ Games.castlevania, Games.superCastlevania4, Games.castlevaniaAdventure, Games.castlevania ] ) ) }

		[Embed(source="../assets/images/skins/016/map_016.png")]
		private static const Map016:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Map016(), 16, ST_MAP, null, null, CT_8B, [ Mario.CHAR_NUM ], [ Games.superMarioBros, Games.superMarioBrosSnes, Games.superMarioBrosDeluxe, Games.superMarioBrosAllNightNippon ] ) ) }

//		-------------------------------------------------------------------------------------------------------------------
//		 themes
//		-------------------------------------------------------------------------------------------------------------------
		[Embed(source="../assets/images/skins/000/theme_000.png")]
		private static const theme_000:Class;	{ addTheme( theme_000, CT_8B, [ Mario.CHAR_NUM ], [ Games.superMarioBros ] ); } 
		
		[Embed(source="../assets/images/skins/001/theme_001.png")]
		private static const theme_001:Class;	{ addTheme( theme_001, CT_16B, [ Mario.CHAR_NUM ], [ Games.superMarioAllStars ] ); }
		
		[Embed(source="../assets/images/skins/002/theme_002.png")]
		private static const theme_002:Class;	{ addTheme( theme_002, CT_GB, [ Mario.CHAR_NUM ], [ Games.superMarioLand2 ] ); }
		
		[Embed(source="../assets/images/skins/003/theme_003.png")]
		private static const theme_003:Class;	{ addTheme( theme_003, CT_8B, [ Luigi.CHAR_NUM ], [ Games.superMarioBros3 ] ); }
		
		[Embed(source="../assets/images/skins/004/theme_004.png")]
		private static const theme_004:Class;	{ addTheme( theme_004, CT_16B, [ Luigi.CHAR_NUM ], [ Games.superMarioBros3Snes ] ); }
		
		[Embed(source="../assets/images/skins/005/theme_005.png")]
		private static const theme_005:Class;	{ addTheme( theme_005, CT_8B, [ Mario.CHAR_NUM ], [ Games.demonReturns ] ); }
		
		[Embed(source="../assets/images/skins/006/theme_006.png")]
		private static const theme_006:Class;	{ addTheme( theme_006, CT_8B, [ Sophia.CHAR_NUM ], [ Games.blasterMaster ] ); }
		
		[Embed(source="../assets/images/skins/007/theme_007.png")]
		private static const theme_007:Class;	{ addTheme( theme_007, CT_8B, [ Mario.CHAR_NUM ], [ Games.superMarioBros ] ); }
		
		[Embed(source="../assets/images/skins/008/theme_008.png")]
		private static const theme_008:Class;	{ addTheme( theme_008, CT_8B, [ Mario.CHAR_NUM ], [ Games.superMarioBrosAtari ] ); }
		
		[Embed(source="../assets/images/skins/009/theme_009.png")]
		private static const theme_009:Class;	{ addTheme( theme_009, CT_8B, [ Link.CHAR_NUM ], [ Games.zeldaAdventureOfLink ] ); }
		
		[Embed(source="../assets/images/skins/010/theme_010.png")]
		private static const theme_010:Class;	{ addTheme( theme_010, CT_16B, [ Mario.CHAR_NUM ], [ Games.superMarioWorld ] ); }
		
		[Embed(source="../assets/images/skins/011/theme_011.png")]
		private static const theme_011:Class;	{ addTheme( theme_011, CT_8B, [ Mario.CHAR_NUM ], [ Games.superMarioBrosLostLevels ] ); }
		
		[Embed(source="../assets/images/skins/012/theme_012.png")]
		private static const theme_012:Class;	{ addTheme( theme_012, CT_8B, [ Mario.CHAR_NUM ], [ Games.superMarioBros2 ] ); }
		
		[Embed(source="../assets/images/skins/013/theme_013.png")]
		private static const theme_013:Class;	{ addTheme( theme_013, CT_16B, [ Mario.CHAR_NUM ], [ Games.superMarioBros2Snes ] ); }
		
		[Embed(source="../assets/images/skins/014/theme_014.png")]
		private static const theme_014:Class;	{ addTheme( theme_014, CT_8B, [ Mario.CHAR_NUM ], [ Games.superMarioBrosSpecial ] ); }
		
		[Embed(source="../assets/images/skins/015/theme_015.png")]
		private static const theme_015:Class;	{ addTheme( theme_015, CT_8B, [ Simon.CHAR_NUM ], [ Games.castlevania ] ); }

		[Embed(source="../assets/images/skins/016/theme_016.png")]
		private static const theme_016:Class;	{ addTheme( theme_016, CT_8B, [ Mario.CHAR_NUM ], [ Games.superMarioBrosAllNightNippon ] ); }

//		-------------------------------------------------------------------------------------------------------------------
//		interfaces
//		-------------------------------------------------------------------------------------------------------------------
		[Embed(source="../assets/images/skins/000/interface_000.png")]
		private static const Interface000:Class;
		{
			BMC_VEC.push( new BmdSkinCont( new Interface000(), 0, ST_INTERFACE, null, null, CT_8B, [ Mario.CHAR_NUM ], [ Games.superMarioBros ] ) ) 
			drawingBoardInterfaceBmc = BMC_VEC[BMC_VEC.length - 1].clone();
		}
		
		[Embed(source="../assets/images/skins/001/interface_001.png")]
		private static const Interface001:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Interface001(), 1, ST_INTERFACE, null, null, CT_16B, [ Mario.CHAR_NUM ], [ Games.superMarioAllStars ] ) ) }
		
		[Embed(source="../assets/images/skins/002/interface_002.png")]
		private static const Interface002:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Interface002(), 2, ST_INTERFACE, null, null, CT_GB, [ Mario.CHAR_NUM ], [ Games.superMarioLand2 ] ) ) }
		
		[Embed(source="../assets/images/skins/003/interface_003.png")]
		private static const Interface003:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Interface003(), 3, ST_INTERFACE, null, null, CT_8B, [ Mario.CHAR_NUM ], [ Games.superMarioBros3 ] ) ) }
		
		[Embed(source="../assets/images/skins/004/interface_004.png")]
		private static const Interface004:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Interface004(), 4, ST_INTERFACE, null, null, CT_16B, [ Mario.CHAR_NUM ], [ Games.superMarioBros3Snes ] ) ) }
		
		[Embed(source="../assets/images/skins/005/interface_005.png")]
		private static const Interface005:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Interface005(), 5, ST_INTERFACE, null, null, CT_8B, [ Mario.CHAR_NUM ], [ Games.demonReturns ] ) ) }

		[Embed(source="../assets/images/skins/006/interface_006.png")]
		private static const Interface006:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Interface006(), 6, ST_INTERFACE, null, null, CT_8B, [ Mario.CHAR_NUM ], [ Games.blasterMaster ] ) ) }

		[Embed(source="../assets/images/skins/007/interface_007.png")]
		private static const Interface007:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Interface007(), 7, ST_INTERFACE, null, null, CT_8B, [ Mario.CHAR_NUM ], [ Games.superMarioBros ] ) ) }
		
		[Embed(source="../assets/images/skins/008/interface_008.png")]
		private static const Interface008:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Interface008(), 8, ST_INTERFACE, null, null, CT_8B, [ Mario.CHAR_NUM ], [ Games.superMarioBros ] ) ) }
		
		[Embed(source="../assets/images/skins/009/interface_009.png")]
		private static const Interface009:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Interface009(), 9, ST_INTERFACE, null, null, CT_8B, [ Link.CHAR_NUM ], [ Games.zeldaAdventureOfLink ] ) ) }
		
		[Embed(source="../assets/images/skins/010/interface_010.png")]
		private static const Interface010:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Interface010(), 10, ST_INTERFACE, null, null, CT_16B, [ Mario.CHAR_NUM ], [ Games.superMarioWorld ] ) ) }
		
		[Embed(source="../assets/images/skins/011/interface_011.png")]
		private static const Interface011:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Interface011(), 11, ST_INTERFACE, null, null, CT_8B, [ Mario.CHAR_NUM ], [ Games.superMarioBrosLostLevels ] ) ) }
		
		[Embed(source="../assets/images/skins/012/interface_012.png")]
		private static const Interface012:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Interface012(), 12, ST_INTERFACE, null, null, CT_8B, [ Mario.CHAR_NUM ], [ Games.superMarioBros2 ] ) ) }
		
		[Embed(source="../assets/images/skins/013/interface_013.png")]
		private static const Interface013:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Interface013(), 13, ST_INTERFACE, null, null, CT_16B, [ Mario.CHAR_NUM ], [ Games.superMarioBros2Snes ] ) ) }
		
		[Embed(source="../assets/images/skins/014/interface_014.png")]
		private static const Interface014:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Interface014(), 14, ST_INTERFACE, null, null, CT_8B, [ Mario.CHAR_NUM ], [ Games.superMarioBrosSpecial ] ) ) }
		
		[Embed(source="../assets/images/skins/015/interface_015.png")]
		private static const Interface015:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Interface015(), 15, ST_INTERFACE, null, null, CT_8B, [ Simon.CHAR_NUM ], [ Games.castlevania ] ) ) }

		[Embed(source="../assets/images/skins/016/interface_016.png")]
		private static const Interface016:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Interface016(), 16, ST_INTERFACE, null, null, CT_8B, [ Mario.CHAR_NUM ], [ Games.superMarioBrosAllNightNippon ] ) ) }

//		-------------------------------------------------------------------------------------------------------------------
//		 palettes
//		-------------------------------------------------------------------------------------------------------------------		
		[Embed(source="../assets/images/skins/000/palette_000.png")]
		private static const palette_000:Class;			{ addMainPalette(palette_000); }

		[Embed(source="../assets/images/skins/001/palette_001.png")]
		private static const palette_001:Class;			{ addMainPalette(palette_001); }
		
		[Embed(source="../assets/images/skins/002/palette_002.png")]
		private static const palette_002:Class;			{ addMainPalette(palette_002); }
		
		[Embed(source="../assets/images/skins/003/palette_003.png")]
		private static const palette_003:Class;			{ addMainPalette(palette_003); }
		
		[Embed(source="../assets/images/skins/004/palette_004.png")]
		private static const palette_004:Class;			{ addMainPalette(palette_004); }
		
		[Embed(source="../assets/images/skins/005/palette_005.png")]
		private static const palette_005:Class;			{ addMainPalette(palette_005); }
		
		[Embed(source="../assets/images/skins/006/palette_006.png")]
		private static const palette_006:Class;			{ addMainPalette(palette_006); }
		
		[Embed(source="../assets/images/skins/007/palette_007.png")]
		private static const palette_007:Class;			{ addMainPalette(palette_007); }
		
		[Embed(source="../assets/images/skins/008/palette_008.png")]
		private static const palette_008:Class;			{ addMainPalette(palette_008); }
		
		[Embed(source="../assets/images/skins/009/palette_009.png")]
		private static const palette_009:Class;			{ addMainPalette(palette_009); }
		
		[Embed(source="../assets/images/skins/010/palette_010.png")]
		private static const palette_010:Class;			{ addMainPalette(palette_010); }
		
		[Embed(source="../assets/images/skins/011/palette_011.png")]
		private static const palette_011:Class;			{ addMainPalette(palette_011); }
		
		[Embed(source="../assets/images/skins/012/palette_012.png")]
		private static const palette_012:Class;			{ addMainPalette(palette_012); }
		
		[Embed(source="../assets/images/skins/013/palette_013.png")]
		private static const palette_013:Class;			{ addMainPalette(palette_013); }
		
		[Embed(source="../assets/images/skins/014/palette_014.png")]
		private static const palette_014:Class;			{ addMainPalette(palette_014); }
		
		[Embed(source="../assets/images/skins/015/palette_015.png")]
		private static const palette_015:Class;			{ addMainPalette(palette_015); }

		[Embed(source="../assets/images/skins/016/palette_016.png")]
		private static const palette_016:Class;			{ addMainPalette(palette_016); }

//		-------------------------------------------------------------------------------------------------------------------
//		bass
//		-------------------------------------------------------------------------------------------------------------------
		[Embed(source="../assets/images/characters/bass/bass_palette.png")]
		private static const bass_palette:Class;			{ addCharPalette(bass_palette,Bass.CHAR_NUM); }
		
//		[Embed(source="../assets/images/characters/bass/bass_preview.png")]
//		private static const bass_preview:Class;			{ addCharacterPreview(bass_preview, Bass.CHAR_NUM); }
		
		[Embed(source="../assets/images/characters/bass/bass_000.png")]
		private static const Bass000:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Bass000(), 0, ST_CHAR, null, null, CT_8B, [ Bass.CHAR_NUM ], [ Games.megaMan10, Games.megaManAndBass, Games.megaMan5Gb, Games.megaMan10 ], [ null, null, "Dr. Wily" ], null  ) ) }
		
		[Embed(source="../assets/images/characters/bass/bass_001.png")]
		private static const Bass001:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Bass001(), 1, ST_CHAR, null, null, CT_16B, [ Bass.CHAR_NUM ], [ Games.megaMan10, Games.megaManAndBass, Games.megaMan5Gb, Games.megaMan10 ], [ null, null, "Dr. Wily" ], null ) ) }
		
		[Embed(source="../assets/images/characters/bass/bass_002.png")]
		private static const Bass002:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Bass002(), 2, ST_CHAR, null, null, CT_GB, [ Bass.CHAR_NUM ], [ Games.megaMan10, Games.megaManAndBass, Games.megaMan5Gb, Games.rockManBattleAndFighters ], [ null, null, "Dr. Wily" ], null ) ) }
		
		[Embed(source="../assets/images/characters/bass/bass_003.png")]
		private static const Bass003:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Bass003(), 3, ST_CHAR, null, null, CT_8B, [ Bass.CHAR_NUM ], [ Games.megaMan2, Games.megaMan7, Games.megaManGb, Games.megaMan ], [ "Dr. Wily", "Dr. Wily", "Bass" ], null ) ) }
		
		[Embed(source="../assets/images/characters/bass/bass_004.png")]
		private static const Bass004:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Bass004(), 4, ST_CHAR, null, null, CT_16B, [ Bass.CHAR_NUM ], [ Games.megaMan2, Games.megaMan7, Games.megaManGb, Games.megaMan ], [ "Dr. Wily", "Dr. Wily", "Bass" ], null ) ) }
		
		[Embed(source="../assets/images/characters/bass/bass_005.png")]
		private static const Bass005:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Bass005(), 5, ST_CHAR, null, null, CT_8B, [ Bass.CHAR_NUM ], [ Games.megaMan6, Games.megaMan7, Games.megaMan4Gb, Games.megaMan6 ], [ "Mr. X", "Mr. X", "Bass" ], null ) ) }
		
		[Embed(source="../assets/images/characters/bass/bass_006.png")]
		private static const Bass006:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Bass006(), 6, ST_CHAR, null, null, CT_16B, [ Bass.CHAR_NUM ], [ Games.megaMan6, Games.megaMan7, Games.megaMan4Gb, Games.megaMan6 ], [ "Mr. X", "Mr. X", "Bass" ], null ) ) }
		
		[Embed(source="../assets/images/characters/bass/bass_007.png")]
		private static const Bass007:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Bass007(), 7, ST_CHAR, null, null, CT_8B, [ Bass.CHAR_NUM ], [ Games.megaMan2, Games.megaMan7, Games.megaManGb, Games.megaMan2 ], [ "Quick Man", "Quick Man", "Dr. Wily" ], null, null, SkinDescriptions.BASS_SKIN_QUICK_MAN  ) ) }

		[Embed(source="../assets/images/characters/bass/bass_008.png")]
		private static const Bass008:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Bass008(), 8, ST_CHAR, null, null, CT_16B, [ Bass.CHAR_NUM ], [ Games.megaMan2, Games.megaMan7, Games.megaManGb, Games.megaManWilyWars ], [ "Quick Man", "Quick Man", "Dr. Wily" ], null, null, SkinDescriptions.BASS_SKIN_QUICK_MAN  ) ) }

		[Embed(source="../assets/images/characters/bass/bass_009.png")]
		private static const Bass009:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Bass009(), 9, ST_CHAR, null, null, CT_8B, [ Bass.CHAR_NUM ], [ Games.superMarioBrosAtari, Games.superMarioBrosAtari, Games.superMarioBrosAtari, Games.megaMan10 ], [ null, null, "Dr. Wily" ], null ) ) }
		
		[Embed(source="../assets/images/characters/bass/bass_010.png")]
		private static const Bass010:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Bass010(), 10, ST_CHAR, null, null, CT_8B, [ Bass.CHAR_NUM ], [ Games.megaMan4, Games.megaMan7, Games.megaMan3Gb, Games.megaMan4 ], [ "Dr. Cossack", "Dr. Cossack", "Kalinka" ], null ) ) }
		
		[Embed(source="../assets/images/characters/bass/bass_011.png")]
		private static const Bass011:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Bass011(), 11, ST_CHAR, null, null, CT_16B, [ Bass.CHAR_NUM ], [ Games.megaMan4, Games.megaMan7, Games.megaMan3Gb, Games.megaMan4 ], [ "Dr. Cossack", "Dr. Cossack", "Kalinka" ], null ) ) }
		
		[Embed(source="../assets/images/characters/bass/bass_012.png")]
		private static const Bass012:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Bass012(), 12, ST_CHAR, null, null, CT_8B, [ Bass.CHAR_NUM ], [ Games.megaMan10, Games.megaManAndBass, Games.megaMan5Gb, Games.megaMan10 ], [ null, null, "Dr. Wily" ], null ) ) }
		
		[Embed(source="../assets/images/characters/bass/bass_013.png")]
		private static const Bass013:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Bass013(), 13, ST_CHAR, null, null, CT_8B, [ Bass.CHAR_NUM ], [ Games.megaMan3, Games.megaMan7, Games.megaMan3Gb, Games.megaMan3 ], [ "Gemini Man", "Gemini Man", "Dr. Wily" ], null ) ) }

		[Embed(source="../assets/images/characters/bass/bass_014.png")]
		private static const Bass014:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Bass014(), 14, ST_CHAR, null, null, CT_16B, [ Bass.CHAR_NUM ], [ Games.megaMan3, Games.megaMan7, Games.megaMan3Gb, Games.megaManWilyWars ], [ "Gemini Man", "Gemini Man", "Dr. Wily" ], null ) ) }

		[Embed(source="../assets/images/characters/bass/bass_015.png")]
		private static const Bass015:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Bass015(), 15, ST_CHAR, null, null, CT_8B, [ Bass.CHAR_NUM ], [ Games.megaMan4, Games.megaMan7, Games.megaMan3Gb, Games.megaMan4 ], [ "Skull Man", "Skull Man", "Dr. Cossack" ], null ) ) }

//		-------------------------------------------------------------------------------------------------------------------
//		bill
//		-------------------------------------------------------------------------------------------------------------------
		[Embed(source="../assets/images/characters/bill/bill_palette.png")]
		private static const bill_palette:Class;			{ addCharPalette(bill_palette, Bill.CHAR_NUM); }
		
//		[Embed(source="../assets/images/characters/bill/bill_preview.png")]
//		private static const bill_preview:Class;			{ addCharacterPreview(bill_preview, Bill.CHAR_NUM); }
		
		[Embed(source="../assets/images/characters/bill/bill_000.png")]
		private static const Bill000:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Bill000(), 0, ST_CHAR, null, null, CT_8B, [ Bill.CHAR_NUM ], [ Games.contra, Games.contra3Snes, Games.operationC, Games.contra ], [ null, null, "your buddy" ], null, null, SkinDescriptions.BILL_SKIN_ALL  ) ) }
			
		[Embed(source="../assets/images/characters/bill/bill_001.png")]
		private static const Bill001:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Bill001(), 1, ST_CHAR, null, null, CT_16B, [ Bill.CHAR_NUM ], [ Games.contra, Games.contra3Snes, Games.operationC, Games.contra ], [ null, null, "your buddy" ], null, null, SkinDescriptions.BILL_SKIN_ALL  ) ) }
		
		[Embed(source="../assets/images/characters/bill/bill_002.png")]
		private static const Bill002:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Bill002(), 2, ST_CHAR, null, null, CT_GB, [ Bill.CHAR_NUM ], [ Games.superC, Games.contra3Snes, Games.operationC, Games.operationC ], [ null, null, "your buddy" ], null, null, SkinDescriptions.BILL_SKIN_ALL  ) ) }
		
		[Embed(source="../assets/images/characters/bill/bill_003.png")]
		private static const Bill003:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Bill003(), 3, ST_CHAR, null, null, CT_8B, [ Bill.CHAR_NUM ], [ Games.contra, Games.contra3Snes, Games.operationC, Games.contra ], [ "Lance Bean", "Lance", "your buddy" ], null, null, SkinDescriptions.BILL_SKIN_ALL  ) ) }
		
		[Embed(source="../assets/images/characters/bill/bill_004.png")]
		private static const Bill004:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Bill004(), 4, ST_CHAR, null, null, CT_16B, [ Bill.CHAR_NUM ], [ Games.contra, Games.contra3Snes, Games.operationC, Games.contra ], [ "Lance Bean", "Lance", "your buddy" ], null, null, SkinDescriptions.BILL_SKIN_ALL  ) ) }
		
		[Embed(source="../assets/images/characters/bill/bill_005.png")]
		private static const Bill005:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Bill005(), 5, ST_CHAR, null, null, CT_GB, [ Bill.CHAR_NUM ], [ Games.superC, Games.contra3Snes, Games.operationC, Games.operationC ], [ "Lance Bean", "Lance", "your buddy" ], null, null, SkinDescriptions.BILL_SKIN_ALL  ) ) }

		[Embed(source="../assets/images/characters/bill/bill_006.png")]
		private static const Bill006:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Bill006(), 6, ST_CHAR, null, null, CT_8B, [ Bill.CHAR_NUM ], [ Games.superC, Games.contra3Snes, Games.operationC, Games.probotector ], [ "RD-008", "RD-008", "your buddy" ], null, null, SkinDescriptions.BILL_SKIN_ALL  ) ) }
		
		[Embed(source="../assets/images/characters/bill/bill_007.png")]
		private static const Bill007:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Bill007(), 7, ST_CHAR, null, null, CT_8B, [ Bill.CHAR_NUM ], [ Games.superC, Games.contra3Snes, Games.operationC, Games.probotector ], [ "RC-011", "RC-011", "your buddy" ], null, null, SkinDescriptions.BILL_SKIN_ALL  ) ) }

		[Embed(source="../assets/images/characters/bill/bill_008.png")]
		private static const Bill008:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Bill008(), 8, ST_CHAR, null, null, CT_16B, [ Bill.CHAR_NUM ], [ Games.superC, Games.contra3Snes, Games.operationC, Games.contra ], [ null, null, "your buddy" ], null, null, SkinDescriptions.BILL_SKIN_ALL  ) ) }

		[Embed(source="../assets/images/characters/bill/bill_009.png")]
		private static const Bill009:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Bill009(), 9, ST_CHAR, null, null, CT_16B, [ Bill.CHAR_NUM ], [ Games.superC, Games.contra3Snes, Games.operationC, Games.contra ], [ "Lance Bean", "Lance", "your buddy" ], null, null, SkinDescriptions.BILL_SKIN_ALL  ) ) }

		[Embed(source="../assets/images/characters/bill/bill_010.png")]
		private static const Bill010:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Bill010(), 10, ST_CHAR, null, null, CT_8B, [ Bill.CHAR_NUM ], [ Games.superMarioBrosAtari, Games.superMarioBrosAtari, Games.superMarioBrosAtari, Games.contra ], [ null, null, "your buddy" ], null, null, SkinDescriptions.BILL_SKIN_ALL  ) ) }
		
		[Embed(source="../assets/images/characters/bill/bill_011.png")] // X1
		private static const Bill011:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Bill011(), 11, ST_CHAR, null, null, CT_GB, [ Bill.CHAR_NUM ], [ Games.contra, Games.contra3Snes, Games.operationC, Games.contra ], [ null, null, "your buddy" ], null, null, SkinDescriptions.BILL_SKIN_ALL  ) ) }

		[Embed(source="../assets/images/characters/bill/bill_012.png")]
		private static const Bill012:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Bill012(), 12, ST_CHAR, null, null, CT_GB, [ Bill.CHAR_NUM ], [ Games.superC, Games.contra3Snes, Games.operationC, Games.probotectorGb ], [ "RD-008", "RD-008", "your buddy" ], null, null, SkinDescriptions.BILL_SKIN_ALL  ) ) }

		[Embed(source="../assets/images/characters/bill/bill_013.png")]
		private static const Bill013:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Bill013(), 13, ST_CHAR, null, null, CT_GB, [ Bill.CHAR_NUM ], [ Games.superC, Games.contra3Snes, Games.operationC, Games.probotectorGb ], [ "RC-011", "RC-011", "your buddy" ], null, null, SkinDescriptions.BILL_SKIN_ALL  ) ) }

		[Embed(source="../assets/images/characters/bill/bill_014.png")]
		private static const Bill014:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Bill014(), 14, ST_CHAR, null, null, CT_8B, [ Bill.CHAR_NUM ], [ Games.superMarioBrosAtari, Games.superMarioBrosAtari, Games.superMarioBrosAtari, Games.contra ], [ "Lance Bean", "Lance", "your buddy" ], null, null, SkinDescriptions.BILL_SKIN_ALL  ) ) }

		[Embed(source="../assets/images/characters/bill/bill_015.png")]
		private static const Bill015:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Bill015(), 15, ST_CHAR, null, null, CT_8B, [ Bill.CHAR_NUM ], [ Games.superC, Games.contra3Snes, Games.operationC, Games.superC ], [ null, null, "your buddy" ], null, null, SkinDescriptions.BILL_SKIN_ALL  ) ) }

		[Embed(source="../assets/images/characters/bill/bill_016.png")]
		private static const Bill016:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Bill016(), 16, ST_CHAR, null, null, CT_8B, [ Bill.CHAR_NUM ], [ Games.superC, Games.contra3Snes, Games.operationC, Games.superC ], [ "Lance Bean", "Lance", "your buddy" ], null, null, SkinDescriptions.BILL_SKIN_ALL  ) ) }

		[Embed(source="../assets/images/characters/bill/bill_017.png")] // X1
		private static const Bill017:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Bill017(), 17, ST_CHAR, null, null, CT_GB, [ Bill.CHAR_NUM ], [ Games.contra, Games.contra3Snes, Games.operationC, Games.contra ], [ "Lance Bean", "Lance", "your buddy" ], null, null, SkinDescriptions.BILL_SKIN_ALL  ) ) }

//		-------------------------------------------------------------------------------------------------------------------
//		link
//		-------------------------------------------------------------------------------------------------------------------
		[Embed(source="../assets/images/characters/link/link_palette.png")]
		private static const link_palette:Class;			{ addCharPalette(link_palette,Link.CHAR_NUM); }
		
//		[Embed(source="../assets/images/characters/link/link_preview.png")]
//		private static const link_preview:Class;			{ addCharacterPreview(link_preview, Link.CHAR_NUM); }
		
		[Embed(source="../assets/images/characters/link/link_000.png")]
		private static const Link000:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Link000(), 0, ST_CHAR, null, null, CT_8B, [ Link.CHAR_NUM ], [ Games.zelda, Games.zeldaLinkToThePast, Games.zeldaLinksAwakening, Games.zelda ], [ null, null, "Princess Zelda" ], null ) ) }
			
		[Embed(source="../assets/images/characters/link/link_001.png")]
		private static const Link001:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Link001(), 1, ST_CHAR, null, null, CT_16B, [ Link.CHAR_NUM ], [ Games.zelda, Games.zeldaLinkToThePast, Games.zeldaLinksAwakening, Games.zeldaLinkToThePast ], [ null, null, "Princess Zelda" ], null  ) ) }
		
		[Embed(source="../assets/images/characters/link/link_002.png")]
		private static const Link002:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Link002(), 2, ST_CHAR, null, null, CT_GB, [ Link.CHAR_NUM ], [ Games.zelda, Games.zeldaLinkToThePast, Games.zeldaLinksAwakening, Games.zeldaLinksAwakening ], [ null, null, "Marin" ], null  ) ) }
		
		[Embed(source="../assets/images/characters/link/link_003.png")]
		private static const Link003:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Link003(), 3, ST_CHAR, null, null, CT_8B, [ Link.CHAR_NUM ], [ Games.zeldaAdventureOfLink, Games.zeldaBs, Games.zeldaLinksAwakening, Games.zeldaAdventureOfLink ], [ "Dark Link", "Dark Link", "Ganon" ], null  ) ) }
		
		[Embed(source="../assets/images/characters/link/link_004.png")]
		private static const Link004:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Link004(), 4, ST_CHAR, null, null, CT_16B, [ Link.CHAR_NUM ], [ Games.zeldaAdventureOfLink, Games.zeldaBs, Games.zeldaLinksAwakening, Games.zeldaAdventureOfLink ], [ "Dark Link", "Dark Link", "Ganon" ], null  ) ) }
		
		[Embed(source="../assets/images/characters/link/link_005.png")]
		private static const Link005:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Link005(), 5, ST_CHAR, null, null, CT_GB, [ Link.CHAR_NUM ], [ Games.zeldaAdventureOfLink, Games.zeldaBs, Games.zeldaLinksAwakening, Games.zeldaOracleOfAges ], [ "Dark Link", "Dark Link", "Nightmare Ganon" ], null  ) ) }
		
		[Embed(source="../assets/images/characters/link/link_006.png")]
		private static const Link006:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Link006(), 6, ST_CHAR, null, null, CT_8B, [ Link.CHAR_NUM ], [ Games.zelda, Games.zeldaBs, Games.zeldaLinksAwakening, Games.zelda ], [ "Old Man", "Old Man", "the old woman" ], null  ) ) }
		
		[Embed(source="../assets/images/characters/link/link_007.png")]
		private static const Link007:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Link007(), 7, ST_CHAR, null, null, CT_8B, [ Link.CHAR_NUM ], [ Games.zelda, Games.zeldaLinkToThePast, Games.zeldaLinksAwakening, Games.zelda ], [ "Princess Zelda", "Zelda", "Link" ], null, null, SkinDescriptions.LINK_SKIN_ZELDA  ) ) }
		
		[Embed(source="../assets/images/characters/link/link_008.png")]
		private static const Link008:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Link008(), 8, ST_CHAR, null, null, CT_16B, [ Link.CHAR_NUM ], [ Games.zelda, Games.zeldaBs, Games.zeldaLinksAwakening, Games.zeldaBs ], [ "Hero", "Hero", "Princess Zelda" ], null  ) ) }
		
		[Embed(source="../assets/images/characters/link/link_009.png")]
		private static const Link009:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Link009(), 9, ST_CHAR, null, null, CT_16B, [ Link.CHAR_NUM ], [ Games.zelda, Games.zeldaBs, Games.zeldaLinksAwakening, Games.zeldaBs ], [ "Heroine", "Heroine", "Princess Zelda" ], null  ) ) }
		
		[Embed(source="../assets/images/characters/link/link_010.png")]
		private static const Link010:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Link010(), 10, ST_CHAR, null, null, CT_8B, [ Link.CHAR_NUM ], [ Games.arkistasRing, Games.arkistasRing, Games.arkistasRing, Games.arkistasRing ], [ "Christine", "Christine", "Arkista's Ring" ], null  ) ) }

		[Embed(source="../assets/images/characters/link/link_011.png")]
		private static const Link011:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Link011(), 11, ST_CHAR, null, null, CT_8B, [ Link.CHAR_NUM ], [ Games.superMarioBrosAtari, Games.superMarioBrosAtari, Games.superMarioBrosAtari, Games.zelda ], [ null, null, "Princess Zelda" ], null  ) ) }

		[Embed(source="../assets/images/characters/link/link_012.png")]
		private static const Link012:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Link012(), 12, ST_CHAR, null, null, CT_16B, [ Link.CHAR_NUM ], [ Games.finalFantasy, Games.finalFantasyMysticQuest, Games.finalFantasyAdventure, Games.finalFantasyMysticQuest ], [ "Benjamin", "Benjamin", "Kaeli" ], null  ) ) }
		
		[Embed(source="../assets/images/characters/link/link_013.png")]
		private static const Link013:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Link013(), 13, ST_CHAR, null, null, CT_8B, [ Link.CHAR_NUM ], [ Games.dragonWarrior, Games.dragonWarriorSnes, Games.dragonWarriorGb, Games.dragonWarrior ], [ "Erdrick", "Erdrick", "Princess Gwaelin" ], null  ) ) }
		
		[Embed(source="../assets/images/characters/link/link_014.png")]
		private static const Link014:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Link014(), 14, ST_CHAR, null, null, CT_8B, [ Link.CHAR_NUM ], [ Games.zelda, Games.zeldaLinkToThePast, Games.zeldaLinksAwakening, Games.zelda ], [ null, null, "Princess Zelda" ], null  ) ) }

		[Embed(source="../assets/images/characters/link/link_015.png")]
		private static const Link015:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Link015(), 15, ST_CHAR, null, null, CT_16B, [ Link.CHAR_NUM ], [ Games.zelda, Games.zeldaBs, Games.zeldaLinksAwakening, Games.zeldaBs ], [ "Princess Zelda", "Zelda", "Link" ], null, null, SkinDescriptions.LINK_SKIN_ZELDA  ) ) }

		[Embed(source="../assets/images/characters/link/link_016.png")]
		private static const Link016:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Link016(), 16, ST_CHAR, null, null, CT_GB, [ Link.CHAR_NUM ], [ Games.zelda, Games.zeldaLinkToThePast, Games.zeldaOracleOfAges, Games.zeldaOracleOfAges ], [ "Ralph", "Ralph", "Nayru" ], null  ) ) }

		[Embed(source="../assets/images/characters/link/link_017.png")]
		private static const Link017:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Link017(), 17, ST_CHAR, null, null, CT_GB, [ Link.CHAR_NUM ], [ Games.zelda, Games.zeldaLinkToThePast, Games.zeldaOracleOfSeasons, Games.zeldaOracleOfSeasons ], [ "Princess Zelda", "Zelda", "Link" ], null, null, SkinDescriptions.LINK_SKIN_ZELDA  ) ) }

		[Embed(source="../assets/images/characters/link/link_018.png")]
		private static const Link018:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Link018(), 18, ST_CHAR, null, null, CT_GB, [ Link.CHAR_NUM ], [ Games.dragonWarrior, Games.dragonWarriorSnes, Games.dragonWarriorGb, Games.dragonWarriorGb ], [ "Loto", "Loto", "Lady Laura" ], null  ) ) }

		[Embed(source="../assets/images/characters/link/link_019.png")]
		private static const Link019:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Link019(), 19, ST_CHAR, null, null, CT_16B, [ Link.CHAR_NUM ], [ Games.dragonWarrior, Games.dragonWarriorSnes, Games.dragonWarriorGb, Games.dragonWarriorSnes ], [ "Roto", "Roto", "Lady Lora" ], null  ) ) }

		[Embed(source="../assets/images/characters/link/link_020.png")]
		private static const Link020:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Link020(), 20, ST_CHAR, null, null, CT_16B, [ Link.CHAR_NUM ], [ Games.zelda, Games.zeldaBs, Games.zeldaLinksAwakening, Games.zeldaBs ], [ "Old Man", "Old Man", "the old woman" ], null  ) ) }

		[Embed(source="../assets/images/characters/link/link_021.png")]
		private static const Link021:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Link021(), 21, ST_CHAR, null, null, CT_GB, [ Link.CHAR_NUM ], [ Games.zelda, Games.zeldaBs, Games.zeldaLinksAwakening, Games.zeldaLinksAwakening ], [ "Old Man", "Old Man", "the old woman" ], null  ) ) }

		[Embed(source="../assets/images/characters/link/link_022.png")]
		private static const Link022:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Link022(), 22, ST_CHAR, null, null, CT_16B, [ Link.CHAR_NUM ], [ Games.finalFantasy3, Games.finalFantasy4, Games.finalFantasyAdventure, Games.finalFantasy4 ], [ "Cecil", "Cecil", "Rosa" ], null  ) ) }

		[Embed(source="../assets/images/characters/link/link_023.png")]
		private static const Link023:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Link023(), 23, ST_CHAR, null, null, CT_16B, [ Link.CHAR_NUM ], [ Games.finalFantasy3, Games.finalFantasy4, Games.finalFantasyAdventure, Games.finalFantasy4 ], [ "Cecil", "Cecil", "Rosa" ], null  ) ) }

		[Embed(source="../assets/images/characters/link/link_024.png")]
		private static const Link024:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Link024(), 24, ST_CHAR, null, null, CT_16B, [ Link.CHAR_NUM ], [ Games.finalFantasy3, Games.finalFantasy5, Games.finalFantasyAdventure, Games.finalFantasy5 ], [ "Bartz", "Bartz", "Boco" ], null  ) ) }

//		-------------------------------------------------------------------------------------------------------------------
//		luigi
//		-------------------------------------------------------------------------------------------------------------------
		[Embed(source="../assets/images/characters/luigi/luigi_palette.png")]
		private static const luigi_palette:Class;			{ addCharPalette(luigi_palette,Luigi.CHAR_NUM); }
		
//		[Embed(source="../assets/images/characters/luigi/luigi_preview.png")]
//		private static const luigi_preview:Class;			{ addCharacterPreview(luigi_preview, Luigi.CHAR_NUM); }
		
		[Embed(source="../assets/images/characters/luigi/luigi_000.png")]
		private static const Luigi000:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Luigi000(), 0, ST_CHAR, null, null, CT_8B, [ Luigi.CHAR_NUM ], [ Games.superMarioBros, Games.superMarioBrosSnes, Games.superMarioBrosDeluxe, Games.superMarioBrosDeluxe ], [ null, null, "your princess" ], null ) ) }
		
		[Embed(source="../assets/images/characters/luigi/luigi_001.png")]
		private static const Luigi001:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Luigi001(), 1, ST_CHAR, null, null, CT_16B, [ Luigi.CHAR_NUM ], [ Games.superMarioBros, Games.superMarioBrosSnes, Games.superMarioBrosDeluxe, Games.superMarioBrosSnes ], [ null, null, "your princess" ], null ) ) }
		
		[Embed(source="../assets/images/characters/luigi/luigi_002.png")]
		private static const Luigi002:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Luigi002(), 2, ST_CHAR, null, null, CT_GB, [ Luigi.CHAR_NUM ], [ Games.superMarioBros, Games.superMarioBrosSnes, Games.superMarioLand2, Games.superMarioLand2 ], [ null, null, "your princess" ], null ) ) }
		
		[Embed(source="../assets/images/characters/luigi/luigi_003.png")]
		private static const Luigi003:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Luigi003(), 3, ST_CHAR, null, null, CT_8B, [ Luigi.CHAR_NUM ], [ Games.superMarioBros3, Games.superMarioBrosSnes, Games.superMarioLand2, Games.superMarioBros3 ], [ null, null, "your princess" ], null ) ) }
		
		[Embed(source="../assets/images/characters/luigi/luigi_004.png")]
		private static const Luigi004:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Luigi004(), 4, ST_CHAR, null, null, CT_8B, [ Luigi.CHAR_NUM ], [ Games.superMarioBros2, Games.superMarioBros2Snes, Games.superMarioLand, Games.superMarioBros2 ], [ null, null, "the Subcon" ], null ) ) }
			
		[Embed(source="../assets/images/characters/luigi/luigi_005.png")]
		private static const Luigi005:Class;	
		{ BMC_VEC.push( new BmdSkinCont( new Luigi005(), 5, ST_CHAR, null, null, CT_16B, [ Luigi.CHAR_NUM ], [ Games.superMarioBros2, Games.superMarioBros2Snes, Games.superMarioLand, Games.superMarioBros2Snes ], [ null, null, "the Subcon" ], null ) ) }
		
		[Embed(source="../assets/images/characters/luigi/luigi_006.png")]
		private static const Luigi006:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Luigi006(), 6, ST_CHAR, null, null, CT_16B, [ Luigi.CHAR_NUM ], [ Games.superMarioBros2, Games.superMarioWorld, Games.superMarioLand2, Games.superMarioWorld ], [ null, null, "your princess" ], null ) ) }
		
		[Embed(source="../assets/images/characters/luigi/luigi_007.png")]
		private static const Luigi007:Class;	
		{ BMC_VEC.push( new BmdSkinCont( new Luigi007(), 7, ST_CHAR, null, null, CT_16B, [ Luigi.CHAR_NUM ], [ Games.superMarioBros3, Games.superMarioBros3Snes, Games.superMarioLand2, Games.superMarioBros3Snes ], [ null, null, "your princess" ], null ) ) }
		
		[Embed(source="../assets/images/characters/luigi/luigi_008.png")]
		private static const Luigi008:Class;	
		{ BMC_VEC.push( new BmdSkinCont( new Luigi008(), 8, ST_CHAR, null, null, CT_8B, [ Luigi.CHAR_NUM ], [ Games.superMarioBros2, Games.superMarioBros2Snes, Games.superMarioLand, Games.superMarioBros2 ], [ "Princess Toadstool", "Toadstool", "the Subcon" ], null ) ) }

		[Embed(source="../assets/images/characters/luigi/luigi_009.png")]
		private static const Luigi009:Class;	
		{ BMC_VEC.push( new BmdSkinCont( new Luigi009(), 9, ST_CHAR, null, null, CT_8B, [ Luigi.CHAR_NUM ], [ Games.superMarioBrosAtari, Games.superMarioBrosAtari, Games.superMarioBrosAtari, Games.superMarioBros ], [ null, null, "your princess" ], null ) ) }
		
		[Embed(source="../assets/images/characters/luigi/luigi_010.png")]
		private static const Luigi010:Class;	
		{ BMC_VEC.push( new BmdSkinCont( new Luigi010(), 10, ST_CHAR, null, null, CT_16B, [ Luigi.CHAR_NUM ], [ Games.superMarioBros2, Games.superMarioBros2Snes, Games.superMarioLand, Games.superMarioBros2Snes ], [ "Princess Toadstool", "Toadstool", "the Subcon" ], null ) ) }
		
		[Embed(source="../assets/images/characters/luigi/luigi_011.png")]
		private static const Luigi011:Class;	
		{ BMC_VEC.push( new BmdSkinCont( new Luigi011(), 11, ST_CHAR, null, null, CT_8B, [ Luigi.CHAR_NUM ], [ Games.superMarioBrosSpecial, Games.superMarioBrosSnes, Games.superMarioLand, Games.superMarioBros ], [ null, null, "your princess" ], null ) ) }

		[Embed(source="../assets/images/characters/luigi/luigi_012.png")]
		private static const Luigi012:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Luigi012(), 12, ST_CHAR, null, null, CT_GB, [ Luigi.CHAR_NUM ], [ Games.superMarioBros, Games.superMarioBrosSnes, Games.superMarioLand2, Games.superMarioLand2 ], [ "Space Luigi", null, "your princess" ], null ) ) }

		[Embed(source="../assets/images/characters/luigi/luigi_013.png")]
		private static const Luigi013:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Luigi013(), 13, ST_CHAR, null, null, CT_8B, [ Luigi.CHAR_NUM ], [ Games.superMarioBrosLostLevels, Games.superMarioBros2Snes, Games.superMarioBrosDeluxe, Games.superMarioBros ], [ null, null, "your princess" ], null ) ) }

		[Embed(source="../assets/images/characters/luigi/luigi_014.png")]
		private static const Luigi014:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Luigi014(), 14, ST_CHAR, null, null, CT_8B, [ Luigi.CHAR_NUM ], [ Games.superMarioBrosLostLevels, Games.superMarioBros2Snes, Games.superMarioBrosDeluxe, Games.superMario3DWorld ], [ "Modern Luigi", null, "your princess" ], null ) ) }

//		[Embed(source="../assets/images/characters/luigi/luigi_009.png")]
//		private static const Luigi009:Class;
//		{ BMC_VEC.push( new BmdSkinCont( new Luigi009(), 9, ST_CHAR, null, null, CT_8B, [ Luigi.CHAR_NUM ], [ Games.superMarioBros, Games.superMarioBrosSnes, Games.superMarioLand2 ], [ "Waluigi", "Waluigi", null ], null ) ) }

//		-------------------------------------------------------------------------------------------------------------------
//		Mario
//		-------------------------------------------------------------------------------------------------------------------
		[Embed(source="../assets/images/characters/mario/mario_palette.png")]
		private static const mario_palette:Class;			{ addCharPalette(mario_palette,Mario.CHAR_NUM); }
		
//		[Embed(source="../assets/images/characters/mario/mario_preview.png")]
//		private static const mario_preview:Class;			{ addCharacterPreview(mario_preview, Mario.CHAR_NUM); }
		
		[Embed(source="../assets/images/characters/mario/mario_000.png")]
		private static const Mario000:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Mario000(), 0, ST_CHAR, null, null, CT_8B, [ Mario.CHAR_NUM ], [ Games.superMarioBrosLostLevels, Games.superMarioBrosSnes, Games.superMarioBrosDeluxe, Games.superMarioBros ] ) ) }
			
		[Embed(source="../assets/images/characters/mario/mario_001.png")]
		private static const Mario001:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Mario001(), 1, ST_CHAR, null, null, CT_16B, [ Mario.CHAR_NUM ], [ Games.superMarioBrosLostLevels, Games.superMarioBrosSnes, Games.superMarioBrosDeluxe, Games.superMarioBrosSnes ] ) ) }
		
		[Embed(source="../assets/images/characters/mario/mario_002.png")]
		private static const Mario002:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Mario002(), 2, ST_CHAR, null, null, CT_GB, [ Mario.CHAR_NUM ], [ Games.superMarioBrosLostLevels, Games.superMarioBrosSnes, Games.superMarioLand2, Games.superMarioLand2 ] ) ) }
		
		[Embed(source="../assets/images/characters/mario/mario_003.png")]
		private static const Mario003:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Mario003(), 3, ST_CHAR, null, null, CT_8B, [ Mario.CHAR_NUM ], [ Games.superMarioBros3, Games.superMarioBrosSnes, Games.superMarioLand2, Games.superMarioBros3 ], [ ] ) ) }
		
		[Embed(source="../assets/images/characters/mario/mario_004.png")]
		private static const Mario004:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Mario004(), 4, ST_CHAR, null, null, CT_8B, [ Mario.CHAR_NUM ], [ Games.demonReturns, Games.demonReturns, Games.demonReturns, Games.demonReturns ], [ "Demon Prince", "Demon", null ] ) ) }
		
		[Embed(source="../assets/images/characters/mario/mario_005.png")]
		private static const Mario005:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Mario005(), 5, ST_CHAR, null, null, CT_16B, [ Mario.CHAR_NUM ], [ Games.demonReturns, Games.demonReturns, Games.demonReturns, Games.superDemonReturns ], [ "Demon Prince", "Demon", null ] ) ) }

		[Embed(source="../assets/images/characters/mario/mario_006.png")]
		private static const Mario006:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Mario006(), 6, ST_CHAR, null, null, CT_16B, [ Mario.CHAR_NUM ], [ Games.superMarioBros3, Games.superMarioWorld, Games.superMarioLand2, Games.superMarioWorld ], [ ] ) ) }
		
		[Embed(source="../assets/images/characters/mario/mario_007.png")]
		private static const Mario007:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Mario007(), 7, ST_CHAR, null, null, CT_8B, [ Mario.CHAR_NUM ], [ Games.superMarioBros2, Games.superMarioBros2Snes, Games.superMarioLand, Games.superMarioBros2 ], [ null, null, "the Subcon" ], null ) ) }
		
		[Embed(source="../assets/images/characters/mario/mario_008.png")]
		private static const Mario008:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Mario008(), 8, ST_CHAR, null, null, CT_16B, [ Mario.CHAR_NUM ], [ Games.superMarioBros2, Games.superMarioBros2Snes, Games.superMarioLand, Games.superMarioBros2Snes ], [ null, null, "the Subcon" ], null ) ) }

		[Embed(source="../assets/images/characters/mario/mario_009.png")]
		private static const Mario009:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Mario009(), 9, ST_CHAR, null, null, CT_16B, [ Mario.CHAR_NUM ], [ Games.superMarioBros3, Games.superMarioBros3Snes, Games.superMarioLand2, Games.superMarioBros3Snes ], [ ] ) ) }

		[Embed(source="../assets/images/characters/mario/mario_010.png")]
		private static const Mario010:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Mario010(), 10, ST_CHAR, null, null, CT_8B, [ Mario.CHAR_NUM ], [ Games.superMarioBros2, Games.superMarioBros2Snes, Games.superMarioLand, Games.superMarioBros2 ], [ "Toad", "Toad", "the Subcon" ] ) ) }

		[Embed(source="../assets/images/characters/mario/mario_011.png")]
		private static const Mario011:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Mario011(), 11, ST_CHAR, null, null, CT_8B, [ Mario.CHAR_NUM ], [ Games.superMarioBrosAtari, Games.superMarioBrosAtari, Games.superMarioBrosAtari, Games.superMarioBros ], [ null, null, null ] ) ) }

		[Embed(source="../assets/images/characters/mario/mario_012.png")]
		private static const Mario012:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Mario012(), 12, ST_CHAR, null, null, CT_16B, [ Mario.CHAR_NUM ], [ Games.superMarioBros2, Games.superMarioBros2Snes, Games.superMarioLand, Games.superMarioBros2Snes ], [ "Toad", "Toad", "the Subcon" ] ) ) }
		
		[Embed(source="../assets/images/characters/mario/mario_013.png")]
		private static const Mario013:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Mario013(), 13, ST_CHAR, null, null, CT_8B, [ Mario.CHAR_NUM ], [ Games.superMarioBrosSpecial, Games.superMarioBrosSnes, Games.superMarioLand, Games.superMarioBrosSpecial ], [ null, null, null ] ) ) }

		[Embed(source="../assets/images/characters/mario/mario_014.png")]
		private static const Mario014:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Mario014(), 14, ST_CHAR, null, null, CT_GB, [ Mario.CHAR_NUM ], [ Games.superMarioBrosLostLevels, Games.superMarioBrosSnes, Games.superMarioLand2, Games.superMarioLand2 ], [ "Space Mario", null, null ] ) ) }

		[Embed(source="../assets/images/characters/mario/mario_015.png")]
		private static const Mario015:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Mario015(), 15, ST_CHAR, null, null, CT_8B, [ Mario.CHAR_NUM ], [ Games.superMarioBros, Games.superMarioBrosSnes, Games.superMarioLand, Games.superMario3DWorld ], [ "Modern Mario", "Mario", null ] ) ) }

//		[Embed(source="../assets/images/characters/mario/mario_013.png")]
//		private static const Mario013:Class;
//		{ BMC_VEC.push( new BmdSkinCont( new Mario013(), 13, ST_CHAR, null, null, CT_8B, [ Mario.CHAR_NUM ], [ Games.superMarioBros2, Games.superMarioBros2Snes, Games.superMarioLand2 ], [ "Papa", "Papa", "your wife" ] ) ) }

//		[Embed(source="../assets/images/characters/mario/mario_014.png")]
//		private static const Mario014:Class;
//		{ BMC_VEC.push( new BmdSkinCont( new Mario014(), 14, ST_CHAR, null, null, CT_8B, [ Mario.CHAR_NUM ], [ Games.superMarioBros2, Games.superMarioBros2Snes, Games.superMarioLand2 ], [ "Imajin", "Imajin", "your sister" ] ) ) }

//		[Embed(source="../assets/images/characters/mario/mario_011.png")]
//		private static const Mario011:Class;
//		{ BMC_VEC.push( new BmdSkinCont( new Mario011(), 11, ST_CHAR, null, null, CT_8B, [ Mario.CHAR_NUM ], [ Games.superMarioBros, Games.superMarioBrosSnes, Games.superMarioLand2 ], [ "Wario", "Wario", null ] ) ) }

//		-------------------------------------------------------------------------------------------------------------------
//		megaMan
//		-------------------------------------------------------------------------------------------------------------------
		[Embed(source="../assets/images/characters/megaMan/megaMan_palette.png")]
		private static const megaMan_palette:Class;			{ addCharPalette(megaMan_palette,MegaMan.CHAR_NUM); }
		
//		[Embed(source="../assets/images/characters/megaMan/megaMan_preview.png")]
//		private static const megaMan_preview:Class;			{ addCharacterPreview(megaMan_preview, MegaMan.CHAR_NUM); }
		
		[Embed(source="../assets/images/characters/megaMan/megaMan_000.png")]
		private static const MegaMan000:Class;
		{ BMC_VEC.push( new BmdSkinCont( new MegaMan000(), 0, ST_CHAR, null, null, CT_8B, [ MegaMan.CHAR_NUM ], [ Games.megaMan, Games.megaMan7, Games.megaManGb, Games.megaMan ], [ null, null, "Dr. Light" ], null ) ) }
			
		[Embed(source="../assets/images/characters/megaMan/megaMan_001.png")]
		private static const MegaMan001:Class;
		{ BMC_VEC.push( new BmdSkinCont( new MegaMan001(), 1, ST_CHAR, null, null, CT_16B, [ MegaMan.CHAR_NUM ], [ Games.megaMan, Games.megaMan7, Games.megaManGb, Games.megaMan ], [ null, null, "Dr. Light" ], null ) ) }
		
		[Embed(source="../assets/images/characters/megaMan/megaMan_002.png")]
		private static const MegaMan002:Class;
		{ BMC_VEC.push( new BmdSkinCont( new MegaMan002(), 2, ST_CHAR, null, null, CT_GB, [ MegaMan.CHAR_NUM ], [ Games.megaMan, Games.megaMan7, Games.megaManGb, Games.rockManBattleAndFighters ], [ null, null, "Dr. Light" ], null ) ) }
		
		[Embed(source="../assets/images/characters/megaMan/megaMan_003.png")]
		private static const MegaMan003:Class;
		{ BMC_VEC.push( new BmdSkinCont( new MegaMan003(), 3, ST_CHAR, null, null, CT_8B, [ MegaMan.CHAR_NUM ], [ Games.megaMan5, Games.megaMan7, Games.megaMan4Gb, Games.megaMan3 ], [ MegaManBase.PROTO_MAN_NAME, MegaManBase.PROTO_MAN_NAME, "Roll" ], null, null, SkinDescriptions.MEGA_MAN_SKIN_PROTO_MAN  ) ) }
		
		[Embed(source="../assets/images/characters/megaMan/megaMan_004.png")]
		private static const MegaMan004:Class;
		{ BMC_VEC.push( new BmdSkinCont( new MegaMan004(), 4, ST_CHAR, null, null, CT_16B, [ MegaMan.CHAR_NUM ], [ Games.megaMan5, Games.megaMan7, Games.megaMan4Gb, Games.megaMan3 ], [ MegaManBase.PROTO_MAN_NAME, MegaManBase.PROTO_MAN_NAME, "Roll" ], null, null, SkinDescriptions.MEGA_MAN_SKIN_PROTO_MAN  ) ) }
		
		[Embed(source="../assets/images/characters/megaMan/megaMan_005.png")]
		private static const MegaMan005:Class;
		{ BMC_VEC.push( new BmdSkinCont( new MegaMan005(), 5, ST_CHAR, null, null, CT_GB, [ MegaMan.CHAR_NUM ], [ Games.megaMan5, Games.megaMan7, Games.megaMan4Gb, Games.rockManBattleAndFighters ], [ MegaManBase.PROTO_MAN_NAME, MegaManBase.PROTO_MAN_NAME, "Roll" ], null, null, SkinDescriptions.MEGA_MAN_SKIN_PROTO_MAN  ) ) }

		[Embed(source="../assets/images/characters/megaMan/megaMan_006.png")]
		private static const MegaMan006:Class;
		{ BMC_VEC.push( new BmdSkinCont( new MegaMan006(), 6, ST_CHAR, null, null, CT_8B, [ MegaMan.CHAR_NUM ], [ Games.megaMan9, Games.megaManAndBass, Games.megaMan3Gb, Games.megaMan9 ], [ null, null, "Dr. Light" ], null  ) ) }

		[Embed(source="../assets/images/characters/megaMan/megaMan_007.png")]
		private static const MegaMan007:Class;
		{ BMC_VEC.push( new BmdSkinCont( new MegaMan007(), 7, ST_CHAR, null, null, CT_16B, [ MegaMan.CHAR_NUM ], [ Games.megaMan9, Games.megaManAndBass, Games.megaMan3Gb, Games.megaMan9 ], [ null, null, "Dr. Light" ], null ) ) }
		
		[Embed(source="../assets/images/characters/megaMan/megaMan_008.png")]
		private static const MegaMan008:Class;
		{ BMC_VEC.push( new BmdSkinCont( new MegaMan008(), 8, ST_CHAR, null, null, CT_8B, [ MegaMan.CHAR_NUM ], [ Games.megaMan3, Games.megaMan7, Games.megaMan4Gb, Games.megaMan3 ], [ "Break Man", "Break Man", "Roll" ], null, null, SkinDescriptions.MEGA_MAN_SKIN_PROTO_MAN  ) ) }

		[Embed(source="../assets/images/characters/megaMan/megaMan_009.png")]
		private static const MegaMan009:Class;
		{ BMC_VEC.push( new BmdSkinCont( new MegaMan009(), 9, ST_CHAR, null, null, CT_16B, [ MegaMan.CHAR_NUM ], [ Games.megaMan3, Games.megaMan7, Games.megaMan4Gb, Games.megaMan3 ], [ "Break Man", "Break Man", "Roll" ], null, null, SkinDescriptions.MEGA_MAN_SKIN_PROTO_MAN  ) ) }

		[Embed(source="../assets/images/characters/megaMan/megaMan_010.png")]
		private static const MegaMan010:Class;
		{ BMC_VEC.push( new BmdSkinCont( new MegaMan010(), 10, ST_CHAR, null, null, CT_8B, [ MegaMan.CHAR_NUM ], [ Games.megaMan, Games.megaMan7, Games.megaManGb, Games.rockManMobile ], [ "Roll", "Roll", "your brother" ], null  ) ) }

		[Embed(source="../assets/images/characters/megaMan/megaMan_011.png")]
		private static const MegaMan011:Class;
		{ BMC_VEC.push( new BmdSkinCont( new MegaMan011(), 11, ST_CHAR, null, null, CT_8B, [ MegaMan.CHAR_NUM ], [ Games.megaMan10, Games.megaManAndBass, Games.megaMan5Gb, Games.rokkoChan ], [ "Rokko Chan", "Rokko Chan", "Professor Thane" ], null, null, SkinDescriptions.MEGA_MAN_SKIN_ROKKO_CHAN  ) ) }
		
		[Embed(source="../assets/images/characters/megaMan/megaMan_012.png")]
		private static const MegaMan012:Class;
		{ BMC_VEC.push( new BmdSkinCont( new MegaMan012(), 12, ST_CHAR, null, null, CT_8B, [ MegaMan.CHAR_NUM ], [ Games.megaMan9, Games.megaMan7, Games.megaMan4Gb, Games.megaMan ], [ "Dr. Light", "Dr. Light", "Rock" ], null  ) ) }

		[Embed(source="../assets/images/characters/megaMan/megaMan_013.png")]
		private static const MegaMan013:Class;
		{ BMC_VEC.push( new BmdSkinCont( new MegaMan013(), 13, ST_CHAR, null, null, CT_8B, [ MegaMan.CHAR_NUM ], [ Games.megaMan, Games.megaMan7, Games.megaManGb, Games.megaMan ], [ "Cut Man", "Cut Man", "Dr. Light" ], null, null, SkinDescriptions.MEGA_MAN_SKIN_CUT_MAN  ) ) }

		[Embed(source="../assets/images/characters/megaMan/megaMan_014.png")]
		private static const MegaMan014:Class;
		{ BMC_VEC.push( new BmdSkinCont( new MegaMan014(), 14, ST_CHAR, null, null, CT_8B, [ MegaMan.CHAR_NUM ], [ Games.megaMan, Games.megaMan7, Games.megaManGb, Games.megaMan ], [ "Ice Man", "Ice Man", "Dr. Light" ], null, null, SkinDescriptions.MEGA_MAN_SKIN_ICE_MAN  ) ) }

		[Embed(source="../assets/images/characters/megaMan/megaMan_015.png")]
		private static const MegaMan015:Class;
		{ BMC_VEC.push( new BmdSkinCont( new MegaMan015(), 15, ST_CHAR, null, null, CT_8B, [ MegaMan.CHAR_NUM ], [ Games.superMarioBrosAtari, Games.superMarioBrosAtari, Games.superMarioBrosAtari, Games.megaMan ], [ null, null, "Dr. Light" ], null  ) ) }

		[Embed(source="../assets/images/characters/megaMan/megaMan_016.png")]
		private static const MegaMan016:Class;
		{ BMC_VEC.push( new BmdSkinCont( new MegaMan016(), 16, ST_CHAR, null, null, CT_8B, [ MegaMan.CHAR_NUM ], [ Games.megaMan, Games.megaMan7, Games.megaManGb, Games.megaMan ], [ "Rock", "Rock", "Dr. Light" ], null, null, SkinDescriptions.MEGA_MAN_SKIN_ROCK  ) ) }

		[Embed(source="../assets/images/characters/megaMan/megaMan_017.png")]
		private static const MegaMan017:Class;
		{ BMC_VEC.push( new BmdSkinCont( new MegaMan017(), 17, ST_CHAR, null, null, CT_16B, [ MegaMan.CHAR_NUM ], [ Games.megaMan, Games.megaMan7, Games.megaManGb, Games.megaMan ], [ "Rock", "Rock", "Dr. Light" ], null, null, SkinDescriptions.MEGA_MAN_SKIN_ROCK  ) ) }

		[Embed(source="../assets/images/characters/megaMan/megaMan_018.png")] // X1
		private static const MegaMan018:Class;
		{ BMC_VEC.push( new BmdSkinCont( new MegaMan018(), 18, ST_CHAR, null, null, CT_GB, [ MegaMan.CHAR_NUM ], [ Games.megaMan, Games.megaMan7, Games.megaManGb, Games.megaMan ], [ null, null, "Dr. Light" ], null  ) ) }

		[Embed(source="../assets/images/characters/megaMan/megaMan_019.png")]
		private static const MegaMan019:Class;
		{ BMC_VEC.push( new BmdSkinCont( new MegaMan019(), 19, ST_CHAR, null, null, CT_GB, [ MegaMan.CHAR_NUM ], [ Games.megaMan3, Games.megaMan7, Games.megaMan4Gb, Games.rockManBattleAndFighters ], [ "Break Man", "Break Man", "Roll" ], null, null, SkinDescriptions.MEGA_MAN_SKIN_PROTO_MAN  ) ) }

		[Embed(source="../assets/images/characters/megaMan/megaMan_020.png")]
		private static const MegaMan020:Class;
		{ BMC_VEC.push( new BmdSkinCont( new MegaMan020(), 20, ST_CHAR, null, null, CT_GB, [ MegaMan.CHAR_NUM ], [ Games.megaMan, Games.megaManAndBass, Games.megaMan3Gb, Games.rockManBattleAndFighters ], [ null, null, "Dr. Light" ], null  ) ) }

		[Embed(source="../assets/images/characters/megaMan/megaMan_021.png")]
		private static const MegaMan021:Class;
		{ BMC_VEC.push( new BmdSkinCont( new MegaMan021(), 21, ST_CHAR, null, null, CT_16B, [ MegaMan.CHAR_NUM ], [ Games.megaMan, Games.megaMan7, Games.megaManGb, Games.megaManWilyWars ], [ "Cut Man", "Cut Man", "Dr. Light" ], null, null, SkinDescriptions.MEGA_MAN_SKIN_CUT_MAN  ) ) }

		[Embed(source="../assets/images/characters/megaMan/megaMan_022.png")]
		private static const MegaMan022:Class;
		{ BMC_VEC.push( new BmdSkinCont( new MegaMan022(), 22, ST_CHAR, null, null, CT_16B, [ MegaMan.CHAR_NUM ], [ Games.megaMan, Games.megaMan7, Games.megaManGb, Games.megaMan8 ], [ "Roll", "Roll", "your brother" ], null  ) ) }

		[Embed(source="../assets/images/characters/megaMan/megaMan_023.png")]
		private static const MegaMan023:Class;
		{ BMC_VEC.push( new BmdSkinCont( new MegaMan023(), 23, ST_CHAR, null, null, CT_8B, [ MegaMan.CHAR_NUM ], [ Games.megaMan2, Games.megaMan7, Games.megaMan2Gb, Games.megaMan2Gb ], [ "Quint", "Quint", "Dr. Wily" ], null  ) ) }

		[Embed(source="../assets/images/characters/megaMan/megaMan_024.png")]
		private static const MegaMan024:Class;
		{ BMC_VEC.push( new BmdSkinCont( new MegaMan024(), 24, ST_CHAR, null, null, CT_8B, [ MegaMan.CHAR_NUM ], [ Games.megaMan, Games.megaMan7, Games.megaManGb, Games.megaMan ], [ "Fire Man", "Fire Man", "Dr. Light" ], null, null, SkinDescriptions.MEGA_MAN_SKIN_FIRE_MAN  ) ) }

		[Embed(source="../assets/images/characters/megaMan/megaMan_025.png")]
		private static const MegaMan025:Class;
		{ BMC_VEC.push( new BmdSkinCont( new MegaMan025(), 25, ST_CHAR, null, null, CT_8B, [ MegaMan.CHAR_NUM ], [ Games.krionConquest, Games.krionConquest, Games.krionConquest, Games.krionConquest ], [ "Francesca", "Francesca", "Kagemaru" ], null, null, SkinDescriptions.MEGA_MAN_SKIN_FRANCESCA  ) ) }

		[Embed(source="../assets/images/characters/megaMan/megaMan_026.png")]
		private static const MegaMan026:Class;
		{ BMC_VEC.push( new BmdSkinCont( new MegaMan026(), 26, ST_CHAR, null, null, CT_8B, [ MegaMan.CHAR_NUM ], [ Games.krionConquest, Games.krionConquest, Games.krionConquest, Games.krionConquest ], [ "Doropie", "Doropie", "Kagemaru" ], null, null, SkinDescriptions.MEGA_MAN_SKIN_FRANCESCA  ) ) }

//		-------------------------------------------------------------------------------------------------------------------
//		protoMan
//		-------------------------------------------------------------------------------------------------------------------
		/*[Embed(source="../assets/images/characters/protoMan/protoMan_000.png")]
		private static const ProtoMan000:Class;
		{ BMC_VEC.push( new BmdSkinCont( new ProtoMan000(), 0, ST_CHAR, null, null, CT_8B, [ ProtoMan.CHAR_NUM ], [  ] ) ) }
		
		[Embed(source="../assets/images/characters/protoMan/protoMan_001.png")]
		private static const ProtoMan001:Class;
		{ BMC_VEC.push( new BmdSkinCont( new ProtoMan001(), 1, ST_CHAR, null, null, CT_16B, [ ProtoMan.CHAR_NUM ], [  ] ) ) }
		
		[Embed(source="../assets/images/characters/protoMan/protoMan_002.png")]
		private static const ProtoMan002:Class;
		{ BMC_VEC.push( new BmdSkinCont( new ProtoMan002(), 2, ST_CHAR, null, null, CT_GB, [ ProtoMan.CHAR_NUM ], [  ] ) ) }
		
		[Embed(source="../assets/images/characters/protoMan/protoMan_003.png")]
		private static const ProtoMan003:Class;
		{ BMC_VEC.push( new BmdSkinCont( new ProtoMan003(), 3, ST_CHAR, null, null, CT_8B, [ ProtoMan.CHAR_NUM ], [  ] ) ) }
		
		[Embed(source="../assets/images/characters/protoMan/protoMan_004.png")]
		private static const ProtoMan004:Class;
		{ BMC_VEC.push( new BmdSkinCont( new ProtoMan004(), 4, ST_CHAR, null, null, CT_16B, [ ProtoMan.CHAR_NUM ], [  ] ) ) }
		
		[Embed(source="../assets/images/characters/protoMan/protoMan_005.png")]
		private static const ProtoMan005:Class;
		{ BMC_VEC.push( new BmdSkinCont( new ProtoMan005(), 5, ST_CHAR, null, null, CT_GB, [ ProtoMan.CHAR_NUM ], [  ] ) ) }*/

//		-------------------------------------------------------------------------------------------------------------------
//		pit
//		-------------------------------------------------------------------------------------------------------------------
//		[Embed(source="../assets/images/characters/pit/pit_palette.png")]
//		private static const pit_palette:Class;			{ addCharPalette(pit_palette,Pit.CHAR_NUM); }
//		
//		[Embed(source="../assets/images/characters/pit/pit_000.png")]
//		private static const Pit000:Class;
//		{ BMC_VEC.push( new BmdSkinCont( new Pit000(), 0, ST_CHAR, null, null, CT_8B, [ Pit.CHAR_NUM ], [ Games.kidIcarus, Games.kidIcarus, Games.kidIcarusOfMythsAndMonsters ], [ null, null, "Palutena" ], null ) ) }
//		
//		[Embed(source="../assets/images/characters/pit/pit_001.png")]
//		private static const Pit001:Class;
//		{ BMC_VEC.push( new BmdSkinCont( new Pit001(), 0, ST_CHAR, null, null, CT_16B, [ Pit.CHAR_NUM ], [ Games.kidIcarus, Games.kidIcarus, Games.kidIcarusOfMythsAndMonsters ], [ null, null, "Palutena" ], null ) ) }
//
//		[Embed(source="../assets/images/characters/pit/pit_002.png")]
//		private static const Pit002:Class;
//		{ BMC_VEC.push( new BmdSkinCont( new Pit002(), 0, ST_CHAR, null, null, CT_GB, [ Pit.CHAR_NUM ], [ Games.kidIcarus, Games.kidIcarus, Games.kidIcarusOfMythsAndMonsters ], [ null, null, "Palutena" ], null ) ) }
		
//		-------------------------------------------------------------------------------------------------------------------
//		ryu
//		-------------------------------------------------------------------------------------------------------------------
		[Embed(source="../assets/images/characters/ryu/ryu_palette.png")]
		private static const ryu_palette:Class;			{ addCharPalette(ryu_palette,Ryu.CHAR_NUM); }
		
//		[Embed(source="../assets/images/characters/ryu/ryu_preview.png")]
//		private static const ryu_preview:Class;			{ addCharacterPreview(ryu_preview, Ryu.CHAR_NUM); }
		
		[Embed(source="../assets/images/characters/ryu/ryu_000.png")]
		private static const Ryu000:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Ryu000(), 0, ST_CHAR, null, null, CT_8B, [ Ryu.CHAR_NUM ], [ Games.ninjaGaiden, Games.ninjaGaidenSnes, Games.ninjaGaidenShadow, Games.ninjaGaiden ], [ null, null, "Irene" ]  ) ) }
			
		[Embed(source="../assets/images/characters/ryu/ryu_001.png")]
		private static const Ryu001:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Ryu001(), 1, ST_CHAR, null, null, CT_16B, [ Ryu.CHAR_NUM ], [ Games.ninjaGaiden, Games.ninjaGaidenSnes, Games.ninjaGaidenShadow, Games.ninjaGaiden ], [ null, null, "Irene" ]  ) ) }
		
		[Embed(source="../assets/images/characters/ryu/ryu_002.png")]
		private static const Ryu002:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Ryu002(), 2, ST_CHAR, null, null, CT_GB, [ Ryu.CHAR_NUM ], [ Games.ninjaGaiden, Games.ninjaGaidenSnes, Games.ninjaGaidenShadow, Games.ninjaGaidenShadow ], [ null, null, "Irene" ]  ) ) }
		
		[Embed(source="../assets/images/characters/ryu/ryu_003.png")]
		private static const Ryu003:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Ryu003(), 3, ST_CHAR, null, null, CT_8B, [ Ryu.CHAR_NUM ], [ Games.ninjaGaidenSms, Games.ninjaGaidenSms, Games.ninjaGaidenShadow, Games.haggleMan3 ], [ "Haggle Man", "Haggle Man", "Koume" ], null, null, SkinDescriptions.RYU_SKIN_HAGGLE_MAN  ) ) }
		
		[Embed(source="../assets/images/characters/ryu/ryu_004.png")]
		private static const Ryu004:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Ryu004(), 4, ST_CHAR, null, null, CT_16B, [ Ryu.CHAR_NUM ], [ Games.ninjaGaidenSms, Games.ninjaGaidenSms, Games.ninjaGaidenShadow, Games.haggleMan3 ], [ "Haggle Man", "Haggle Man", "Koume" ], null, null, SkinDescriptions.RYU_SKIN_HAGGLE_MAN  ) ) }
		
		[Embed(source="../assets/images/characters/ryu/ryu_005.png")]
		private static const Ryu005:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Ryu005(), 5, ST_CHAR, null, null, CT_16B, [ Ryu.CHAR_NUM ], [ Games.finalFantasy3, Games.finalFantasy6, Games.finalFantasyAdventure, Games.finalFantasy6 ], [ "Shadow", "Shadow", "Interceptor" ], null  ) ) }
		
		[Embed(source="../assets/images/characters/ryu/ryu_006.png")] // X1
		private static const Ryu006:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Ryu006(), 6, ST_CHAR, null, null, CT_GB, [ Ryu.CHAR_NUM ], [ Games.ninjaGaiden, Games.ninjaGaidenSnes, Games.ninjaGaidenShadow, Games.ninjaGaiden ], [ null, null, "Irene" ]  ) ) }
		
		[Embed(source="../assets/images/characters/ryu/ryu_007.png")]
		private static const Ryu007:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Ryu007(), 7, ST_CHAR, null, null, CT_8B, [ Ryu.CHAR_NUM ], [ Games.superMarioBrosAtari, Games.superMarioBrosAtari, Games.superMarioBrosAtari, Games.ninjaGaiden ], [ null, null, "Irene" ], null  ) ) }

		[Embed(source="../assets/images/characters/ryu/ryu_008.png")]
		private static const Ryu008:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Ryu008(), 8, ST_CHAR, null, null, CT_8B, [ Ryu.CHAR_NUM ], [ Games.ninjaGaidenSms, Games.ninjaGaidenSnes, Games.ninjaGaidenShadow, Games.ninjaGaidenSms ], [ null, null, "Irene" ], null  ) ) }

		[Embed(source="../assets/images/characters/ryu/ryu_009.png")]
		private static const Ryu009:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Ryu009(), 9, ST_CHAR, null, null, CT_8B, [ Ryu.CHAR_NUM ], [ Games.ninjaGaiden2, Games.ninjaGaidenSnes, Games.ninjaGaidenShadow, Games.ninjaGaiden2 ], [ "Ryu Clone", "Ryu?", "Irene" ], null  ) ) }

		[Embed(source="../assets/images/characters/ryu/ryu_010.png")]
		private static const Ryu010:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Ryu010(), 10, ST_CHAR, null, null, CT_8B, [ Ryu.CHAR_NUM ], [ Games.shadowOfTheNinja, Games.shadowOfTheNinja, Games.shadowOfTheNinja, Games.shadowOfTheNinja ], [ "Hayate", "Hayate", "Kaede" ], null  ) ) }

		[Embed(source="../assets/images/characters/ryu/ryu_011.png")]
		private static const Ryu011:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Ryu011(), 11, ST_CHAR, null, null, CT_8B, [ Ryu.CHAR_NUM ], [ Games.shadowOfTheNinja, Games.shadowOfTheNinja, Games.shadowOfTheNinja, Games.shadowOfTheNinja ], [ "Kaede", "Kaede", "Hayate" ], null  ) ) }

//		-------------------------------------------------------------------------------------------------------------------
//		samus
//		-------------------------------------------------------------------------------------------------------------------
		[Embed(source="../assets/images/characters/samus/samus_palette.png")]
		private static const samus_palette:Class;			{ addCharPalette(samus_palette,Samus.CHAR_NUM); }
		
//		[Embed(source="../assets/images/characters/samus/samus_preview.png")]
//		private static const samus_preview:Class;			{ addCharacterPreview(samus_preview, Samus.CHAR_NUM); }
		
		[Embed(source="../assets/images/characters/samus/samus_000.png")]
		private static const Samus000:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Samus000(), 0, ST_CHAR, null, null, CT_8B, [ Samus.CHAR_NUM ], [ Games.metroid, Games.superMetroid, Games.metroid2, Games.metroid ], [ null, null, "the hatchling" ], null ) ) }
		
		[Embed(source="../assets/images/characters/samus/samus_001.png")]
		private static const Samus001:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Samus001(), 1, ST_CHAR, null, null, CT_16B, [ Samus.CHAR_NUM ], [ Games.metroid, Games.superMetroid, Games.metroid2, Games.superMetroid ], [ null, null, "the hatchling" ], null ) ) }
		
		[Embed(source="../assets/images/characters/samus/samus_002.png")]
		private static const Samus002:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Samus002(), 2, ST_CHAR, null, null, CT_GB, [ Samus.CHAR_NUM ], [ Games.metroid, Games.superMetroid, Games.metroid2, Games.metroid2 ], [ null, null, "the hatchling" ], null  ) ) }
		
		[Embed(source="../assets/images/characters/samus/samus_003.png")]
		private static const Samus003:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Samus003(), 3, ST_CHAR, null, null, CT_8B, [ Samus.CHAR_NUM ], [ Games.metroid, Games.superMetroid, Games.metroid2, Games.metroid ], [ null, null, "the hatchling" ], null  ) ) }
		
		[Embed(source="../assets/images/characters/samus/samus_004.png")]
		private static const Samus004:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Samus004(), 4, ST_CHAR, null, null, CT_16B, [ Samus.CHAR_NUM ], [ Games.metroid, Games.superMetroid, Games.metroid2, Games.metroidPrime3Corruption ], [ "Dark Samus", "Dark Samus", "the hatchling" ], null ) ) }
		
		[Embed(source="../assets/images/characters/samus/samus_005.png")]
		private static const Samus005:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Samus005(), 5, ST_CHAR, null, null, CT_8B, [ Samus.CHAR_NUM ], [ Games.metroid, Games.superMetroid, Games.metroid2, Games.metroidZeroMission ], [ "Zero Suit Samus", "Samus", "the hatchling" ], null ) ) }
		
		[Embed(source="../assets/images/characters/samus/samus_006.png")]
		private static const Samus006:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Samus006(), 6, ST_CHAR, null, null, CT_8B, [ Samus.CHAR_NUM ], [ Games.kidIcarus, Games.kidIcarus, Games.kidIcarus, Games.kidIcarus ], [ "Pit", "Pit", "Palutena" ], Samus.skinSettingsWrite(22, true, false, true, false, SoundNames.SFX_PIT_SHOOT, SoundNames.SFX_PIT_JUMP), null, SkinDescriptions.SAMUS_SKIN_PIT  ) ) }

		[Embed(source="../assets/images/characters/samus/samus_007.png")]
		private static const Samus007:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Samus007(), 7, ST_CHAR, null, null, CT_8B, [ Samus.CHAR_NUM ], [ Games.superMarioBrosAtari, Games.superMarioBrosAtari, Games.superMarioBrosAtari, Games.metroid ], [ null, null, "the hatchling" ], null ) ) }

		[Embed(source="../assets/images/characters/samus/samus_008.png")]
		private static const Samus008:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Samus008(), 8, ST_CHAR, null, null, CT_8B, [ Samus.CHAR_NUM ], [ Games.metroid, Games.superMetroid, Games.metroid2, Games.metroid ], [ null, null, "the hatchling" ], null ) ) }

		[Embed(source="../assets/images/characters/samus/samus_009.png")]
		private static const Samus009:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Samus009(), 9, ST_CHAR, null, null, CT_16B, [ Samus.CHAR_NUM ], [ Games.metroid, Games.superMetroid, Games.metroid2, Games.superMetroid ], [ null, null, "the hatchling" ], null ) ) }

		[Embed(source="../assets/images/characters/samus/samus_010.png")]
		private static const Samus010:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Samus010(), 10, ST_CHAR, null, null, CT_16B, [ Samus.CHAR_NUM ], [ Games.metroid, Games.superMetroid, Games.metroid2, Games.metroid ], [ null, null, "the hatchling" ], null ) ) }

		[Embed(source="../assets/images/characters/samus/samus_011.png")]
		private static const Samus011:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Samus011(), 11, ST_CHAR, null, null, CT_8B, [ Samus.CHAR_NUM ], [ Games.kidIcarus, Games.kidIcarus, Games.kidIcarus, Games.kidIcarusUprising ], [ "Dark Pit", "Dark Pit", "the Reaper" ], Samus.skinSettingsWrite(22, true, false, true, false, SoundNames.SFX_PIT_SHOOT, SoundNames.SFX_PIT_JUMP), null, SkinDescriptions.SAMUS_SKIN_PIT  ) ) }

		[Embed(source="../assets/images/characters/samus/samus_012.png")]
		private static const Samus012:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Samus012(), 12, ST_CHAR, null, null, CT_GB, [ Samus.CHAR_NUM ], [ Games.metroid, Games.superMetroid, Games.metroid2, Games.metroidPrime3Corruption ], [ "Dark Samus", "Dark Samus", "the hatchling" ], null ) ) }

		[Embed(source="../assets/images/characters/samus/samus_013.png")]
		private static const Samus013:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Samus013(), 13, ST_CHAR, null, null, CT_8B, [ Samus.CHAR_NUM ], [ Games.metroid, Games.superMetroid, Games.metroid2, Games.metroidPrime3Corruption ], [ "Dark Samus", "Dark Samus", "the hatchling" ], null ) ) }

//		-------------------------------------------------------------------------------------------------------------------
//		simon
//		-------------------------------------------------------------------------------------------------------------------
		[Embed(source="../assets/images/characters/simon/simon_palette.png")]
		private static const simon_palette:Class;			{ addCharPalette(simon_palette,Simon.CHAR_NUM); }
		
//		[Embed(source="../assets/images/characters/simon/simon_preview.png")]
//		private static const simon_preview:Class;			{ addCharacterPreview(simon_preview, Simon.CHAR_NUM); }
		
		[Embed(source="../assets/images/characters/simon/simon_000.png")]
		private static const Simon000:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Simon000(), 0, ST_CHAR, null, null, CT_8B, [ Simon.CHAR_NUM ], [ Games.castlevania, Games.superCastlevania4, Games.castlevaniaAdventure, Games.castlevania ], [ null, null, "your friend" ], Simon.skinSettings(0,0, 0,0, 0,0, 0,0, 0,0, 0,0) ) ) }
			
		[Embed(source="../assets/images/characters/simon/simon_001.png")]
		private static const Simon001:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Simon001(), 1, ST_CHAR, null, null, CT_16B, [ Simon.CHAR_NUM ], [ Games.castlevania, Games.superCastlevania4, Games.castlevaniaAdventure, Games.castlevania ], [ null, null, "your friend" ], Simon.skinSettings(0,0, 0,0, 0,0, 0,0, 0,0, 0,0) ) ) }
		
		[Embed(source="../assets/images/characters/simon/simon_002.png")]
		private static const Simon002:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Simon002(), 2, ST_CHAR, null, null, CT_GB, [ Simon.CHAR_NUM ], [ Games.castlevania, Games.superCastlevania4, Games.castlevaniaAdventure, Games.castlevaniaBelmontsRevenge ], [ "Christopher Belmont", "Christopher", "Soleiyu" ], Simon.skinSettings(18,2, 12,6, 2,-2, 18,0, 12,4, 2,-4) ) ) }
		
		[Embed(source="../assets/images/characters/simon/simon_003.png")]
		private static const Simon003:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Simon003(), 3, ST_CHAR, null, null, CT_8B, [ Simon.CHAR_NUM ], [ Games.castlevania3, Games.castlevaniaDraculaX, Games.castlevaniaLegends, Games.castlevania3 ], [ "Trevor Belmont", "Trevor", "the true Sypha" ], Simon.skinSettings(0,-10, 0,-8, 8,0, 0,-10, 0,-8, 8,0) ) ) }
		
		[Embed(source="../assets/images/characters/simon/simon_004.png")]
		private static const Simon004:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Simon004(), 4, ST_CHAR, null, null, CT_16B, [ Simon.CHAR_NUM ], [ Games.castlevania3, Games.castlevaniaDraculaX, Games.castlevaniaLegends, Games.castlevania3 ], [ "Trevor Belmont", "Trevor", "the true Sypha" ], Simon.skinSettings(0,-10, 0,-8, 8,0, 0,-10, 0,-8, 8,0) ) ) }
		
		[Embed(source="../assets/images/characters/simon/simon_005.png")]
		private static const Simon005:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Simon005(), 5, ST_CHAR, null, null, CT_GB, [ Simon.CHAR_NUM ], [ Games.castlevania3, Games.castlevaniaDraculaX, Games.castlevaniaLegends, Games.castlevania3 ], [ "Trevor Belmont", "Trevor", "the true Sypha" ], Simon.skinSettings(18,2, 10,6, 2,-2, 18,0, 10,4, 2,-4) ) ) }
		
		[Embed(source="../assets/images/characters/simon/simon_006.png")]
		private static const Simon006:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Simon006(), 6, ST_CHAR, null, null, CT_8B, [ Simon.CHAR_NUM ], [ Games.castlevania2, Games.superCastlevania4, Games.castlevaniaAdventure, Games.castlevania2 ], [ null, null, "the priest" ], Simon.skinSettings(0,-2, 0,0, 4,-2, 0,0, 0,0, 4,-2) ) ) }

		[Embed(source="../assets/images/characters/simon/simon_007.png")]
		private static const Simon007:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Simon007(), 7, ST_CHAR, null, null, CT_16B, [ Simon.CHAR_NUM ], [ Games.castlevania, Games.superCastlevania4, Games.castlevaniaAdventure, Games.superCastlevania4 ], [ null, null, "your friend" ], Simon.skinSettings(-2,-6, -2,-10, 8,0, 0,-6, -2,-10, 8,0) ) ) }

		[Embed(source="../assets/images/characters/simon/simon_008.png")]
		private static const Simon008:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Simon008(), 8, ST_CHAR, null, null, CT_8B, [ Simon.CHAR_NUM ], [ Games.castlevania3, Games.castlevaniaDraculaX, Games.castlevaniaLegends, Games.castlevania3 ], [ "Whip Skeleton", "Skeleton", "your captain" ], Simon.skinSettings(2,-4, -4,-10, 6,0, 2,-8, -2,-14, 2,-6)  ) ) }

		[Embed(source="../assets/images/characters/simon/simon_009.png")]
		private static const Simon009:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Simon009(), 9, ST_CHAR, null, null, CT_8B, [ Simon.CHAR_NUM ], [ Games.superMarioBrosAtari, Games.superMarioBrosAtari, Games.superMarioBrosAtari, Games.castlevania ], [ null, null, "your friend" ], Simon.skinSettings(0,-2, 2,-2, 2,-2, 0,-2, 2,-2, 4,-2) ) ) }

		[Embed(source="../assets/images/characters/simon/simon_010.png")]
		private static const Simon010:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Simon010(), 10, ST_CHAR, null, null, CT_8B, [ Simon.CHAR_NUM ], [ Games.castlevania, Games.superCastlevania4, Games.castlevaniaAdventure, Games.castlevania ], [ null, null, "your friend" ], Simon.skinSettings(0,0, 0,0, 0,0, 0,0, 0,0, 0,0) ) ) }

		[Embed(source="../assets/images/characters/simon/simon_011.png")]
		private static const Simon011:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Simon011(), 11, ST_CHAR, null, null, CT_8B, [ Simon.CHAR_NUM ], [ Games.castlevania3J, Games.castlevaniaDraculaX, Games.castlevaniaLegends, Games.castlevaniaDraculaX ], [ "Richter Belmont", "Richter", "Annette" ], Simon.skinSettings(2,-10, 0,-10, 8,0, 6,-10, 0,-10, 6,-2) ) ) }
		
		[Embed(source="../assets/images/characters/simon/simon_012.png")]
		private static const Simon012:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Simon012(), 12, ST_CHAR, null, null, CT_8B, [ Simon.CHAR_NUM ], [ Games.riverCityRansom, Games.riverCityRansom, Games.riverCityRansom, Games.riverCityRansom ], [ "Alex", "Alex", "Cyndi" ], Simon.skinSettings(16,-32, 6,-26, 4,-6, 16,-30, 6,-24, 4,-6) ) ) }

		[Embed(source="../assets/images/characters/simon/simon_013.png")]
		private static const Simon013:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Simon013(), 13, ST_CHAR, null, null, CT_8B, [ Simon.CHAR_NUM ], [ Games.castlevania3J, Games.castlevaniaDraculaX, Games.castlevaniaLegends, Games.castlevania3 ], [ "Trevor?", "Trevor?", "Sypha?" ], Simon.skinSettings(0,-10, 0,-8, 8,0, 0,-10, 0,-8, 8,0) ) ) }

		[Embed(source="../assets/images/characters/simon/simon_014.png")]
		private static const Simon014:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Simon014(), 14, ST_CHAR, null, null, CT_16B, [ Simon.CHAR_NUM ], [ Games.castlevania3J, Games.castlevaniaDraculaX, Games.castlevaniaLegends, Games.castlevaniaSymphonyOfTheNight ], [ "Trevor?", "Trevor?", "Sypha?" ], Simon.skinSettings(0,-10, 0,-8, 8,0, 0,-10, 0,-8, 8,0) ) ) }

		[Embed(source="../assets/images/characters/simon/simon_015.png")]
		private static const Simon015:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Simon015(), 15, ST_CHAR, null, null, CT_16B, [ Simon.CHAR_NUM ], [ Games.castlevania3J, Games.castlevaniaDraculaX, Games.castlevaniaLegends, Games.castlevaniaDraculaX ], [ "Richter Belmont", "Richter", "Maria" ], Simon.skinSettings(0,0, 26,-6, 2,-8, 2,0, 22,-6, -2,-8) ) ) }

		[Embed(source="../assets/images/characters/simon/simon_016.png")]
		private static const Simon016:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Simon016(), 16, ST_CHAR, null, null, CT_GB, [ Simon.CHAR_NUM ], [ Games.castlevania, Games.superCastlevania4, Games.castlevaniaLegends, Games.castlevaniaLegends ], [ "Sonia Belmont", "Sonia", "Alucard" ], Simon.skinSettings(16,0, 2,10, -4,-2, 16,-2, 4,8, -2,-4) ) ) }

		[Embed(source="../assets/images/characters/simon/simon_017.png")]
		private static const Simon017:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Simon017(), 17, ST_CHAR, null, null, CT_16B, [ Simon.CHAR_NUM ], [ Games.riverCityRansom, Games.riverCityRansom, Games.riverCityRansom, Games.riverCityRansomEX ], [ "Kunio", "Kunio", "Mami" ], Simon.skinSettings(2,-24, -2,-26, 6,-4, 8,-22, 0,-24, 8,-6) ) ) }

		[Embed(source="../assets/images/characters/simon/simon_018.png")]
		private static const Simon018:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Simon018(), 18, ST_CHAR, null, null, CT_GB, [ Simon.CHAR_NUM ], [ Games.castlevania, Games.superCastlevania4, Games.castlevaniaAdventure, Games.castlevaniaBelmontsRevenge ], [ "Soleiyu", "Soleiyu", "your father" ], Simon.skinSettings(18,2, 10,6, 2,-2, 18,0, 10,4, 2,-4) ) ) }

//		-------------------------------------------------------------------------------------------------------------------
//		sophia
//		-------------------------------------------------------------------------------------------------------------------
		[Embed(source="../assets/images/characters/sophia/sophia_palette.png")]
		private static const sophia_palette:Class;			{ addCharPalette(sophia_palette,Sophia.CHAR_NUM); }
		
//		[Embed(source="../assets/images/characters/sophia/sophia_preview.png")]
//		private static const sophia_preview:Class;			{ addCharacterPreview(sophia_preview, Sophia.CHAR_NUM); }
		
		[Embed(source="../assets/images/characters/sophia/sophia_000.png")]
		private static const Sophia000:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Sophia000(), 0, ST_CHAR, null, null, CT_8B, [ Sophia.CHAR_NUM ], [ Games.blasterMaster, Games.blasterMasterSnes, Games.blasterMasterEnemyBelow, Games.blasterMaster ], [ null, null, "your frog" ], null ) ) }
		
		[Embed(source="../assets/images/characters/sophia/sophia_001.png")]
		private static const Sophia001:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Sophia001(), 1, ST_CHAR, null, null, CT_16B, [ Sophia.CHAR_NUM ], [ Games.blasterMaster, Games.blasterMasterSnes, Games.blasterMasterEnemyBelow, Games.blasterMaster ], [ null, null, "your frog" ], null ) ) }
			
		[Embed(source="../assets/images/characters/sophia/sophia_002.png")]
		private static const Sophia002:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Sophia002(), 2, ST_CHAR, null, null, CT_GB, [ Sophia.CHAR_NUM ], [ Games.blasterMaster, Games.blasterMasterSnes, Games.blasterMasterEnemyBelow, Games.blasterMasterEnemyBelow ], [ null, null, "your frog" ], null ) ) }
		
		[Embed(source="../assets/images/characters/sophia/sophia_003.png")]
		private static const Sophia003:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Sophia003(), 3, ST_CHAR, null, null, CT_8B, [ Sophia.CHAR_NUM ], [ Games.blasterMaster, Games.blasterMasterSnes, Games.blasterMasterEnemyBelow, Games.blasterMasterBlastingAgain ], [ "Sophia J-7", "Sophia J-7", "your frog" ], null  ) ) }
			
		[Embed(source="../assets/images/characters/sophia/sophia_004.png")]
		private static const Sophia004:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Sophia004(), 4, ST_CHAR, null, null, CT_16B, [ Sophia.CHAR_NUM ], [ Games.blasterMaster, Games.blasterMasterSnes, Games.blasterMasterEnemyBelow, Games.blasterMasterBlastingAgain ], [ "Sophia J-7", "Sophia J-7", "your frog" ], null  ) ) }
		
		[Embed(source="../assets/images/characters/sophia/sophia_005.png")]
		private static const Sophia005:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Sophia005(), 5, ST_CHAR, null, null, CT_GB, [ Sophia.CHAR_NUM ], [ Games.blasterMaster, Games.blasterMasterSnes, Games.blasterMasterEnemyBelow, Games.blasterMasterBlastingAgain ], [ "Sophia J-7", "Sophia J-7", "your frog" ], null  ) ) }

		[Embed(source="../assets/images/characters/sophia/sophia_006.png")]
		private static const Sophia006:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Sophia006(), 6, ST_CHAR, null, null, CT_8B, [ Sophia.CHAR_NUM ], [ Games.tetris, Games.tetrisDrMario, Games.tetrisGb, Games.tetris ], [ "Tetrimino", "Tetrimino", "our king" ], null  ) ) }

		[Embed(source="../assets/images/characters/sophia/sophia_007.png")]
		private static const Sophia007:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Sophia007(), 7, ST_CHAR, null, null, CT_8B, [ Sophia.CHAR_NUM ], [ Games.superMarioBrosAtari, Games.superMarioBrosAtari, Games.superMarioBrosAtari, Games.blasterMaster ], [ null, null, "your frog" ], null ) ) }

		[Embed(source="../assets/images/characters/sophia/sophia_008.png")] // X1
		private static const Sophia008:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Sophia008(), 8, ST_CHAR, null, null, CT_GB, [ Sophia.CHAR_NUM ], [ Games.blasterMaster, Games.blasterMasterSnes, Games.blasterMasterEnemyBelow, Games.blasterMaster ], [ null, null, "your frog" ], null ) ) }

		[Embed(source="../assets/images/characters/sophia/sophia_009.png")]
		private static const Sophia009:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Sophia009(), 9, ST_CHAR, null, null, CT_16B, [ Sophia.CHAR_NUM ], [ Games.tetris, Games.tetrisDrMario, Games.tetrisGb, Games.tetrisDrMario ], [ "Tetrimino", "Tetrimino", "our king" ], null  ) ) }

		[Embed(source="../assets/images/characters/sophia/sophia_010.png")]
		private static const Sophia010:Class;
		{ BMC_VEC.push( new BmdSkinCont( new Sophia010(), 10, ST_CHAR, null, null, CT_16B, [ Sophia.CHAR_NUM ], [ Games.blasterMaster, Games.blasterMasterSnes, Games.blasterMasterEnemyBelow, Games.blasterMaster ], [ null, null, "your frog" ], null  ) ) }

//		-------------------------------------------------------------------------------------------------------------------
//		vicViper
//		-------------------------------------------------------------------------------------------------------------------
//		[Embed(source="../assets/images/characters/vicViper/vicViper_palette.png")]
//		private static const vic_palette:Class;			{ addCharPalette(vic_palette,VicViper.CHAR_NUM); }
//		
//		[Embed(source="../assets/images/characters/vicViper/vicViper_000.png")]
//		private static const VicViper000:Class;
//		{ BMC_VEC.push( new BmdSkinCont( new VicViper000(), 0, ST_CHAR, null, null, CT_8B, [ VicViper.CHAR_NUM ], [ Games.gradius, Games.superCastlevania4, Games.castlevaniaAdventure ] ) ) }
//		
//		[Embed(source="../assets/images/characters/vicViper/vicViper_001.png")]
//		private static const VicViper001:Class;
//		{ BMC_VEC.push( new BmdSkinCont( new VicViper001(), 1, ST_CHAR, null, null, CT_16B, [ VicViper.CHAR_NUM ], [ Games.castlevania, Games.superCastlevania4, Games.castlevaniaAdventure ] ) ) }
//			
//		[Embed(source="../assets/images/characters/vicViper/vicViper_002.png")]
//		private static const VicViper002:Class;
//		{ BMC_VEC.push( new BmdSkinCont( new VicViper002(), 2, ST_CHAR, null, null, CT_GB, [ VicViper.CHAR_NUM ], [ Games.castlevania, Games.superCastlevania4, Games.castlevaniaAdventure ] ) ) }
//
//		[Embed(source="../assets/images/characters/vicViper/vicViper_003.png")]
//		private static const VicViper003:Class;
//		{ BMC_VEC.push( new BmdSkinCont( new VicViper003(), 3, ST_CHAR, null, null, CT_8B, [ VicViper.CHAR_NUM ], [ Games.castlevania, Games.superCastlevania4, Games.castlevaniaAdventure ], [ "Lord English", "Lord English" ] ) ) }

//		[Embed(source="../assets/images/characters/vicViper/vicViper_004.png")]
//		private static const VicViper004:Class;
//		{ BMC_VEC.push( new BmdSkinCont( new VicViper004(), 4, ST_CHAR, null, null, CT_16B, [ VicViper.CHAR_NUM ], [  ] ) ) }
//		
//		[Embed(source="../assets/images/characters/vicViper/vicViper_005.png")]
//		private static const VicViper005:Class;
//		{ BMC_VEC.push( new BmdSkinCont( new VicViper005(), 5, ST_CHAR, null, null, CT_GB, [ VicViper.CHAR_NUM ], [  ] ) ) }

//		-------------------------------------------------------------------------------------------------------------------
//		warOfLight
//		-------------------------------------------------------------------------------------------------------------------
		/*[Embed(source="../assets/images/characters/warOfLight/warOfLight_000.png")]
		private static const WarriorOfLight000:Class;
		{ BMC_VEC.push( new BmdSkinCont( new WarriorOfLight000(), 0, ST_CHAR, null, null, CT_8B, [ WarriorOfLight.CHAR_NUM ], [  ] ) ) }
		
		[Embed(source="../assets/images/characters/warOfLight/warOfLight_001.png")]
		private static const WarriorOfLight001:Class;
		{ BMC_VEC.push( new BmdSkinCont( new WarriorOfLight001(), 1, ST_CHAR, null, null, CT_16B, [ WarriorOfLight.CHAR_NUM ], [  ] ) ) }
		
		[Embed(source="../assets/images/characters/warOfLight/warOfLight_002.png")]
		private static const WarriorOfLight002:Class;
		{ BMC_VEC.push( new BmdSkinCont( new WarriorOfLight002(), 2, ST_CHAR, null, null, CT_GB, [ WarriorOfLight.CHAR_NUM ], [  ] ) ) }
		
		[Embed(source="../assets/images/characters/warOfLight/warOfLight_003.png")]
		private static const WarriorOfLight003:Class;
		{ BMC_VEC.push( new BmdSkinCont( new WarriorOfLight003(), 3, ST_CHAR, null, null, CT_8B, [ WarriorOfLight.CHAR_NUM ], [  ] ) ) }
		
		[Embed(source="../assets/images/characters/warOfLight/warOfLight_004.png")]
		private static const WarriorOfLight004:Class;
		{ BMC_VEC.push( new BmdSkinCont( new WarriorOfLight004(), 4, ST_CHAR, null, null, CT_16B, [ WarriorOfLight.CHAR_NUM ], [  ] ) ) }
		
		[Embed(source="../assets/images/characters/warOfLight/warOfLight_005.png")]
		private static const WarriorOfLight005:Class;
		{ BMC_VEC.push( new BmdSkinCont( new WarriorOfLight005(), 5, ST_CHAR, null, null, CT_GB, [ WarriorOfLight.CHAR_NUM ], [  ] ) ) }*/
		public static function initiate():void
		{
			for (var i:int = 0; i < HIDE_TOP_CASTLES.length; i++) 
			{
				var num:int = HIDE_TOP_CASTLES[i];
				hideTopCastleDct[num] = num;
			}
		}
		public static function setUpMasterCharBmpVec():void
		{
			var charInfoVec:Vector.<Array> = CharacterInfo.CHAR_ARR;
			var n:int = charInfoVec.length;
			for (var i:int = 0; i < n; i++) 
			{
				var className:String = charInfoVec[i][CharacterInfo.IND_CHAR_NAME_CLASS] + "000";
				var classObj:Class = BmdInfo[ className ];
				MASTER_CHAR_BMP_VEC[i] = new classObj();
			}
		}
		public static function getBmcVec():Vector.<BmdSkinCont>
		{
			return BMC_VEC;
		}
		public static function getBmp(arr:Array):Bitmap
		{
			return Bitmap(arr[IND_BMP]);
		}
		public static function getSkinType(arr:Array):int
		{
			return arr[IND_SHEET_TYPE];
		}
		public static function getConsoleType(arr:Array):String
		{
			return arr[IND_CONSOLE_TYPE];
		}
		public static function getCharNums(arr:Array):Array
		{
			return arr[IND_CHARACTERS];
		}
		public static function getGames(arr:Array):Array
		{
			return arr[IND_GAMES];
		}
		public static function getMasterCharBmp(charNum:int):Bitmap
		{
			return MASTER_CHAR_BMP_VEC[charNum];
		}
		private static function addTheme(themeClass:Class,consoleType:int,charNums:Array,games:Array = null):void
		{
			if (!games)
				games = [];
			var data:Array = StringUtils.readClassData(themeClass);
			THEME_VEC.push( new BmdSkinCont( new themeClass(), data[StringUtils.IND_DATA_SKIN], ST_THEME, null, null, consoleType, charNums, games ) );
		}
		private static function addMainPalette(palClass:Class):void
		{
			var bmp:Bitmap = Bitmap( new palClass() );
			var data:Array = StringUtils.readClassData(palClass);
			var skin:int = data[StringUtils.IND_DATA_SKIN];
			MAIN_PALETTE_VEC[skin] = new PaletteSheet( bmp, PaletteSheet.TYPE_MAIN, skin );
			
		}
		
		private static function addCharPalette(palClass:Class,charNum:int):void
		{
			var bmp:Bitmap = Bitmap( new palClass() );
			CHAR_PALETTE_VEC[charNum] = new PaletteSheet( bmp, PaletteSheet.TYPE_CHARACTER, charNum );
		}
		
		private static function addCharacterPreview(previewClass:Class, charNum:int):void
		{
			CHARACTER_PREVIEW_VEC[charNum] = Bitmap( new previewClass() );
		}
		
		public static function getTheme(skin:int):BmdSkinCont
		{
			return THEME_VEC[skin];
		}
		
		public static function getMainPaletteSheet(skin:int):PaletteSheet
		{
			return MAIN_PALETTE_VEC[skin];
		}
		
		public static function getCharPaletteSheet(charNum:int):PaletteSheet
		{
			return CHAR_PALETTE_VEC[charNum];
		}
		
//		public static function getCharacterPreview(charNum:int):Bitmap
//		{
//			return CHARACTER_PREVIEW_VEC[charNum];
//		}
		
		public static function getMapSkinPreviews():Vector.<CustomMovieClip>
		{
			if (mapSkinPreviews == null)
			{
//				var matrix:Matrix = new Matrix();
//				matrix.scale(GlobVars.SCALE, GlobVars.SCALE);
				var mapSkins:Vector.<BmdSkinCont> = GraphicsManager.INSTANCE.CLEAN_BMD_VEC_MAP;
				mapSkinPreviews = new Vector.<CustomMovieClip>(mapSkins.length, true);
				for (var i:int; i < mapSkins.length; i++)
				{
					var sourceBitmapData:BitmapData = mapSkins[i].bmd;
					var targetBitmapData:BitmapData = new BitmapData(MAP_SKIN_PREVIEW_RECTANGLE.width, MAP_SKIN_PREVIEW_RECTANGLE.height, true, 0);
					targetBitmapData.copyPixels(sourceBitmapData, MAP_SKIN_PREVIEW_RECTANGLE, GlobVars.ZERO_PT);
//					trace("is Empty:" +isEmpty(targetBitmapData));
					var customMovieClip:CustomMovieClip = new CustomMovieClip();
					customMovieClip.setNumFrames(1);
					customMovieClip.addChildToSingleFrame( new Bitmap(targetBitmapData), 1);
					customMovieClip.scaleX = GlobVars.SCALE;
					customMovieClip.scaleY = GlobVars.SCALE;
					customMovieClip.gotoAndStop(1);
					mapSkinPreviews[i] = customMovieClip;
				}
			}
			return mapSkinPreviews;
		}
		
//		private static function isEmpty(bitmapData:BitmapData):Boolean
//		{
//			var bounds:Rectangle = bitmapData.getColorBoundsRect(0xFF000000, 0, false);
//			return bounds.width == 0 && bounds.height == 0; 
//		}
		
		public static function getSoundReplaceDct(bmcType:int,infoNum:int,skinNum:int):Dictionary
		{
			return null;
		}
	}
}