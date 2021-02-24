package com.smbc.interfaces
{
	import com.explodingRabbit.cross.gameplay.statusEffects.StatusEffect;
	import com.explodingRabbit.cross.gameplay.statusEffects.StatusProperty;
	import com.explodingRabbit.utils.CustomDictionary;
	import com.smbc.main.LevObj;
	import com.smbc.projectiles.Projectile;
	
	import flash.display.MovieClip;

	public interface IAttackable
	{
		function hitByAttack(source:LevObj,dmg:int):void
		function get health():int
		function hit(mc:LevObj,hType:String):void
		function confirmedHitProj(proj:Projectile):void
		function getProperty(type:String):StatusProperty
		function isSusceptibleToProperty(aggProp:StatusProperty):Boolean
		function getStatusEffect(type:String):StatusEffect
	}
}