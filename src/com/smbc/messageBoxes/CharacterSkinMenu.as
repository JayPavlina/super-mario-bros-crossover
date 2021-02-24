package com.smbc.messageBoxes
{
	import com.explodingRabbit.cross.games.Game;
	import com.explodingRabbit.display.CustomMovieClip;
	import com.smbc.characters.Character;
	import com.smbc.data.CharacterInfo;
	import com.smbc.data.GameStates;
	import com.smbc.data.SoundNames;
	import com.smbc.graphics.BmdSkinCont;
	import com.smbc.graphics.GridItem;
	import com.smbc.graphics.GridSelector;
	import com.smbc.graphics.fontChars.FontChar;
	import com.smbc.graphics.fontChars.FontCharMenu;
	import com.smbc.level.CharacterSelect;
	import com.smbc.level.Level;
	import com.smbc.main.GlobVars;
	import com.smbc.managers.GameStateManager;
	import com.smbc.managers.GraphicsManager;
	import com.smbc.managers.SoundManager;
	import com.smbc.managers.StatManager;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;

	public class CharacterSkinMenu extends GridMenuBox
	{
		private var charNum:int;
		private var player:Character;
		private var initialSkinNum:int;
		private var skinDescriptionBox:SkinDescriptionBox;
		
		public function CharacterSkinMenu(charNum:int, isDisableMenu:Boolean = false)
		{
			this.charNum = charNum;
			super(isDisableMenu);
			if (Level.levelInstance != null)
				player = Level.levelInstance.player;
			initialSkinNum = STAT_MNGR.getCharSkinNum(charNum);
		}
		
		override protected function setUpBorder():void
		{
			var size:Point = Character.getSkinPreviewSize(charNum);
			itemWidth = size.x + GlobVars.SCALE*2;
			itemHeight = size.y + GlobVars.SCALE*2;
			super.setUpBorder();
		}
		
		override protected function setUpBitmaps():void
		{
			for each( var skinPreview:CustomMovieClip in Character.getSkinPreviews(charNum) )
			{
				var gridItem:GridItem = new GridItem();
				gridItem.image = skinPreview;
				gridItem.borderImage = new Bitmap(border);
				gridItem.skinNum = items.length;
				items.push(gridItem)	
			}
			sortItems();
		}
		
		override public function initiate():void
		{
			super.initiate();
			skinDescriptionBox = new SkinDescriptionBox();
			skinDescriptionBox.initiate();
//			if (isDisableMenu)
//				skinDescriptionBox.visible = false;
			var item:GridItem = items[0];
			if (player.charNum == charNum)
			{
				item = getItemFromSkinNum(player.skinNum);
				if (item == null)
					item = items[0];
			}
			setSelection( item, false);
		}
		
		override protected function setSelection(newItem:GridItem, playSound:Boolean = true):void
		{
			if (currentItem != null)
				currentItem.image.visible = true;
			super.setSelection(newItem, playSound);
			
			if (player != null && !isDisableMenu)
			{
//				currentItem.image.visible = false;
//				var positionLocal:Point = selector.localToGlobal( new Point() );
				if (playSound)
					GraphicsManager.INSTANCE.changeCharacterSkin(player, currentItem.skinNum);
//				player.x = positionLocal.x + selector.width/2;
//				player.y = positionLocal.y + selector.height - 4;
//				characterSelect.lockPlayerPosition = new Point(player.x, player.y);
			}
			updateText();
			skinDescriptionBox.updateText();
		}
		
		override protected function sortItems():void
		{
			var actualOrder:Vector.<int> = Character.getSkinOrderVec(charNum);
			var newOrder:Vector.<GridItem> = new Vector.<GridItem>();
			var graphicsManager:GraphicsManager = GraphicsManager.INSTANCE;
			for each (var skinNum:int in actualOrder)
			{
//				trace( "skinNum: " + skinNum + " enabled: " + graphicsManager.skinIsActive( graphicsManager.CLEAN_BMC_VEC_CHARACTER[charNum][skinNum] ) );
				
				if ( isDisableMenu || graphicsManager.skinIsActive( graphicsManager.CLEAN_BMC_VEC_CHARACTER[charNum][skinNum] ) )
				{
					var gridItem:GridItem = getItemFromSkinNum(skinNum);
					newOrder.push(gridItem);
					if (isDisableMenu && !StatManager.characterSkinIsEnabled(charNum, skinNum) )
						desaturate(gridItem);
				}
			}
			items = newOrder;
		}
		
		override protected function updateFontColor():void
		{
			if ( StatManager.characterSkinIsEnabled(charNum, currentItem.skinNum) )
			{
				topTfc.changeType(FontCharMenu.TYPE_NORMAL);
				bottomTfc.changeType(FontCharMenu.TYPE_NORMAL);
			}
			else
			{
				topTfc.changeType(FontCharMenu.TYPE_DISABLED);
				bottomTfc.changeType(FontCharMenu.TYPE_DISABLED);
			}
		}
		
		override protected function generateTopText():String
		{
			var skinName:String = null;
			var nameArr:Array = STAT_MNGR.getBmc(charNum, currentItem.skinNum).namesArr;
			if (nameArr != null)
				skinName = nameArr[BmdSkinCont.IND_NAME_ARR_FULL];
			if (skinName == null)
				skinName = CharacterInfo.CHAR_ARR[charNum][CharacterInfo.IND_CHAR_NAME_FULL];
			return skinName;
		}
		
		override protected function generateBottomText():String
		{
//			STAT_MNGR.getc
			var game:Game = STAT_MNGR.getBmc(charNum, currentItem.skinNum).games[BmdSkinCont.IND_GAME_SOURCE];
			if (game.shortName != null)
				return game.shortName;
			else
				return game.fullName;
		}
		
		private function pressedChooseSkinButton(randomSkin:Boolean):void
		{
			if (characterSelect)
			{
				if (randomSkin)
					GraphicsManager.INSTANCE.changeCharacterSkin(characterSelect.player, GraphicsManager.CHAR_SKIN_NUM_RANDOM);
				characterSelect.chooseCharacter( charNum );
				cancel();
			}
			else if (isDisableMenu)
			{
				if ( StatManager.characterSkinIsEnabled(charNum, currentItem.skinNum) && StatManager.getEnabledCharacterSkinCount(charNum) == 1)
					return; // don't allow disabling all skins
				
				StatManager.toggleCharacterSkinEnabled(charNum, currentItem.skinNum);
				if ( StatManager.characterSkinIsEnabled(charNum, currentItem.skinNum) )
					resaturate(currentItem);
				else
					desaturate(currentItem);
				SoundManager.SND_MNGR.playSoundNow(SoundNames.SFX_GAME_COIN);
				updateFontColor();
			}
			else
			{
				if (randomSkin && player != null)
					GraphicsManager.INSTANCE.changeCharacterSkin(player, GraphicsManager.CHAR_SKIN_NUM_RANDOM);
				nextMsgBxToCreate = new GraphicsOptions(GraphicsOptions.lastIndex);
				SoundManager.SND_MNGR.playSoundNow(SoundNames.SFX_GAME_COIN);
				SoundManager.SND_MNGR.changeMusicOnResumeGame = true;
				cancel();
			}	
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
		
		override public function pressPseBtn():void
		{
			if (!isDisableMenu && GameStateManager.GS_MNGR.gameState == GameStates.PAUSE && currentItem.skinNum != initialSkinNum)
				GraphicsManager.INSTANCE.changeCharacterSkin(player, initialSkinNum);
			super.pressPseBtn();
		}
		
		override public function pressAtkBtn():void
		{
			if (characterSelect != null)
			{
				nextMsgBxToCreate = new CharacterSelectBox();
//				if (currentItem.skinNum != initialSkinNum)
//					GraphicsManager.INSTANCE.changeCharacterSkin(player, initialSkinNum);
			}
			else if (isDisableMenu)
			{
				nextMsgBxToCreate = new CharacterSelectBox(false, charNum);
				nextMsgBxToCreate.nextMsgBxToCreate = new DisableSkinsMenu(DisableSkinsMenu.lastIndex);
			}
			else
			{
				nextMsgBxToCreate = new GraphicsOptions(GraphicsOptions.lastIndex);
				if (currentItem.skinNum != initialSkinNum)
					GraphicsManager.INSTANCE.changeCharacterSkin(player, initialSkinNum);
			}
			SoundManager.SND_MNGR.playSoundNow(SoundNames.SFX_GAME_HIT_CEILING);
			cancel();
		}
		
		override public function cancel():void
		{
			super.cancel();
			if (skinDescriptionBox != null)
				skinDescriptionBox.cancel();
		}
	}
}