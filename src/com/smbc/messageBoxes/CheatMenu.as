package com.smbc.messageBoxes
{
	import com.explodingRabbit.cross.data.ConsoleType;
	import com.explodingRabbit.cross.games.GameContra;
	import com.explodingRabbit.cross.games.Games;
	import com.explodingRabbit.utils.KeyCodeToString;
	import com.smbc.characters.MegaMan;
	import com.smbc.data.Cheats;
	import com.smbc.data.GameSettings;
	import com.smbc.data.MusicType;
	import com.smbc.data.SoundNames;
	import com.smbc.events.CustomEvents;
	import com.smbc.level.Level;
	import com.smbc.managers.ButtonManager;
	import com.smbc.sound.SoundContainer;
	import com.smbc.text.TextFieldContainer;
	
	import flash.events.Event;
	import flash.text.TextField;
	import flash.ui.Keyboard;

	public class CheatMenu extends SettingsMenuBox
	{
//		private static const ALL_CHEATS_CTR_NUM:int = 10;
		private var allCheatsCtr:int;
		private var enteringCode:Boolean;
		private var currentInputIndex:int;
		private var musicWasPlaying:Boolean;
		private static const CORRECT_INPUT:Array = [
			Keyboard.UP, Keyboard.UP, Keyboard.DOWN, Keyboard.DOWN, Keyboard.LEFT, Keyboard.RIGHT, Keyboard.LEFT, Keyboard.RIGHT,
			Keyboard.B, Keyboard.A
			];
		public function CheatMenu(selectorStartIndex:int = 0, txtContY:Number = NaN)
		{
			super(loadItems(), selectorStartIndex, txtContY);
			nextMsgBxToCreate = new OptionsMenu(OptionsMenu.lastIndex);
		}
		private function loadItems():Array
		{
			var arr:Array = [
				addCheat(MenuBoxItems.LEVEL_SELECT),
				addCheat(MenuBoxItems.ALL_GROUND_IS_BRICKS,Cheats.allGroundIsBricks),
				addCheat(MenuBoxItems.ALL_HAMMER_BROS,Cheats.allHammerBros),
//				addCheat(MenuBoxItems.ALL_PIRANHAS_RED,Cheats.allPiranhasRed),
				addCheat(MenuBoxItems.ALL_WEAPONS_PIERCE,Cheats.allWeaponsPierce),
				addCheat(MenuBoxItems.ALWAYS_BREAK_BRICKS,Cheats.alwaysBreakBricks),
				addCheat(MenuBoxItems.BOUNCY_PITS,Cheats.bouncyPits),
				addCheat(MenuBoxItems.CLASSIC_SAMUS,Cheats.classicSamus),
				addCheat(MenuBoxItems.CLASSIC_SCREEN_SCROLL,Cheats.classicScreenScroll),
				addCheat(MenuBoxItems.CLASSIC_SIMON,Cheats.classicSimon),
				addCheat(MenuBoxItems.EVERYONE_CAN_STOMP,Cheats.everyoneCanStomp),
				addCheat(MenuBoxItems.EVIL_HAMMER_BROS,Cheats.evilHammerBros),
				addCheat(MenuBoxItems.EXTRA_CHECKPOINTS,Cheats.extraCheckpoints),
				addCheat(MenuBoxItems.INFINITE_AMMO,Cheats.infiniteAmmo),
//				addCheat(MenuBoxItems.INFINITE_HOVER,Cheats.infiniteHover),
				addCheat(MenuBoxItems.INFINITE_LIVES,Cheats.infiniteLives),
				addCheat(MenuBoxItems.INFINITE_TIME,Cheats.infiniteTime),
				addCheat(MenuBoxItems.INVINCIBLE,Cheats.invincible),
//				addCheat(MenuBoxItems.PIRANHAS_IN_ALL_PIPES,Cheats.piranhasInAllPipes),
//				addCheat(MenuBoxItems.MEGA_MAN_HIGH_JUMP,Cheats.megaManHighJump),
//				addCheat(MenuBoxItems.QUIET_COINS,Cheats.quietCoins),
				addCheat(MenuBoxItems.WATER_MODE,Cheats.waterMode),
				[MenuBoxItems.ENTER_CODE],
				[MenuBoxItems.BACK]
			];
			if ( !Cheats.getLockStatus(MenuBoxItems.LEVEL_SELECT) )
				arr.shift();
			if (Cheats.allUnlocked)
				arr.splice(arr.length - 2, 1);
			return arr;
		}
		private function addCheat(cheatName:String,value:*=undefined):Array
		{
			if ( Cheats.getLockStatus(cheatName) ) // if locked
				return [cheatName, value, MenuBoxItems.HIDDEN_CHEAT];
			else
				return [cheatName, value];
		}
		override protected function chooseItem(itemName:String, itemValue:String, itemTfc:TextFieldContainer, gsOvRdNum:int):void
		{
			var level:Level = Level.levelInstance;
			var newVal:int = -1;
			var bool:Boolean;
			var newValueStr:String;
			if (itemTfc && itemTfc.text == MenuBoxItems.HIDDEN_CHEAT)
			{
				nextMsgBxToCreate = new PlainMessageBox(Cheats.getUnlockConditionsMessage(itemName));
				nextMsgBxToCreate.nextMsgBxToCreate = new CheatMenu(cSelNum,TXT_CONT.y);
				SND_MNGR.playSoundNow(SN_CHOOSE_ITEM);
				cancel();
				return;
			}
			switch(itemName)
			{
				case MenuBoxItems.EVERYONE_CAN_STOMP:
				{
					bool = !Cheats.everyoneCanStomp;
					Cheats.everyoneCanStomp = bool;
					newValueStr = convertToOnOffStr(bool);
					break;
				}
				case MenuBoxItems.ALL_HAMMER_BROS:
				{
					bool = !Cheats.allHammerBros;
					Cheats.allHammerBros = bool;
					newValueStr = convertToOnOffStr(bool);
					break;
				}
//				case MenuBoxItems.ALL_PIRANHAS_RED:
//				{
//					bool = !Cheats.allPiranhasRed;
//					Cheats.allPiranhasRed = bool;
//					newValueStr = convertToOnOffStr(bool);
//					break;
//				}
				case MenuBoxItems.ALL_WEAPONS_PIERCE:
				{
					Cheats.allWeaponsPierce = bool = !Cheats.allWeaponsPierce;
					newValueStr = convertToOnOffStr(bool);
					break;
				}
				case MenuBoxItems.ALL_GROUND_IS_BRICKS:
				{
					Cheats.allGroundIsBricks = bool = !Cheats.allGroundIsBricks;
					newValueStr = convertToOnOffStr(bool);
					break;
				}
				case MenuBoxItems.ALWAYS_BREAK_BRICKS:
				{
					Cheats.alwaysBreakBricks = bool = !Cheats.alwaysBreakBricks;
					newValueStr = convertToOnOffStr(bool);
					break;
				}
				case MenuBoxItems.BACK:
				{
					cancel();
					break;
				}
				case MenuBoxItems.BOUNCY_PITS:
				{
					bool = !Cheats.bouncyPits;
					Cheats.bouncyPits = bool;
					newValueStr = convertToOnOffStr(bool);
					break;
				}
				case MenuBoxItems.CLASSIC_SAMUS:
				{
					bool = !Cheats.classicSamus;
					Cheats.classicSamus = bool;
					newValueStr = convertToOnOffStr(bool);
					break;
				}
				case MenuBoxItems.CLASSIC_SCREEN_SCROLL:
				{
					bool = !Cheats.classicScreenScroll;
					Cheats.classicScreenScroll = bool;
					newValueStr = convertToOnOffStr(bool);
					break;
				}
				case MenuBoxItems.CLASSIC_SIMON:
				{
					bool = !Cheats.classicSimon;
					Cheats.classicSimon = bool;
					newValueStr = convertToOnOffStr(bool);
					allCheatsCtr++;
					break;
				}
				case MenuBoxItems.EVIL_HAMMER_BROS:
				{
					bool = !Cheats.evilHammerBros;
					Cheats.evilHammerBros = bool;
					newValueStr = convertToOnOffStr(bool);
					break;
				}
				case MenuBoxItems.EXTRA_CHECKPOINTS:
				{
					bool = !Cheats.extraCheckpoints;
					Cheats.extraCheckpoints = bool;
					newValueStr = convertToOnOffStr(bool);
					break;
				}
				case MenuBoxItems.INFINITE_AMMO:
				{
					bool = !Cheats.infiniteAmmo;
					Cheats.infiniteAmmo = bool;
					newValueStr = convertToOnOffStr(bool);
					break;
				}
//				case MenuBoxItems.INFINITE_HOVER:
//				{
//					bool = !Cheats.infiniteHover;
//					Cheats.infiniteHover = bool;
//					newValueStr = convertToOnOffStr(bool);
//					break;
//				}
				case MenuBoxItems.INFINITE_LIVES:
				{
					bool = !Cheats.infiniteLives;
					Cheats.infiniteLives = bool;
					newValueStr = convertToOnOffStr(bool);
					break;
				}
				case MenuBoxItems.INFINITE_TIME:
				{
					bool = !Cheats.infiniteTime;
					Cheats.infiniteTime = bool;
					newValueStr = convertToOnOffStr(bool);
					break;
				}
				case MenuBoxItems.INVINCIBLE:
				{
					bool = !Cheats.invincible;
					Cheats.invincible = bool;
					newValueStr = convertToOnOffStr(bool);
					if (level && level.player)
					{
						if (bool)
							level.player.forceTakeNoDamage();
						else
							level.player.forceTakeDamage();
					}
					break;
				}
				/*case MenuBoxItems.MEGA_MAN_HIGH_JUMP:
				{
					bool = !Cheats.megaManHighJump;
					Cheats.megaManHighJump = bool;
					newValueStr = convertToOnOffStr(bool);
					var megaMan:MegaMan;
					if (level && level.player is MegaMan)
						megaMan = level.player as MegaMan;
					if (megaMan)
						megaMan.toggleHighJump(bool);				
					break;
				}*/
//				case MenuBoxItems.PIRANHAS_IN_ALL_PIPES:
//				{
//					bool = !Cheats.piranhasInAllPipes;
//					Cheats.piranhasInAllPipes = bool;
//					newValueStr = convertToOnOffStr(bool);
//					break;
//				}
//				case MenuBoxItems.QUIET_COINS:
//				{
//					bool = !Cheats.quietCoins;
//					Cheats.quietCoins = bool;
//					newValueStr = convertToOnOffStr(bool);
//					break;
//				}
				case MenuBoxItems.WATER_MODE:
				{
					bool = !Cheats.waterMode;
					Cheats.waterMode = bool;
					newValueStr = convertToOnOffStr(bool);
					if (level && !level.initialWaterLevel)
					{
						if (bool)
							level.forceWaterLevel();
						else
							level.forceNonwaterLevel();
					}
					break;
				}
				case MenuBoxItems.ENTER_CODE:
				{
					beginEnteringCode();
					break;
				}
			}
			afterChooseItem(itemName, newValueStr, itemTfc);
		}
		
		private function beginEnteringCode():void
		{
			enteringCode = true;
			currentInputIndex = 0;
			if (SND_MNGR.musicPlayerMain.isPlaying)
			{
				musicWasPlaying = true;
				SND_MNGR.pauseBgm();
			}
			else
				musicWasPlaying = false;
			SND_MNGR.playMusic(Games.contra.SngTitle, SND_MNGR.sfxPlayer, false, null, ConsoleType.BIT_8, true);
		}
		
		private function captureInput(keyCode:uint):void
		{
			if ( CORRECT_INPUT[currentInputIndex] == keyCode )
			{
				currentInputIndex++;
				if (currentInputIndex == CORRECT_INPUT.length)
				{
					cancelCodeInput();
					Cheats.unlockAllCheats();
					nextMsgBxToCreate = new CheatMenu();
					cancel();
//					chooseItem(MenuBoxItems.BACK,null,null,0);
					var snd:SoundContainer = SND_MNGR.findSound(SoundNames.SFX_GAME_HIT_CEILING);
					if (snd != null)
						SND_MNGR.removeSnd(snd);
					SND_MNGR.playSoundNow(SoundNames.SFX_GAME_NEW_LIFE);
				}
			}
			else
				cancelCodeInput();
		}
		
		private function cancelCodeInput():void
		{
			enteringCode = false;
			SND_MNGR.sfxPlayer.stop();
			SND_MNGR.playSoundNow(SoundNames.SFX_GAME_HIT_CEILING);
			if (musicWasPlaying)
				SND_MNGR.resumeBgm();
		}
		
		override public function pressUpBtn():void
		{
			if (enteringCode)
				captureInput(Keyboard.UP);
			else
				super.pressUpBtn();
		}
		override public function pressDwnBtn():void
		{
			if (enteringCode)
				captureInput(Keyboard.DOWN);
			else
				super.pressDwnBtn();
		}
		override public function pressLftBtn():void
		{
			if (enteringCode)
				captureInput(Keyboard.LEFT);
			else
				super.pressLftBtn();
		}
		override public function pressRhtBtn():void
		{
			if (enteringCode)
				captureInput(Keyboard.RIGHT);
			else
				super.pressRhtBtn();
		}
		override public function pressJmpBtn():void
		{
			if (enteringCode)
				captureInput(Keyboard.A);
			else
				super.pressJmpBtn();
		}
		override public function pressAtkBtn():void
		{
			if (enteringCode)
				captureInput(Keyboard.B);
			else
			{
				cancel();
				SND_MNGR.playSoundNow(SN_CANCEL_ITEM);
			}
		}
		override public function pressSpcBtn():void
		{
			if (enteringCode)
				captureInput(Keyboard.C);
			else
				super.pressSpcBtn();
		}
		override public function pressPseBtn():void
		{
			if (enteringCode)
				captureInput(Keyboard.ESCAPE);
			else
				super.pressPseBtn();
		}
		/*override public function cancel():void
		{
			super.cancel();
			lastSelectorIndex = 0;
		}*/
	}
}