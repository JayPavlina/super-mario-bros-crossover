package com.smbc.graphics
{
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.characters.Bass;
	import com.smbc.characters.Character;
	import com.smbc.characters.MegaMan;
	import com.smbc.characters.base.MegaManBase;
	import com.smbc.data.AnimationTimers;
	import com.smbc.data.CharacterInfo;
	import com.smbc.events.CustomEvents;
	import com.smbc.main.LevObj;
	import com.smbc.main.SimpleAnimatedObject;
	import com.smbc.utils.GameLoopTimer;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	
	public class MegaManSimpleGraphics extends SimpleAnimatedObject
	{
		public static const TYPE_DAMAGE_SPLASH:String = "damageSplash";
		public static const TYPE_DAMAGE_SPARK:String = "damageSpark";
		public static const TYPE_ENEMY_EXPLOSION:String = "enemyExplosion";
		public static const TYPE_CHARGE_KICK:String = "chargeKick";
		public static const TYPE_SLIDE_DUST:String = "slideDust"
		private static const FL_CHARGE_KICK_END:String = "chargeKickEnd";
		private static const FL_CHARGE_KICK_START:String = "chargeKickStart";
		public static const FL_DAMAGE_SPLASH:String = "damageSplash";
		public static const FL_DAMAGE_SPARK_END:String = "damageSparkEnd";
		public static const FL_DAMAGE_SPARK_START:String = "damageSparkStart";
		public static const FL_ENEMY_EXPLOSION_END:String = "enemyExplosionEnd";
		public static const FL_ENEMY_EXPLOSION_START:String = "enemyExplosionStart";
		public static const FL_SLIDE_DUST_END:String = "slideDustEnd";
		public static const FL_SLIDE_DUST_START:String = "slideDustStart";
		private static const DAMAGE_SPLASH_FLICKER_TMR_DEL:int = 50;
		private static const DAMAGE_SPARK_1_OFS_PNT:Point = new Point(-24,-8);
		private static const DAMAGE_SPARK_2_OFS_PNT:Point = new Point(0,-14);
		private static const DAMAGE_SPARK_3_OFS_PNT:Point = new Point(24,-8);
		private static const SLIDE_DUST_OFS_PNT:Point = new Point(-32, 0);
		private static const SLIDE_DUST_ANIM_TMR_DEL:int = 130;
		private static const SPARK_ANIM_TMR_DEL:int = 130;
		public static const EXPLOSION_ANIM_TMR_DEL:int = 32;
		private static const CHARGE_KICK_ANIM_TMR_DEL:int = 80;
		private static const CHARGE_KICK_X_OFS:int = 16;
		private var slideDustOfsPnt:Point;
		private var sparkNum:int;
		private var sparkOfsPnt:Point;
		
		public var type:String;
		private var source:LevObj;
		
		public function MegaManSimpleGraphics(source:LevObj,type:String,sparkNum:int = 0)
		{
			this.type = type;
			this.source = source;
			this.sparkNum = sparkNum;
			var charNum:int = player.charNum;
			if (charNum != Bass.CHAR_NUM && charNum != MegaMan.CHAR_NUM)
				charNum = MegaMan.CHAR_NUM;
			inheritedForceShortClassName = CharacterInfo.CHAR_ARR[charNum][CharacterInfo.IND_CHAR_NAME_CLASS]+"SimpleGraphics";
			super();
			setUpType();
		}
		
		private function setUpType():void
		{
			switch(type)
			{
				case TYPE_DAMAGE_SPLASH:
				{
					gotoAndStop(FL_DAMAGE_SPLASH);
					x = source.nx;
					y = source.ny - source.height/2;
					stopAnim = true;
					stopUpdate = false;
					source.addEventListener(CustomEvents.CHARACTER_TAKE_DAMAGE_END,characterTakeDamageEndHandler,false,0,true);
					visible = !player.visible;
					level.addToLevel( new MegaManSimpleGraphics(source,TYPE_DAMAGE_SPARK,1) );
					level.addToLevel( new MegaManSimpleGraphics(source,TYPE_DAMAGE_SPARK,2) );
					level.addToLevel( new MegaManSimpleGraphics(source,TYPE_DAMAGE_SPARK,3) );
					break;
				}
				case TYPE_DAMAGE_SPARK:
				{
					gotoAndStop(FL_DAMAGE_SPARK_START);
					stopAnim = false;
					stopUpdate = false;
					sparkOfsPnt = classObj["DAMAGE_SPARK_" + sparkNum.toString() + "_OFS_PNT"];
					x = source.nx + sparkOfsPnt.x;
					y = source.ny - source.height + sparkOfsPnt.y;
					accurateAnimTmr = new GameLoopTimer(SPARK_ANIM_TMR_DEL);
					break;
				}
				case TYPE_ENEMY_EXPLOSION:
				{
					x = source.hMidX;
					y = source.hMidY;
					source.destroy();
					stopAnim = false;
					gotoAndStop(FL_ENEMY_EXPLOSION_START);
					accurateAnimTmr = new GameLoopTimer(EXPLOSION_ANIM_TMR_DEL);
					break;
				}
				case TYPE_CHARGE_KICK:
				{
					x = source.nx + CHARGE_KICK_X_OFS*source.scaleX;;
					y = source.ny - source.height/2;
					stopAnim = false;
					stopUpdate = false;
					scaleX = source.scaleX;
					gotoAndStop(FL_CHARGE_KICK_START);
					accurateAnimTmr = new GameLoopTimer(CHARGE_KICK_ANIM_TMR_DEL);
					EVENT_MNGR.addEventListener(CustomEvents.LEVEL_SET_INDEXES,levelSetIndexesHandler,false,0,true);
					break;
				}
				case TYPE_SLIDE_DUST:
				{
					gotoAndStop(FL_SLIDE_DUST_START);
					stopAnim = false;
					stopUpdate = false;
					slideDustOfsPnt = classObj["SLIDE_DUST_OFS_PNT"];
					x = source.nx - 32;
					y = source.ny - 8;
					accurateAnimTmr = new GameLoopTimer(SLIDE_DUST_ANIM_TMR_DEL);
//					EVENT_MNGR.addEventListener(CustomEvents.LEVEL_SET_INDEXES,levelSetIndexesHandler,false,0,true);
					break;
				}
			}
		}
		
		protected function levelSetIndexesHandler(event:Event):void
		{
			if (type == TYPE_CHARGE_KICK)
				parent.setChildIndex(this,parent.numChildren - 1);
			
		}
		
		protected function characterTakeDamageEndHandler(event:Event):void
		{
			if (type == TYPE_DAMAGE_SPLASH)
				destroy();
		}
		
		override public function updateObj():void
		{
			super.updateObj();
			if (type == TYPE_DAMAGE_SPLASH)
			{
				x = source.nx;
				y = source.ny - source.height/2;
			}
			else if (type == TYPE_DAMAGE_SPARK)
			{
				x = source.nx + sparkOfsPnt.x;
				y = source.ny - source.height + sparkOfsPnt.y;
			}
			else if (type == TYPE_CHARGE_KICK)
			{
				x = source.nx + CHARGE_KICK_X_OFS * source.scaleX;
				y = source.ny - source.height / 2;
			}
			else if (type == TYPE_SLIDE_DUST)
			{
				x = source.nx + slideDustOfsPnt.x;
				y = source.ny;
			}
		}
		
		override protected function reattachLsrs():void
		{
			super.reattachLsrs();
//			EVENT_MNGR.addEventListener(CustomEvents.LEVEL_SET_INDEXES,levelSetIndexesHandler,false,0,true);
			source.addEventListener(CustomEvents.CHARACTER_TAKE_DAMAGE_END,characterTakeDamageEndHandler,false,0,true);
		}
		
		override protected function removeListeners():void
		{
			super.removeListeners();
			source.removeEventListener(CustomEvents.CHARACTER_TAKE_DAMAGE_END,characterTakeDamageEndHandler);
			if (type == TYPE_CHARGE_KICK)
				EVENT_MNGR.removeEventListener(CustomEvents.LEVEL_SET_INDEXES,levelSetIndexesHandler);
		}
		
		override public function checkFrame():void
		{
			if (type == TYPE_DAMAGE_SPARK && currentFrame == convFrameToInt( FL_DAMAGE_SPARK_END) + 1)
				destroy();
			else if (type == TYPE_ENEMY_EXPLOSION && currentFrame == convFrameToInt( FL_ENEMY_EXPLOSION_END) + 1)
				destroy();
			else if (type == TYPE_CHARGE_KICK && currentFrame == convFrameToInt(FL_CHARGE_KICK_END) + 1)
				gotoAndStop(FL_CHARGE_KICK_START);
			else if (type == TYPE_SLIDE_DUST && currentFrame == convFrameToInt(FL_SLIDE_DUST_END))
				destroy();
		}
	}
}