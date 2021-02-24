package com.smbc.level
{
	import com.explodingRabbit.utils.CustomDictionary;
	import com.smbc.SuperMarioBrosCrossover;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.Background;
	import com.smbc.graphics.HudAlwaysOnTop;
	import com.smbc.graphics.ScorePop;
	
	import flash.display.Sprite;
	
	public class LevelForeground extends LevelGraphicLayerContainer
	{
		public static var instance:LevelForeground;
		private static const HudTop:HudAlwaysOnTop = HudAlwaysOnTop.INSTANCE;
		public var SCORE_POP_DCT:CustomDictionary = new CustomDictionary();
		public function LevelForeground(level:Level)
		{
			super(level);
			if (instance)
				throw new SingletonError();
			instance = this;
			SuperMarioBrosCrossover.game.addChild(this);
			addChild(HudTop);
			type = Background.TYPE_FG;
		}
		public function addScorePop(scorePop:ScorePop):void
		{
			SCORE_POP_DCT.addItem(scorePop);
			HudTop.addChild(scorePop);
		}
		public function removeScorePop(scorePop:ScorePop):void
		{
			SCORE_POP_DCT.removeItem(scorePop);
		}
		private function removeAllScorePops():void
		{
			for each (var scorePop:ScorePop in SCORE_POP_DCT)
			{
				scorePop.destroy();
			}
		}
		public function updateScorePops():void
		{
			for each (var scorePop:ScorePop in SCORE_POP_DCT)
			{
				scorePop.update();
			}
		}
		override public function destroy():void
		{
			removeAllScorePops();
			super.destroy();
			instance = null;
			
		}
	}
}