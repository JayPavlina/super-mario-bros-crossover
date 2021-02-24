package com.smbc.messageBoxes
{
	import com.explodingRabbit.cross.data.ConsoleType;
	import com.smbc.data.GameSettings;
	import com.smbc.data.MusicQuality;
	import com.smbc.data.MusicSets;
	import com.smbc.enums.CoinSoundType;
	import com.smbc.graphics.SkinNames;
	import com.smbc.text.TextFieldContainer;

	public class SoundOptions extends SettingsMenuBox
	{
		public function SoundOptions()
		{
			super( loadItems() );
			nextMsgBxToCreate = new OptionsMenu(OptionsMenu.lastIndex);
		}
		private function loadItems():Array
		{
			return [
				[MenuBoxItems.SFX,!GameSettings.muteSfx],
				[MenuBoxItems.MUSIC,!GameSettings.muteMusic],
				[MenuBoxItems.MUSIC_TYPE, ConsoleType.convNumToName(GameSettings.musicType) ],
				[MenuBoxItems.MUSIC_SET, MusicSets.convNumToStr(GameSettings.musicSet) ],
				[MenuBoxItems.COIN_SOUND_TYPE, GameSettings.coinSoundType.Name],
				[MenuBoxItems.BACK]
			];
		}
		override protected function chooseItem(itemName:String, itemValue:String, itemTfc:TextFieldContainer, gsOvRdNum:int):void
		{
			var newValueStr:String;
			switch(itemName)
			{
				case MenuBoxItems.SFX:
				{
					GameSettings.changeMuteSfx();
					newValueStr = convertToOnOffStr(!GameSettings.muteSfx);
					break;
				}
				case MenuBoxItems.MUSIC:
				{
					GameSettings.changeMuteMusic();
					newValueStr = convertToOnOffStr(!GameSettings.muteMusic);
					break;
				}
				case MenuBoxItems.MUSIC_TYPE:
				{
					newValueStr = ConsoleType.convNumToName( GameSettings.changeMusicType(gsOvRdNum) );
					break;
				}
				case MenuBoxItems.MUSIC_SET:
				{
					newValueStr = GameSettings.changeMusicSet(gsOvRdNum);
					break;
				}
				case MenuBoxItems.COIN_SOUND_TYPE:
				{
					GameSettings.coinSoundType = GameSettings.coinSoundType.GetAtIndex(gsOvRdNum) as CoinSoundType;
					newValueStr = GameSettings.coinSoundType.NiceName;
					break;
				}
				/*case MenuBoxItems.MUSIC_QUALITY:
				{
					GameSettings.changeMusicQuality();
					newValueStr = MusicQuality.convNumToName(GameSettings.musicQuality);
					break;
				}*/
				case MenuBoxItems.BACK:
				{
					cancel();
					break;
				}
			}
			afterChooseItem(itemName, newValueStr, itemTfc);
		}
	}
}