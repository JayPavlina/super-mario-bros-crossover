package com.smbc.messageBoxes
{
	import com.smbc.data.GameStates;
	import com.smbc.managers.GameStateManager;

	public class NotConnectedMessageBox extends PlainMessageBox
	{
		public function NotConnectedMessageBox()
		{
			super("Could not download required data. Please make sure you're connected to the internet or try again later.");
			nonActive = true;
			nonInteractive = true;
			var gsMngr:GameStateManager = GameStateManager.GS_MNGR;
			gsMngr.lockGameState = false;
			gsMngr.gameState = GameStates.LOGOS;
			gsMngr.lockGameState = true;
		}
	}
}