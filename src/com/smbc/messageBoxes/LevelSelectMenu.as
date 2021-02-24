package com.smbc.messageBoxes
{
	import com.smbc.data.GameSettings;
	import com.smbc.data.LevelID;
	import com.smbc.data.MapDifficulty;
	import com.smbc.data.MapPack;
	import com.smbc.data.SoundNames;
	import com.smbc.level.Level;
	import com.smbc.managers.LevelDataManager;
	import com.smbc.managers.ScreenManager;
	import com.smbc.text.TextFieldContainer;
	
	import flash.text.TextField;

	public class LevelSelectMenu extends SettingsMenuBox
	{
//		private const WORLD_NUM_MAX:int = 8;
		private const WORLD_NUM_MIN:int = 1;
		private const LEV_NUM_MAX:int = 4;
		private const LEV_NUM_MIN:int = 1;
		private const LEV_SEP:String = "-";
		private const AREA_STR:String = "a";
		private static const WORLD_IND:int = 2;
		private static const LEV_IND:int = WORLD_IND + 1;
		private static const GO_TO_LEVEL_IND:int = LEV_IND + 1;
		private static const BACK_TO_CHEAT_MENU_IND:int = 5;
		private var worldNum:int;
		private var levNum:int;
		private var level:Level = Level.levelInstance;
		private var strVec:Vector.<String> = new Vector.<String>();
		private var mapPackToSet:MapPack;
		private var mapDifficultyToSet:int;
		
		public function LevelSelectMenu()
		{
			if (level)
			{
				worldNum = level.worldNum;
				levNum = level.levNum;
			}
			mapPackToSet = GameSettings.mapPack;
			if (worldNum < WORLD_NUM_MIN || worldNum > worldNumberMax)
				worldNum = worldNumberMax;
			if (levNum < LEV_NUM_MIN || levNum > LEV_NUM_MAX)
				levNum = LEV_NUM_MIN;
			mapDifficultyToSet = GameSettings.mapDifficulty;
			super(loadItems());
			nextMsgBxToCreate = new CheatMenu();
			strVec = null;
		}
		override public function initiate():void
		{
			super.initiate();
			updateGoToWorldText();
//			var tf:TextFieldContainer = ARR_VEC[GO_TO_LEVEL_IND][IND_ARR_VEC_TEXT_FIELD] as TextFieldContainer;
//			tf.text = MenuBoxItems.GO_TO_WORLD + VALUE_SEP + LevelID.ToDisplay(worldNum) + LEV_SEP + levNum.toString();
		}
		private function loadItems():Array
		{
			return [
			[ MenuBoxItems.MAP_PACK, mapPackToSet.NiceName ],
			[ MenuBoxItems.MAP_DIFFICULTY, MapDifficulty.swapNumAndName(mapDifficultyToSet) ],
			[ MenuBoxItems.WORLD_NUMBER, LevelID.ToDisplay(worldNum) ],
			[ MenuBoxItems.LEVEL_NUMBER, levNum.toString() ],
			[ MenuBoxItems.GO_TO_WORLD ],
			[ MenuBoxItems.BACK_TO_MAIN_MENU ]
			];
		}
		override protected function chooseItem(itemName:String, itemValue:String, itemTfc:TextFieldContainer, gsOvRdNum:int):void
		{
			var updGoToWorldTxt:Boolean;
			var increase:Boolean = true;
			if (gsOvRdNum == GameSettings.DECREASE_SETTING_NUM)
				increase = false;
			switch(itemName)
			{
				case MenuBoxItems.MAP_DIFFICULTY:
				{
					mapDifficultyToSet = GameSettings.changeMapDifficulty(gsOvRdNum, mapDifficultyToSet);
					afterChooseItem(itemName, MapDifficulty.swapNumAndName(mapDifficultyToSet), itemTfc);
					break;
				}
				case MenuBoxItems.MAP_PACK:
				{
					mapPackToSet = mapPackToSet.GetAtIndex(gsOvRdNum) as MapPack;
					afterChooseItem(itemName, mapPackToSet.NiceName, itemTfc);
					if (worldNum > worldNumberMax)
						updateWorldNumber();
					break;
				}
				case MenuBoxItems.WORLD_NUMBER:
				{
					if (increase)
						updateWorldNumber(1);
					else
						updateWorldNumber(-1);
					SND_MNGR.playSoundNow(SN_CHOOSE_ITEM);
					break;
				}
				case MenuBoxItems.LEVEL_NUMBER:
				{
					if (increase)
						levNum++;
					else
						levNum--;
					if (levNum > LEV_NUM_MAX)
						levNum = LEV_NUM_MIN;
					else if (levNum < LEV_NUM_MIN) 
						levNum = LEV_NUM_MAX;
					itemTfc.text = MenuBoxItems.LEVEL_NUMBER + VALUE_SEP + levNum.toString();
					updateGoToWorldText();
					SND_MNGR.playSoundNow(SN_CHOOSE_ITEM);
					break;
				}
				case MenuBoxItems.GO_TO_WORLD:
				{
					if (level)
						level.destroyLevel();
//					GameSettings.changeMapPack(mapPackToSet);
					GameSettings.mapPack = mapPackToSet;
					GameSettings.changeMapDifficulty(mapDifficultyToSet);
					SND_MNGR.removeAllSounds();
					STAT_MNGR.newLev = true;
					STAT_MNGR.passedHw = false;
					STAT_MNGR.resetLevelStats();
					if (level && level.player)
						STAT_MNGR.writePlayerStats(STAT_MNGR.curCharNum,level.player.pState,0);
					ScreenManager.SCRN_MNGR.createLevel( new LevelID(worldNum, levNum) );
					nextMsgBxToCreate = null;
					cancel();
					SND_MNGR.playSoundNow(SoundNames.SFX_GAME_CANON);
					break;
				}
				case MenuBoxItems.BACK_TO_MAIN_MENU:
				{
					MSG_BX_MNGR.writeNextMainMenu(this);
					cancel();
					SND_MNGR.playSoundNow(SN_CANCEL_ITEM);
					break;
				}
			}
		}
		
		private function updateGoToWorldText():void
		{
			var tf:TextFieldContainer = ARR_VEC[GO_TO_LEVEL_IND][IND_ARR_VEC_TEXT_FIELD] as TextFieldContainer;
			tf.text = MenuBoxItems.GO_TO_WORLD + VALUE_SEP + LevelID.ToDisplay(worldNum) + LEV_SEP + levNum.toString();
		}
		
		private function updateWorldNumber(offset:int = 0):void
		{
			worldNum += offset;
			
			if (worldNum > worldNumberMax)
			{
				if (offset != 0)
					worldNum = WORLD_NUM_MIN;
				else
					worldNum = worldNumberMax;
			}
			else if (worldNum < WORLD_NUM_MIN) 
				worldNum = worldNumberMax;
			
			var worldTextField:TextFieldContainer = ARR_VEC[WORLD_IND][IND_ARR_VEC_TEXT_FIELD] as TextFieldContainer;
			worldTextField.text = MenuBoxItems.WORLD_NUMBER + VALUE_SEP + LevelID.ToDisplay(worldNum);
			updateGoToWorldText();
		}
		
		private function get worldNumberMax():int
		{
			return LevelDataManager.getLevelData(mapPackToSet).worldCount;
		}
		
		override public function pressAtkBtn():void
		{
			cancel();
			SND_MNGR.playSoundNow(SN_CANCEL_ITEM);
		}
	}
}