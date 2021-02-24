package com.smbc.pickups 
{
	import com.explodingRabbit.display.CustomMovieClip;
	import com.explodingRabbit.utils.CustomDictionary;
	import com.smbc.data.AnimationTimers;
	import com.smbc.data.MapInfo;
	import com.smbc.data.PickupInfo;
	import com.smbc.events.CustomEvents;
	import com.smbc.ground.Ground;
	import com.smbc.interfaces.ICustomTimer;
	import com.smbc.level.Level;
	import com.smbc.main.AnimatedObject;
	import com.smbc.managers.EventManager;
	import com.smbc.managers.GraphicsManager;
	import com.smbc.projectiles.*;
	import com.smbc.sound.*;
	
	import flash.events.Event;
	
	public class Coin extends Pickup
	{
		private static const FL_END:String = "end";
		private static const FL_START:String = "start";
		private static var animEndFrameNum:int;
		private static const NUM_ANIM_FRAMES:int = 4;
		private static var animStartFrameDelay:int;
		protected var animDelCtr:int;
		private static const CHANGE_MAP_FCT_DCT:CustomDictionary = new CustomDictionary(true);
		{
			EventManager.EVENT_MNGR.addEventListener(CustomEvents.CHANGE_MAP_SKIN, changeMapSkinHandler, false, 0, true);
		}

		public function Coin(stopFrame:String) 
		{ 
			super(PickupInfo.COIN);
			behindGround = true;
			_boomerangGrabbable = true;
			stopAnim = false;
			mainAnimTmr = AnimationTimers.ANIM_SLOWEST_TMR;
			playsRegularSound = true;
			defyGrav = true;
			bottomAo = true;
			level.ALWAYS_ANIM_DCT.addItem(this);
			CHANGE_MAP_FCT_DCT.addItem(changeMapSkinLocalHandler);
			addHitTestableItem(HT_BRICK);
		}
		protected static function changeMapSkinHandler(event:Event):void
		{
			var gm:GraphicsManager = GraphicsManager.INSTANCE;
//			var palette:Array = gm.readPalette(gm.drawingBoardMapSkinCont.bmd, GraphicsManager.MAP_INFO_ARR[MapInfo.Coin][GraphicsManager.INFO_ARR_IND_CP]);
			var coin:CustomMovieClip = new CustomMovieClip(null,null,"Coin");
			animStartFrameDelay = gm.getFrameDelay( coin.getPaletteByRow(0) );
			animEndFrameNum = NUM_ANIM_FRAMES + coin.convFrameToInt(FL_START) - 1;
			while ( animEndFrameNum > 0 && coin.frameIsEmpty( animEndFrameNum ) )
			{
				animEndFrameNum--;
			}
			for each (var fct:Function in CHANGE_MAP_FCT_DCT)
			{
				fct();
			}
		}
		public static function initiateLevelHandler():void
		{
			changeMapSkinHandler(null);
		}
		private function changeMapSkinLocalHandler():void
		{
			if (!stopAnim)
				gotoAndStop(FL_START);
			animDelCtr = 0;
		}
		override public function gBounceHit(g:Ground):void
		{
			destroy();
			var fc:FlyingCoin = new FlyingCoin();
			fc.getAlternateInfo(this);
			level.addToLevel(fc);
			EVENT_MNGR.getCoin();
		}
		override public function rearm():void
		{
			super.rearm();
			level.ALWAYS_ANIM_DCT.addItem(this);
		}
		override public function disarm():void
		{
			level.ALWAYS_ANIM_DCT.removeItem(this);
			super.disarm();
		}
		
		override public function animate(ct:ICustomTimer):Boolean
		{
			if (currentFrameLabel == FL_START && animDelCtr < animStartFrameDelay && mainAnimTmr == ct)
				animDelCtr ++;
			else
			{
				animDelCtr = 0;
				return super.animate(ct);
			}
			return false;
		}
		
		override public function checkFrame():void
		{
			if (currentFrame == animEndFrameNum + 1)
				gotoAndStop(FL_START);
		}
		override public function cleanUp():void
		{
			super.cleanUp();
			if (level)
				level.ALWAYS_ANIM_DCT.removeItem(this);
			CHANGE_MAP_FCT_DCT.removeItem(changeMapSkinLocalHandler);
		}
			
	}
	
}