package com.smbc.level
{
	import com.smbc.characters.Character;
	import com.smbc.characters.base.MegaManBase;
	import com.smbc.data.CharacterInfo;
	import com.smbc.data.LevelID;
	import com.smbc.data.MapPack;
	import com.smbc.managers.GraphicsManager;
	import com.smbc.managers.LevelDataManager;

	public class FakeLevel extends Level
	{
		public static const DEFAULT_CHANGE_TO_SKIN_NUM:int = -1;
		private var changetoSkinNum:int;
		private var resetAmmo:Boolean;
		
		public function FakeLevel(changeSkinOnly:int = -1, resetAmmo:Boolean = false)
		{
			this.changetoSkinNum = changeSkinOnly;
			this.resetAmmo = resetAmmo;
			super( LevelID.Create(CharacterSelect.FULL_LEVEL_STR), LevelDataManager.getLevelData(MapPack.Smb), [], true);
		}
		override public function initiateLevel():void
		{
			super.initiateLevel();
			var gm:GraphicsManager = GraphicsManager.INSTANCE;
			if (changetoSkinNum == GraphicsManager.CHAR_SKIN_NUM_RANDOM || changetoSkinNum >= 0)
				gm.changeCharacterSkin(player,changetoSkinNum);
			else
			{
				player.destroy();
				player = null;
				var n:int = Character.NUM_CHARACTERS;
				for (var charNum:int = 0; charNum < n; charNum++) 
				{
					var charClass:Class = CharacterInfo.getCharClassFromNum(charNum);
					player = new charClass();
					player.initiate();
					if (resetAmmo)
						player.setAllAmmoToDefault();
//					var skinNum:int = ;
					gm.changeCharacterSkin(player, STAT_MNGR.getCharSkinNum(charNum) );
				}
			}
			player.destroy();
			destroyLevel();
		}
	}
}