package com.smbc.messageBoxes
{
	import com.explodingRabbit.cross.data.ConsoleType;
	import com.smbc.characters.Character;
	import com.smbc.data.GameBoyPalettes;
	import com.smbc.data.GameSettings;
	import com.smbc.data.GameSettingsValues;
	import com.smbc.graphics.SkinNames;
	import com.smbc.level.Level;
	import com.smbc.level.TitleLevel;
	import com.smbc.managers.GraphicsManager;
	import com.smbc.managers.ScreenManager;
	import com.smbc.managers.StatManager;
	import com.smbc.text.TextFieldContainer;

	public class GraphicsOptions extends SettingsMenuBox
	{
		public static var instance:GraphicsOptions;
		private var disableChooseItemSnd:Boolean;
		public static var lastIndex:int;
		
		public function GraphicsOptions(selectorStartIndex:int = 0)
		{
			super( loadItems(), selectorStartIndex );
			instance = this;
			nextMsgBxToCreate = new OptionsMenu(OptionsMenu.lastIndex);
			alwaysResizeWhenOptionsChanged = true;
		}
		private function loadItems():Array
		{
			var arr:Array = [
//				[MenuBoxItems.CHANGE_CHAR_SKIN],
				[MenuBoxItems.CHANGE_MAP_SKIN  ],
				[MenuBoxItems.DISABLE_SKINS],
				[MenuBoxItems.RANDOM_MAP_SKIN, GameSettings.randomMapSkin ],
				[MenuBoxItems.ENEMY_SKIN, SkinNames.getName(GameSettings.enemySkin) ],
				[MenuBoxItems.INTERFACE_SKIN, SkinNames.getName(GameSettings.interfaceSkin) ],
				[ MenuBoxItems.BACK ]
			];
			var changeMapSkinIndex:int = 0;
			if ( !(Level.levelInstance is TitleLevel) && StatManager.getEnabledCharacterSkinCount(StatManager.STAT_MNGR.curCharNum) > 1 )
			{
				arr.splice(0, 0, [ MenuBoxItems.CHANGE_CHAR_SKIN ]); // adds change char skin to index in first parameter
				changeMapSkinIndex = 1;
			}
			if (StatManager.enabledSkinSetCount == 1)
			{
				arr.splice(changeMapSkinIndex, 1); // removes change map skin, first parameter should be its index
			}
			return arr;
		}
		override protected function chooseItem(itemName:String, itemValue:String, itemTfc:TextFieldContainer, gsOvRdNum:int):void
		{
			var newValueStr:String;
			lastIndex = cSelNum;
			switch(itemName)
			{
				case MenuBoxItems.LIMIT_SKINS:
				{
					newValueStr = GameSettingsValues.numToName( GameSettingsValues.PALETTE_TARGET_PREFIX, GameSettings.changeActiveSkins(gsOvRdNum) );
					break;
				}
				case MenuBoxItems.CHANGE_MAP_SKIN:
				{
					if (GameSettings.randomMapSkin)
					{
						nextMsgBxToCreate = new PlainMessageBox(MessageBoxMessages.CANNOT_CHANGE_MAP_SKIN);
						nextMsgBxToCreate.nextMsgBxToCreate = new GraphicsOptions(selectorStartIndex);
					}
					else
						nextMsgBxToCreate = new MapSkinMenu();
					cancel();
					break;
				}	
				case MenuBoxItems.ENEMY_SKIN:
				{
					GameSettings.changeEnemySkin(gsOvRdNum);
					newValueStr = SkinNames.getName(GameSettings.enemySkin);
					break;
				}
				case MenuBoxItems.INTERFACE_SKIN:
				{
					GameSettings.changeInterfaceSkin(gsOvRdNum);
					newValueStr = SkinNames.getName(GameSettings.interfaceSkin);
					break;
				}
				case MenuBoxItems.RANDOM_MAP_SKIN:
				{
					GameSettings.randomMapSkin = !GameSettings.randomMapSkin;
					newValueStr = convertToOnOffStr(GameSettings.randomMapSkin);
					break;
				}
				case MenuBoxItems.CHANGE_CHAR_SKIN:
				{
					var player:Character;
					if (Level.levelInstance)
						player = Level.levelInstance.player;
					if (player)
					{
						nextMsgBxToCreate = new CharacterSkinMenu(player.charNum);
						cancel();
//						GraphicsManager.INSTANCE.changeCharacterSkin(player);
//						SND_MNGR.changeMusicOnResumeGame = true;
					}
					break;
				}
				case MenuBoxItems.DISABLE_SKINS:
				{
					nextMsgBxToCreate = new DisableSkinsMenu();
					cancel();
					break;
				}
//				case MenuBoxItems.GAME_BOY_FILTER:
//				{
//					GameSettings.changeGameBoyFilter();
//					newValueStr = convertToOnOffStr(GameSettings.gameBoyFilter);
//					break;
//				}
				case MenuBoxItems.PALETTE_TARGET:
				{
					GameSettings.changePaletteTarget(gsOvRdNum);
					newValueStr = GameSettingsValues.numToName( GameSettingsValues.PALETTE_TARGET_PREFIX,GameSettings.paletteTarget );
					break;
				}
				case MenuBoxItems.MAP_PALETTE:
				{
					GameSettings.changeMapPalette(gsOvRdNum);
					newValueStr = GameBoyPalettes.VEC[GameSettings.mapPalette];
					break;
				}
				case MenuBoxItems.CHARACTER_PALETTE:
				{
					GameSettings.changeCharacterPalette(gsOvRdNum);
					newValueStr = GameBoyPalettes.VEC[GameSettings.characterPalette];
					break;
				}
				case MenuBoxItems.ENEMY_PALETTE:
				{
					GameSettings.changeEnemyPalette(gsOvRdNum);
					newValueStr = GameBoyPalettes.VEC[GameSettings.enemyPalette];
					break;
				}
				case MenuBoxItems.INTERFACE_PALETTE:
				{
					GameSettings.changeInterfacePalette(gsOvRdNum);
					newValueStr = GameBoyPalettes.VEC[GameSettings.interfacePalette];
					break;
				}
				case MenuBoxItems.BACK:
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
		override protected function destroy():void
		{
			super.destroy();
			instance = null;
		}
		
		
	}
}