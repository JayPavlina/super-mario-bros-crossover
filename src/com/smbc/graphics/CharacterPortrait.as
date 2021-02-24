package com.smbc.graphics
{
	import com.explodingRabbit.display.CustomMovieClip;
	import com.explodingRabbit.utils.CustomDictionary;
	import com.smbc.characters.Character;
	import com.smbc.data.CharacterInfo;
	import com.smbc.data.GameSettings;
	import com.smbc.data.PickupInfo;
	import com.smbc.graphics.BmdInfo;
	import com.smbc.graphics.BmdSkinCont;
	import com.smbc.level.CharacterSelect;
	import com.smbc.main.SkinObj;
	import com.smbc.managers.GraphicsManager;
	import com.smbc.managers.StatManager;
	import com.smbc.messageBoxes.CharacterSelectBox;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class CharacterPortrait extends Sprite
	{
		private static const ICON_PNT:Point = new Point(2,2);
		private static const SPACE_BTW_ICONS:int = 16;
		private static const NUM_ICONS_PER_ROW:int = 3;
		private static const MAX_ICONS:int = 9;
		private static const ICON_FRAME_OFS:int = 1;
		private static const ICON_INVISIBLE_FRAME_NUM:int = Character.PS_NORMAL + ICON_FRAME_OFS;
		private static const PORT_X_OFS:int = 2;
//		private static const FRAME_X_OFS:int = -2;
		private const PS_ICON:PStateIcon = new PStateIcon();
		private static const TYPE_RANDOM:String = "random";
		private static const TYPE_MAP_SKIN:String = "mapSkin";
		private static const FL_PORTRAIT:String = "portrait";
		private static const FL_MAP_SKIN:String = "mapSkin";
		private var frame:CustomMovieClip;
		public var portrait:CustomMovieClip;
		private var showIcon:Boolean;
		private var type:String;
		public var recoloredSprite:Sprite;
		private var iconVec:Vector.<UpgradeIcon> = new Vector.<UpgradeIcon>();
		private var charNum:int;
		
		public function CharacterPortrait(charNum:int)
		{
			super();
			this.charNum = charNum;
			if (charNum >= 0)
			{
//				var gm:GraphicsManager = GraphicsManager.INSTANCE;
//				var charBmc:BmdSkinCont = gm.masterCharSkinVec[charNum];
//				if ( gm.shouldBeRecoloredToGb(charBmc) )
//					gm.recolorGbSkin(charBmc);
				type = StatManager.STAT_MNGR.convNumToName(charNum);
//				var skinNum:int = StatManager.STAT_MNGR.getCharSkinNum(charNum);
//				var bmc:BmdSkinCont = GraphicsManager.INSTANCE.drawingBoardCharSkinVec[charNum];
//				if (bmc.skinNum != skinNum)
//					GraphicsManager.INSTANCE.prepareRecolor(bmc);
				portrait = new CustomMovieClip(null, null, CharacterInfo.getCharClassName(charNum) + "Icon");
			}
			else if (charNum == CharacterSelectBox.RANDOM_CHAR_NUM)
			{
				type = TYPE_RANDOM;
				portrait = new CustomMovieClip(null,null,"PortraitSelector");
			}
			else if (charNum == CharacterSelectBox.MAP_SKIN_CHAR_NUM)
			{
				type = TYPE_MAP_SKIN;
				portrait = new CustomMovieClip(null,null,"PortraitSelector");
			}
			if (portrait)
			{
				portrait.gotoAndStop(FL_PORTRAIT);
				portrait.x = PORT_X_OFS;
				portrait.y = PORT_X_OFS;
				addChild(portrait);
			}
			if (charNum == CharacterSelectBox.MAP_SKIN_CHAR_NUM)
				portrait.gotoAndStop(FL_MAP_SKIN);
			setType();
			PS_ICON.x = ICON_PNT.x;
			PS_ICON.y = ICON_PNT.y;
			x = PORT_X_OFS;
			y = PORT_X_OFS;
		}
		public function getPortraitBmpSprite():Sprite
		{
			recoloredSprite = new Sprite();
			addChildAt(recoloredSprite,1);
			recoloredSprite.addChild(portrait);
			return recoloredSprite;
		}
		public function setIconVisibility(visibility:Boolean):void
		{
			if (PS_ICON.currentFrame == ICON_INVISIBLE_FRAME_NUM)
				PS_ICON.visible = false;
			else
				PS_ICON.visible = visibility;
			showIcon = visibility;
//			if (frame)
//				trace("frame: "+frame+" visible :"+frame.visible+" parent: "+frame.parent.getChildIndex(frame));
		}
		
		public function update():void
		{
			portrait.gotoAndStop(portrait.currentFrame);
		}
		
		public function setIconPState(pState:int):void
		{
			PS_ICON.gotoAndStop(pState + ICON_FRAME_OFS);
			if (PS_ICON.currentFrame == ICON_INVISIBLE_FRAME_NUM)
				PS_ICON.visible = false;
			else if (showIcon)
				PS_ICON.visible = true;
		}
		public function updateUpgIcons():void
		{
			while (iconVec.length)
			{
				iconVec[0].destroy();
				iconVec.shift();
			}
			var statMngr:StatManager = StatManager.STAT_MNGR;
			var iconOrderVec:Vector.<String> = statMngr.getIconOrderVec(charNum);
			var obtainedItemsDct:CustomDictionary = statMngr.getObtainedUpgradesDct(charNum);
			var forceName:String = CharacterInfo.getCharClassName(charNum) + "Icon";
			var curCol:int = -1;
			var curRow:int;
			var n:int = iconOrderVec.length;
			for (var i:int = 0; i < n; i++) 
			{
				if (i == MAX_ICONS)
					break;
				var upgradeName:String = iconOrderVec[i];
				if ( obtainedItemsDct[upgradeName] )
				{
					var icon:UpgradeIcon = new UpgradeIcon(upgradeName,forceName);
					iconVec.push( icon );
					curCol++;
					if (curCol == NUM_ICONS_PER_ROW)
					{
						curCol = 0;
						curRow++;
					}
					icon.x = ICON_PNT.x + SPACE_BTW_ICONS*curCol;
					icon.y = ICON_PNT.y + SPACE_BTW_ICONS*curRow;
					trace("curCol: "+curCol+" curRow: "+curRow);
					addChild(icon);
				}
			}
		}
		public function setType():void
		{
			if (type != TYPE_RANDOM)
			{
//				addChild(PS_ICON);
//				updateUpgIcons();
			}
			frame = new CustomMovieClip(null,null,"PortraitSelector");
			addChildAt(frame,0);
			frame.gotoAndStop(PortraitSelector.FL_FRAME);
		}
		
	}
}