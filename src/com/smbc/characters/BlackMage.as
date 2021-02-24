package com.smbc.characters
{
	import com.smbc.data.Spell;
	import com.smbc.displayInterface.FinalFantasyPointer;
	import com.smbc.projectiles.BlackMageSpell;
	
	import flash.geom.Point;

	public class BlackMage extends WarriorOfLight
	{
		private static const COPY_PIXELS_Y_OFS:int = 47*4;
		
		public function BlackMage()
		{
			copyPixelsYOfs = COPY_PIXELS_Y_OFS;
			super();
		}
		
		override protected function upAttack():void
		{
			super.upAttack();
//			createPointer(FinalFantasyPointer.TYPE_HORIZONTAL);
			spellToCast = Spell.SPELL_BOLT;
			prepareSpell();
		}
		override protected function sideAttack():void
		{
			super.sideAttack();
			spellToCast = Spell.SPELL_FIRE;
			prepareSpell();
		}
		override protected function downAttack():void
		{
			super.downAttack();
			spellToCast = Spell.SPELL_ICE;
			prepareSpell();
//			createPointer();
		}
		override protected function castSpell(spellToCast:Spell):void
		{
			super.castSpell(spellToCast);
			var pnt:Point;
			if (pointer)
				pnt = level.globalToLocal( new Point(pointer.x,pointer.y) );
			level.addToLevel( new BlackMageSpell(this, spellToCast, pnt ) );
		}
		
		
	}
}