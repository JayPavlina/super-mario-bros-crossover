package com.smbc.displayInterface
{
	import com.smbc.SuperMarioBrosCrossover;
	import com.smbc.characters.WarriorOfLight;
	import com.smbc.main.GlobVars;
	import com.smbc.main.SkinObj;
	
	import flash.events.Event;
	import flash.geom.Point;
	
	public class FinalFantasyPointer extends SkinObj
	{
		private static const SPEED:int = 400;
		public static const TYPE_NORMAL:String = "normal";
		public static const TYPE_HORIZONTAL:String = "horizontal";
		public static const EVENT_CANCEL:String = "eventCancel";
		public static const EVENT_SELECT:String = "eventSelect";		
		private var game:SuperMarioBrosCrossover = SuperMarioBrosCrossover.game;
		private var warrior:WarriorOfLight;
		private var lftBtn:Boolean;
		private var rhtBtn:Boolean;
		private var upBtn:Boolean;
		private var dwnBtn:Boolean;
		private var type:String;
		
		public function FinalFantasyPointer(warrior:WarriorOfLight, type:String = "normal")
		{
			super();
			this.warrior = warrior;
			this.type = type;
		}
		
		override public function initiate():void
		{
//			x = GlobVars.STAGE_WIDTH/2;
//			y = GlobVars.STAGE_HEIGHT/2;
			var pnt:Point = warrior.localToGlobal( GlobVars.ZERO_PT );
			x = pnt.x;
			if (type == TYPE_NORMAL)
				y = pnt.y;
			else
				y = GlobVars.STAGE_HEIGHT/2;
			game.addChild(this);
			
		}	
		/**
		 * called whenever WarriorOfLight gameLoop is called 
		 * 
		 */		
		public function update(dt:Number):void
		{
			if (type == TYPE_NORMAL)
			{
				if (upBtn && !dwnBtn)
					y -= dt*SPEED;
				else if (dwnBtn && !upBtn)
					y += dt*SPEED;
			}
			if (rhtBtn && !lftBtn)
				x += dt*SPEED;
			else if (lftBtn && !rhtBtn)
				x -= dt*SPEED;
		}
		public function pressJmpBtn():void
		{
			dispatchEvent( new Event(EVENT_SELECT) );
			cleanUp();
		}
		public function pressAtkBtn():void
		{
			dispatchEvent( new Event(EVENT_CANCEL) );
			cleanUp();
		}
		public function pressUpBtn():void
		{
			trace("press up btn");
			upBtn = true;
		}
		public function pressDwnBtn():void
		{
			dwnBtn = true;
		}
		public function pressLftBtn():void
		{
			lftBtn = true;
		}
		public function pressRhtBtn():void
		{
			rhtBtn = true;
		}
		public function relUpBtn():void
		{
			upBtn = false;
		}
		public function relDwnBtn():void
		{
			dwnBtn = false;	
		}
		public function relLftBtn():void
		{
			lftBtn = false;
		}
		public function relRhtBtn():void
		{
			rhtBtn = false;
		}
		
		override public function cleanUp():void
		{
			if (game.contains(this))
				game.removeChild(this);
			if (warrior)
				warrior.removePointer();
		}
		
	}
}