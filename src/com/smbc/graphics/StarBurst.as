package com.smbc.graphics
{
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.data.AnimationTimers;
	import com.smbc.enemies.Enemy;
	import com.smbc.main.LevObj;
	import com.smbc.main.SimpleAnimatedObject;
	
	public class StarBurst extends SimpleAnimatedObject
	{
		public static const ENEMY_OFS:int = 12;
		private static const FL_END:String = "end";
		private static const FL_START:String = "start";
		public static const TYPE_FIREBALL:int = 0;
		public static const TYPE_SHELL_WALL:int = 1;
		public static const TYPE_SHELL_ENEMY:int = 2;
		public static const TYPE_SHELL_KICK:int = 3;
		public static const TYPE_STAR:int = 4;
		public static const TYPE_BELOW:int = 5;
		
		public function StarBurst(enemy:Enemy, type:int, otherObj:LevObj = null)
		{
			super();
			stopAnim = false;
			accurateAnimTmr = new CustomTimer(AnimationTimers.DEL_FAST);
			gotoAndStop(FL_START);
			calcPosition(enemy,type,otherObj);
		}
		private function calcPosition(enemy:Enemy,type:int,otherObj:LevObj = null):void
		{
			var ofs:Number;
			if (type == TYPE_BELOW || type == TYPE_STAR)
				type = TYPE_SHELL_KICK;
			switch(type)
			{
				case TYPE_FIREBALL:
				{
					if (otherObj.nx < enemy.nx)
						x = enemy.nx + ENEMY_OFS;
					else
						x = enemy.nx - ENEMY_OFS;
					y = enemy.y;
					break;
				}
				case TYPE_SHELL_WALL:
				{
					ofs = ENEMY_OFS;
					x = enemy.nx + ENEMY_OFS*enemy.scaleX;
					y = enemy.y;
					break;
				}
				case TYPE_SHELL_ENEMY:
				{
					ofs = ENEMY_OFS;
					x = enemy.nx + ENEMY_OFS*enemy.scaleX;
					y = enemy.y;
					break;
				}
				case TYPE_SHELL_KICK:
				{
					x = enemy.nx;
					y = enemy.ny;
					break;
				}
			}
		}
		override public function checkFrame():void
		{
			if (currentLabel == FL_END)
				destroy();
		}
	}
}