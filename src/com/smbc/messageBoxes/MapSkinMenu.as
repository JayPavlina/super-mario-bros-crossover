package com.smbc.messageBoxes
{
	import com.explodingRabbit.cross.games.Game;
	import com.explodingRabbit.display.CustomMovieClip;
	import com.smbc.data.GameSettings;
	import com.smbc.data.MusicType;
	import com.smbc.data.SoundNames;
	import com.smbc.graphics.BmdInfo;
	import com.smbc.graphics.BmdSkinCont;
	import com.smbc.graphics.GridItem;
	import com.smbc.graphics.fontChars.FontCharMenu;
	import com.smbc.main.GlobVars;
	import com.smbc.managers.GraphicsManager;
	import com.smbc.managers.SoundManager;
	import com.smbc.managers.StatManager;
	
	import flash.display.Bitmap;
	import flash.geom.Point;
	
	public class MapSkinMenu extends GridMenuBox
	{
		private static const SPACE_BETWEEN_ITEMS:int = 8;
		public function MapSkinMenu(isDisableMenu:Boolean = false)
		{
			super(isDisableMenu);
		}
		
		override public function initiate():void
		{
			super.initiate();
			setSelection( getItemFromSkinNum(GameSettings.getMapSkinLimited()), false);
		}
		override protected function setUpBorder():void
		{
			spaceBetweenItemsX = SPACE_BETWEEN_ITEMS;
			spaceBetweenItemsY = SPACE_BETWEEN_ITEMS;
			itemWidth = BmdInfo.MAP_SKIN_PREVIEW_RECTANGLE.width * GlobVars.SCALE + GlobVars.SCALE*2;
			itemHeight = BmdInfo.MAP_SKIN_PREVIEW_RECTANGLE.height * GlobVars.SCALE + GlobVars.SCALE*2;
			super.setUpBorder();
		}
		
		
		override protected function setUpBitmaps():void
		{
//			for each( var skinPreview:CustomMovieClip in BmdInfo.getMapSkinPreviews() )
			var mapSkinPreviews:Vector.<CustomMovieClip> = BmdInfo.getMapSkinPreviews();
			for ( var i:int = 0; i < mapSkinPreviews.length; i++)
			{
				var skinPreview:CustomMovieClip = mapSkinPreviews[i];
				var gridItem:GridItem = new GridItem();
				gridItem.image = skinPreview;
				gridItem.borderImage = new Bitmap(border);
				gridItem.skinNum = items.length;
				items.push(gridItem)	
			}
			sortItems();
		}
		
		override protected function sortItems():void
		{
			var actualOrder:Vector.<int> = Vector.<int>(BmdInfo.MAIN_SKIN_ORDER);
			var newOrder:Vector.<GridItem> = new Vector.<GridItem>();
			var graphicsManager:GraphicsManager = GraphicsManager.INSTANCE;
			for each (var skinNum:int in actualOrder)
			{
				if (isDisableMenu || graphicsManager.skinIsActive( graphicsManager.CLEAN_BMD_VEC_MAP[skinNum] ) )
				{
					var gridItem:GridItem = getItemFromSkinNum(skinNum);
					newOrder.push(gridItem);
					if (isDisableMenu && !StatManager.skinSetIsEnabled(skinNum) )
						desaturate(gridItem);
				}
			}
			items = newOrder;
		}
		
		override protected function setSelection(newItem:GridItem, playSound:Boolean=true):void
		{
			super.setSelection(newItem, playSound);
//			GameSettings.changeMapSkin(currentItem.skinNum, false);
			updateText();
		}
		
		override protected function generateTopText():String
		{
			var game:Game = GraphicsManager.INSTANCE.CLEAN_BMD_VEC_MAP[currentItem.skinNum].games[BmdSkinCont.IND_GAME_SOURCE];
			if (game.shortName != null)
				return game.shortName;
			else
				return game.fullName;
		}
		
//		override protected function reachedMaxSize():void
//		{
//			super.reachedMaxSize();
//			setSelection( getItemFromSkinNum(0), false);
//		}
		
		override protected function setUpText():void
		{
			bottomTfc = null;
			super.setUpText();
		}
		
		override protected function updateFontColor():void
		{
			if ( StatManager.skinSetIsEnabled(currentItem.skinNum) )
				topTfc.changeType(FontCharMenu.TYPE_NORMAL);
			else
				topTfc.changeType(FontCharMenu.TYPE_DISABLED);
		}
		
		private function pressedChooseSkinButton(randomSkin:Boolean):void
		{
			var lastRandomMapSkinSetting:Boolean = GameSettings.randomMapSkin;
			if (characterSelect)
			{
				if (randomSkin && !GameSettings.randomMapSkin)
					GameSettings.randomMapSkin = true;
				
				GameSettings.changeMapSkin(currentItem.skinNum, false);
				
				if (GameSettings.randomMapSkin != lastRandomMapSkinSetting)
					GameSettings.randomMapSkin = lastRandomMapSkinSetting;
				
				nextMsgBxToCreate = new CharacterSelectBox();
				SoundManager.SND_MNGR.changeMusic(MusicType.CHAR_SEL);
				cancel();
			}
			else if (isDisableMenu)
			{
				if ( StatManager.skinSetIsEnabled(currentItem.skinNum) && StatManager.enabledSkinSetCount == 1)
					return; // don't allow disabling all skins
				
				StatManager.toggleSkinSetEnabled(currentItem.skinNum);
				if ( StatManager.skinSetIsEnabled(currentItem.skinNum) )
					resaturate(currentItem);
				else
					desaturate(currentItem);
				//				SoundManager.SND_MNGR.playSoundNow(SoundNames.SFX_GAME_COIN);
				updateFontColor();
			}
			else
			{
				if (randomSkin && !GameSettings.randomMapSkin)
					GameSettings.randomMapSkin = true;
				
				GameSettings.changeMapSkin(currentItem.skinNum, false);
				
				if (GameSettings.randomMapSkin != lastRandomMapSkinSetting)
					GameSettings.randomMapSkin = lastRandomMapSkinSetting;
				nextMsgBxToCreate = new GraphicsOptions(GraphicsOptions.lastIndex);
				cancel();
			}
			
			SoundManager.SND_MNGR.playSoundNow(SoundNames.SFX_GAME_COIN);
		}
		
		override public function pressJmpBtn():void
		{
			pressedChooseSkinButton(false);
		}
		override public function pressSpcBtn():void
		{
			if (!isDisableMenu)
				pressedChooseSkinButton(true);
		}
	
		override public function pressAtkBtn():void
		{
			if (characterSelect != null)
				nextMsgBxToCreate = new CharacterSelectBox();
			else if (isDisableMenu)
			{
				nextMsgBxToCreate = new DisableSkinsMenu(DisableSkinsMenu.lastIndex);
			}
			else
				nextMsgBxToCreate = new GraphicsOptions(GraphicsOptions.lastIndex);
			SoundManager.SND_MNGR.playSoundNow(SoundNames.SFX_GAME_HIT_CEILING);
			cancel();
		}
		
		override public function cancel():void
		{
			super.cancel();
			if (isDisableMenu)
				GraphicsManager.INSTANCE.changeActiveSkins();
		}
		
	}
}