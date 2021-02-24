package com.smbc.messageBoxes
{
	import com.smbc.data.GameSettings;
	import com.smbc.level.Level;
	import com.smbc.managers.ScreenManager;
	import com.smbc.text.TextFieldContainer;
	
	import flash.globalization.LastOperationStatus;

	public class GeneralOptions extends SettingsMenuBox
	{
		public static var lastIndex:int;
		
		public function GeneralOptions(selectorStartIndex:int = 0)
		{
			super( loadItems(), selectorStartIndex );
			nextMsgBxToCreate = new OptionsMenu(OptionsMenu.lastIndex);
		}
		private function loadItems():Array
		{
			return [
				[MenuBoxItems.FULL_SCREEN_MODE],
				[MenuBoxItems.DISABLE_CHARACTERS],
				[MenuBoxItems.CLASSIC_SPECIAL_INPUT, GameSettings.classicSpecialInput],
				[MenuBoxItems.TUTORIALS, GameSettings.tutorials],
				[MenuBoxItems.CHEAT_NOTIFY,GameSettings.cheatNotify],
				[MenuBoxItems.LOCK_FRAME_RATE, GameSettings.lockFrameRate],
				[MenuBoxItems.GAME_BOY_FILTER, GameSettings.gameBoyFilter],
				[MenuBoxItems.BACK]
			];
		}
		override protected function chooseItem(itemName:String, itemValue:String, itemTfc:TextFieldContainer, gsOvRdNum:int):void
		{
			//var vol:int;
			//var volInc:int = SoundLevels.VOLUME_INCREMENT;
			//var maxVol:int = SoundLevels.MAX_VOLUME;
			//var minVol:int = SoundLevels.MIN_VOLUME;
			lastIndex = cSelNum;
			var spcOn:String = MenuBoxItems.ON;
			var spcOff:String = MenuBoxItems.OFF;
			var strVec:Vector.<String>;
			var level:Level = Level.levelInstance;
			var str:String;
			var newValueStr:String;
			switch(itemName)
			{
				case MenuBoxItems.DISABLE_CHARACTERS:
				{
					nextMsgBxToCreate = new CharacterSelectBox();
					nextMsgBxToCreate.nextMsgBxToCreate = new GeneralOptions(lastIndex);
					cancel();
					break;
				}
				case MenuBoxItems.TUTORIALS:
				{
					GameSettings.changeTutorials();
					newValueStr = convertToOnOffStr(GameSettings.tutorials);
					break;
				}
				case MenuBoxItems.LOCK_FRAME_RATE:
				{
					newValueStr = convertToOnOffStr( GameSettings.changeLockFrameRate() );
					break;
				}
				case MenuBoxItems.GAME_BOY_FILTER:
				{
					GameSettings.changeGameBoyFilter();
					newValueStr = convertToOnOffStr(GameSettings.gameBoyFilter);
					break;
				}
				case MenuBoxItems.CLASSIC_SPECIAL_INPUT:
				{
					newValueStr = newValueStr = convertToOnOffStr(GameSettings.classicSpecialInput = !GameSettings.classicSpecialInput);
					break;
				}
				case MenuBoxItems.CHEAT_NOTIFY:
				{
					var bool:Boolean = !GameSettings.cheatNotify;
					GameSettings.cheatNotify = bool;
					newValueStr = convertToOnOffStr(GameSettings.cheatNotify);
					break;
				}	
				case MenuBoxItems.FULL_SCREEN_MODE:
				{
					tryEnterFullScreen();
					break;
				}
				case MenuBoxItems.BACK:
				{
					cancel();
					break;
				}
			}
			afterChooseItem(itemName, newValueStr, itemTfc);
		}
		
		override public function pressAtkBtn():void
		{
			cancel();
			SND_MNGR.playSoundNow(SN_CANCEL_ITEM);
		}
	}
}