package com.smbc.characters
{
	import com.smbc.data.CharacterInfo;
	import com.smbc.data.DamageValue;
	import com.smbc.interfaces.IAttackable;
	
	import flash.events.TimerEvent;

	public class Fighter extends WarriorOfLight
	{
		private static const COPY_PIXELS_Y_OFS:int = 0;
		
		public function Fighter()
		{
			copyPixelsYOfs = COPY_PIXELS_Y_OFS;
			super();
			flAttackEnd = FL_ATTACK_END;
			trace("this is a fighter");
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
			obj.hitByAttack(this,DamageValue.FIGHTER_SWORD);
		}
	}
}