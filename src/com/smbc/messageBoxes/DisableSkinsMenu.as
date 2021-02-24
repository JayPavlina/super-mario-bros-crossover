package com.smbc.messageBoxes
{
	import com.smbc.managers.GraphicsManager;
	import com.smbc.managers.StatManager;
	import com.smbc.text.TextFieldContainer;

	public class DisableSkinsMenu extends SettingsMenuBox
	{
		public static var lastIndex:int;
		
		public function DisableSkinsMenu(selectorStartIndex:int = 0)
		{
			super(loadItems(), selectorStartIndex);
			nextMsgBxToCreate = new GraphicsOptions(GraphicsOptions.lastIndex);
		}
		
		private function loadItems():Array
		{
			return [
				[MenuBoxItems.DISABLE_CHARACTER_SKINS], // change DISABLE_CHARACTER_SKINS_INDEX if you move this
				[MenuBoxItems.DISABLE_MAP_SKINS],
				[MenuBoxItems.ENABLE_ALL_SKINS],
				[MenuBoxItems.BIT_8_ONLY],
				[MenuBoxItems.BIT_16_ONLY],
				[MenuBoxItems.GB_ONLY],
				[MenuBoxItems.CLASSIC],
				[MenuBoxItems.CLASSIC_16_BIT],
				[MenuBoxItems.SHARP_X1_ONLY],
				[MenuBoxItems.ATARI_ONLY],
				[MenuBoxItems.BACK]
			];
		}
		
		override protected function chooseItem(itemName:String, itemValue:String, itemTfc:TextFieldContainer, gsOvRdNum:int):void
		{
			var newValueStr:String;
			lastIndex = cSelNum;
			switch(itemName)
			{
				case MenuBoxItems.DISABLE_CHARACTER_SKINS:
				{
					nextMsgBxToCreate = new CharacterSelectBox();
					nextMsgBxToCreate.nextMsgBxToCreate = new DisableSkinsMenu(lastIndex);
					cancel();
					break;
				}
				case MenuBoxItems.DISABLE_MAP_SKINS:
				{
					nextMsgBxToCreate = new MapSkinMenu(true);
					nextMsgBxToCreate.nextMsgBxToCreate = new DisableSkinsMenu(lastIndex);
					cancel();
					break;
				}
				case MenuBoxItems.ENABLE_ALL_SKINS:
				{
					StatManager.enableAllSkinsExceptInvisible();
					break;	
				}
				case MenuBoxItems.BIT_8_ONLY:
				{
					StatManager.enable8BitSkinsOnly();
					GraphicsManager.INSTANCE.changeActiveSkins();
					break;	
				}
				case MenuBoxItems.BIT_16_ONLY:
				{
					StatManager.enable16BitSkinsOnly();
					GraphicsManager.INSTANCE.changeActiveSkins();
					break;	
				}
				case MenuBoxItems.GB_ONLY:
				{
					StatManager.enableGameBoySkinsOnly();
					GraphicsManager.INSTANCE.changeActiveSkins();
					break;	
				}
				case MenuBoxItems.ATARI_ONLY:
				{
					StatManager.enableAtariSkinsOnly();
					GraphicsManager.INSTANCE.changeActiveSkins();
					break;	
				}
				case MenuBoxItems.SHARP_X1_ONLY:
				{
					StatManager.enableSharpX1SkinsOnly();
					GraphicsManager.INSTANCE.changeActiveSkins();
					break;	
				}
				case MenuBoxItems.CLASSIC:
				{
					StatManager.enableClassicSkinsOnly();
					GraphicsManager.INSTANCE.changeActiveSkins();
					break;	
				}
				case MenuBoxItems.CLASSIC_16_BIT:
				{
					StatManager.enableClassic16BitSkinsOnly();
					GraphicsManager.INSTANCE.changeActiveSkins();
					break;	
				}
				case MenuBoxItems.BACK:
				{
					cancel();
					break;
				}
			}
			afterChooseItem(itemName, newValueStr, itemTfc);
//			disableChooseItemSnd = false;
		}
		
		override public function cancel():void
		{
			super.cancel();
			if (nextMsgBxToCreate is GraphicsOptions)
				nextMsgBxToCreate = new GraphicsOptions(GraphicsOptions.lastIndex);
		}
	}
}