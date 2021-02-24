package com.smbc.graphics
{
	import com.smbc.data.CharacterInfo;
	import com.smbc.events.CustomEvents;
	import com.smbc.main.SimpleAnimatedObject;
	import com.smbc.managers.EventManager;
	import com.smbc.managers.StatManager;
	
	import flash.events.Event;
	
	public class NPC extends Scenery
	{
		public static const TYPE_TOAD:String = "toad";
		public static const TYPE_PRINCESS:String = "princess";
		public var type:String;
		
		public function NPC(scenery:Scenery)
		{
			inheritedForceShortClassName = CharacterInfo.getCharClassName(StatManager.STAT_MNGR.curCharNum) + "Icon"; 
			super(currentLabel);
			if (scenery.currentLabel == Scenery.FL_TOAD_BOT)
				type = TYPE_TOAD;
			else if (scenery.currentLabel == Scenery.FL_PRINCESS_BOT)
				type = TYPE_PRINCESS;
//			destroyOffScreen = false;
			x = scenery.x + TILE_SIZE/2;
			y = scenery.y + TILE_SIZE;
			gotoAndStop(type);
			stopAnim = true;
//			EventManager.EVENT_MNGR.addEventListener(CustomEvents.CHANGE_MAP_SKIN, fuck, false, 0, true);
//			addEventListener(Event.ADDED_TO_STAGE, added, false, 0, true);
//			addEventListener(Event.REMOVED_FROM_STAGE, removed, false, 0, true);
		}
		
//		protected function added(event:Event):void
//		{
//			trace("added");
//		}
//		
//		protected function removed(event:Event):void
//		{
//			trace("removed");
//		}
	}
}