package com.smbc.messageBoxes
{
	import com.smbc.data.GameSettings;
	import com.smbc.enums.AttackStrength;
	import com.smbc.enums.BillWeapon;
	import com.smbc.enums.ClassicDamageResponse;
	import com.smbc.enums.DamageResponse;
	import com.smbc.enums.EnemySpeed;
	import com.smbc.enums.GoombaReplacementType;
	import com.smbc.enums.InitialLivesCount;
	import com.smbc.enums.ItemDropRate;
	import com.smbc.enums.LinkWeapon;
	import com.smbc.enums.MegaManSpecialWeapon;
	import com.smbc.enums.PiranhaSpawnType;
	import com.smbc.enums.RyuSpecialWeapon;
	import com.smbc.enums.SamusWeapon;
	import com.smbc.enums.SimonSpecialWeapon;
	import com.smbc.enums.SophiaWeapon;
	import com.smbc.text.TextFieldContainer;
	
	public class CustomizeWeaponsMenu extends SettingsMenuBox
	{
		public static var instance:CustomizeWeaponsMenu;
		
		public function CustomizeWeaponsMenu(selectorStartIndex:int = 0)
		{
			super( loadItems(), selectorStartIndex );
			instance = this;
//			nextMsgBxToCreate = new NewGameOptionsMenu(NewGameOptionsMenu.);
		}
		private function loadItems():Array
		{
			var arr:Array = [
				[ MenuBoxItems.BASS_WEAPON, GameSettings.bassWeapon.NiceName ],
				[ MenuBoxItems.BILL_FIRST_WEAPON, GameSettings.billFirstWeapon.NiceName ],
				[ MenuBoxItems.BILL_SECOND_WEAPON, GameSettings.billSecondWeapon.NiceName ],
				[ MenuBoxItems.LINK_WEAPON, GameSettings.linkWeapon.NiceName ],
				[ MenuBoxItems.MEGA_MAN_WEAPON, GameSettings.megaManWeapon.NiceName ],
				[ MenuBoxItems.RYU_START_WEAPON, GameSettings.ryuStartWeapon.NiceName ],
				[ MenuBoxItems.RYU_EXTRA_WEAPON, GameSettings.ryuExtraWeapon.NiceName ],
				[ MenuBoxItems.SAMUS_WEAPON, GameSettings.samusWeapon.NiceName ],
				[ MenuBoxItems.SIMON_START_WEAPON, GameSettings.simonStartWeapon.NiceName ],
				[ MenuBoxItems.SIMON_EXTRA_WEAPON, GameSettings.simonExtraWeapon.NiceName ],
				[ MenuBoxItems.SOPHIA_WEAPON, GameSettings.sophiaWeapon.NiceName ],
				[ MenuBoxItems.BACK ]
			];
			return arr;
		}
		override protected function chooseItem(itemName:String, itemValue:String, itemTfc:TextFieldContainer, gsOvRdNum:int):void
		{
			var newValueStr:String;
			switch(itemName)
			{
				case MenuBoxItems.BILL_FIRST_WEAPON:
				{
					GameSettings.billFirstWeapon = GameSettings.billFirstWeapon.GetAtIndex(gsOvRdNum) as BillWeapon;
					if (GameSettings.billFirstWeapon == GameSettings.billSecondWeapon || GameSettings.billFirstWeapon == BillWeapon.Spread)
						GameSettings.billFirstWeapon = GameSettings.billFirstWeapon.GetAtIndex(gsOvRdNum) as BillWeapon;
					if (GameSettings.billFirstWeapon == GameSettings.billSecondWeapon || GameSettings.billFirstWeapon == BillWeapon.Spread)
						GameSettings.billFirstWeapon = GameSettings.billFirstWeapon.GetAtIndex(gsOvRdNum) as BillWeapon;
					newValueStr = GameSettings.billFirstWeapon.NiceName;
					break;
				}
				case MenuBoxItems.BILL_SECOND_WEAPON:
				{
					GameSettings.billSecondWeapon = GameSettings.billSecondWeapon.GetAtIndex(gsOvRdNum) as BillWeapon;
					if (GameSettings.billSecondWeapon == GameSettings.billFirstWeapon)
						GameSettings.billSecondWeapon = GameSettings.billSecondWeapon.GetAtIndex(gsOvRdNum) as BillWeapon;
					newValueStr = GameSettings.billSecondWeapon.NiceName;
					break;
				}
				case MenuBoxItems.BASS_WEAPON:
				{
					GameSettings.bassWeapon = GameSettings.bassWeapon.GetAtIndex(gsOvRdNum) as MegaManSpecialWeapon;
					newValueStr = GameSettings.bassWeapon.NiceName;
					break;
				}
				case MenuBoxItems.LINK_WEAPON:
				{
					GameSettings.linkWeapon = GameSettings.linkWeapon.GetAtIndex(gsOvRdNum) as LinkWeapon;
					newValueStr = GameSettings.linkWeapon.NiceName;
					break;
				}
				case MenuBoxItems.MEGA_MAN_WEAPON:
				{
					GameSettings.megaManWeapon = GameSettings.megaManWeapon.GetAtIndex(gsOvRdNum) as MegaManSpecialWeapon;
					newValueStr = GameSettings.megaManWeapon.NiceName;
					break;
				}
				case MenuBoxItems.RYU_START_WEAPON:
				{
					GameSettings.ryuStartWeapon = GameSettings.ryuStartWeapon.GetAtIndex(gsOvRdNum) as RyuSpecialWeapon;
					if (GameSettings.ryuStartWeapon == GameSettings.ryuExtraWeapon)
						GameSettings.ryuStartWeapon = GameSettings.ryuStartWeapon.GetAtIndex(gsOvRdNum) as RyuSpecialWeapon;
					newValueStr = GameSettings.ryuStartWeapon.NiceName;
					break;
				}
				case MenuBoxItems.RYU_EXTRA_WEAPON:
				{
					GameSettings.ryuExtraWeapon = GameSettings.ryuExtraWeapon.GetAtIndex(gsOvRdNum) as RyuSpecialWeapon;
					if (GameSettings.ryuExtraWeapon == GameSettings.ryuStartWeapon)
						GameSettings.ryuExtraWeapon = GameSettings.ryuExtraWeapon.GetAtIndex(gsOvRdNum) as RyuSpecialWeapon;
					newValueStr = GameSettings.ryuExtraWeapon.NiceName;
					break;
				}
				case MenuBoxItems.SAMUS_WEAPON:
				{
					GameSettings.samusWeapon = GameSettings.samusWeapon.GetAtIndex(gsOvRdNum) as SamusWeapon;
					newValueStr = GameSettings.samusWeapon.NiceName;
					break;
				}
				case MenuBoxItems.SIMON_START_WEAPON:
				{
					GameSettings.simonStartWeapon = GameSettings.simonStartWeapon.GetAtIndex(gsOvRdNum) as SimonSpecialWeapon;
					if (GameSettings.simonStartWeapon == GameSettings.simonExtraWeapon)
						GameSettings.simonStartWeapon = GameSettings.simonStartWeapon.GetAtIndex(gsOvRdNum) as SimonSpecialWeapon;
					newValueStr = GameSettings.simonStartWeapon.NiceName;
					break;
				}
				case MenuBoxItems.SIMON_EXTRA_WEAPON:
				{
					GameSettings.simonExtraWeapon = GameSettings.simonExtraWeapon.GetAtIndex(gsOvRdNum) as SimonSpecialWeapon;
					if (GameSettings.simonExtraWeapon == GameSettings.simonStartWeapon)
						GameSettings.simonExtraWeapon = GameSettings.simonExtraWeapon.GetAtIndex(gsOvRdNum) as SimonSpecialWeapon;
					newValueStr = GameSettings.simonExtraWeapon.NiceName;
					break;
				}
				case MenuBoxItems.SOPHIA_WEAPON:
				{
					GameSettings.sophiaWeapon = GameSettings.sophiaWeapon.GetAtIndex(gsOvRdNum) as SophiaWeapon;
					newValueStr = GameSettings.sophiaWeapon.NiceName;
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

//		override public function pressAtkBtn():void
//		{
//			cancel();
//			SND_MNGR.playSoundNow(SN_CANCEL_ITEM);
//		}
		override protected function destroy():void
		{
			super.destroy();
			instance = null;
		}
	}
}