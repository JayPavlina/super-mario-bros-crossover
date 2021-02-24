package com.smbc.projectiles
{
	import com.explodingRabbit.display.CustomMovieClip;
	import com.smbc.characters.BlackMage;
	import com.smbc.data.AnimationTimers;
	import com.smbc.data.DamageValue;
	import com.smbc.data.Spell;
	import com.smbc.interfaces.IAttackable;
	import com.smbc.main.GlobVars;
	import com.smbc.main.LevObj;
	
	import flash.geom.Point;
	import flash.profiler.showRedrawRegions;
	
	public class BlackMageSpell extends Projectile
	{
		public static const TYPE_FIRE:String = "fire";
		public static const TYPE_BOLT:String = "bolt";
		public static const TYPE_ICE:String = "ice";
		private static const FIRE_SPEED:int = 450;
		private static const FIRE_X_OFS:int = 38;
		private static const FIRE_Y_OFS:int = 27;
		private static const BOLT_OFS_PNT:Point = new Point(100,0);
		private static const FIRE_OFS_PNT:Point = new Point(38,27);
		private static const ICE_OFS_PNT:Point = new Point(100,27);
		
		public var spell:Spell;
		private var mage:BlackMage;
		private var spellPnt:Point;
		public function BlackMageSpell(origin:LevObj,spell:Spell, spellPnt:Point = null)
		{
			super(origin,SOURCE_TYPE_PLAYER);
			this.spell = spell;
			this.spellPnt = spellPnt;
			mage = origin as BlackMage;
			defyGrav = true;
			if (spell == Spell.SPELL_FIRE)
				setUpFire();
			else if (spell == Spell.SPELL_ICE)
				setUpIce();
			else if (spell == Spell.SPELL_BOLT)
				setUpBolt();
			gotoAndStop(spell.name+"Start");
		}
		
		private function setUpFire():void
		{	
			var msx:Number = mage.scaleX;
			x = mage.nx + FIRE_X_OFS*msx;
			y = mage.ny - FIRE_Y_OFS;
			vx = FIRE_SPEED*msx;
			scaleX = msx;
			mainAnimTmr = AnimationTimers.ANIM_FAST_TMR;
			_damageAmt = DamageValue.BLACK_MAGE_FIRE;
		}
		private function setUpIce():void
		{	
			var msx:Number = mage.scaleX;
//			x = spellPnt.x;
//			y = spellPnt.y;
			x = mage.nx + ICE_OFS_PNT.x*msx;
			y = mage.ny - ICE_OFS_PNT.y;
//			vx = FIRE_SPEED*msx;
//			scaleX = msx;
			mainAnimTmr = AnimationTimers.ANIM_MODERATE_TMR;
//			noAnimThisCycle = true;
			_damageAmt = DamageValue.BLACK_MAGE_ICE;
		}
		private function setUpBolt():void
		{	
			var msx:Number = mage.scaleX;
//			x = spellPnt.x;
			x = mage.nx + BOLT_OFS_PNT.x*msx;
			y = (GLOB_STG_TOP + GLOB_STG_BOT)/2 + 10;
//			vx = 0;
//			scaleX = msx;
			mainAnimTmr = AnimationTimers.ANIM_MODERATE_TMR;
//			noAnimThisCycle = true;
			_damageAmt = DamageValue.BLACK_MAGE_BOLT;
			hitDistOver = GLOB_STG_BOT/2;
		}
		override public function confirmedHit(mc:IAttackable,damaged:Boolean = true):void
		{
			HIT_OBJS_DCT.addItem(mc);
			/*if (!passThrough)
			{
				destroy();
			}
			else if (mc.health > 0)
				destroy();*/
		}
		override public function checkFrame():void
		{
			super.checkFrame();
			var cf:int = currentFrame;
			if (cf == getLabNum(spell.name+"End") + 1)
			{
				if (spell == Spell.SPELL_FIRE)
					gotoAndStop(spell.name+"Start");
				else
				{
					visible = false;
					destroy();
				}
			}
		}
		
		
		
	}
}