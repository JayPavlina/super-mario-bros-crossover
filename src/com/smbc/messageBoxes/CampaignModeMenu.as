package com.smbc.messageBoxes
{
	import com.smbc.data.CampaignModes;
	import com.smbc.data.GameSettings;
	import com.smbc.managers.ScreenManager;
	import com.smbc.text.TextFieldContainer;
	
	import flash.text.TextField;

	public class CampaignModeMenu extends MenuBox
	{
		private var strVec:Vector.<String> = new Vector.<String>();
		public function CampaignModeMenu()
		{
			super(loadItems(),0,NaN,false,MessageBoxMessages.CAMPAIGN_MODE_DESCRIPTION);
			strVec = null;
		}
		private function loadItems():Array
		{
			return [
			[MenuBoxItems.ALL_CHARACTERS],
			[MenuBoxItems.SURVIVAL],
			[MenuBoxItems.SINGLE_CHARACTER],
			[MenuBoxItems.SINGLE_CHARACTER_RANDOM]
			];
		}
		override protected function chooseItem(itemName:String, itemValue:String, itemTfc:TextFieldContainer, gsOvRdNum:int):void
		{
			GameSettings.changeCampaignMode( CampaignModes.swapNumAndName(itemName) );
			nextMsgBxToCreate = new ConsoleSimulationMenu();
			cancel();
			if (GameSettings.campaignMode != CampaignModes.SINGLE_CHARACTER_RANDOM)
				ScreenManager.SCRN_MNGR.forceShowCharacterSelectScreen = true;
			else
				ScreenManager.SCRN_MNGR.forceShowCharacterSelectScreen = false;
			SND_MNGR.playSoundNow(MessageBoxSounds.CHOOSE_CAMPAGIN_MODE);
		}
		override public function pressAtkBtn():void
		{
			nextMsgBxToCreate = new DifficultyMenu();
			cancel();
			SND_MNGR.playSoundNow(SN_CANCEL_ITEM);
		}
	}
}