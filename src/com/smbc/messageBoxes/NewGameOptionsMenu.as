package com.smbc.messageBoxes
{
	import com.explodingRabbit.cross.data.ConsoleType;
	import com.smbc.characters.Character;
	import com.smbc.data.CampaignModes;
	import com.smbc.data.Difficulties;
	import com.smbc.data.GameBoyPalettes;
	import com.smbc.data.GameSettings;
	import com.smbc.data.GameSettingsValues;
	import com.smbc.data.MapDifficulty;
	import com.smbc.data.MapPack;
	import com.smbc.enums.PowerupMode;
	import com.smbc.graphics.SkinNames;
	import com.smbc.graphics.fontChars.FontCharMenu;
	import com.smbc.level.Level;
	import com.smbc.level.TitleLevel;
	import com.smbc.managers.GraphicsManager;
	import com.smbc.managers.ScreenManager;
	import com.smbc.text.TextFieldContainer;
	
	public class NewGameOptionsMenu extends SettingsMenuBox
	{
		public static var instance:NewGameOptionsMenu;
		private var disableChooseItemSnd:Boolean;
		private static var customizeWeaponsIndex:int;
//		private var gameDifficultyToSet:int;
//		private var mapDifficultyToSet:int;
//		private var mapPackToSet:int;
		
		public function NewGameOptionsMenu(selectorStartIndex:int = 0)
		{
//			gameDifficultyToSet = GameSettings.difficulty;
//			mapDifficultyToSet = GameSettings.mapDifficulty;
//			mapPackToSet = GameSettings.mapPack;
			super( loadItems(), selectorStartIndex );
			instance = this;
			MSG_BX_MNGR.writeNextMainMenu(this);
		}
		private function loadItems():Array
		{
			var arr:Array = [
				[ MenuBoxItems.MAP_PACK, GameSettings.mapPack.NiceName ],
				[ MenuBoxItems.MAP_DIFFICULTY, MapDifficulty.swapNumAndName(GameSettings.mapDifficulty) ],
//				[ MenuBoxItems.MAP_SKIN, SkinNames.getName(GameSettings.mapSkin) ],
				[ MenuBoxItems.GAME_MODE, CampaignModes.swapNumAndName(GameSettings.campaignMode) ],
				[ MenuBoxItems.POWERUP_MODE, GameSettings.powerupMode.NiceName ],
//				[ MenuBoxItems.GAME_DIFFICULTY, Difficulties.swapNumAndName(gameDifficultyToSet) ],
//				[ MenuBoxItems.TUTORIALS,GameSettings.tutorials ],
				[ MenuBoxItems.CUSTOMIZE_WEAPONS ],
				[ MenuBoxItems.MORE_DIFFICULTY_SETTINGS ],
				[ MenuBoxItems.FULL_SCREEN_MODE ],
				[ MenuBoxItems.START_GAME ]
			];
			for (var i:int = 0; i < arr.length; i++)
			{
				if (arr[i][0] == MenuBoxItems.CUSTOMIZE_WEAPONS)
				{
					customizeWeaponsIndex = i;
					break;
				}
			}
			return arr;
		}
		
		override public function initiate():void
		{
			super.initiate();
			updateCustomizeWeaponsEnabled();
		}
		
		private function updateCustomizeWeaponsEnabled():void
		{
			if (_cSelNum == customizeWeaponsIndex)
				return;
			
			var tfc:TextFieldContainer = getTfc(customizeWeaponsIndex);
			if (GameSettings.classicMode)
				tfc.changeType(FontCharMenu.TYPE_NORMAL);
			else
				tfc.changeType(FontCharMenu.TYPE_DISABLED);
		}
		
		override protected function setNewSelection(nSelNum:int):void
		{
			if (!GameSettings.classicMode)
			{
				if (nSelNum == customizeWeaponsIndex)
				{
					if (_cSelNum == customizeWeaponsIndex - 1)
						nSelNum = customizeWeaponsIndex + 1;
					else if (_cSelNum == customizeWeaponsIndex + 1)
						nSelNum = customizeWeaponsIndex - 1;
				}
			}
			super.setNewSelection(nSelNum);
		}
		
		override protected function chooseItem(itemName:String, itemValue:String, itemTfc:TextFieldContainer, gsOvRdNum:int):void
		{
			var newValueStr:String;
			switch(itemName)
			{
				case MenuBoxItems.MAP_PACK:
				{	
					GameSettings.mapPack = GameSettings.mapPack.GetAtIndex(gsOvRdNum) as MapPack;
					newValueStr = GameSettings.mapPack.NiceName;
					break;
				}
				case MenuBoxItems.GAME_MODE:
				{
					newValueStr = GameSettings.changeCampaignMode(gsOvRdNum);
					break;
				}
//				case MenuBoxItems.GAME_DIFFICULTY:
//				{
//					GameSettings.changeDifficulty(gsOvRdNum);
//					newValueStr = Difficulties.swapNumAndName(gameDifficultyToSet);
//					break;
//				}
				case MenuBoxItems.MAP_DIFFICULTY:
				{
					GameSettings.changeMapDifficulty(gsOvRdNum);
					newValueStr = MapDifficulty.swapNumAndName(GameSettings.mapDifficulty);
					break;
				}
				case MenuBoxItems.POWERUP_MODE:
				{
					GameSettings.powerupMode = GameSettings.powerupMode.GetAtIndex(gsOvRdNum) as PowerupMode;
					newValueStr = GameSettings.powerupMode.NiceName;
					updateCustomizeWeaponsEnabled();
					break;
				}
				case MenuBoxItems.CUSTOMIZE_WEAPONS:
				{
					nextMsgBxToCreate = new CustomizeWeaponsMenu();
					nextMsgBxToCreate.nextMsgBxToCreate = new NewGameOptionsMenu(_cSelNum);
					cancel();
					break;
				}
				case MenuBoxItems.FULL_SCREEN_MODE:
				{
					tryEnterFullScreen();
					break;
				}
				case MenuBoxItems.MORE_DIFFICULTY_SETTINGS:
				{
//					if (GameSettings.powerupMode == PowerupMode.Classic)
//						nextMsgBxToCreate = new ClassicSettingsMenu();
//					else
					nextMsgBxToCreate = new DifficultySettingsMenu();
					nextMsgBxToCreate.nextMsgBxToCreate = new NewGameOptionsMenu(_cSelNum);
					cancel();
					break;
				}
				case MenuBoxItems.CHANGE_MAP_SKIN:
				{
					GameSettings.changeMapSkin(gsOvRdNum);
					newValueStr = SkinNames.getName(GameSettings.mapSkin);
					break;
				}	
				case MenuBoxItems.TUTORIALS:
				{
					GameSettings.changeTutorials();
					newValueStr = convertToOnOffStr(GameSettings.tutorials);
					break;
				}
				case MenuBoxItems.START_GAME:
				{
					if (GameSettings.campaignMode != CampaignModes.SINGLE_CHARACTER_RANDOM)
						ScreenManager.SCRN_MNGR.forceShowCharacterSelectScreen = true;
					nextMsgBxToCreate = null;
					cancel();
					if (GameSettings.classicMode)
						GameSettings.startWithMushroom = false;
					EVENT_MNGR.startNewGame();
					break;
				}
				case MenuBoxItems.CANCEL:
				{
					cancel();
					break;
				}
			}
			afterChooseItem(itemName, newValueStr, itemTfc, disableChooseItemSnd);
			disableChooseItemSnd = false;
		}
		public function forceChooseItem(name:String):void
		{
			var n:int = ARR_VEC.length;
			var num:int;
			for (var i:int = 0; i < n; i++) 
			{
				var itemName:String = ARR_VEC[i][IND_ARR_VEC_NAME];
				if (name == itemName)
				{
					num = i;
					break;
				}
			}
			var value:String = ARR_VEC[num][IND_ARR_VEC_VALUE];
			var tfc:TextFieldContainer = ARR_VEC[num][IND_ARR_VEC_TEXT_FIELD] as TextFieldContainer;
			disableChooseItemSnd = true;
			chooseItem(name, value, tfc, GameSettings.INCREASE_SETTING_NUM);
		}
		override public function pressAtkBtn():void
		{
//			MSG_BX_MNGR.writeNextMainMenu(this);
			cancel();
			SND_MNGR.playSoundNow(SN_CANCEL_ITEM);
		}
		override protected function destroy():void
		{
			super.destroy();
			instance = null;
		}
	}
}