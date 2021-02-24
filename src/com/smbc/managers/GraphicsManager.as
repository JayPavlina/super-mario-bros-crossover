package com.smbc.managers
{
	import com.adobe.images.PNGEncoder;
	import com.explodingRabbit.cross.data.ConsoleType;
	import com.explodingRabbit.cross.games.Games;
	import com.explodingRabbit.display.CustomMovieClip;
	import com.explodingRabbit.utils.ArrayUtils;
	import com.explodingRabbit.utils.CustomDictionary;
	import com.smbc.characters.Bass;
	import com.smbc.characters.Bill;
	import com.smbc.characters.Character;
	import com.smbc.characters.Link;
	import com.smbc.characters.Luigi;
	import com.smbc.characters.Mario;
	import com.smbc.characters.MegaMan;
	import com.smbc.characters.ProtoMan;
	import com.smbc.characters.Ryu;
	import com.smbc.characters.Samus;
	import com.smbc.characters.Simon;
	import com.smbc.characters.Sophia;
	import com.smbc.characters.VicViper;
	import com.smbc.characters.WarriorOfLight;
	import com.smbc.characters.base.MarioBase;
	import com.smbc.characters.base.MegaManBase;
	import com.smbc.data.CharacterInfo;
	import com.smbc.data.EnemyInfo;
	import com.smbc.data.GameBoyPalettes;
	import com.smbc.data.GameSettings;
	import com.smbc.data.GameSettingsValues;
	import com.smbc.data.GameStates;
	import com.smbc.data.InterfaceInfo;
	import com.smbc.data.LevelDataTranscoder;
	import com.smbc.data.LevelTypes;
	import com.smbc.data.MapInfo;
	import com.smbc.data.MusicSets;
	import com.smbc.data.MusicType;
	import com.smbc.data.PaletteTypes;
	import com.smbc.data.Themes;
	import com.smbc.enemies.Beetle;
	import com.smbc.enemies.Bloopa;
	import com.smbc.enemies.Bowser;
	import com.smbc.enemies.CheepFast;
	import com.smbc.enemies.Enemy;
	import com.smbc.enemies.Goomba;
	import com.smbc.enemies.HammerBro;
	import com.smbc.enemies.KoopaGreen;
	import com.smbc.enemies.Lakitu;
	import com.smbc.enemies.PiranhaGreen;
	import com.smbc.enemies.SpikeTop;
	import com.smbc.enemies.Spiney;
	import com.smbc.events.CustomEvents;
	import com.smbc.graphics.Background;
	import com.smbc.graphics.BackgroundInfo;
	import com.smbc.graphics.BmdInfo;
	import com.smbc.graphics.BmdSkinCont;
	import com.smbc.graphics.CastleFlag;
	import com.smbc.graphics.CharacterPortrait;
	import com.smbc.graphics.ExtendedBitmap;
	import com.smbc.graphics.MasterObjects;
	import com.smbc.graphics.Palette;
	import com.smbc.graphics.PaletteSheet;
	import com.smbc.graphics.Scenery;
	import com.smbc.graphics.SkinNames;
	import com.smbc.graphics.SubMc;
	import com.smbc.graphics.ThemeGroup;
	import com.smbc.graphics.TopScreenText;
	import com.smbc.ground.Ground;
	import com.smbc.level.CharacterSelect;
	import com.smbc.level.Level;
	import com.smbc.level.LevelBackground;
	import com.smbc.level.LevelForeground;
	import com.smbc.main.GlobVars;
	import com.smbc.main.SimpleAnimatedObject;
	import com.smbc.main.SkinObj;
	import com.smbc.messageBoxes.CharacterSelectBox;
	import com.smbc.messageBoxes.GraphicsOptions;
	import com.smbc.messageBoxes.MenuBoxItems;
	import com.smbc.messageBoxes.MessageBox;
	import com.smbc.pickups.Pickup;
	import com.smbc.projectiles.BowserFireBall;
	import com.smbc.projectiles.FireBar;
	import com.smbc.projectiles.Hammer;
	import com.smbc.projectiles.LavaFireBall;
	import com.smbc.projectiles.MarioFireBall;
	import com.smbc.projectiles.Projectile;
	import com.smbc.sound.BackgroundMusic;
	import com.smbc.sound.BackgroundMusicSections;
	import com.smbc.text.TextFieldContainer;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	import mx.core.BitmapAsset;
	
	import org.osmf.events.DisplayObjectEvent;

	public class GraphicsManager extends MainManager
	{ 
		public static const INSTANCE:GraphicsManager = new GraphicsManager();
		public static const BMD_SCALE:Number = 2;
		public static const TYPE_MAP:int = BmdSkinCont.TYPE_MAP;
		public static const TYPE_CHARACTER:int = BmdSkinCont.TYPE_CHARACTER;
		public static const TYPE_ENEMY:int = BmdSkinCont.TYPE_ENEMY;
		public static const TYPE_INTERFACE:int = BmdSkinCont.TYPE_INTERFACE;
		public static const TYPE_BACKGROUND:int = BmdSkinCont.TYPE_BACKGROUND;
		public static const TYPE_THEME:int = BmdSkinCont.TYPE_THEME;
		public static const LUM_MULT:Number = 63.75; // 63.75
		private static const GB_LUM_PAL_1:int = LUM_MULT*3;
		private static const GB_LUM_PAL_2:int = LUM_MULT*2;
		private static const GB_LUM_PAL_3:int = LUM_MULT*1;
		public static const CHAR_SKIN_NUM_RANDOM:int = -2;
		/*private static const GB_PAL_ORIGIN_COL_0:uint = 0xffc4cfa1;
		private static const GB_PAL_ORIGIN_COL_1:uint = 0xff8b956d;
		private static const GB_PAL_ORIGIN_COL_2:uint = 0xff4d533c;
		private static const GB_PAL_ORIGIN_COL_3:uint = 0xff1f1f1f;*/
		public const BW_FILTER:ColorMatrixFilter = new ColorMatrixFilter([
			.3086	,	.6094	,	.0820	,	0	,	0,
			.3086	,	.6094	,	.0820	,	0	,	0,
			.3086	,	.6094	,	.0820	,	0	,	0,
			0	,	0	,	0	,	1	,	0
		]);
		private const COL_PAL_MAP_ARRS:Array = [
			new Array(256),
			new Array(256),
			new Array(256)
		];
		private var knownBmd:BitmapData;
		private var knownSkin:Sprite;
		public static const RANDOM_SKIN_NUM:int = LevelDataTranscoder.SKINS_VEC.length;
		public static const USE_MAP_SKIN_NUM:int = RANDOM_SKIN_NUM + 1; // same for interface
//		public static const USE_MAP_CONSOLE_NUM_INTERFACE:int = 6; // not used currently
		public static const NUM_GB_PALETTES:int = 13;
		private static const TSPX:int = 206; // theme standard palette x
		private static const TSPO:int = 6; // theme standard palette offset
		public static const GB_PALETTE_FULL_COLOR:int = 0;
		public static const GB_PALETTE_OFFSET:int = -1;
		public static const GB_PALETTE:Palette = Palette.createGameBoyPalette();
		private static const NUM_GB_PALETTE_GROUPS:int = Palette.NUM_GB_PALETTE_GROUPS;
		private static const NUM_GB_COLORS_PER_GROUP:int = Palette.NUM_GB_COLORS_PER_GROUP;
		public static const GB_PAL_OBJ1:int = 0; // characters, enemies
		public static const GB_PAL_OBJ2:int = 1; // projectiles, pickups
		public static const GB_PAL_BG:int = 2; // background
		private static const IND_BG_INFO_VEC_PAL_ORDER:int = 0;
		private static const GB_Y_OFS:int = 6;
		private static const MAX_CP_COLORS:int = 18;
		private static const INFO_ARR_IND_RECT_ARR:int = 0;
		private static const INFO_ARR_IND_RECOLOR:int = 1;
		private static const INFO_ARR_IND_OVRD_DEF_PAL:int = 2;
		public static const THEME_RECT_VEC:Vector.<Rectangle> = new Vector.<Rectangle>(Themes.MAX_THEMES + 1,true);
		{
			THEME_RECT_VEC[1] = new Rectangle(1,7,220,237);
			THEME_RECT_VEC[2] = new Rectangle(222,7,220,237);
			THEME_RECT_VEC[3] = new Rectangle(443,7,220,237);
			THEME_RECT_VEC[4] = new Rectangle(664,7,220,237);
			THEME_RECT_VEC[5] = new Rectangle(1,245,220,237);
			THEME_RECT_VEC[6] = new Rectangle(222,245,220,237);
			THEME_RECT_VEC[7] = new Rectangle(443,245,220,237);
			THEME_RECT_VEC[8] = new Rectangle(664,245,220,237);
			THEME_RECT_VEC[9] = new Rectangle(1,483,220,237);
			THEME_RECT_VEC[10] = new Rectangle(222,483,220,237);
			THEME_RECT_VEC[11] = new Rectangle(443,483,220,237);
			THEME_RECT_VEC[12] = new Rectangle(664,483,220,237);
			THEME_RECT_VEC[13] = new Rectangle(1,721,220,237);
			THEME_RECT_VEC[14] = new Rectangle(222,721,220,237);
			THEME_RECT_VEC[15] = new Rectangle(443,721,220,237);
			THEME_RECT_VEC[16] = new Rectangle(664,721,220,237);
		}
		public static const ZERO_PNT:Point = GlobVars.ZERO_PT;
		public static const COLOR_NEW_REGULAR_PALETTE:uint = Palette.COLOR_NEW_REGULAR_PALETTE;		
		public static const COLOR_NEW_FLASH_PALETTE:uint = Palette.COLOR_NEW_FLASH_PALETTE;
		public static const COLOR_FRAME:uint = Palette.COLOR_FRAME;
		public static const COLOR_NEW_ROW:uint = Palette.COLOR_NEW_ROW;
		public static const COLOR_STANDARD_PALETTE:uint = Palette.COLOR_STANDARD_PALETTE;
		public static const COLOR_ANIM_FRAME_DELAY:uint = Palette.COLOR_ANIM_FRAME_DELAY;
		private const inactiveSkinNumsDct:CustomDictionary = new CustomDictionary();
		private static const STANDARD_COL_DCT:CustomDictionary = Palette.STANDARD_COLOR_DCT;
		{
			STANDARD_COL_DCT.addItem(COLOR_NEW_REGULAR_PALETTE);
			STANDARD_COL_DCT.addItem(COLOR_NEW_FLASH_PALETTE);
			STANDARD_COL_DCT.addItem(COLOR_NEW_ROW);
			STANDARD_COL_DCT.addItem(COLOR_STANDARD_PALETTE);
			STANDARD_COL_DCT.addItem(COLOR_FRAME);			
		}
		// red animation length
		// green first frame delay
		// green blue transparent castle
		
		// new
//		magenta - standard palette, yellow - new row, red - continued row, green - animation length, turquoise - animation delay
		private static const COLOR_END:uint = 0;
		public var drawingBoardMapSkinCont:BmdSkinCont;
		public var drawingBoardEnemySkinCont:BmdSkinCont;
		public var drawingBoardInterfaceSkinCont:BmdSkinCont;
		public var drawingBoardThemeSkinCont:BmdSkinCont;
//		public var masterPortraitSkinCont:BmdSkinCont;
//		public var masterPortraitSkinContClean:BmdSkinCont;
		public var drawingBoardCharSkinVec:Vector.<BmdSkinCont> = new Vector.<BmdSkinCont>(Character.NUM_CHARACTERS,true); // the bmd that is drawn to
		public static const gameBoyFilterSprite:Sprite = new Sprite();
		private static const GAME_BOY_FILTER_COLOR:uint = 0xF0FFC1;
//		public const PLAYER_1_MASTER_BMC_VEC:Vector.<BmdSkinCont> = new Vector.<BmdSkinCont>(Character.NUM_CHARACTERS,true);
		public const CLEAN_BMC_CONTAINER_ARR:Array = []; // holds map, enemy, and interface bmc vecs
		public const CLEAN_BMC_VEC_CHARACTER:Vector.<Vector.<BmdSkinCont>> = new Vector.<Vector.<BmdSkinCont>>(Character.NUM_CHARACTERS,true);
		public const CLEAN_BMD_VEC_ENEMY:Vector.<BmdSkinCont> = new Vector.<BmdSkinCont>();
		public const CLEAN_BMD_VEC_MAP:Vector.<BmdSkinCont> = new Vector.<BmdSkinCont>();
		public var CLEAN_BMD_VEC_THEME:Vector.<BmdSkinCont> = new Vector.<BmdSkinCont>();
		public const CLEAN_BMC_VEC_INTERFACE:Vector.<BmdSkinCont> = new Vector.<BmdSkinCont>();
		private static const CHAR_GB_INFO_VEC:Vector.<Array> = new Vector.<Array>(Character.NUM_CHARACTERS, true);
		public static const CHAR_INFO_VEC:Vector.<Array> = new Vector.<Array>(Character.NUM_CHARACTERS, true);
		{
			(function ():void
			{
				function ai(charNum:int,index:int,rectArr:Array, recolor:Boolean = true):void
				{
					var arr:Array = CHAR_INFO_VEC[charNum];
					if (!arr)
					{
						arr = [];
						CHAR_INFO_VEC[charNum] = arr;
					}
					arr[index] = [ rectArr, recolor ];
				}
				var billNum:int = Bill.CHAR_NUM;
				ai(billNum, Bill.IND_CI_Bill, [ ar(59,7,289,173) ] );
				
				CHAR_GB_INFO_VEC[billNum] = [
					[ GB_PAL_OBJ1, GB_PAL_OBJ2 ],
					[ ar(1,7,347,231) ], // obj1
					[ ar(1,65,57,115), ar(1,181,173,57) ], // obj2
					[  ] // bg
				];
				
				var linkNum:int = Link.CHAR_NUM;
				ai(linkNum, Link.IND_CI_Link, [ ar(1,7,23,23), ar(25,7,191,71) ] ); 
				ai(linkNum, Link.IND_CI_Portrait, [ ar(217,7,24,24) ] );
//				ai(linkNum, Link.IND_CI_LinkSword, [ar(22,70,20,20)] );
				ai(linkNum, Link.IND_CI_LinkEnemyExplosion, [ ar(1,103,47,23) ] );
//				linkArr[Link.IND_CI_LinkSwordProjectile] = [ new Point(43,70), [ar(64,70,20,20)] ];
//				linkArr[Link.IND_CI_LinkSwordExplosion] = [ new Point(43,91), [ar(64,91,20,20)] ];
//				linkArr[Link.IND_CI_LinkShield] = [ new Point(127,70), [ar(148,7,41,83)] ];
//				linkArr[Link.IND_CHAR_INFsO_VEC_LinkBoomerang] = [ new Point(85,70), [ar(106,70,20,20)] ];
				CHAR_GB_INFO_VEC[linkNum] = [
					[ GB_PAL_OBJ1, GB_PAL_OBJ2 ],
					[ ar(1,7,240,95) ], // obj1
					[ ar(49,79,167,119), ar(1,103,47,95) ], // obj2
					[  ] // bg
				];
				
				var marioNum:int = Mario.CHAR_NUM;
				ai(marioNum, MarioBase.IND_CI_Mario, [ar(36,1,454,230), ar(36,232,104,49), ar(456,232,34,49)] );
				ai(marioNum, MarioBase.IND_CI_MarioFireBall, [ar(176,232,244,24)] );
				ai(marioNum, MarioBase.IND_CI_MarioFireFlowerNormal, [ar(176,232,244,24)] );
				ai(marioNum, MarioBase.IND_CI_MarioStar, [ar(176,232,244,24)] );
				ai(marioNum, MarioBase.IND_CI_MarioPortrait, [ar(6,2,24,24)] );
				CHAR_GB_INFO_VEC[Mario.CHAR_NUM] = [
					[ GB_PAL_OBJ1, GB_PAL_OBJ2 ],
					[ ar(1,7,489,274) ], // obj1
					[ ar(176,232,279,49) ], // obj2
					[  ] // bg
				];
				
				CHAR_INFO_VEC[Luigi.CHAR_NUM] = CHAR_INFO_VEC[marioNum].concat();
				CHAR_GB_INFO_VEC[Luigi.CHAR_NUM] = CHAR_GB_INFO_VEC[marioNum].concat();
				
				var megaManNum:int = MegaMan.CHAR_NUM;
				ai(megaManNum, MegaManBase.IND_CI_MegaManFlash, [ar(37,7,287,107), ar(289,115,35,143)] );
				ai(megaManNum, MegaManBase.IND_CI_MegaManChargeMegaBuster, [ar(37,7,287,107), ar(289,115,35,143)] );
				ai(megaManNum, MegaManBase.IND_CI_MegaManChargeMagmaBazooka, [ar(37,7,287,107), ar(289,115,35,143)] );
				ai(megaManNum, MegaManBase.IND_CI_Portrait, [ar(6,12,24,24)] );
				ai(megaManNum, MegaManBase.IND_CI_Energy, [ar(37,115,35,35), ar(325,7,35,71), ar(325,223,35,35)] );

				CHAR_INFO_VEC[Bass.CHAR_NUM] = CHAR_INFO_VEC[megaManNum].concat();
				
//				this must be added after Bass copies array because it's different
				ai(megaManNum, MegaManBase.IND_CI_MegaManSuitColors, [ar(37,7,287,107), ar(289,115,35,143)] );
				ai(Bass.CHAR_NUM, MegaManBase.IND_CI_MegaManSuitColors, [ar(37,7,287,107), ar(73,115,179,35), ar(289,115,35,143)] );
				
				CHAR_GB_INFO_VEC[megaManNum] = [
					[ GB_PAL_OBJ1, GB_PAL_OBJ2 ],
					[ ar(1,7,359,287) ], // obj1, entire sheet
					[ ar(1,43,35,179), ar(37,151,251,71), ar(73,115,215,35), ar(19,259,17,17), ar(325,79,35,179), ar(289,259,70,34) ], // obj2
					[  ] // bg
				];
				CHAR_GB_INFO_VEC[Bass.CHAR_NUM] = [
					[ GB_PAL_OBJ1, GB_PAL_OBJ2 ],
					[ ar(1,7,359,287) ], // obj1, entire sheet
					[ ar(1,43,35,179), ar(37,151,251,71), ar(253,113,35,35), ar(19,259,17,17), ar(325,79,35,179), ar(289,259,70,34) ], // obj2
					[  ] // bg
				];
				var ryuNum:int = Ryu.CHAR_NUM;
				ai(ryuNum,Ryu.IND_CI_Ryu, [ ar(1,50,42,171), ar(44,7,171,214), ar(216,7,85,257) ] );
				CHAR_GB_INFO_VEC[Ryu.CHAR_NUM] = [
					[ GB_PAL_OBJ1, GB_PAL_OBJ2 ],
					[ ar(1,7,386,214) ], // obj1
					[ ar(1,222,386,128) ], // obj2
					[  ] // bg
				];
				var samusNum:int = Samus.CHAR_NUM;
				ai(samusNum, Samus.IND_CI_Samus, [ ar(26,7,374,249), ar(1,32,24,224) ] ); 
				ai(samusNum, Samus.IND_CI_SamusPortrait, [ ar(1,7,24,24) ] ); 
				ai(samusNum, Samus.IND_CI_SamusVariaSuit, [ ar(1,282,24,24) ] );
				ai(samusNum, Samus.IND_CI_SamusLongBeam, [ ar(26,282,24,24) ] );
				ai(samusNum, Samus.IND_CI_SamusIceBeam, [ ar(51,282,24,24) ] );
				ai(samusNum, Samus.IND_CI_SamusWaveBeam, [ ar(76,282,24,24) ] );
				ai(samusNum, Samus.IND_CI_SamusMorphBall, [ ar(101,282,24,24) ] );
				ai(samusNum, Samus.IND_CI_SamusBomb, [ ar(126,282,24,24) ] );
				ai(samusNum, Samus.IND_CI_SamusMissile, [ ar(151,282,24,24) ] );
				ai(samusNum, Samus.IND_CI_SamusMissileExpansion, [ ar(176,282,24,24) ] );
				ai(samusNum, Samus.IND_CI_SamusHighJump, [ ar(201,282,24,24) ] );
				ai(samusNum, Samus.IND_CI_SamusScrewAttack, [ ar(226,282,24,24) ] );
				ai(samusNum, Samus.IND_CI_SamusMissileAmmo, [ ar(326,282,24,24) ] );
					
				CHAR_GB_INFO_VEC[Samus.CHAR_NUM] = [
					[ GB_PAL_OBJ1, GB_PAL_OBJ2 ],
					[ ar(1,7,399,299) ], // obj1
					[ ar(1,57,49,199), ar(1,257,399,49), ar(351,7,49,199) ], // obj2
					[  ] // bg
				];
				var simonNum:int = Simon.CHAR_NUM;
				ai(simonNum, Simon.IND_CI_Simon, [ar(1,7,293,83)] );
				ai(simonNum, Simon.IND_CI_SimonWhipMid, [ ar(43,91,20,62), ar(85,112,62,20) ] );
				ai(simonNum, Simon.IND_CI_SimonWhip, [ ar(64,91,20,62), ar(85,133,62,20) ] );
				
				CHAR_GB_INFO_VEC[simonNum] = [
					[ GB_PAL_OBJ1, GB_PAL_OBJ2 ],
					[ ar(22,7,272,188) ], // obj1
					[ ar(148,91,146,62), ar(1,154,188,41), ar(232,154,62,41) ], // obj2
					[  ] // bg
				];
				var sophiaNum:int = Sophia.CHAR_NUM;
				var vec:Vector.<Array> = CHAR_INFO_VEC;
				ai(sophiaNum, Sophia.IND_CI_Sophia, [ar(22,7,209,83), ar(211,112,20,41)] );
				ai(sophiaNum, Sophia.IND_CI_SophiaBullet, [ar(22,196,209,20), ar(211,7,20,41)] );	
				
				CHAR_GB_INFO_VEC[sophiaNum] = [
					[ GB_PAL_OBJ1, GB_PAL_OBJ2 ],
					[ ar(22,7,234,251) ], // obj1
					[ ar(1,7,20,251), ar(22,196,104,41), ar(22,238,83,20), ar(126,175,105,41), ar(191,219,39,16), ar(22,91,188,62), ar(211,49,20,41), ar(148,49,20,41) ], // obj2
					[  ] // bg
				];
				//			CHAR_INFO_VEC[VicViper.CHAR_NUM] = [
				//				[ new Point(1,7), [ar(51,7,299,249) ] ] // VicViper
				//			];
				//			CHAR_GB_INFO_VEC[VicViper.CHAR_NUM] = [
				//				[ GB_PAL_OBJ1, GB_PAL_OBJ2 ],
				//				[ ar(22,7,272,146) ], // obj1
				//				[ ar(211,91,83,62) ], // obj2
				//				[  ] // bg
				//			];
				//			CHAR_INFO_VEC[WarriorOfLight.CHAR_NUM] = [
				//				[ new Point(1,7), [ar(48,7,469,187) ] ] // WarriorOfLight
				//			];
				//			CHAR_GB_INFO_VEC[WarriorOfLight.CHAR_NUM] = [
				//				[ GB_PAL_OBJ1, GB_PAL_OBJ2 ],
				//				[ ar(22,7,272,146) ], // obj1
				//				[ ar(211,91,83,62) ], // obj2
				//				[  ] // bg
			
			}() );
		}
		public static const IND_MAP_INFO_ARR_BRICK:int = 1;
		public static const IND_MAP_INFO_ARR_ITEM_BLOCK:int = 3;
		public static const IND_MAP_INFO_ARR_ITEM_COIN:int = 3;
		public static const MAP_INFO_ARR:Array = [];
		{(function ():void{
			
			mp( MapInfo.GroundNormal, [ ar(1,24,67,67), ar(69,7,84,84) ] );
			mp( MapInfo.BlockNormal, [ ar(1,92,67,67), ar(69,92,84,84) ] );
			mp( MapInfo.Grass, [ ar(154,7,67,50) ] );
			mp( MapInfo.Fence, [ ar(188,109,16,16) ] );
			mp( MapInfo.TreeTall, [ ar(154,58,16,67) ] );
			mp( MapInfo.TreeShort, [ ar(171,75,16,50) ] );
			mp( MapInfo.Railing, [ ar(171,58,50,16) ] );
			mp( MapInfo.MovingPlatform, [ ar(1,194,103,33), ar(103,194,67,33), ar(171,194,33,33) ] );
			mp( MapInfo.StandardPlatform, [ ar(154,126,67,50) ] );
			mp( MapInfo.CoralHorizontal, [ ar(52,177,67,16) ] );
			mp( MapInfo.CoralVertical, [ ar(120,77,67,16) ] );
			mp( MapInfo.BowserBridge, [ ar(52,160,16,16) ] );
			mp( MapInfo.FlagPoleBlock, [ ar(1,177,16,16) ] );
			mp( MapInfo.FireBarBlock, [ ar(18,177,16,16) ] );
			mp( MapInfo.AlternatingBrickSet, [ ar(1,160,50,16) ] );
			mp( MapInfo.ThinGround, [ ar(120,177,67,16) ] );
			mp( MapInfo.SinglePieceGround, [ ar(35,177,16,16) ] );
			
// themes end			
			mp( MapInfo.Pipe, [ ar(392,109,67,84) ] );
			mp( MapInfo.Hill, [ ar(188,41,50,33), ar(171,75,84,50), ar(477,143,118,67) ] );
			mp( MapInfo.Cloud, [ ar(239,41,84,33),ar(256,75,67,33), ar(460,194,16,16) ] );
			mp( MapInfo.Mushroom, [ ar(324,7,67,16) ] );
			mp( MapInfo.FireFlower, [ ar(324,58,67,16) ] );
			mp( MapInfo.PoisonMushroom, [ ar(324,24,67,16) ] );
			mp( MapInfo.OneUp, [ ar(324,41,67,16) ] );
			mp( MapInfo.Star, [ ar(324,75,67,16) ] );
			mp( MapInfo.YoshiEgg, [ ar(324,160,16,16) ] );
			mp( MapInfo.SpringGreen, [ ar(477,7,50,33) ] );
			mp( MapInfo.SpringRed, [ ar(477,41,50,33) ] );
			mp( MapInfo.Brick, [ ar(409,7,67,33) ] );
			mp( MapInfo.BrickHitResting, [ ar(392,7,16,16) ] );
			mp( MapInfo.BrickHitMoving, [ ar(392,24,16,16) ] );
			mp( MapInfo.ItemBlockHitResting, [ ar(392,41,16,16) ] );
			mp( MapInfo.ItemBlock, [ ar(409,41,67,16) ] );
			mp( MapInfo.Vine, [ ar(460,58,16,135) ] );
			mp( MapInfo.Coin, [ ar(324,92,67,16) ] );
			mp( MapInfo.FlyingCoin, [ ar(324,109,67,16) ] );
			mp( MapInfo.RedCoin, [ ar(324,143,67,16) ] );
			mp( MapInfo.BowserAxe, [ ar(324,126,67,16) ] );
			mp( MapInfo.BrickPiece, [ ar(392,194,33,16) ] );
			mp( MapInfo.WaterSwimStage, [ ar(171,126,135,33), ar(307,143,16,16) ] );
			mp( MapInfo.WaterRegularStage, [ ar(171,160,152,16) ] );
			mp( MapInfo.Lava, [ ar(171,177,152,16) ] );
			mp( MapInfo.Firework, [ ar(188,7,135,33) ] );
			mp( MapInfo.CoinExplosion, [ ar(409,58,50,16), ar(392,75,67,33) ] );
			mp( MapInfo.BowserBridgeBreak, [ ar(477,75,50,67) ] );
			mp( MapInfo.Pully, [ ar(256,109,67,16) ] );
			mp( MapInfo.Canon, [ ar(528,92,16,50) ] );
			mp( MapInfo.FlagPole, [ ar(103,58,16,33) ] );
			mp( MapInfo.Flag, [ ar(120,58,50,16) ] );
			mp( MapInfo.CastleBig, [ ar(1,7,101,84) ] );
			mp( MapInfo.CastleSmall, [ ar(1,92,169,101) ] );
			mp( MapInfo.Leaf, [ ar(341,160,33,16) ] );
			mp( MapInfo.AxeObtained, [ ar(324,143,67,16) ] );
			mp( MapInfo.HudsonBee, [ ar(528,7,67,16) ] );
			mp( MapInfo.Hammer, [ ar(528,24,67,16), ar(426,194,33,16) ] );
			mp( MapInfo.Wing, [ ar(528,41,67,16) ] );
			mp( MapInfo.Clock, [ ar(528,58,67,16) ] );
			mp( MapInfo.LuckyStar, [ ar(528,75,67,16) ] );
			mp( MapInfo.ExplodingRabbitPowerup, [ ar(324,194,67,16) ] );
			mp( MapInfo.BrickWall, [ ar(103, 7, 50, 33) ] );
			
			function mp(num:int, rectArr:Array, recolor:Boolean = true):void
			{
				MAP_INFO_ARR[num] = [ rectArr, recolor ];
			}
			
		}() );}
		private const MAP_GB_INFO_ARR:Array = [
			[ GB_PAL_BG, GB_PAL_OBJ2, GB_PAL_OBJ1 ],
			[ ar(154,7,33,33), ar(171,41,16,33) ], // obj1
			[ ar(324,7,67,186), ar(188,7,135,33) ], // obj2
			[ new Rectangle(1,7,526,186) ] // bg
		];	
		private const THEME_GB_INFO_ARR:Array = [
			[ GB_PAL_BG, GB_PAL_OBJ2, GB_PAL_OBJ1 ],
			[ new Rectangle(188,602,50,33) ], // obj1
			[ new Rectangle(18,381,67,203) ], // obj2
			[ new Rectangle(1,7,560,662) ] // bg
		];
		public static const COIN_SYMBOL_IND:int = 0;
		public static const INTERFACE_INFO_ARR:Array = [];
		{(function ():void{
			
			ai( InterfaceInfo.CoinSymbol, [ ar(137,47,39,10) ] );
			ai( InterfaceInfo.FontCharMenu, [ ar(1,7,125,62) ], false );
			ai( InterfaceInfo.FontCharHud, [ ar(127,7,119,39) ] );
			ai( InterfaceInfo.MushroomSelector, [ ar(168,59,45,9) ], false );
			ai( InterfaceInfo.FontCharScore, [ ar(177,47,69,10) ] );
			ai( InterfaceInfo.CharSelector, [ ar(16,70,107,26) ] );
			ai( InterfaceInfo.CharSelectorRevive, [ ar(16,97,107,26) ] );
			ai( InterfaceInfo.FontOneUp, [ ar(127,58,27,11) ] );
			
			function ai(num:int,rectArr:Array, recolor:Boolean = true):void
			{
				INTERFACE_INFO_ARR[num] = [ rectArr, recolor ];
			}
			
		}() );}
		private const INTERFACE_GB_INFO_ARR:Array = [ // just a placeholder
			[ GB_PAL_BG, GB_PAL_OBJ2, GB_PAL_OBJ1 ],
			[ new Rectangle(188,602,50,33) ], // obj1
			[ new Rectangle(18,381,67,203) ], // obj2
			[ new Rectangle(1,7,560,662) ] // bg
		];
		public static const MESSAGE_BOX_BG_COLOR_PNT:Point = new Point(219,84);
		/*private const GB_INFO_ARR:Array = [ 
			[ new Point(1,1), [] ] // starts at pixel needed, not at palette 
		];*/
		public static const ENEMY_INFO_ARR:Array = [];
		{(function ():void{
			
			en( EnemyInfo.Goomba, [ ar(26,7,74,24) ] );
			en( EnemyInfo.Beetle, [ ar(26,32,74,49) ] );
			en( EnemyInfo.SpikeTop, [ ar(126,7,49,24) ] );
			en( EnemyInfo.Spiney, [ ar(126,32,49,49) ] );
			en( EnemyInfo.KoopaGreen, [ ar(26,82,99,49), ar(1,132,124,24) ] );
			en( EnemyInfo.KoopaRed, [ ar(151,82,99,49), ar(126,132,124,24) ] );
			en( EnemyInfo.PiranhaGreen, [ ar(251,7,49,49) ] );
			en( EnemyInfo.PiranhaRed, [ ar(326,7,49,49) ] );
			en( EnemyInfo.Bloopa, [ ar(376,7,49,49) ] );
			en( EnemyInfo.CheepFast, [ ar(201,7,49,24) ] );
			en( EnemyInfo.CheepSlow, [ ar(201,32,49,24) ] );
			en( EnemyInfo.CheepFlying, [ ar(201,57,49,24) ] );
			en( EnemyInfo.HammerBro, [ ar(276,57,99,49) ] );
			en( EnemyInfo.Lakitu, [ ar(451,7,49,49) ] );
			en( EnemyInfo.BulletBill, [ ar(251,107,99,24) ] );
			en( EnemyInfo.Bowser, [ ar(51,157,449,49), ar(1,207,199,49) ] );
			en( EnemyInfo.Hammer, [ ar(376,82,24,24), ar(401,57,49,49) ] );
			en( EnemyInfo.Podoboo, [ ar(351,107,74,24) ] );
			en( EnemyInfo.FireBar, [ ar(451,107,49,49) ] );
			en( EnemyInfo.BowserFireball, [ ar(201,207,174,24) ] );
			en( EnemyInfo.HammerBowser, [ ar(1,157,49,49) ] );
			en( EnemyInfo.Crab, [ ar(1,257,99,24) ] );
			en( EnemyInfo.Fly, [ ar(101,257,74,24) ] );
			en( EnemyInfo.FireEnemy, [ ar(176,257,99,24) ] );
			en( EnemyInfo.Barrel, [ ar(276,257,99,24) ] );
			en( EnemyInfo.Icicle, [ ar(376,257,99,24) ] );
			en( EnemyInfo.BowserFake, [ ar(51,282,449,49) ] );
			en( EnemyInfo.HammerBowserFake, [ ar(1,282,49,49) ] );
			en( EnemyInfo.BowserFakeFireBall, [ ar(201,232,174,24) ] );
			
			function en(num:int,rectArr:Array, recolor:Boolean = true):void
			{
				ENEMY_INFO_ARR[num] = [ rectArr, recolor ];
			}
			
		}() );}
		private const ENEMY_GB_INFO_ARR:Array = [
			[ GB_PAL_OBJ1, GB_PAL_OBJ2 ],
			[ new Rectangle(1,7,499,249) ], // obj1
			[ new Rectangle(376,57,24,49), new Rectangle(351,107,149,49), new Rectangle(251,132,99,24), new Rectangle(201,207,149,49) ], // obj2
			//[  ] // bg
		];
		public var cMapNum:int;
		public var cEnemyBmc:BmdSkinCont;
		public var cInterfaceBmc:BmdSkinCont;
		
		public function GraphicsManager()
		{
			super();
		}
		override public function initiate():void
		{
			super.initiate();
			gameBoyFilterSprite.graphics.beginFill(GAME_BOY_FILTER_COLOR);
			gameBoyFilterSprite.graphics.drawRect(0,0,GlobVars.STAGE_WIDTH,GlobVars.STAGE_HEIGHT);
			gameBoyFilterSprite.graphics.endFill();
			gameBoyFilterSprite.blendMode = BlendMode.MULTIPLY;
			gameBoyFilterSprite.mouseEnabled = false;
			updateScreenFilter();
			setUpVecs();
			setUpColorMapArr();
			
//			var alpha:uint = color >> 24;
//			var red:uint = (color >> 16) & 0xFF;
//			var green:uint = (color >> 8) & 0xFF;
//			var blue:uint = color & 0x000000FF;
			
//			characters
//			var sheet:PaletteSheet =  BmdInfo.getCharPaletteSheet(Mario.CHAR_NUM);
//			var itemNum:int = 1;
//			var skinNum:int = 0;
//			var pal:Palette = sheet.getPaletteFromRow(itemNum,skinNum,PaletteSheet.THEME_TYPE_CHARACTER,true);
			
//			var skinNum:int = 0;
//			var sheet:PaletteSheet =  BmdInfo.getMainPaletteSheet(skinNum);
//			var themeType:int = PaletteSheet.THEME_TYPE_ENEMY;
//			var itemNum:int = 1;
//			var pal:Palette = sheet.getPaletteFromRow(itemNum,0,themeType,true);
//			trace(pal);
//			trace("break");
//			recordCharacterPaletteData();
//			swapEnemyGraphics();
			//enemyBmd.threshold(enemyBmd,enemyBmd.rect,new Point(),"==",0xc84c0c,0xFF0000);
		}
		
		/*private function recordCharacterPaletteData():void
		{
			// TODO Auto Generated method stub
			var curCharNum:int = Sophia.CHAR_NUM;
			var mainArr:Array = CHAR_INFO_VEC[curCharNum];
			var itemNumLength:int = mainArr.length;
			labMainArr: for (var itemNum:int = 0; itemNum < itemNumLength; itemNum++) 
			{
				var arr:Array = mainArr[itemNum];
				if (!arr)
					continue;
				var skinArr:Vector.<BmdSkinCont> = CLEAN_BMC_VEC_CHARACTER[curCharNum];
				var numSkins:int = skinArr.length;
				for (var skin:int = 0; skin < numSkins; skin++) 
				{
					var charBmd:BitmapData = skinArr[skin].bmd;
					var palette:Palette = new Palette(itemNum, Palette.TYPE_CHARACTER, skin, curCharNum, 0, charBmd, arr[INFO_ARR_IND_CP] );
				}
			}
			var fileRef:FileReference = new FileReference();
			var bmdToSave:BitmapData = Palette.CHAR_PALETTE_BLANK;
			fileRef.save(PNGEncoder.encode(bmdToSave), "image.png");
		}*/
		
		/*private function setUpPalettes():void
		{
			var allArrs:Array = [ MAP_INFO_ARR, ENEMY_INFO_ARR, INTERFACE_INFO_ARR ];
			var ni:int = allArrs.length;
			var numSkins:int = BmdInfo.NUM_SKIN_SETS;
			labSkin: for (var skin:int = 0; skin < numSkins; skin++) 
			{
				var paletteBmd:BitmapData = BmdInfo.getMainPaletteBmp(skin);
				var numThemes:int = Palette.getNumColumns(paletteBmd);
				var numSets:int = Palette.getNumRows(paletteBmd);
				for (var theme:int = 0; theme < numThemes; theme++) 
				{
					for (var set:int = 0; set < numSets; set++) 
					{		
						labAllArrs: for (var typeNum:int = 0; typeNum < ni; typeNum++) 
						{
							var mainArr:Array = allArrs[typeNum];
							var nj:int = mainArr.length;
							labMainArr: for (var itemNum:int = 0; itemNum < nj; itemNum++) 
							{
								var arr:Array = mainArr[itemNum];
								if (!arr)
									continue labMainArr;
								var palette:Palette = new Palette(itemNum, typeNum, skin, theme, set );
								palette.addToPalArr();
							}
						}
						
					}
				}
			}
			var fileRef:FileReference = new FileReference();
			var bmdToSave:BitmapData = BmdInfo.getMainPaletteBmp(0);
			fileRef.save(PNGEncoder.encode(bmdToSave), "image.png");
		}*/
		
		private static function ar(x:int,y:int,width:int,height:int):Rectangle
		{
			return new Rectangle(x,y,width,height);
		}
		private function setUpColorMapArr():void
		{
			var redArr:Array = COL_PAL_MAP_ARRS[0];
			var greenArr:Array = COL_PAL_MAP_ARRS[1];
			var blueArr:Array = COL_PAL_MAP_ARRS[2];
			var n:int = 256;
			for (var i:int = 0; i < n; i++) 
			{
				/*redArr[i] = int(i*.7) << 16;
				var green:int = i;
				if (green > 255)
					green = 255;
				var blue:int = i*2 + 150;
				if (blue > 255)
					blue = 255;
				greenArr[i] = green << 8;
				blueArr[i] = 255;*/
				if (i < GB_LUM_PAL_3) // gb color 4: 0x1F1F1F
				{
					redArr[i] = 0x1F << 16;
					greenArr[i] = 0x1F << 8;
					blueArr[i] = 0x1F;
				}
				else if (i < GB_LUM_PAL_2) // gb color 3: 0x4d533c
				{
					redArr[i] = 0x4d << 16;
					greenArr[i] = 0x53 << 8;
					blueArr[i] = 0x3c;
				}
				else if (i < GB_LUM_PAL_1) // gb color 2: 0x8b956d
				{
					redArr[i] = 0x8b << 16;
					greenArr[i] = 0x95 << 8;
					blueArr[i] = 0x6d;
				}
				else // gb color 1: 0xc4cfa1
				{
					redArr[i] = 0xc4 << 16;
					greenArr[i] = 0xcf << 8;
					blueArr[i] = 0xa1;
				}
			}
		}
		private function setUpVecs():void
		{
			BmdInfo.initiate();
			var inactiveSkinsArr:Array = GameSettings.INACTIVE_SKIN_NUMS;
			for each (var skinNum:int in inactiveSkinsArr)
			{
				inactiveSkinNumsDct.addItem(skinNum);
			}
			function addCharSkin( bmp:Bitmap):void
			{
				//new BmdSkinCont( null, 
			}
			var n:int = Character.NUM_CHARACTERS;
			BmdInfo.setUpMasterCharBmpVec();
			CLEAN_BMC_CONTAINER_ARR[Palette.TYPE_MAP] = CLEAN_BMD_VEC_MAP;
			CLEAN_BMC_CONTAINER_ARR[Palette.TYPE_ENEMY] = CLEAN_BMD_VEC_ENEMY;
			CLEAN_BMC_CONTAINER_ARR[Palette.TYPE_INTERFACE] = CLEAN_BMC_VEC_INTERFACE;
			for (var i:int; i < n; i++)
			{
				CLEAN_BMC_VEC_CHARACTER[i] = new Vector.<BmdSkinCont>();
				drawingBoardCharSkinVec[i] = new BmdSkinCont( BmdInfo.MASTER_CHAR_BMP_VEC[i], 0, TYPE_CHARACTER, null, null, 0, [i] );
			}
			drawingBoardEnemySkinCont = BmdInfo.drawingBoardEnemyBmc;
			drawingBoardMapSkinCont = BmdInfo.drawingBoardMapBmc;
			drawingBoardInterfaceSkinCont = BmdInfo.drawingBoardInterfaceBmc;
			drawingBoardThemeSkinCont = BmdInfo.drawingBoardThemeBmc;
//			masterPortraitSkinCont = new BmdSkinCont( new Bitmap(MasterObjects.CharacterPortraitMaster.masterBmd), 0, BmdSkinCont.TYPE_NEUTRAL);
//			masterPortraitSkinContClean = masterPortraitSkinCont.clone();
			var skinArr:Vector.<BmdSkinCont> = BmdInfo.BMC_VEC;
			n = skinArr.length;
			for (i=0; i < n; i++)
			{
				var bmc:BmdSkinCont = skinArr[i];
				var bmcType:int = bmc.type;
				if ( bmcType == TYPE_CHARACTER )
				{
					var charNumArr:Array = bmc.charArr;
					var m:int = charNumArr.length;
					for (var j:int=0; j < m; j++)
					{
						var charNum:int = charNumArr[j];
						CLEAN_BMC_VEC_CHARACTER[charNum].push( bmc );
					}
				}
				else if (bmcType == TYPE_ENEMY)
					CLEAN_BMD_VEC_ENEMY.push(bmc);
				else if (bmcType == TYPE_MAP)
					CLEAN_BMD_VEC_MAP.push(bmc);
				else if (bmcType == TYPE_INTERFACE)
					CLEAN_BMC_VEC_INTERFACE.push(bmc);
				CLEAN_BMD_VEC_THEME = BmdInfo.THEME_VEC;
			}
		}
		
		private function nextSkin(charNum:int,curSkin:int):int
		{
			var vec:Vector.<int> = statMngr.getCharSkinOrder(charNum);
			var ind:int = vec.indexOf(curSkin) + 1;
			if (ind >= vec.length)
				ind = 0;
			if (!vec.length)
				return curSkin++;
			return vec[ind];
		}
		
		private function getRandomSkinNum(charNum:int):int
		{
			var skinNum:int = -1;
			var maxSkinNum:int = CLEAN_BMC_VEC_CHARACTER[charNum].length - 1;
			do
			{
				skinNum = int (Math.random()*(maxSkinNum + 1) );
			}
			while ( !StatManager.characterSkinIsEnabled(charNum, skinNum) );
			return skinNum;
		}
		
		public function changeCharacterSkin(char:Character,skinNum:int = -1):void
		{
			var charNum:int = char.charNum;
			var cSkin:int = statMngr.getCharSkinNum(charNum);
			var n:int = CLEAN_BMC_VEC_CHARACTER[charNum].length;
			var cNumMax:int = n - 1;
			cSkin = nextSkin(charNum,cSkin);
			if (cSkin > cNumMax || cSkin < 0)
				cSkin = 0;
			if (skinNum > -1)
				cSkin = skinNum;
			else if (skinNum == CHAR_SKIN_NUM_RANDOM)
				cSkin = getRandomSkinNum(charNum);
			if ( !skinIsActive(CLEAN_BMC_VEC_CHARACTER[charNum][cSkin]) )
			{
				if ( !skinIsActive(char.currentBmdSkin) )
					cSkin = 0;
				while( !skinIsActive(CLEAN_BMC_VEC_CHARACTER[charNum][cSkin]) )
				{
					if (skinNum != CHAR_SKIN_NUM_RANDOM)
					{
						cSkin = nextSkin(charNum,cSkin);
						if (cSkin > cNumMax || cSkin < 0)
							cSkin = 0;
					}
					else
						cSkin = int (Math.random()*(cNumMax + 1) );
				}
			}
			statMngr.setCharSkinNum(char.charNum,cSkin);
			if (!char.recolorsCharSkin)
				prepareRecolor(drawingBoardCharSkinVec[charNum]);
			char.setCurrentBmdSkin(statMngr.getCurrentBmc(char.charNum) );
			TopScreenText.instance.updNameDispTxt();
			if ( (GameSettings.musicType == ConsoleType.CHARACTER || GameSettings.musicSet == MusicSets.CHARACTER) && gsMngr.gameState == GameStates.PLAY)
				sndMngr.changeMusic();
			eventMngr.dispatchEvent( new Event( CustomEvents.CHANGE_CHARACTER_SKIN ) );
		}
		public function updateScreenFilter():void
		{
			var stage:DisplayObjectContainer = game.stage;
			if (GameSettings.gameBoyFilter)
			{
				game.filters = [ BW_FILTER ];
				stage.addChild(gameBoyFilterSprite);
				game.mask = game.MASK_SPRITE;
			}
			else
			{
				game.filters = [];
				game.mask = null;
//				if (gameBoyFilterSprite.parent)
//					gameBoyFilterSprite.parent.removeChild(gameBoyFilterSprite);
				game.mask = gameBoyFilterSprite;
//				game.MASK_SPRITE.x = 0;
//				game.MASK_SPRITE.y = 0;
//				trace("game.mask.x: "+game.mask.x);
//				trace("game.numChildren: "+game.numChildren);
			}
		}
		public function recolorCharacterSheet(charNum:int,targetPalRow:int,indArr:Array = null, noGameBoy:Boolean = false):void
		{
			prepareRecolor(drawingBoardCharSkinVec[charNum],targetPalRow,indArr);
		}
		public function changeCharacterColor(char:Character):void
		{
			var charNum:int = char.charNum;
			var cNum:int = statMngr.getCharColorNum(charNum);
			var n:int = char.numColors;
			cNum++;
			if (cNum > n - 1 || cNum < 0)
				cNum = 0;
			statMngr.setCharColorNum(charNum,cNum);
			prepareRecolor(drawingBoardCharSkinVec[charNum]);
		}
		public function swapGbPalette(recolorAll:Boolean = false):void
		{
			if ( recolorAll || shouldBeRecoloredToGb(drawingBoardMapSkinCont) )
			{
				recolorGbSkin(drawingBoardMapSkinCont);
				recolorGbSkin(drawingBoardThemeSkinCont);
				level.resizeScenery();
			}
			if ( recolorAll || shouldBeRecoloredToGb(drawingBoardEnemySkinCont) )
				recolorGbSkin(drawingBoardEnemySkinCont);
			if ( recolorAll || shouldBeRecoloredToGb(drawingBoardInterfaceSkinCont) )
			{
				recolorGbSkin(drawingBoardInterfaceSkinCont);
				updateInterfaceItems();
			}
			var charBmc:BmdSkinCont = drawingBoardCharSkinVec[statMngr.curCharNum];
			if ( recolorAll || shouldBeRecoloredToGb(charBmc) )
				recolorGbSkin(charBmc);
		}
		public function initiateLevelHandler():void
		{
//			if set to random, changes number
			if (level is CharacterSelect)
				CharacterSelect.instance.setCurLevStr();
			var mapIsRandom:Boolean;
			if (GameSettings.randomMapSkin)
				mapIsRandom = true;
//			var mapPalette:int = GameSettings.getMapPaletteLimited(true);
//			var charPal:int = GameSettings.getCharacterPaletteLimited(false,true);
//			if (charPal != GameSettings.getCharacterPaletteLimited(true) && shouldBeRecoloredToGb(player.currentBmdSkin))
//				recolorGbSkin(masterCharSkinVec[statMngr.curCharNum]);
//			GameSettings.getEnemyPaletteLimited(true);
//			GameSettings.getInterfacePaletteLimited(true);
//			drawItems(masterMapSkinCont);
			if ( Themes.getMapTheme(true) != Themes.getMapTheme() || mapIsRandom || !level.newLev)
			{
				prepareRecolor(drawingBoardMapSkinCont);
				prepareRecolor(drawingBoardThemeSkinCont);
			}
//			if (mapPalette == 0) // it does this in gb recolor
//			{
				level.background.setBackgrounds();
				level.foreground.setBackgrounds();
//			}
			if ( Themes.getEnemyTheme(true) != Themes.getEnemyTheme() || GameSettings.enemySkin == RANDOM_SKIN_NUM || (mapIsRandom && GameSettings.enemySkin == USE_MAP_SKIN_NUM) )
				prepareRecolor(drawingBoardEnemySkinCont);
			if ( Themes.getInterfaceTheme(true) != Themes.getInterfaceTheme() || GameSettings.interfaceSkin == RANDOM_SKIN_NUM || (mapIsRandom && GameSettings.interfaceSkin == USE_MAP_SKIN_NUM) ) 
				swapInterface();
//			prepareRecolor(masterInterfaceSkinCont);
		}
		private function drawItems(bmc:BmdSkinCont):void
		{
			var bmd:BitmapData = bmc.bmd;
			var bmcType:int = bmc.type;
			if (bmcType == TYPE_THEME)
			{
//				if (level.fullLevStr == "6-3" && cMapNum == 0)
//					drawGrayStuff();
				var themeGroup:ThemeGroup = Themes.getMapTheme(); 
				var themeRect:Rectangle = THEME_RECT_VEC[Themes.NORMAL];
				var srcBmd:BitmapData = CLEAN_BMD_VEC_THEME[GameSettings.getMapSkinLimited()].bmd;
//				bmd.fillRect(themeRect,0);
//				if (levTheme <= BackgroundInfo.NUM_THEMES_ON_SHEET)
				bmd.copyPixels(srcBmd,THEME_RECT_VEC[themeGroup.theme],themeRect.topLeft);
				/*else
				{
					srcBmd = BackgroundInfo.getExtraTheme(GameSettings.getMapSkinLimited(),levTheme);
					bmd.copyPixels(srcBmd,srcBmd.rect,themeRect.topLeft);
					fakeTheme = 0;
				}*/
			}
		}
		private function drawGrayStuff():void
		{
			var rectDct:CustomDictionary = new CustomDictionary();
			rectDct.addItem( new Rectangle(1,7,561,374) );
			rectDct.addItem( new Rectangle(103,432,67,135) );
			rectDct.addItem( new Rectangle(17,585,153,33) );
			var bmd:BitmapData = drawingBoardMapSkinCont.bmd;
			var arr:Array = [
				[ 0xFFc84c0c, 0xFFcacaca ],
				[ 0xFFfcbcb0, 0xFFfdfdfd ],
				[ 0xFF000000, 0xFF8a8a8a ],
				[ 0xFF3cbcfc, 0xFFd82800 ],
				[ 0xFF80d010, 0xFFfcfcfc ],
				[ 0xFF00a800, 0xFFcacaca ]
			];
			var n:int = arr.length;
			var i:int = 0;
			for each (var rect:Rectangle in rectDct)
			{
				for (i = 0; i < n; i++) 
				{
					bmd.threshold(bmd,rect,rect.topLeft,"==",arr[i][0],arr[i][1]);
				}
			}
			
		}
		public function swapEnemyGraphics():void
		{
			prepareRecolor(drawingBoardEnemySkinCont);
		}
		public function swapInterface():void
		{
			prepareRecolor(drawingBoardInterfaceSkinCont);
			updateInterfaceItems();
			eventMngr.dispatchEvent( new Event( CustomEvents.CHANGE_INTERFACE_SKIN ) );
		}
		private function updateInterfaceItems():void
		{
			var mb:MessageBox = MessageBox.activeInstance;
			if (mb)
			{
				mb.changeBackgroundColor();
				mb.resizeBox();
			}
			TextFieldContainer.updateTfcs();
		}
		public function swapMapGraphics():void
		{
			prepareRecolor(drawingBoardMapSkinCont);
			prepareRecolor(drawingBoardThemeSkinCont);
//			if (level.background.currentMapSkin != cMapNum)
//			{
				level.background.setBackgrounds();
				level.foreground.setBackgrounds();
//			}
			level.resizeScenery();
			if (GameSettings.enemySkin == USE_MAP_SKIN_NUM)
				swapEnemyGraphics();
			if (GameSettings.interfaceSkin == USE_MAP_SKIN_NUM)
				swapInterface();
			if (GameSettings.musicType == ConsoleType.MAP || GameSettings.musicSet == MusicSets.MAP)
			{
				if (gsMngr.gameState == GameStates.PLAY)
					sndMngr.changeMusic();
				else if (gsMngr.gameState == GameStates.PAUSE)
					sndMngr.changeMusicOnResumeGame = true;
			}
			/*var tsTxt:TopScreenText = TopScreenText.instance;
			if (tsTxt)
			{
				trace("tstx before: "+tsTxt.x);
				tsTxt.scroll();
				trace("tstx after: "+tsTxt.x);
			}*/
			
		}
		private function redraw(type:int):void
		{
			var dct:Dictionary;
			var cmc:CustomMovieClip;
			var event:Event;
			if (type == TYPE_MAP)
				dct = CustomMovieClip.MAP_MASTER_OBJ_DCT;
			else if (type == TYPE_THEME)
			{
				dct = CustomMovieClip.THEME_MASTER_OBJ_DCT;
			}
			else if (type == TYPE_ENEMY)
			{
				dct = CustomMovieClip.ENEMY_MASTER_OBJ_DCT;
				event = new Event(CustomEvents.ENEMY_SKIN_CHANGE);
			}
			else if (type == TYPE_INTERFACE)
				dct = CustomMovieClip.INTERFACE_MASTER_OBJ_DCT;
			else if (type == TYPE_CHARACTER)
			{
				var charDct:CustomDictionary = level.charDct;
				dct = CustomMovieClip.CHARACTER_MASTER_OBJ_DCT;
				var ind:int;
				var charNum:int;
				if (charDct)
				{
					for each (var char:Character in charDct)
					{	
						ind = CustomMovieClip.IND_MBMDT_CHAR_NUM;
						charNum = char.charNum;
						for each (cmc in dct)
						{
							if (cmc.masterBmdType[ind] == charNum)
								cmc.markForRedraw();
						}
						char.markForRedraw();
						for each (var cmc2:CustomMovieClip in char.subMcDct)
						{
							cmc2.markForRedraw();
						}
					}
				}
				else
				{
					ind = CustomMovieClip.IND_MBMDT_CHAR_NUM;
					charNum = player.charNum;
					for each (cmc in dct)
					{
						if (cmc.masterBmdType[ind] == charNum)
							cmc.markForRedraw();
					}
				}
				player.markForRedraw();
				dct = player.subMcDct;
			}
			for each (cmc in dct)
			{
//				cmc.markForRedraw(-1,drawingBoardMapSkinCont.bmd);
				cmc.markForRedraw();
			}
			if (event)
				dispatchEvent(event);
			var parentsToCheck:Array = [ game ];
			if (level)
				parentsToCheck.push(level);
			if (TopScreenText.instance)
				parentsToCheck.push(TopScreenText.instance);
			if (LevelForeground.instance)
				parentsToCheck.push(LevelForeground.instance);
//			if (CharacterSelectBox.instance)
//				parentsToCheck = parentsToCheck.concat(CharacterSelectBox.instance.getPortraitArr());
			for (var i:int = 0; i < parentsToCheck.length; i++) 
			{
				var curParent:DisplayObjectContainer = parentsToCheck[i];
				var n:int = curParent.numChildren;
				for (var j:int = 0; j < n; j++) 
				{
					var child:DisplayObject = curParent.getChildAt(j);
					if (child is CustomMovieClip)
					{
						cmc = child as CustomMovieClip;
						if (!cmc.drawnFramesDct[cmc.currentFrame])
							cmc.gotoAndStop(cmc.currentFrame);
					}
				}
			}
		}
		public function recolorCharacterItems(char:Character):void
		{
			
		}
		public function getSkinNum(bmcType:int):int
		{
			var num:int;
			if (bmcType == TYPE_MAP || bmcType == TYPE_ENEMY || bmcType == TYPE_INTERFACE)
			{
//			do
//			{
				if (bmcType == TYPE_MAP)
					num = GameSettings.getMapSkinLimited();
				else if (bmcType == TYPE_ENEMY)
					num = GameSettings.getEnemySkinLimited();
				else if (bmcType == TYPE_INTERFACE)
					num = GameSettings.getInterfaceSkinLimited()
//				if (num >= RANDOM_SKIN_NUM)
//				{
//					if (num == RANDOM_SKIN_NUM)
//						num = GameSettings.getMapSkinLimited(true);
//					else
//						num = cMapNum;
//				}
				/*var conType:int;
				var n:int = LevelDataTranscoder.SKINS_VEC.length;
				num--; // because I add to it in a second
				do
				{
					num++
					if (num >= n || n < 0)
						num = 0;
					if (bmcType == TYPE_MAP)
						conType = BMD_VEC_MAP[num].consoleType;
					else if (bmcType == TYPE_ENEMY)
						conType = BMD_VEC_ENEMY[num].consoleType;
					else if (bmcType == TYPE_INTERFACE)
						conType = BMD_VEC_INTERFACE[num].consoleType;
				}
					while ( !skinIsActive(null,conType) )*/
			}
//			if (bmcType == TYPE_MAP)
//				trace("map num: "+num+" gamesettings: "+GameSettings.mapSkin);
			return num;
			/*else if (bmcType == TYPE_INTERFACE)
			{
				num = GameSettings.interfaceSkin;
				if (num < USE_MAP_CONSOLE_NUM_INTERFACE)
					return num;
				else
					return cMapNum;
			}*/
		}
		private function resetBmd(bmc:BmdSkinCont):void
		{
			var bmd:BitmapData = bmc.bmd;
			var srcBmc:BmdSkinCont;
			/*if (bmc == masterEnemySkinCont || bmc == masterMapSkinCont || bmc == masterInterfaceSkinCont)
				bmd = bmc.bmd.clone();
			else
				bmd = bmc.bmd;*/
			var bmcType:int = bmc.type;
//			bmd.fillRect(bmd.rect,0);
			if (bmcType == TYPE_CHARACTER)
			{
				var cn:int = bmc.charArr[0];
				if (!CLEAN_BMC_VEC_CHARACTER[cn])
					return;
				srcBmc = CLEAN_BMC_VEC_CHARACTER[cn][statMngr.getCharSkinNum(cn)];
				bmd.copyPixels( srcBmc.bmd,bmd.rect,ZERO_PNT );
				bmc.copyStatsFrom(srcBmc);
				bmc.gbPal = 0;
			}
			else
			{
				var skinNum:int;
				if (bmcType == TYPE_MAP)
				{
					skinNum = GameSettings.getMapSkinLimited(true);
					cMapNum = skinNum;
					srcBmc = CLEAN_BMD_VEC_MAP[skinNum];
					bmd.copyPixels(srcBmc.bmd,bmd.rect,ZERO_PNT);
					bmc.copyStatsFrom(srcBmc);
					bmc.gbPal = 0;
				}
				else if (bmcType == TYPE_THEME)
				{
					skinNum = GameSettings.getMapSkinLimited();
					srcBmc = CLEAN_BMD_VEC_THEME[skinNum];
//					this gets drawn in drawItems();
//					bmd.copyPixels(srcBmc.bmd,bmd.rect,ZERO_PNT);
					bmc.copyStatsFrom(srcBmc);
					bmc.gbPal = 0;
					drawItems(bmc);
				}
				else if (bmcType == TYPE_ENEMY)
				{	
					skinNum = GameSettings.getEnemySkinLimited(true);
					srcBmc = CLEAN_BMD_VEC_ENEMY[skinNum];
					bmd.copyPixels(srcBmc.bmd,bmd.rect,ZERO_PNT);
					bmc.copyStatsFrom(srcBmc);
					bmc.gbPal = 0;
					cEnemyBmc = srcBmc;
					//drawItems(bmc);
				}
				else if (bmcType == TYPE_INTERFACE)
				{
					skinNum = GameSettings.getInterfaceSkinLimited(true);
					srcBmc = CLEAN_BMC_VEC_INTERFACE[skinNum];
					bmd.copyPixels(srcBmc.bmd,bmd.rect,ZERO_PNT);
					bmc.copyStatsFrom(srcBmc);
//					masterPortraitSkinContClean.consoleType = srcBmc.consoleType; // makes portraits match interface
					bmc.gbPal = 0;
					cInterfaceBmc = srcBmc;
//					updateInterfaceItems()
//					TextFieldContainer.storeOriginalFontChars();
				}
				else if (bmcType == BmdSkinCont.TYPE_NEUTRAL)
				{
//					srcBmc = masterPortraitSkinContClean;
					bmd.copyPixels(srcBmc.bmd,bmd.rect,ZERO_PNT);
					bmc.copyStatsFrom(srcBmc);
					bmc.gbPal = 0;
				}
			}
		}
		public function prepareRecolor(bmc:BmdSkinCont,yOfsOutOvRd:int = -1,indsArr:Array = null,noGameboy:Boolean = false, noRedraw:Boolean = false):void
		{
			var bmd:BitmapData = bmc.bmd;
			if (!level)
				return;
			resetBmd(bmc);
			var yOfsOut:int;
			var mainArr:Array;
			/*if (gameboy)
			{
				recolorGbPalette(bmc);
				yOfsOut = 0;
				mainArr = GB_INFO_ARR.concat();
				var bmdRect:Rectangle = bmd.rect;
				bmdRect.y += GB_Y_OFS;
				bmdRect.height -= GB_Y_OFS;
				mainArr[0][INFO_ARR_IND_RECT_ARR] = [ bmdRect ];
				//recolorItems(bmc,mainArr,yOfsOut);
			}*/
			var bmcType:int = bmc.type;
			if (bmcType == TYPE_MAP || bmcType == TYPE_ENEMY || bmcType == TYPE_INTERFACE || bmcType == TYPE_THEME)
			{
				if (bmcType == TYPE_MAP || bmcType == TYPE_THEME)
					mainArr = MAP_INFO_ARR;
				else if (bmcType == TYPE_ENEMY)
					mainArr = ENEMY_INFO_ARR,yOfsOut;
				else if (bmcType == TYPE_INTERFACE)
					mainArr = INTERFACE_INFO_ARR;
			}
			else if (bmcType == TYPE_CHARACTER)
			{
				var cNum:int = bmc.charArr[0];
				if (yOfsOutOvRd != -1)
					yOfsOut = yOfsOutOvRd;
				else
					yOfsOut = 1;
				mainArr = CHAR_INFO_VEC[cNum];
			}
			if (mainArr)
			{
				var exportArr:Array = [];
				if (indsArr)
				{
					for each (var num:int in indsArr)
					{
						exportArr[num] = mainArr[num];
					}
				}
				else
					exportArr = mainArr;
				recolorItems(bmc,exportArr,yOfsOut);
			}
//			if (shouldBeRecoloredToGb(bmc) && !noGameboy)
//			{
//				if (!recolorGbSkin(bmc) && !noRedraw)
//					redraw(bmcType)
//			}
//			else if (!noRedraw)
			if (!noRedraw)
				redraw(bmcType);
			if (GameSettings.DEBUG_MODE && GameSettings.SHOW_BMP)
			{
				var tBmp:Bitmap = game.testBmp;
				tBmp.scaleX = 2;
				tBmp.scaleY = 2;
				tBmp.bitmapData = drawingBoardThemeSkinCont.bmd;
				tBmp.y = -40;
				if (game.contains(tBmp))
					game.removeChild(tBmp);
				game.addChild(tBmp);
			}
			if (bmc == drawingBoardMapSkinCont)
				eventMngr.dispatchEvent( new Event( CustomEvents.CHANGE_MAP_SKIN ) );
//			else if (bmc == drawingBoardInterfaceSkinCont)
				
//			/*
			//*/
		}
		public function changeActiveSkins():void
		{
//			trace("interface skin: "+GameSettings.interfaceSkin);
			var graphicsMenu:GraphicsOptions = GraphicsOptions.instance;
			if (MessageBox.activeInstance != graphicsMenu)
				graphicsMenu = null;
			if (!skinIsActive(player.currentBmdSkin))
				changeCharacterSkin(player);
			var n:int = Character.NUM_CHARACTERS;
			var cCharNum:int = player.charNum;
			for (var i:int = 0; i < n; i++) 
			{
				if ( i == cCharNum || skinIsActive(statMngr.getCurrentBmc(i) ) )
					continue;
//				var charClass:Class = CharacterInfo.getCharClassFromNum(i);
//				var char:Character = new charClass();
				player.changeChar(i);
				changeCharacterSkin(player);
//				char.destroy();
			}
			if (player.charNum != cCharNum)
				player.changeChar(cCharNum);
			if (!skinIsActive(CLEAN_BMD_VEC_MAP[GameSettings.getMapSkinLimited()]))
			{
				if (GameSettings.mapSkin <= GameSettingsValues.mapSkinLimitedMaxValue)
				{
//					if (graphicsMenu)
//						graphicsMenu.forceChooseItem(MenuBoxItems.CHANGE_MAP_SKIN);
//					else
						GameSettings.changeMapSkin(GameSettings.INCREASE_SETTING_NUM,false);
				}
				else
					swapMapGraphics();
			}
			if (!skinIsActive(cEnemyBmc))
			{
				if (GameSettings.enemySkin <= GameSettingsValues.enemySkinLimitedMaxValue)
				{
					if (graphicsMenu)
						graphicsMenu.forceChooseItem(MenuBoxItems.ENEMY_SKIN);
					else
						GameSettings.changeEnemySkin(GameSettings.INCREASE_SETTING_NUM);
				}
				else
					swapEnemyGraphics();
			}
			if (!skinIsActive(cInterfaceBmc))
			{
				if (GameSettings.interfaceSkin <= GameSettingsValues.interfaceSkinLimitedMaxValue)
				{
					if (graphicsMenu)
						graphicsMenu.forceChooseItem(MenuBoxItems.INTERFACE_SKIN);
					else
						GameSettings.changeInterfaceSkin(GameSettings.INCREASE_SETTING_NUM);
				}
				else 
					swapInterface();
			}
			sndMngr.changeMusicOnResumeGame = true;
		}
		public function skinIsActive(bmc:BmdSkinCont, conType:int = -1):Boolean
		{
			if (bmc.type != TYPE_CHARACTER && inactiveSkinNumsDct[bmc.skinNum] != undefined)
				return false;
			if (bmc.type == TYPE_CHARACTER)
				return StatManager.characterSkinIsEnabled(bmc.charNum, bmc.skinNum);
			else if (bmc.type != BmdSkinCont.TYPE_NEUTRAL && bmc.type != BmdSkinCont.TYPE_PALETTE)
				return StatManager.skinSetIsEnabled(bmc.skinNum);
			else
				return true;
//			var activeSkins:int = GameSettings.activeSkins;
//			if (activeSkins == GameSettingsValues.paletteTargetAll)
//				return bmc.type != TYPE_CHARACTER ? true : StatManager.characterSkinIsEnabled(bmc.charNum, bmc.skinNum);
//			if (bmc && conType == -1)
//				conType = bmc.consoleType;
//			if (activeSkins == GameSettingsValues.paletteTarget8Bit && ( conType == ConsoleType.GB || conType == ConsoleType.BIT_8) )
//				return bmc.type != TYPE_CHARACTER ? true : StatManager.characterSkinIsEnabled(bmc.charNum, bmc.skinNum);
////			else if (activeSkins == GameSettingsValues.paletteTargetGb && conType == ConsoleType.GB)
////				return true;
////			else if (activeSkins == GameSettingsValues.paletteTargetNes && conType == ConsoleType.BIT_8)
////				return true;
//			else if (activeSkins == GameSettingsValues.paletteTarget16Bit && conType == ConsoleType.BIT_16)
//				return bmc.type != TYPE_CHARACTER ? true : StatManager.characterSkinIsEnabled(bmc.charNum, bmc.skinNum);
//			return false;
			
		}
		public function recolorGbSkin(bmc:BmdSkinCont):Boolean
		{
			return false;
			var bmcType:int = bmc.type;
			var palNum:int = getPalNumFromType(bmcType);
			if (palNum == bmc.gbPal && shouldBeRecoloredToGb(bmc))
				return false;
//			if ( bmcType == TYPE_MAP || bmcType == TYPE_CHARACTER || bmcType == TYPE_ENEMY || bmcType == TYPE_INTERFACE || bmcType == BmdSkinCont.TYPE_NEUTRAL )
//			{
			if (bmc.gbPal != GB_PALETTE_FULL_COLOR && bmcType != TYPE_BACKGROUND)
			{
//				resetBmd(bmc);
//				if (bmcType == TYPE_CHARACTER)
					prepareRecolor(bmc,-1,null,true,true);
			}
			if (bmcType == TYPE_INTERFACE)
			{
				recolorGbSkin( masterPortraitSkinCont );
				MasterObjects.CharacterPortraitMaster.redraw();
			}
//			}
			else if (bmcType == TYPE_MAP)
			{
				if (level.background.currentMapSkin != cMapNum) // have to do this so things are done in proper order
				{
					level.background.setBackgrounds();
					level.foreground.setBackgrounds();
				}
				var bgVec:Vector.<Background> = LevelBackground.instance.BG_VEC.concat(LevelForeground.instance.BG_VEC);
				for each (var bg:Background in bgVec)
				{
					bg.activate();
					var bmcTemp:BmdSkinCont = new BmdSkinCont(bg.masterBmp,0,TYPE_BACKGROUND, null, null, bmc.consoleType); 
					recolorGbSkin( bmcTemp );
					bg.redraw();
				}
			}
			if (palNum == GB_PALETTE_FULL_COLOR)
			{
				redraw(bmcType);
				return true;
			}
			else if ( !shouldBeRecoloredToGb(bmc) )
			{
//				resetBmd(bmc);
				prepareRecolor(bmc,-1,null,true,true);
//				redraw(bmcType);
				return true;
			}
			bmc.gbPal = getPalNumFromType(bmcType);
//			trace("palNum: "+palNum+" palName: "+GameBoyPalettes.VEC[palNum]);
			var bmd:BitmapData = bmc.bmd;
			bmd.lock();
			recolorToStanGbPalette(bmd,bmd.rect);
			recolorStanGbPalToCurGbPal(bmd,bmcType);
			if (bmcType != TYPE_BACKGROUND)
				redraw(bmcType);
			bmd.unlock();
			return true;
		}
		public function readPalette(bmd:BitmapData,pnt:Point):Array
		{
			// only currently designed for standard, new palette, and continue rows
			var containerArr:Array = [];
			var inColor:uint = bmd.getPixel32(pnt.x,pnt.y);
			if (inColor != COLOR_STANDARD_PALETTE)
				throw new Error("must have standard palette");
			var numColorsPerStandardRow:int;
			var numRows:int;
			var newColorsEnd:int; // when replace colors begin, stored at end of array
			containerArr[0] = [];
			var standardRowsEnd:int;
			var i:int = 0;
			// read left column, create arrays
			while (inColor != COLOR_END)
			{
				inColor = bmd.getPixel32(pnt.x,pnt.y + i);
				if (inColor != COLOR_END && inColor != COLOR_NEW_ROW && inColor != COLOR_NEW_REGULAR_PALETTE && inColor != COLOR_NEW_FLASH_PALETTE)
				{
					standardRowsEnd = i;
				}
				containerArr[i] = [inColor];
				i++;
			}
			numRows = i - 1;
			inColor = bmd.getPixel32(pnt.x,pnt.y);
			i = 0;
			// read standard row
			while (inColor != COLOR_END)
			{
				containerArr[0][i] = inColor;
				if (inColor == COLOR_STANDARD_PALETTE && i != 0)
					newColorsEnd = i;
				i++;
				inColor = bmd.getPixel32(pnt.x + i,pnt.y);
			}
			numColorsPerStandardRow = i;
			var n:int = numRows;
			if (standardRowsEnd)
				n = standardRowsEnd;
			// read the other rows, skipping first row
			for (i = 1; i < n; i++) // i == 1 because first row is already read
			{
				for (var j:int = 0; j < numColorsPerStandardRow; j++) 
				{
					containerArr[i][j] = bmd.getPixel32(pnt.x + j,pnt.y + i);
				}
			}
			if (standardRowsEnd)
			{
				j = 1;
				inColor = bmd.getPixel32(pnt.x + j,pnt.y + i);
				for (i = standardRowsEnd; i < numRows; i++) 
				{
					while (inColor != COLOR_END)
					{
						containerArr[i][j] = inColor;
						j++;
						inColor = bmd.getPixel32(pnt.x + j,pnt.y + i);
					}
				}
			}
			containerArr.push(newColorsEnd);
			return containerArr;
		}
		public function recolorSingleBitmap(bmd:BitmapData,inPalette:Palette,outPalette:Palette,inColorRow:int = 0,outColorRow:int = 0, rect:Rectangle = null):void
		{
//			if (!palArr)
//				return;
			if (!rect)
				rect = bmd.rect;
//			if (!inColorArr || !outColorArr)
//				return;
			var n:int = inPalette.numCols;
			if (inPalette.readColor(inColorRow,0) != COLOR_STANDARD_PALETTE)
			{
				var newColorsEnd:int = inPalette.newColorsEnd; // changes length if colors are being replaced
				if (newColorsEnd > 0)
					n = newColorsEnd;
			}
			var cloneBmd:BitmapData = bmd.clone();
//			bmd.lock();
			for (var i:int = 1; i < n; i++) // starts at one because skips left column
			{
				var inColor:uint = inPalette.readColor(inColorRow,i);
				var outColor:uint = outPalette.readColor(outColorRow,i);
				var num:int = bmd.threshold(cloneBmd,rect,rect.topLeft,"==",inColor,outColor);
			}
//			bmd.unlock();
			
		}
		private function recolorItems(bmc:BmdSkinCont,mainArr:Array,yOfsOut:int = 0):void
		{
			var bmd:BitmapData = bmc.bmd;
//			var bmdClone:BitmapData = bmd.clone();
			bmd.lock();
			var n:int = mainArr.length;
			var ctr:int;
//			var bmdOvrd:BitmapData = BackgroundInfo.getSetBmdOvrd(GameSettings.getMapSkinLimited(), level.theme, Themes.set,BackgroundInfo.TYPE_MAP_OVRD );
			var paletteSheet:PaletteSheet;
			var themeType:int;
			var palRow:int;
			var palCol:int;
			var themeGroup:ThemeGroup;
			var bmcType:int = bmc.type;
			var i:int;
			if (bmcType == BmdSkinCont.TYPE_CHARACTER)
			{
				paletteSheet = BmdInfo.getCharPaletteSheet(bmc.charArr[0]);
				palRow = bmc.skinNum;
				palCol = yOfsOut;
			}
			else
			{
				paletteSheet = BmdInfo.getMainPaletteSheet( bmc.skinNum );
				if (bmcType == TYPE_MAP)
				{
					
					i = PaletteSheet.ITEM_NUM_MAP_REG_START;
					themeGroup = Themes.getMapTheme();
				}
				else if (bmcType == TYPE_THEME)
				{
					n = PaletteSheet.ITEM_NUM_MAP_REG_START;
					themeGroup = Themes.getMapTheme(true);
				}
				else if (bmcType == TYPE_ENEMY)
				{
					themeType = PaletteSheet.THEME_TYPE_ENEMY;
					themeGroup = Themes.getEnemyTheme();
				}
				else if (bmcType == TYPE_INTERFACE)
				{
					themeType = PaletteSheet.THEME_TYPE_INTERFACE;
					themeGroup = Themes.getInterfaceTheme();
				}
				palRow = themeGroup.setNum;
				palCol = themeGroup.theme;
				yOfsOut = themeGroup.theme + 1;
//				trace("recolor type: "+bmcType+" skin: "+bmc.skinNum+" row: "+palRow+" column: "+palCol+" themeType: "+themeType);
			}
			var defYOfsOut:int = yOfsOut;
			/*if (mainArr != MAP_INFO_ARR)
				bmdOvrd = null;
			else
			{
				trace("bmdOvrd: "+bmdOvrd+" theme: "+level.theme+" fakeTheme: "+fakeTheme);
			}*/
			outer: for (i; i < n; i++)
			{
				var arr:Array = mainArr[i];
				if (!arr || !arr[INFO_ARR_IND_RECOLOR])
					continue outer;
				var palette:Palette = paletteSheet.getInOutPalette(i,palRow,palCol,themeType);
				var rowColorType:uint = palette.getRowFirstColor(1); 
				if (rowColorType != COLOR_NEW_ROW && rowColorType != COLOR_NEW_REGULAR_PALETTE)
					continue outer; // only these types should be used for recoloring
				var rectArr:Array = arr[INFO_ARR_IND_RECT_ARR];
				var ovRdYOfs:* = arr[INFO_ARR_IND_OVRD_DEF_PAL];
				var ovRdYOfsNum:Number = NaN;
				if (ovRdYOfs != undefined)
					ovRdYOfsNum = int(ovRdYOfs);
				ctr = 0;
//				if (rectArr == MAP_INFO_ARR[1][1])
//					trace("break");
				var inColor:uint = palette.readColor(0,0);
				var outColor:uint = 0;
				/*var useBmdOvRd:Boolean = false;
				if (bmdOvrd)
				{
					outColor = readBmd.getPixel32(1,i);
					if (outColor != COLOR_END)
						useBmdOvRd = true;
				}
				if (!bmdOvrd && (nextRowType == COLOR_STANDARD_PALETTE || nextRowType == COLOR_END) )
					continue;*/
				yOfsOut = defYOfsOut;
				if ( !isNaN(ovRdYOfsNum) )
				{
					yOfsOut -= defYOfsOut;
					yOfsOut += ovRdYOfsNum;
				}
				outColor = 0;
				var numColors:int = palette.numCols;
				inner: for (var j:int=0; j < numColors; j++)
				{
					inColor = palette.readColor(0,j);
//					if (inColor == COLOR_END)
//						continue outer;
					if (j != 0) // not in left column
					{
						outColor = palette.readColor(1,j);
//						outColor = returnARGB( Math.round(Math.random()*0xFFFFFF) );
						for each (var rect:Rectangle in rectArr)
						{
							bmd.threshold(bmd,rect,rect.topLeft,"==",inColor,outColor);
						}
					}
					ctr++;
				}
			}
			bmd.unlock();
		}
		private function returnARGB(rgb:uint, newAlpha:int = 255):uint{
			//newAlpha has to be in the 0 to 255 range
			var argb:uint = 0;
			argb += (newAlpha<<24);
			argb += (rgb);
			return argb;
		}
		public function recolorToStanGbPalette(bmd:BitmapData,rect:Rectangle):void
		{
			var originalBmd:BitmapData = bmd.clone();
			var rect:Rectangle = bmd.rect;
			bmd.applyFilter(bmd,rect,ZERO_PNT, BW_FILTER );
			bmd.paletteMap(bmd,rect,ZERO_PNT,COL_PAL_MAP_ARRS[0],COL_PAL_MAP_ARRS[1],COL_PAL_MAP_ARRS[2]);
			for each (var color:uint in STANDARD_COL_DCT) // recolors important things
			{
				bmd.threshold(originalBmd,rect,ZERO_PNT,"==",color,color);
			}
			originalBmd.dispose();
		}
		public function recolorStanGbPalToCurGbPalSingle(bmd:BitmapData,bmcType:int,palGroup:int,palNumOvRd:int = -1):void // for small single bitmaps
		{
			var palNum:int = getPalNumFromType(bmcType);
			if (palNumOvRd >= 0)
				palNum = palNumOvRd;
			if (palNum < 2)
				return;
			var srcColorPnt:Point = new Point(2,1);
			var colorToChangePnt:Point = new Point(2,2);
			var inColor:uint;
			var outColor:uint;
			var usedPaletteVec:Vector.<int> = new Vector.<int>();
			var n:int;
			var cx:Number;
			var cy:Number;
			var rectangle:Rectangle = bmd.rect; // area to be colored over with default gameboy colors
			// convert everything to standard gameboy colors
			var palOfs:int = palNum + GB_PALETTE_OFFSET;
			var curPalGroup:int = palGroup;
			for (var i:int = 0; i < NUM_GB_COLORS_PER_GROUP; i++)
			{
				outColor = GB_PALETTE.readColor(palOfs,curPalGroup*NUM_GB_COLORS_PER_GROUP + i);
				for each (var num:int in usedPaletteVec)
				{
					inColor = GB_PALETTE.readColor(palOfs,num*NUM_GB_COLORS_PER_GROUP + i);
					bmd.threshold(bmd,rectangle,rectangle.topLeft,"==",inColor,outColor);
				}
				inColor = GB_PALETTE.readColor(0,curPalGroup*NUM_GB_COLORS_PER_GROUP + i);
				bmd.threshold(bmd,rectangle,rectangle.topLeft,"==",inColor,outColor);
			}
		}
		public function shouldBeRecoloredToGb(bmc:BmdSkinCont, conType:int = -1):Boolean
		{
			return false;
			var palTarget:int = GameSettings.paletteTarget;
			if (palTarget == GameSettingsValues.paletteTargetAll)
				return true;
			if (bmc && conType == -1)
				conType = bmc.consoleType;
			if (palTarget == GameSettingsValues.paletteTarget8Bit && ( conType == ConsoleType.GB || conType == ConsoleType.BIT_8) )
				return true;
			else if (palTarget == GameSettingsValues.paletteTargetGb && conType == ConsoleType.GB)
				return true;
			else if (palTarget == GameSettingsValues.paletteTargetNes && conType == ConsoleType.BIT_8)
				return true;
			else if (palTarget == GameSettingsValues.paletteTarget16Bit && conType == ConsoleType.BIT_16)
				return true;
			return false;
		}
		public function getGBPalette(type:int):int
		{
			switch(type)
			{
				case TYPE_ENEMY:
					return GameSettings.getEnemyPaletteLimited();
				case TYPE_CHARACTER:
					return GameSettings.getCharacterPaletteLimited();
				case TYPE_INTERFACE:
					return GameSettings.getInterfacePaletteLimited();
				default:
					return GameSettings.getMapPaletteLimited();
			}
		}
		public function getPaletteGroup(obj:Object):int
		{
			if (obj is Character || obj is SubMc || obj is Enemy)
				return GB_PAL_OBJ1;
			else if (obj is Pickup || obj is Projectile || obj is SimpleAnimatedObject)
				return GB_PAL_OBJ2;
			else if (obj is Ground || obj is Scenery)
				return GB_PAL_BG;
			return -1;
		}
		public function recolorStanGbPalToCurGbPal(bmd:BitmapData,bmcType:int):void
		{
			var palNum:int = getPalNumFromType(bmcType);
			if (palNum < 2)
				return;
			var srcColorPnt:Point = new Point(2,1);
			var colorToChangePnt:Point = new Point(2,2);
			var inColor:uint;
			var outColor:uint;
			var usedPaletteVec:Vector.<int> = new Vector.<int>();
			var i:int = -1; // because it's more accurate
			var n:int;
			var cx:Number;
			var cy:Number;
			var bmdRect:Rectangle = bmd.rect; // area to be colored over with default gameboy colors
//			bmdRect.y += GB_Y_OFS;
//			bmdRect.height -= GB_Y_OFS;
//			recolorToGbPalette(bmd,bmdRect);
			//			bmd.unlock();
			/*do // recolors everything to default gameboy colors
			{
			i++;
			cx = srcColorPnt.x;
			cy = srcColorPnt.y;
			inColor = bmd.getPixel32(cx + i,cy);
			outColor = bmd.getPixel32(cx + i, cy + 1);
			trace("in: "+getGbColor(inColor) + " out: "+outColor);
			bmd.threshold(bmd,bmdRect,bmdRect.topLeft,"==",inColor,outColor);
			//var color:uint = bmd.getPixel32(colorToChangePnt.x + i,colorToChangePnt.y);
			}
			while (inColor != 0);*/
			var infoArr:Array;
			if (bmcType == TYPE_CHARACTER)
				infoArr = CHAR_GB_INFO_VEC[statMngr.curCharNum];
			else if (bmcType == TYPE_MAP)
				infoArr = MAP_GB_INFO_ARR;
			else if (bmcType == TYPE_THEME)
				infoArr = THEME_GB_INFO_ARR;
			else if (bmcType == TYPE_ENEMY)
				infoArr = ENEMY_GB_INFO_ARR;
			else if (bmcType == TYPE_INTERFACE)
				infoArr = INTERFACE_GB_INFO_ARR;
			else if (bmcType == TYPE_BACKGROUND)
			{
				infoArr = [
					[ GB_PAL_BG ],
					[ ],
					[ ],
					[ bmdRect ]
				];
			}
			else
			{
				infoArr = [ 
					[ GB_PAL_OBJ1 ],
					[ bmdRect ],
					[ ],
					[ ]
				];
			}
			var palOrderArr:Array = infoArr[IND_BG_INFO_VEC_PAL_ORDER];
			// convert everything to standard gameboy colors
			var palOfs:int = palNum + GB_PALETTE_OFFSET;
			n = palOrderArr.length;
			for (i = 0; i < n; i++)
			{
				var curPalGroup:int = palOrderArr[i];
				var rectVec:Vector.<Rectangle> = Vector.<Rectangle>(infoArr[curPalGroup+1]);
				for each (var rectangle:Rectangle in rectVec)
				{
					for (var j:int = 0; j < NUM_GB_COLORS_PER_GROUP; j++)
					{
						outColor = GB_PALETTE.readColor(palOfs,curPalGroup*NUM_GB_COLORS_PER_GROUP + j);
						for each (var num:int in usedPaletteVec)
						{
							inColor = GB_PALETTE.readColor(palOfs, num*NUM_GB_COLORS_PER_GROUP + j);
							bmd.threshold(bmd,rectangle,rectangle.topLeft,"==",inColor,outColor);
						}
						inColor = GB_PALETTE.readColor(0, curPalGroup*NUM_GB_COLORS_PER_GROUP + j);
						bmd.threshold(bmd,rectangle,rectangle.topLeft,"==",inColor,outColor);
					}
				}
				usedPaletteVec.push(curPalGroup);
			}
		}
		public function getCurrentMapBmc():BmdSkinCont
		{
			return CLEAN_BMD_VEC_MAP[cMapNum];
		}
		public function getCurrentMapConsoleType():int
		{
			var mapBmc:BmdSkinCont = CLEAN_BMD_VEC_MAP[cMapNum];
			return mapBmc.consoleType;
		}
		public function getPalNumFromType(type:int):int
		{
			switch(type)
			{
				case TYPE_MAP:
					return GameSettings.getMapPaletteLimited();
				case TYPE_BACKGROUND:
					return GameSettings.getMapPaletteLimited();
				case TYPE_THEME:
					return GameSettings.getMapPaletteLimited();	
				case TYPE_CHARACTER:
					return GameSettings.getCharacterPaletteLimited();
				case TYPE_ENEMY:
					return GameSettings.getEnemyPaletteLimited();
				case TYPE_INTERFACE:
					return GameSettings.getInterfacePaletteLimited();
				case BmdSkinCont.TYPE_NEUTRAL:
					return GameSettings.getInterfacePaletteLimited();
			}
			return -1;
		}
		public function getFrameDelay(palette:Palette):int
		{
			var color:uint;
			var n:int = palette.numRows;
			var curCol:int;
			for (var curRow:int = 0; curRow < n; curRow++) 
			{
				color = palette.getRowFirstColor(curRow);
				if (color == COLOR_ANIM_FRAME_DELAY)
				{
					while (color != COLOR_END)
					{
						curCol++;
						color = palette.readColor(curRow,curCol);
					}
					curCol--;
					break;
				}
			}
			return curCol; 
		}
	}
}