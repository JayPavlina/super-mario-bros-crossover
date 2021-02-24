package com.smbc.graphics
{
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.characters.Samus;
	import com.smbc.data.AnimationTimers;
	import com.smbc.displayInterface.SamusMissileCount;
	import com.smbc.main.LevObj;
	import com.smbc.main.SimpleAnimatedObject;
	import com.smbc.projectiles.SamusBomb;
	import com.smbc.projectiles.SamusGuts;
	import com.smbc.projectiles.SamusShot;
	import com.smbc.utils.GameLoopTimer;
	
	public class SamusSimpleGraphics extends SimpleAnimatedObject
	{
		public static const TYPE_MISSILE_EXPLOSION:String = "missileExplosion";
		public static const TYPE_ENEMY_EXPLOSION:String = "enemyExplosion";
		private static const FL_MISSILE_EXPLOSION_START:String = "missileExplosionStart";
		private static const FL_MISSILE_EXPLOSION_END:String = "missileExplosionEnd";
		private static const FL_ENEMY_EXPLOSION_START:String = "enemyExplosionStart";
		private static const FL_ENEMY_EXPLOSION_END:String = "enemyExplosionEnd";
		private static const MAIN_ANIM_TMR:CustomTimer = AnimationTimers.ANIM_FAST_TMR;
		private var type:String;
		private var source:LevObj;
		private var attacker:LevObj;
		public function SamusSimpleGraphics(source:LevObj,type:String,attacker:LevObj = null)
		{
			super();
			this.source = source;
			this.type = type;
			this.attacker = attacker;
			switch(type)
			{
				case TYPE_MISSILE_EXPLOSION:
				{
					accurateAnimTmr = new GameLoopTimer(AnimationTimers.DEL_FAST);
					gotoAndStop(FL_MISSILE_EXPLOSION_START);
					x = source.nx;
					y = source.ny;
					break;
				}
				case TYPE_ENEMY_EXPLOSION:
				{
					accurateAnimTmr = new GameLoopTimer(55);
					gotoAndStop(FL_ENEMY_EXPLOSION_START);
					x = source.hMidX;
					y = source.hMidY;
					if ( showGuts() )
					{
						level.addToLevel(new SamusGuts(source,1));
						level.addToLevel(new SamusGuts(source,2));
						//					level.addToLevel(new SamusGuts(source,3));
						level.addToLevel(new SamusGuts(source,4));
						level.addToLevel(new SamusGuts(source,5));
						//					level.addToLevel(new SamusGuts(source,6));
					}
					source.destroy();
					break;
				}
			}
		}
		
		private function showGuts():Boolean
		{
			if (attacker is SamusShot)
			{
				var shotType:String = SamusShot(attacker).shotType;
				if (shotType == SamusShot.SHOT_TYPE_NORMAL || shotType == SamusShot.SHOT_TYPE_WAVE)
					return false;
			}
			return true;
		}
		override public function checkFrame():void
		{
			if (type == TYPE_MISSILE_EXPLOSION && currentFrame == convFrameToInt(FL_MISSILE_EXPLOSION_END) + 1)
				destroy();
			else if (type == TYPE_ENEMY_EXPLOSION && currentFrame == convFrameToInt(FL_ENEMY_EXPLOSION_END) + 1)
				destroy();
		}
	}
}