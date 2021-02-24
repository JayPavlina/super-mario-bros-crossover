package com.smbc.graphics
{
	import com.smbc.characters.Simon;
	import com.smbc.data.AnimationTimers;
	import com.smbc.events.CustomEvents;
	import com.smbc.main.LevObj;
	import com.smbc.main.SimpleAnimatedObject;
	import com.smbc.utils.GameLoopTimer;
	
	import flash.events.Event;
	
	public class SimonSimpleGraphics extends SimpleAnimatedObject
	{
		public static const TYPE_DESTROY_FLAME:String = "destroyFlame";
		public static const TYPE_WHIP_SPARK:String = "whipSpark";
		private static const FL_DESTROY_FLAME_END:String = "destroyFlameEnd";
		private static const FL_DESTROY_FLAME_START:String = "destroyFlameStart";
		private static const FL_WHIP_SPARK:String = "whipSpark";
		private var type:String;
		private var source:LevObj;
		public function SimonSimpleGraphics(source:LevObj,type:String,attacker:LevObj = null)
		{
			this.source = source;
			this.type = type;
			super();
			switch(type)
			{
				case TYPE_DESTROY_FLAME:
				{
					gotoAndStop(FL_DESTROY_FLAME_START);
					accurateAnimTmr = new GameLoopTimer(AnimationTimers.DEL_SLOW);
					x = source.hMidX;
					y = source.hMidY;		
					source.destroy();
					break;
				}
				case TYPE_WHIP_SPARK:
				{
					accurateAnimTmr = new GameLoopTimer(220);
					if (source.nx > attacker.nx)
						x = source.hLft;
					else
						x = source.hRht;
					y = attacker.hMidY;
					gotoAndStop(FL_WHIP_SPARK);
					EVENT_MNGR.addEventListener(CustomEvents.LEVEL_SET_INDEXES,levelSetIndexesHandler,false,0,true);
					break;
				}
			}
			
		}
		
		protected function levelSetIndexesHandler(event:Event):void
		{
			if (type == TYPE_WHIP_SPARK && parent)
				level.setChildIndex(this, level.numChildren - 1);
		}
		
		override public function checkFrame():void
		{
			if (type == TYPE_DESTROY_FLAME && currentFrame == convFrameToInt(FL_DESTROY_FLAME_END) + 1)
				destroy();
			else if (type == TYPE_WHIP_SPARK && currentFrameLabel != FL_WHIP_SPARK)
				destroy();
		}
		
		override public function cleanUp():void
		{
			super.cleanUp();
			if (type == TYPE_WHIP_SPARK)
				EVENT_MNGR.removeEventListener(CustomEvents.LEVEL_SET_INDEXES,levelSetIndexesHandler);
		}
		
		
		
	}
}