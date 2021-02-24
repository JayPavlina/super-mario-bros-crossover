package com.smbc.graphics
{
	import com.explodingRabbit.display.CustomMovieClip;
	import com.explodingRabbit.utils.CustomDictionary;
	import com.smbc.data.AnimationTimers;
	import com.smbc.data.InterfaceInfo;
	import com.smbc.data.MapInfo;
	import com.smbc.events.CustomEvents;
	import com.smbc.ground.ItemBlock;
	import com.smbc.interfaces.ICustomTimer;
	import com.smbc.main.SkinObj;
	import com.smbc.managers.EventManager;
	import com.smbc.managers.GraphicsManager;
	
	import flash.events.Event;
	
	public class CoinSymbol extends SkinObj
	{
		public static var instance:CoinSymbol;
		public static const FL_START:String = "start";
		public static const FL_END:String = "end";
		public static var animEndFrameNum:int;
		private static const NUM_ANIM_FRAMES:int = 4;
		public static var animStartFrameDelay:int;
		protected var animDelCtr:int;
		private static const CHANGE_MAP_FCT_DCT:CustomDictionary = new CustomDictionary(true);
		{
			EventManager.EVENT_MNGR.addEventListener(CustomEvents.CHANGE_INTERFACE_SKIN, changeInterfaceSkinHandler, false, 0, true);
		}
		public function CoinSymbol()
		{
			super();
			mainAnimTmr = AnimationTimers.ANIM_SLOWEST_TMR;
		}
		public static function getInstance():CoinSymbol
		{
			instance = new CoinSymbol();
			return instance;
		}
		public function initiateLevelHandler():void
		{
			gotoAndStop(FL_START);
			animDelCtr = 0;
		}
		protected static function changeInterfaceSkinHandler(event:Event):void
		{
			var gm:GraphicsManager = GraphicsManager.INSTANCE;
//			var palette:Array = gm.readPalette(gm.drawingBoardInterfaceSkinCont.bmd, GraphicsManager.INTERFACE_INFO_ARR[InterfaceInfo.CoinSymbol][GraphicsManager.INFO_ARR_IND_CP]);
			var test:CustomMovieClip = new CustomMovieClip(null,null,"CoinSymbol");
			animStartFrameDelay = gm.getFrameDelay( test.getPaletteByRow(0) );
			animEndFrameNum = NUM_ANIM_FRAMES + test.convFrameToInt(FL_START) - 1;
			while ( animEndFrameNum > 0 && test.frameIsEmpty( animEndFrameNum ) )
			{
				animEndFrameNum--;
			}
			instance.gotoAndStop(FL_START);
			instance.animDelCtr = 0;
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
//			var masterIb:ItemBlock = ItemBlock.masterItemBlock;
//			if (masterIb && ItemBlock.animEndFrameNum == animEndFrameNum && ItemBlock.animStartFrameDelay == animStartFrameDelay)
//			{
//				gotoAndStop(masterIb.currentFrame);
//			}
			return false;
		}
		override public function checkFrame():void
		{
			if (currentFrame == animEndFrameNum + 1)
				gotoAndStop(FL_START);
		}
	}
}