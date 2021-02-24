package com.smbc.level
{
	import com.smbc.SuperMarioBrosCrossover;
	import com.smbc.data.GameSettings;
	import com.smbc.data.Themes;
	import com.smbc.graphics.Background;
	import com.smbc.graphics.BackgroundInfo;
	import com.smbc.graphics.ThemeGroup;
	import com.smbc.graphics.TopScreenText;
	import com.smbc.managers.GraphicsManager;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class LevelGraphicLayerContainer extends Sprite
	{
		public var BG_VEC:Vector.<Background> = new Vector.<Background>();
		protected var level:Level;
		protected var type:String;
		public var currentMapSkin:int;
		private static var offset:Number = 0;
		public function LevelGraphicLayerContainer(level:Level)
		{
			super();
			this.level = level;
			if (GameSettings.DEBUG_MODE)
				addEventListener(MouseEvent.CLICK, clickHandler);
		}
		private function clickHandler(event:MouseEvent):void
		{
			if (level)
				level.clickLsr(event);
		}
		
		public function setBackgrounds():void
		{
			// remove old backgrounds in they exist
			var n:int = BG_VEC.length;
			for (var i:int = 0; i < n; i++)
			{
				var bg:Background = BG_VEC[i];
				bg.deactivate();
			}
			offset = 0;
			var themeGroup:ThemeGroup = Themes.getMapTheme();
			BG_VEC = Vector.<Background>( BackgroundInfo.getBgSetItem(GameSettings.getMapSkinLimited(),themeGroup.theme,themeGroup.setNum,type) ).concat();
			currentMapSkin = GraphicsManager.INSTANCE.cMapNum;
			n = BG_VEC.length;
			for (i = 0; i < n; i++)
			{
				bg = BG_VEC[i];
				bg.x = 0;
				bg.y = 0;
				addChildAt(bg,i);
			}
			if (level.player)
			{
				x = 0;
				level.scrollScreen();
				for each (bg in BG_VEC)
				{
					bg.activate();
				}
			}
		}
		public function setOffset():void
		{
			for each (var bg:Background in BG_VEC)
			{
				bg.bgXAtTeleport = bg.x;
				bg.getNewLevelX = true;
			}
		}
		public function initiateLevelHandler():void
		{
			for each (var bg:Background in BG_VEC)
			{
				bg.activate();
			}
			offset = 0;
		}
		public function scroll():void
		{
			for each (var bg:Background in BG_VEC)
			{
				var bgOfs:Number = level.x*bg.scrollSpeed;
				if (bg.getNewLevelX)
				{
					bg.levelXAfterTeleport = bgOfs;
					bg.getNewLevelX = false;
				}
				if (bg.bgXAtTeleport == 0)
					bg.x = bgOfs;
				else
					bg.x = bg.bgXAtTeleport - (bg.levelXAfterTeleport - bgOfs);
				bg.checkIfNeedsExtension();
//				bg.y = level.y*ss;
			}
		}
		public function destroy():void
		{
			var n:int = BG_VEC.length;
			for (var i:int = 0; i < n; i++)
			{
				var bg:Background = BG_VEC[i];
				bg.deactivate();
			}
			var game:SuperMarioBrosCrossover = SuperMarioBrosCrossover.game;
			if (parent)
				parent.removeChild(this);
			if (GameSettings.DEBUG_MODE)
				removeEventListener(MouseEvent.CLICK, clickHandler);
		}
	}
}