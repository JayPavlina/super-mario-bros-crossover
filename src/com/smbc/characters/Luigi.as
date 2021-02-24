package com.smbc.characters
{
	import com.explodingRabbit.utils.CustomDictionary;
	import com.smbc.characters.base.MarioBase;
	import com.smbc.data.CharacterInfo;
	import com.smbc.data.PaletteTypes;
	import com.smbc.data.PickupInfo;
	import com.smbc.ground.SimpleGround;
	import com.smbc.level.TitleLevel;
	import com.smbc.utils.CharacterSequencer;
	
	import flash.geom.Point;
	
	public class Luigi extends MarioBase
	{
		public static const CHAR_NAME:String = CharacterInfo.Luigi[ CharacterInfo.IND_CHAR_NAME ];
		public static const CHAR_NAME_CAPS:String = CharacterInfo.Luigi[ CharacterInfo.IND_CHAR_NAME_CAPS ];
		public static const CHAR_NAME_TEXT:String = CharacterInfo.Luigi[ CharacterInfo.IND_CHAR_NAME_MENUS ];
		public static const CHAR_NUM:int = CharacterInfo.Luigi[ CharacterInfo.IND_CHAR_NUM ];
		public static const PAL_ORDER_ARR:Array = [ PaletteTypes.FLASH_POWERING_UP ];
		public static const OBTAINABLE_UPGRADES_ARR:Array = [
			[ MARIO_FIRE_FLOWER ]
		];
		public static const MUSHROOM_UPGRADES:Array = [ ];
		public static const NEVER_LOSE_UPGRADES:Array = [ ];
		public static const RESTORABLE_UPGRADES:Array = [ ];
		public static const START_WITH_UPGRADES:Array = [ ];
		public static const SINGLE_UPGRADES_ARR:Array = [ ];
		public static const REPLACEABLE_UPGRADES_ARR:Array = [ [ ] ];
		public static const TITLE_SCREEN_UPGRADES:Array = [ MUSHROOM ];
		public static const ICON_ORDER_ARR:Array = [ MARIO_FIRE_FLOWER ];
		public static const SUFFIX_VEC:Vector.<String> = Vector.<String>(["_1","_2","_2"]);
		public static const WIN_SONG_DUR:int = 5400;
		public static const CHAR_SEL_END_DUR:int = 2000;
		public static const GRAVITY:int = 1400;
		public static const JUMP_HEIGHT_MIN:int = 30;
		public static const JUMP_HEIGHT_NORMAL:int = 128;
		public static const JUMP_HEIGHT_RUN:int = 136;
		public static const JUMP_SPEED_NORMAL:int = 370;
		public static const JUMP_SPEED_RUN:int = 430;
		public static const AX_DEFAULT:int = 200;
		public static const AX_RUN:int = 285;
		public static const VY_MAX_PSV_NORMAL:int = 480;
		public static const FX_WALK:Number = 0.2;
		public static const FX_RUN_CROUCH:Number = .15;
		public static const FX_SKID:Number = 0.33; // 0.6;
		public static const SKID_THRESHOLD:int = 40;
		public static const FY:Number = 1; // 0.006
		private const CHOOSE_CHAR_SEQ:Array = [
			[1,pressRhtBtn], [67,pressAtkBtn], [120,pressJmpBtn]
		];
		public static const SKIN_PREVIEW_SIZE:Point = new Point(); // parent is used
		public static const SKIN_APPEARANCE_STATE_COUNT:int = 3;
		
		public static const SKIN_ORDER:Array = [ 
			SKIN_LUIGI_SMBDX, 
			SKIN_LUIGI_SMB_SNES, 
			SKIN_LUIGI_SMB2_NES, 
			SKIN_LUIGI_SMB2_SNES, 
			SKIN_LUIGI_SMB3_NES, 
			SKIN_LUIGI_SMB3_SNES, 
			SKIN_LUIGI_SMW_SNES, 
			SKIN_LUIGI_SML2, 
			SKIN_LUIGI_SML2_SPACE, 
			SKIN_LUIGI_SMB_NES, 
			SKIN_LUIGI_MODERN, 
			SKIN_LUIGI_X1, 
			SKIN_LUIGI_ATARI, 
			SKIN_PEACH_NES, 
			SKIN_PEACH_SNES, 
		];
		
		public static const SKIN_LUIGI_SMBDX:int = 0;
		public static const SKIN_LUIGI_SMB_SNES:int = 1;
		public static const SKIN_LUIGI_SML2:int = 2;
		public static const SKIN_LUIGI_SMB3_NES:int = 3;
		public static const SKIN_LUIGI_SMB2_NES:int = 4;
		public static const SKIN_LUIGI_SMB2_SNES:int = 5;
		public static const SKIN_LUIGI_SMW_SNES:int = 6;
		public static const SKIN_LUIGI_SMB3_SNES:int = 7;
		public static const SKIN_PEACH_NES:int = 8;
		public static const SKIN_LUIGI_ATARI:int = 9;
		public static const SKIN_PEACH_SNES:int = 10;
		public static const SKIN_LUIGI_X1:int = 11;
		public static const SKIN_LUIGI_SML2_SPACE:int = 12;
		public static const SKIN_LUIGI_SMB_NES:int = 13;
		public static const SKIN_LUIGI_MODERN:int = 14;
		
		public static const SPECIAL_SKIN_NUMBER:int = SKIN_LUIGI_X1;
		public static const ATARI_SKIN_NUMBER:int = SKIN_LUIGI_ATARI;
		
//		public static const SKIN_MAMA_NES:int = 12;
//		public static const SKIN_LINA_NES:int = 13;
//		public static const SKIN_MILON_NES:int = 14;

		public function Luigi()
		{
			inheritedForceShortClassName = "Mario";
			super();
		}
		override public function chooseCharacter():void
		{
			super.chooseCharacter();
			var seq:CharacterSequencer = new CharacterSequencer();
			seq.startNewSequence(CHOOSE_CHAR_SEQ);
			var curY:int = GLOB_STG_BOT - TILE_SIZE*7;
			var endY:int = GLOB_STG_BOT - TILE_SIZE*2;
			var groundX:Number = level.getNearestGrid( player.nx + TILE_SIZE*3,-1);
			var groundDct:CustomDictionary = new CustomDictionary(true);
			while (curY != endY)
			{
				var brick:SimpleGround = new SimpleGround(SimpleGround.BN_BLOCK);
				brick.x = groundX;
				brick.y = curY;
				level.addToLevel(brick);
				curY += TILE_SIZE;
				groundDct.addItem(brick);
			}
			level.addObj();
			for each (brick in groundDct)
			{
				brick.checkNearbyGround();
			}
		}
		
		override protected function changeAppearance(forceAppearanceNum:int = -1, forcePalCol:int = -1):void
		{
			super.changeAppearance(forceAppearanceNum, forcePalCol);
			if (level is TitleLevel)
			{
				SKIN_PREVIEW_SIZE.x = SKIN_PREVIEW_SIZE_SMALL.x;
				SKIN_PREVIEW_SIZE.y = SKIN_PREVIEW_SIZE_SMALL.y;
			}
			else if (appearanceNum == APPEARANCE_NUM_SMALL)
			{
				SKIN_PREVIEW_SIZE.x = SKIN_PREVIEW_SIZE_SMALL.x;
				SKIN_PREVIEW_SIZE.y = SKIN_PREVIEW_SIZE_SMALL.y;
			}
			else
			{
				SKIN_PREVIEW_SIZE.x = SKIN_PREVIEW_SIZE_BIG.x;
				SKIN_PREVIEW_SIZE.y = SKIN_PREVIEW_SIZE_BIG.y;
			}
		}
	}
}