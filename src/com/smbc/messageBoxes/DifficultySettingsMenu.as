package com.smbc.messageBoxes
{
	import com.smbc.data.GameSettings;
	import com.smbc.enums.AttackStrength;
	import com.smbc.enums.ClassicDamageResponse;
	import com.smbc.enums.DamageResponse;
	import com.smbc.enums.EnemySpeed;
	import com.smbc.enums.GoombaReplacementType;
	import com.smbc.enums.InitialLivesCount;
	import com.smbc.enums.ItemDropRate;
	import com.smbc.enums.PiranhaSpawnType;
	import com.smbc.text.TextFieldContainer;

	public class DifficultySettingsMenu extends SettingsMenuBox
	{
		public static var instance:DifficultySettingsMenu;
		private var disableChooseItemSnd:Boolean;
		private var gameDifficultyToSet:int;
		private var mapDifficultyToSet:int;
		private var mapPackToSet:int;
		
		public function DifficultySettingsMenu(selectorStartIndex:int = 0)
		{
			super( loadItems(), selectorStartIndex );
			instance = this;
//			nextMsgBxToCreate = new OptionsMenu(OptionsMenu.lastIndex);
		}
		private function loadItems():Array
		{
			var arr:Array = [
				[ MenuBoxItems.LIVES_START, GameSettings.initialLivesCount.NiceName ],
				[ MenuBoxItems.START_WITH_MUSHROOM, GameSettings.startWithMushroom ],
				[ MenuBoxItems.ATTACK_STRENGTH, GameSettings.attackStrength.NiceName ],
				[ MenuBoxItems.DAMAGE_RESPONSE, GameSettings.damageResponse.NiceName ],
				[ MenuBoxItems.ITEM_DROP_RATE, GameSettings.itemDropRate.NiceName ],
				[ MenuBoxItems.PIRANHAS, GameSettings.piranhaSpawnType.NiceName ],
				[ MenuBoxItems.REPLACE_GOOMBAS, GameSettings.goombaReplacementType.NiceName ],
				[ MenuBoxItems.ENEMY_SPEED, GameSettings.enemySpeed.NiceName ],
//				[ MenuBoxItems.RESTORE_DEFAULTS ],
				[ MenuBoxItems.BACK ]
			];
			if (GameSettings.classicMode)
			{
				arr.splice(1, 1); // remove start with mushroom
				arr.splice(2, 1, [ MenuBoxItems.DAMAGE_RESPONSE, GameSettings.classicDamageResponse.NiceName ]); // replace damage response with classic version
			}
			return arr;
		}
		override protected function chooseItem(itemName:String, itemValue:String, itemTfc:TextFieldContainer, gsOvRdNum:int):void
		{
			var newValueStr:String;
			switch(itemName)
			{
				case MenuBoxItems.LIVES_START:
				{
					GameSettings.initialLivesCount = GameSettings.initialLivesCount.GetAtIndex(gsOvRdNum) as InitialLivesCount;
					newValueStr = GameSettings.initialLivesCount.NiceName;
					break;
				}
				case MenuBoxItems.ATTACK_STRENGTH:
				{
					GameSettings.attackStrength = GameSettings.attackStrength.GetAtIndex(gsOvRdNum) as AttackStrength;
					newValueStr = GameSettings.attackStrength.NiceName;
					break;
				}
				case MenuBoxItems.PIRANHAS:
				{
					GameSettings.piranhaSpawnType = GameSettings.piranhaSpawnType.GetAtIndex(gsOvRdNum) as PiranhaSpawnType;
					newValueStr = GameSettings.piranhaSpawnType.NiceName;
					break;
				}
				case MenuBoxItems.ENEMY_SPEED:
				{
					GameSettings.enemySpeed = GameSettings.enemySpeed.GetAtIndex(gsOvRdNum) as EnemySpeed;
					newValueStr = GameSettings.enemySpeed.NiceName;
					break;
				}
				case MenuBoxItems.ITEM_DROP_RATE:
				{
					GameSettings.itemDropRate = GameSettings.itemDropRate.GetAtIndex(gsOvRdNum) as ItemDropRate;
					newValueStr = GameSettings.itemDropRate.NiceName;
					break;
				}
				case MenuBoxItems.REPLACE_GOOMBAS:
				{
					GameSettings.goombaReplacementType = GameSettings.goombaReplacementType.GetAtIndex(gsOvRdNum) as GoombaReplacementType;
					newValueStr = GameSettings.goombaReplacementType.NiceName;
					break;
				}
				case MenuBoxItems.DAMAGE_RESPONSE:
				{
					if (GameSettings.classicMode)
					{
						GameSettings.classicDamageResponse = GameSettings.classicDamageResponse.GetAtIndex(gsOvRdNum) as ClassicDamageResponse;
						newValueStr = GameSettings.classicDamageResponse.NiceName;
					}
					else
					{
						GameSettings.damageResponse = GameSettings.damageResponse.GetAtIndex(gsOvRdNum) as DamageResponse;
						newValueStr = GameSettings.damageResponse.NiceName;
					}
					break;
				}
				case MenuBoxItems.START_WITH_MUSHROOM:
				{
					newValueStr = convertToOnOffStr(GameSettings.startWithMushroom = !GameSettings.startWithMushroom);
					break;
				}
				case MenuBoxItems.RESTORE_DEFAULTS:
				{
					GameSettings.resetDifficultySettings();
					nextMsgBxToCreate = new DifficultySettingsMenu(_cSelNum);
					cancel();
					break;
				}
				case MenuBoxItems.BACK:
				{
					cancel();
					break;
				}
			}
			afterChooseItem(itemName, newValueStr, itemTfc, disableChooseItemSnd);
			disableChooseItemSnd = false;
		}
		public function forceChooseItem(name:String):void
		{
			var n:int = ARR_VEC.length;
			var num:int;
			for (var i:int = 0; i < n; i++) 
			{
				var itemName:String = ARR_VEC[i][IND_ARR_VEC_NAME];
				if (name == itemName)
				{
					num = i;
					break;
				}
			}
			var value:String = ARR_VEC[num][IND_ARR_VEC_VALUE];
			var tfc:TextFieldContainer = ARR_VEC[num][IND_ARR_VEC_TEXT_FIELD] as TextFieldContainer;
			disableChooseItemSnd = true;
			chooseItem(name, value, tfc, GameSettings.INCREASE_SETTING_NUM);
		}
		override public function pressAtkBtn():void
		{
			//			MSG_BX_MNGR.writeNextMainMenu(this);
			cancel();
			SND_MNGR.playSoundNow(SN_CANCEL_ITEM);
		}
		override protected function destroy():void
		{
			super.destroy();
			instance = null;
		}
	}
}