package com.smbc.graphics
{
	import com.smbc.characters.Bass;
	import com.smbc.characters.Character;
	import com.smbc.characters.MegaMan;
	import com.smbc.characters.base.MegaManBase;
	import com.smbc.data.CharacterInfo;
	import com.smbc.data.GameSettings;
	import com.smbc.events.CustomEvents;
	import com.smbc.level.Level;
	import com.smbc.level.LevelForeground;
	import com.smbc.main.SkinObj;
	import com.smbc.managers.EventManager;
	import com.smbc.managers.StatManager;
	
	import flash.events.Event;
	
	public class MegaManEnergyBar extends SkinObj
	{
		private static const FRAME_OFS:int = 1;
		private static const X_POS:int = 32;
		private static const Y_POS:int = 70;
		protected static const NUM_BARS:int = 30;
		public static const NUM_UNITS_PER_BAR:int = 4;
		private var megaMan:MegaManBase;
		private static const MEGA_MAN_CHANGE_Y_SKIN_NUMS:Array = [ 1, 4, 7, 9, 11, 17, 21, 22 ];
		private static const BASS_CHANGE_Y_SKIN_NUMS:Array = [ 1, 4, 6, 8, 11, 14 ];
		public function MegaManEnergyBar(megaMan:MegaManBase)
		{
			this.megaMan = megaMan;
			inheritedForceShortClassName = CharacterInfo.CHAR_ARR[megaMan.charNum][CharacterInfo.IND_CHAR_NAME_CLASS]+"EnergyBar";
			super();
			x = X_POS;
			y = Y_POS;
			LevelForeground.instance.addChild(this);
			EventManager.EVENT_MNGR.addEventListener( CustomEvents.CHANGE_CHARACTER_SKIN, changeCharacterSkinHandler, false, 0, true);
			checkYPos();
		}
		private function checkYPos():void
		{
			
			if (yPositionShouldBeChanged)
				y = Y_POS + 8;
			else
				y = Y_POS;
		}
		
		private function get yPositionShouldBeChanged():Boolean
		{
			var level:Level = Level.levelInstance;
			if (level == null)
				return false;
			var player:Character = level.player;
			if (player == null)
				return false;
			var skinNum:int = player.skinNum;
			
			if (player is MegaMan)
				return MEGA_MAN_CHANGE_Y_SKIN_NUMS.indexOf(skinNum) != -1;
			else // if (player is Bass)
				return BASS_CHANGE_Y_SKIN_NUMS.indexOf(skinNum) != -1;
		}
		
		protected function changeCharacterSkinHandler(event:Event):void
		{
			checkYPos();
		}
		public function update(value:int):void
		{
			visible = megaMan.primaryOrSecondaryWeaponUsesEnergy;
			if (GameSettings.hideNewStuff)
				visible = false;
			if (!visible)
				return;
			var frameNum:int = 0;
			if (value > 0)
				frameNum = int(value/NUM_UNITS_PER_BAR);
			gotoAndStop( frameNum + FRAME_OFS );
			checkYPos();
		}
	}
}