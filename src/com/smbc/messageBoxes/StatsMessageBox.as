package com.smbc.messageBoxes
{
	import com.smbc.data.GameStates;
	import com.smbc.managers.GameStateManager;
	import com.smbc.managers.StatManager;

	public class StatsMessageBox extends PlainMessageBox
	{
		private static const END_WIDTH:int = 480;
		private var resumeGame:Boolean;
		public function StatsMessageBox()
		{
			super(loadText());
			endBoxWidth = END_WIDTH;
		}
		private function loadText():String
		{
			var sm:StatManager = StatManager.STAT_MNGR;
			var str:String = "";
			str += "Enemies Defeated: "+ sm.numEnemiesDefeated;
			str += "\\nEnemies Stomped: "+sm.numEnemiesStomped;
			str += "\\nCheep Cheeps Defeated: "+ sm.numCheepCheepsDefeated;
			str += "\\nHammer Bros Defeated: "+ sm.numHammerBrosDefeated;
			str += "\\nContinues Used: "+ sm.numContinuesUsed;
			str += "\\nAmmo Pickups: "+sm.numAmmoPickupsCollected;
			return str;
		}
		override public function pressPseBtn():void
		{
			if (GameStateManager.GS_MNGR.gameState == GameStates.PAUSE)
			{
				resumeGame = true;
				nextMsgBxToCreate = null;
				cancel(); 
			}
		}
		override protected function destroy():void
		{
			super.destroy();
			if (resumeGame)
				EVENT_MNGR.unpauseGame();
		}
	}
}