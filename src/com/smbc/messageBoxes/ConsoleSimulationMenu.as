package com.smbc.messageBoxes
{
	import com.explodingRabbit.cross.data.ConsoleType;
	import com.smbc.data.CampaignModes;
	import com.smbc.data.GameSettings;
	import com.smbc.data.GameSettingsValues;
	import com.smbc.data.MusicSets;
	import com.smbc.data.MusicType;
	import com.smbc.managers.GraphicsManager;
	import com.smbc.managers.ScreenManager;
	import com.smbc.text.TextFieldContainer;
	
	import flash.text.TextField;
	
	public class ConsoleSimulationMenu extends MenuBox
	{
		private var strVec:Vector.<String> = new Vector.<String>();
		public function ConsoleSimulationMenu()
		{
			super(loadItems(),0,NaN,true,MessageBoxMessages.CONSOLE_SIMULATION_DESCRIPTION);
			strVec = null;
		}
		private function loadItems():Array
		{
			return [
				[MenuBoxItems.CURRENT],
				[MenuBoxItems.NINTENDO],
				[MenuBoxItems.SUPER_NES],
				[MenuBoxItems.GAMEBOY],
				[MenuBoxItems.MIX_IT_UP]
			];
		}
		override protected function chooseItem(itemName:String, itemValue:String, itemTfc:TextFieldContainer, gsOvRdNum:int):void
		{
			var gm:GraphicsManager = GraphicsManager.INSTANCE;
			switch(itemName)
			{
				case MenuBoxItems.NINTENDO:
				{
					GameSettings.changeActiveSkins( GameSettingsValues.paletteTargetNes );
//					gm.changeActiveSkins();
					GameSettings.changeMusicType( ConsoleType.BIT_8 );
					GameSettings.changeGameBoyFilter( int(false) );
					break;
				}
				case MenuBoxItems.SUPER_NES:
				{
					GameSettings.changeActiveSkins( GameSettingsValues.paletteTarget16Bit );
//					gm.changeActiveSkins();
					GameSettings.changeGameBoyFilter( int(false) );
					GameSettings.changeMusicType( ConsoleType.BIT_16 );
					break;
				}
				case MenuBoxItems.GAMEBOY:
				{
					GameSettings.changeActiveSkins( GameSettingsValues.paletteTargetGb );
//					gm.changeActiveSkins();
					GameSettings.changeGameBoyFilter( int(true) );
					GameSettings.changeMusicType( ConsoleType.GB );
					break;
				}
				case MenuBoxItems.MIX_IT_UP:
				{
					GameSettings.changeActiveSkins( GameSettingsValues.paletteTargetAll );
					GameSettings.changeMapSkin( GraphicsManager.RANDOM_SKIN_NUM );
					GameSettings.changeEnemySkin( GraphicsManager.RANDOM_SKIN_NUM );
					GameSettings.changeInterfaceSkin( GraphicsManager.RANDOM_SKIN_NUM );
					GameSettings.changeGameBoyFilter( int(false) );
					GameSettings.changeMusicType( ConsoleType.RANDOM );
					GameSettings.changeMusicSet( MusicSets.RANDOM );
					break;
				}
			}
			if (GameSettings.tutorials)
			{
				nextMsgBxToCreate = new PlainMessageMenuBox(MessageBoxMessages.TUTORIALS_ARE_ON, Vector.<String>([
					MenuBoxItems.NO, MenuBoxItems.YES]),1 );
				cancel();
			}
			else
			{
				cancel();
				EVENT_MNGR.startNewGame();
			}
//			SND_MNGR.playSoundNow(MessageBoxSounds.CHOOSE_CONSOLE_SIMULATION);
		}
		override public function pressAtkBtn():void
		{
			nextMsgBxToCreate = new CampaignModeMenu();
			cancel();
			SND_MNGR.playSoundNow(SN_CANCEL_ITEM);
		}
	}
}