package com.smbc.level
{
	import com.smbc.SuperMarioBrosCrossover;
	import com.smbc.data.GameSettings;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.Background;
	import com.smbc.graphics.BackgroundInfo;
	import com.smbc.graphics.TopScreenText;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class LevelBackground extends LevelGraphicLayerContainer
	{
		public static var instance:LevelBackground;
//		private var tsTxt:TopScreenText;
		public function LevelBackground(level:Level)
		{
			super(level);
			if (instance)
				throw new SingletonError();
			instance = this;
			var game:SuperMarioBrosCrossover = SuperMarioBrosCrossover.game;
			game.addChildAt( this, game.getChildIndex(level) );
//			getGraphicLayersFct = LevelData.instance.getBGVec;
			type = Background.TYPE_BG;
		}
		override public function initiateLevelHandler():void
		{
//			tsTxt = level.tsTxt;
//			addChild(tsTxt);
			super.initiateLevelHandler();
		}
		override public function setBackgrounds():void
		{
//			if (tsTxt && contains(tsTxt) )
//				removeChild(tsTxt);
			super.setBackgrounds();
			var bg:Background = BG_VEC[0];
			var n:int = bg.numChildren;
			for (var i:int = 0; i<n; i++)
			{
				var dObj:DisplayObject = bg.getChildAt(i);
				if (dObj is TopScreenText)
					bg.removeChild(dObj);
			}
//			if (tsTxt)
//				addChild(tsTxt);
		}
		override public function destroy():void
		{
			super.destroy();
			instance = null;
		}
	}
}