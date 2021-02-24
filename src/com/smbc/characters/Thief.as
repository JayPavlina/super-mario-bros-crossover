package com.smbc.characters
{
	import com.explodingRabbit.utils.CustomDictionary;
	import com.explodingRabbit.cross.gameplay.statusEffects.StatusProperty;
	import com.smbc.data.DamageValue;
	import com.smbc.interfaces.IAttackable;
	
	import flash.events.TimerEvent;

	public class Thief extends WarriorOfLight
	{
		private static const COPY_PIXELS_Y_OFS:int = 47*2;
		public function Thief()
		{
			copyPixelsYOfs = COPY_PIXELS_Y_OFS;
			super();
			flAttackEnd = FL_ATTACK_END;
//			addProperty(StatusProperty.STUN);
//			addProperty(AttackProperties.NON_BRICK);
		}
		
		override protected function sideAttack():void
		{
			super.sideAttack();
			attack();
		}
		
		override public function landAttack(obj:IAttackable):void
		{
			super.landAttack(obj);
			if (ATK_DCT[obj])
				return;
			else
				ATK_DCT.addItem(obj);
			obj.hitByAttack(this,DamageValue.THIEF_ATTACK);
		}
	}
}