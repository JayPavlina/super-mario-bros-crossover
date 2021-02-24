package com.smbc.messageBoxes
{
	import com.explodingRabbit.cross.games.Game;
	import com.explodingRabbit.display.CustomMovieClip;
	import com.smbc.characters.Bass;
	import com.smbc.characters.Character;
	import com.smbc.data.CharacterInfo;
	import com.smbc.data.GameSettings;
	import com.smbc.data.GameStates;
	import com.smbc.data.SoundNames;
	import com.smbc.enums.ScrollingIndicatorDirection;
	import com.smbc.graphics.BmdInfo;
	import com.smbc.graphics.BmdSkinCont;
	import com.smbc.graphics.GridItem;
	import com.smbc.graphics.GridSelector;
	import com.smbc.graphics.Palette;
	import com.smbc.graphics.ScrollingIndicator;
	import com.smbc.graphics.fontChars.FontCharMenu;
	import com.smbc.interfaces.IKeyPressable;
	import com.smbc.level.CharacterSelect;
	import com.smbc.main.GlobVars;
	import com.smbc.managers.GameStateManager;
	import com.smbc.managers.GraphicsManager;
	import com.smbc.managers.SoundManager;
	import com.smbc.managers.StatManager;
	import com.smbc.text.TextFieldContainer;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextFormatAlign;

	public class GridMenuBox extends MessageBox
	{
		// preview image
//		private static const PREVIEW_SPACE_BETWEEN_ITEMS_X:int = 1;
//		private static const PREVIEW_SPACE_BETWEEN_ITEMS_Y:int = 1;
//		private static const PREVIEW_MARGIN_X:int = 1;
//		private static const PREVIEW_MARGIN_Y:int = 1;
		
		
		private static const TOP_LEFT_BORDER_POSITION_INTERFACE_SHEET:Point = new Point(178,70);
		private static const BORDER_SPACE_BETWEEN_ITEMS:int = 2;
		private static const VERTICAL_SPACE_FOR_PORTRAITS_LIMIT:int = 132 * 2;
		
		private static const MAX_WIDTH_FOR_ROW:Number = 420;
//		private static const MIN_WIDTH:Number = 300;
		private static const Y_POS:Number = 512/2;
		protected var spaceBetweenItemsX:int = 4;
		protected var spaceBetweenItemsY:int = 4;
		
		private static const NAME_BOX_WIDTH:int = 300;
		private static const NAME_BOX_HEIGHT:int = 150;
		public static const NAME_BOX_Y_POS:int = 396;
		private static const ITEMS_MARGIN_X:int = 0; // ScrollingIndicator.MAX_WIDTH;
		private static const ITEMS_MARGIN_Y:int = 32;
		private static const BOTTOM_TEXT_MARGIN:int = 16;
		
		protected static const STAT_MNGR:StatManager = StatManager.STAT_MNGR;
		
		public static var instance:GridMenuBox;
		
		protected var topTfc:TextFieldContainer = new TextFieldContainer(FontCharMenu.FONT_NUM);
		protected var bottomTfc:TextFieldContainer = new TextFieldContainer(FontCharMenu.FONT_NUM, FontCharMenu.TYPE_SELECTED);
		
		protected var border:BitmapData;
		protected var itemWidth:int;
		protected var itemHeight:int;
		protected var itemsPerRowCount:int;
		protected var rowCount:int;
		protected var items:Vector.<GridItem> = new Vector.<GridItem>();
//		private var interfaceBitmapData:BitmapData;
		protected var selector:GridSelector;
		protected var currentItem:GridItem;
		protected var characterSelect:CharacterSelect;
//		private var nameBox:CharNameBox;
		
		private var itemContainerMaskLayer:Sprite;
		private var itemContainerMask:Sprite;
		private var itemContainer:Sprite;

		private var itemContainerMaskRectangle:Rectangle;
		
		private var scrollingIndicatorBottomLeft:ScrollingIndicator;
		private var scrollingIndicatorBottomRight:ScrollingIndicator;
		private var scrollingIndicatorTopLeft:ScrollingIndicator;
		private var scrollingIndicatorTopRight:ScrollingIndicator;
		private var coloredBackground:Bitmap;
		protected var isDisableMenu:Boolean;
		private var unpauseGameOnDestroy:Boolean;
		
		public function GridMenuBox(isDisableMenu:Boolean = false)
		{
			super();
			this.isDisableMenu = isDisableMenu;
			instance = this;
			if (CharacterSelect.instance != null)
				characterSelect = CharacterSelect.instance;
			setUpBorder();
			setUpBitmaps();
			endYPos = Y_POS;
		}
		
		protected function setUpBorder():void
		{
			border = GridSelector.drawBorder(itemWidth / GlobVars.SCALE, itemHeight / GlobVars.SCALE, TOP_LEFT_BORDER_POSITION_INTERFACE_SHEET, BORDER_SPACE_BETWEEN_ITEMS, GraphicsManager.INSTANCE.drawingBoardInterfaceSkinCont.bmd);
		}
		
		protected function setUpBitmaps():void
		{
			sortItems();
		}
		
		
		protected function setUpScrollingIndicators():void
		{
			// bottom left
			scrollingIndicatorBottomLeft = new ScrollingIndicator(ScrollingIndicatorDirection.Down);
			scrollingIndicatorBottomLeft.y = itemContainerMaskRectangle.height + ITEMS_MARGIN_Y + BOTTOM_TEXT_MARGIN; //+ ScrollingIndicator.MAX_HEIGHT/2;
			scrollingIndicatorBottomLeft.x += ScrollingIndicator.MAX_WIDTH/2;
			TXT_CONT.addChild(scrollingIndicatorBottomLeft);
			
			// bottom right
			scrollingIndicatorBottomRight = new ScrollingIndicator(ScrollingIndicatorDirection.Down);
			scrollingIndicatorBottomRight.y = scrollingIndicatorBottomLeft.y;
			scrollingIndicatorBottomRight.x += itemContainerMaskRectangle.width + ITEMS_MARGIN_X*2 - ScrollingIndicator.MAX_WIDTH/2;
			TXT_CONT.addChild(scrollingIndicatorBottomRight);
			
			// top left
			scrollingIndicatorTopLeft = new ScrollingIndicator(ScrollingIndicatorDirection.Up);
			scrollingIndicatorTopLeft.x += scrollingIndicatorBottomLeft.x;
			scrollingIndicatorTopLeft.y = ScrollingIndicator.MAX_HEIGHT;
			TXT_CONT.addChild(scrollingIndicatorTopLeft);
			
			// top right
			scrollingIndicatorTopRight = new ScrollingIndicator(ScrollingIndicatorDirection.Up);
			scrollingIndicatorTopRight.x += scrollingIndicatorBottomRight.x;
			scrollingIndicatorTopRight.y = scrollingIndicatorTopLeft.y;
			TXT_CONT.addChild(scrollingIndicatorTopRight);
		}
		
		protected function sortItems():void
		{
			
		}
		
		protected function getItemFromSkinNum(skinNum:int):GridItem
		{
			for each (var item:GridItem in items)
			{
				if (item.skinNum == skinNum)
					return item;
			}
			return null;
		}
		
		private function isEmpty(bitmapData:BitmapData):Boolean
		{
			var bounds:Rectangle = bitmapData.getColorBoundsRect(0xFF000000, 0, false);
			return bounds.width == 0 && bounds.height == 0; 
		}
		
		override public function initiate():void
		{
			super.initiate();
//			if (characterSelect != null)
//				characterSelect.addChild(this);
//			updateText();
			endYPos = GlobVars.STAGE_HEIGHT/2;
		}
		
		
		
		
		override protected function setUpText():void
		{
			var itemCount:int = items.length;
			itemsPerRowCount = Math.floor( MAX_WIDTH_FOR_ROW / (itemWidth + spaceBetweenItemsX) );
			rowCount = Math.ceil(itemCount / itemsPerRowCount);
			var i:int = 0;
			
			itemContainerMaskLayer = new Sprite();
			itemContainer = new Sprite();
			TXT_CONT.addChild(itemContainerMaskLayer);
			itemContainerMaskLayer.addChild(itemContainer);
			itemContainerMaskLayer.x = ITEMS_MARGIN_X;
			itemContainerMaskLayer.y = ITEMS_MARGIN_Y;
			
			var bottomRightMaskPosition:Point = new Point();
			itemContainerMaskRectangle = new Rectangle();
			
			outer: for (var row:int = 0; row < rowCount; row++)
			{
				inner: for (var column:int = 0; column < itemsPerRowCount; column++)
				{
					var gridItem:GridItem = items[i++];
					gridItem.x = column * (itemWidth + spaceBetweenItemsX);
					gridItem.y = row * (itemHeight + spaceBetweenItemsY);
					gridItem.row = row;
					gridItem.column = column;
					if (gridItem.y + itemHeight <= VERTICAL_SPACE_FOR_PORTRAITS_LIMIT)
						itemContainerMaskRectangle.bottom = gridItem.y + itemHeight;
					if (gridItem.x + itemWidth > itemContainerMaskRectangle.right)
						itemContainerMaskRectangle.right = gridItem.x + itemWidth;
//					trace("gridItemy: "+gridItem.y+" rect: "+maskRect);
//					TXT_CONT.addChild(gridItem);
					itemContainer.addChild(gridItem);
					if (i == items.length)
						break outer;
				}
			}
			
			itemContainerMask = new Sprite();
			itemContainerMask.graphics.beginFill(0xFFFFFF);
			itemContainerMask.graphics.drawRect(itemContainerMaskRectangle.x, itemContainerMaskRectangle.y, itemContainerMaskRectangle.width, itemContainerMaskRectangle.height);
			itemContainerMask.graphics.endFill();
//			itemContainerMaskLayer.addChild(itemContainerMask);
//			itemContainerMaskLayer.mask = itemContainerMask;
//			itemContainerMaskRectangle = itemContainerMask.getBounds(itemContainer);
//			trace("bounds: "+itemContainerMaskRectangle);
			for each( var item:GridItem in items)
			{
				if (!itemContainerMaskRectangle.contains(item.x, item.y) && item.parent)
					item.parent.removeChild(item);
			}
//			itemContainerMaskLayer.addChild(itemContainerMask);
//			itemContainer.mask = itemContainerMask;
//			itemContainer.mask.x = maskRect.x;
//			itemContainer.mask.y = maskRect.y;
			
			selector = new GridSelector(itemWidth / GlobVars.SCALE, itemHeight / GlobVars.SCALE);
//			TXT_CONT.addChild(selector);
			itemContainer.addChild(selector);
			if (bottomTfc != null)
			{
				bottomTfc.y = itemContainerMaskRectangle.bottom + ITEMS_MARGIN_Y + BOTTOM_TEXT_MARGIN;
				TXT_CONT.addChild(bottomTfc);
				bottomTfc.text = "Castlevania: Dracula XXX";
			}
			if (topTfc != null)
			{
				TXT_CONT.addChild(topTfc);
				topTfc.text = "Castlevania: Dracula XXX";
			}
			TXT_CONT.x = CONTAINER_PADDING;
			TXT_CONT.y = CONTAINER_PADDING;
			setUpScrollingIndicators();
		}
		
		protected function setSelection(newItem:GridItem, playSound:Boolean = true):void
		{

			currentItem = newItem;
			selector.x = newItem.x;
			selector.y = newItem.y;

			if (!itemContainerMaskRectangle.contains(selector.x, selector.y + itemContainer.y) )
			{
				if (selector.y + itemContainer.y < itemContainerMaskRectangle.top) // above
					itemContainer.y = -currentItem.y; // keeps selector at top
				else
					itemContainer.y = -currentItem.y + (rowsThatFitOnScreenCount - 1) * (itemHeight + spaceBetweenItemsY);
				
				for each( var item:GridItem in items)
				{
					if ( !itemContainerMaskRectangle.contains(item.x, item.y + itemContainer.y) )
					{
						if ( itemContainer.contains(item) )
							itemContainer.removeChild(item);
					}
					else
						itemContainer.addChild(item);
					itemContainer.setChildIndex(selector, itemContainer.numChildren - 1);
				}
			}
			
//			if (getItemAt(0, rowCount - 1).parent != null)
//			{
//				if ( TXT_CONT.contains(scrollingIndicatorBottomRight) )
//					TXT_CONT.removeChild(scrollingIndicatorBottomRight);
//			scrollingIndicatorBottomLeft.stopAnim = true;
//					scrollingIndicatorBottomRight.visible = false;
//			}
//			else
//				scrollingIndicatorBottomRight.visible = true;
			scrollingIndicatorBottomLeft.visible = scrollingIndicatorBottomRight.visible = (getItemAt(0, rowCount - 1).parent == null);
			scrollingIndicatorTopLeft.visible = scrollingIndicatorTopRight.visible = (getItemAt(0, 0).parent == null);
			
			
			if (playSound)
				SoundManager.SND_MNGR.playSoundNow(SoundNames.SFX_GAME_CHARACTER_SELECT_CURSOR);
//			else
//			{
//				drawBackground();
//			}
			
//			updateText();
		}
		
		private function toARGB(rgb:uint, newAlpha:int = 255):uint
		{
			var argb:uint = 0;
			argb = (rgb);
			argb += (newAlpha<<24);
			return argb;
		}
		
		private function drawBackground():void
		{
			makeBackgroundTransparent();
			var bmdWidth:int = TXT_CONT.width;
			var bmdHeight:int = TXT_CONT.height;
			var bmd:BitmapData = new BitmapData(bmdWidth, bmdHeight, true, toARGB( getBackgroundColor() ) );
			
			for each(var item:GridItem in items)
			{
				if (item.visible)
				{
					bmd.fillRect(new Rectangle(item.x + GlobVars.SCALE, item.y + ITEMS_MARGIN_Y + GlobVars.SCALE, item.image.width, item.image.height), 0);
//					makeAreaTransparent(  );
				}
			}
			TXT_CONT.addChildAt( new Bitmap(bmd), 0);
//			for (var y:int = 0; y < height; y++)
//			{
//				for (var x:int = 0; x < width; x++)
//				{
//					var position:Point = topLeftPixelLocation.clone();
//					if (x == width - 1)
//						position.x += spaceBetweenPixelsOnReferenceSheet*2;
//					else if (x != 0)
//						position.x += spaceBetweenPixelsOnReferenceSheet;
//					if (y == height - 1)
//						position.y += spaceBetweenPixelsOnReferenceSheet*2;
//					else if (y != 0)
//						position.y += spaceBetweenPixelsOnReferenceSheet;
//					bitmapData.setPixel32( x, y, referenceBitmapData.getPixel32(position.x, position.y) );
//				}
//			}
		}
		
		private function get rowsThatFitOnScreenCount():int
		{
			var count:int = 0;
			while ( count * (itemHeight + spaceBetweenItemsY) < itemContainerMaskRectangle.height)
				count++;
			trace("rows that fit on screen: "+count);
			return count;
		}
		
		protected function generateTopText():String
		{
			return null;
		}
		
		protected function generateBottomText():String
		{
			return null;
		}
		
		protected function updateText():void
		{
			var topString:String = generateTopText();
			var bottomString:String = generateBottomText();
			
			if (topTfc != null && topString != null)
			{
				topTfc.text = topString;
//				shrinkTextToFit(topTfc);
				topTfc.x = bg.width/2 - (topTfc.width*.5);
			}
			
			if (bottomTfc != null && bottomString != null)
			{
				bottomTfc.text = bottomString;
//				shrinkTextToFit(bottomTfc);
				bottomTfc.x = bg.width/2 - (bottomTfc.width*.5);
			}
			updateFontColor();
		}
		
		protected function updateFontColor():void
		{
	
		}
		
		private function shrinkTextToFit(textFieldContainer:TextFieldContainer):void
		{
			while (textFieldContainer.width > bg.width - ScrollingIndicator.MAX_WIDTH*2)
			{
				var text:String = textFieldContainer.text;
				var lastSpaceIndex:int = text.lastIndexOf(" "); 
//				if (text.charAt(text.length - 5) == " ")
//					textFieldContainer.text = text.substr(0, text.length - 5) + "..."; // takes off a space
//				else
					textFieldContainer.text = text.substr(0, lastSpaceIndex - 1) + "...";
			}
		}
		
		private function modifySelection(columnOffset:int, rowOffset:int):void
		{
			var newColumn:int = currentItem.column + columnOffset;
			var newRow:int = currentItem.row + rowOffset;
			var newItem:GridItem = getItemAt(newColumn, newRow);
			if (newItem != null)
				setSelection(newItem);
			else
			{
				if (columnOffset != 0)
				{
					if (columnOffset < 0)
						newColumn = getItemCountInRow(newRow) - 1;
					else
						newColumn = 0;
				}
				else if (rowOffset != 0)
				{
					if (rowOffset < 0)
					{
						newRow = getItemCountInColumn(newColumn) - 1;
						if (newRow != rowCount - 1)
						{
							newRow = rowCount - 1;
							newItem = getItemAt( getItemCountInRow(newRow) - 1, newRow );
							setSelection(newItem);
							return;
						}
					}
					else
					{
						if (newRow < rowCount)
						{
							newItem = getItemAt( getItemCountInRow(newRow) - 1, newRow );
							setSelection(newItem);
							return;
						}
						else
							newRow = 0;
					}
				}
				newItem = getItemAt(newColumn, newRow);
				if (newItem != null)
					setSelection(newItem);
				else
					setSelection(currentItem);
			}
		}
		
		private function getItemAt(column:int, row:int):GridItem
		{
			for each(var item:GridItem in items)
			{
				if (item.column == column && item.row == row)
					return item;
			}
			return null;
		}
		
		private function getItemCountInRow(row:int):int
		{
			var counter:int = 0;
			for each(var item:GridItem in items)
			{
				if (item.row == row)
					counter++;
			}
			return counter;
		}
		
		protected function desaturate(item:GridItem):void
		{
			var mc:Sprite = item.getBmpSprite();
			if (mc)
			{
				var matrix:Array = [];
				matrix = matrix.concat([0.3, 0.59, 0.11, 0, -10]);  // red
				matrix = matrix.concat([0.3, 0.59, 0.11, 0, -10]);  // green
				matrix = matrix.concat([0.3, 0.59, 0.11, 0, -10]);  // blue
				matrix = matrix.concat([0,   0,    0,    1, 0]);  // alpha
				
				var cmFilter:ColorMatrixFilter = new ColorMatrixFilter(matrix);
				mc.filters = [cmFilter];
			}
		}
		protected function resaturate(item:GridItem):void
		{
			if (item.recoloredSprite)
				item.recoloredSprite.filters = [];
		}
		
		private function getItemCountInColumn(column:int):int
		{
			var counter:int = 0;
			for each(var item:GridItem in items)
			{
				if (item.column == column)
					counter++;
			}
			return counter;
		}
		
		override public function pressUpBtn():void
		{
			modifySelection(0, -1);
		}
		
		override public function pressDwnBtn():void
		{
			modifySelection(0, 1);
		}
		
		override public function pressLftBtn():void
		{
			modifySelection(-1, 0);
		}
		
		override public function pressRhtBtn():void
		{
			modifySelection(1, 0);	
		}
		
		
//		override public function pressAtkBtn():void
//		{
//			
//		}
		
		override public function pressSpcBtn():void
		{
			
		}
		
		override public function pressPseBtn():void
		{
			if (GameStateManager.GS_MNGR.gameState == GameStates.PAUSE)
			{
				cancel();
				nextMsgBxToCreate = null;
				unpauseGameOnDestroy = true;
				if (isDisableMenu)
					GraphicsManager.INSTANCE.changeActiveSkins();
			}
		}
		
		override protected function destroy():void
		{
			super.destroy();
			instance = null;
			if (unpauseGameOnDestroy)
				EVENT_MNGR.unpauseGame();
		}

		override public function cancel():void
		{
			super.cancel();
//			nameBox.cancel();
		}
	}
}