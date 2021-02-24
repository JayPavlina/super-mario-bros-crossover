package com.smbc.graphics
{
	import com.smbc.data.AnimationTimers;
	import com.smbc.data.SoundNames;
	import com.smbc.main.LevObj;
	import com.smbc.main.SimpleAnimatedObject;
	import com.smbc.utils.GameLoopTimer;
	
	public class BillSimpleGraphics extends SimpleAnimatedObject
	{
		public static const TYPE_ENEMY_EXPLOSION:String = "enemyExplosion";
		private static const FL_ENEMY_EXPLOSION_END:String = "enemyExplosionEnd";
		private static const FL_ENEMY_EXPLOSION_START:String = "enemyExplosionStart";
		private var type:String;
		private var source:LevObj;
		
		public function BillSimpleGraphics(source:LevObj,type:String)
		{
			super();
			this.type = type;
			this.source = source;
			switch(type)
			{
				case TYPE_ENEMY_EXPLOSION:
				{
					accurateAnimTmr = new GameLoopTimer(AnimationTimers.DEL_SLOWEST);
					x = source.hMidX;
					y = source.hMidY;
					source.destroy();
					SND_MNGR.playSound(SoundNames.SFX_BILL_ENEMY_EXPLODE);
					break;
				}
			}
		}
		
		override public function checkFrame():void
		{
			if (type == TYPE_ENEMY_EXPLOSION && currentFrame == convFrameToInt(FL_ENEMY_EXPLOSION_END) + 1)
				destroy();
		}
		
		
	}
}