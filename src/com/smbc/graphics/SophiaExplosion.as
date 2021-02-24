package com.smbc.graphics
{
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.characters.Sophia;
	import com.smbc.data.AnimationTimers;
	import com.smbc.data.RandomDropGenerator;
	import com.smbc.data.SoundNames;
	import com.smbc.enemies.Enemy;
	import com.smbc.main.AnimatedObject;
	import com.smbc.main.LevObj;
	import com.smbc.main.SimpleAnimatedObject;
	import com.smbc.projectiles.SophiaBullet;
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	public class SophiaExplosion extends SimpleAnimatedObject
	{
		private static const FL_BULLET_EXPLODE_END:String = "bulletExplodeEnd";
		private static const FL_BULLET_EXPLODE_START:String = "bulletExplodeStart";
		private static const FL_ENEMY_DIE_END:String = "enemyDieEnd";
		private static const FL_ENEMY_DIE_START:String = "enemyDieStart";
		private static const FL_SOPHIA_DIE_END:String = "playerDieEnd";
		private static const FL_SOPHIA_DIE_START:String = "playerDieStart";
		private static const ET_BULLET:String = "bullet";
		private static const ET_ENEMY:String = "enemy";
		private static const ET_SOPHIA:String = "sophia";
		private static const MAIN_ANIM_TMR:CustomTimer = AnimationTimers.ANIM_FAST_TMR;
		private var exType:String;
		
		public function SophiaExplosion(exploder:AnimatedObject)
		{
			super();
			stopAnim = false;
			mainAnimTmr = MAIN_ANIM_TMR;
			noAnimThisCycle = true;
			if (exploder is SophiaBullet)
			{
				exType = ET_BULLET;
				gotoAndStop(FL_BULLET_EXPLODE_START);
				x = exploder.nx;
				y = exploder.ny;
				SND_MNGR.playSound(SoundNames.SFX_SOPHIA_BULLET_EXPLODE);
			}
			else if (exploder is Enemy)
			{
				exType = ET_ENEMY;
				gotoAndStop(FL_ENEMY_DIE_START);
				x = exploder.hMidX;
				y = exploder.hMidY;
				exploder.destroy();
				SND_MNGR.playSound(SoundNames.SFX_SOPHIA_KILL_ENEMY);
			}
			else if (exploder is Sophia)
			{
				exType = ET_SOPHIA;
				gotoAndStop(FL_SOPHIA_DIE_START);
				x = exploder.nx;
				y = exploder.ny;
				SND_MNGR.playSound(SoundNames.SFX_SOPHIA_DIE);
			}
			else
				throw new Error("Sophia explosion called on wrong type of object");
		}
		override public function checkFrame():void
		{
			if (exType == ET_BULLET && currentLabel == FL_BULLET_EXPLODE_END)
				destroy();
			else if (exType == ET_ENEMY && currentLabel == FL_ENEMY_DIE_END)
				destroy();
			else if (exType == ET_SOPHIA && currentLabel == FL_SOPHIA_DIE_END)
				destroy();
		}
		override public function destroy():void
		{
			super.destroy();
			if (exType == ET_ENEMY)
				RandomDropGenerator.checkDropItem(Sophia.CHAR_NAME_CAPS,this);
		}
	}
}