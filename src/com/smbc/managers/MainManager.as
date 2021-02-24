package com.smbc.managers
{
	import com.explodingRabbit.utils.CustomDictionary;
	import com.smbc.SuperMarioBrosCrossover;
	import com.smbc.characters.Character;
	import com.smbc.errors.InitiateError;
	import com.smbc.interfaces.IInitiater;
	import com.smbc.interfaces.IManager;
	import com.smbc.level.Level;
	
	import flash.events.EventDispatcher;
	
	
	public class MainManager extends EventDispatcher implements IInitiater, IManager
	{
		public static const MNGR_DCT:CustomDictionary = new CustomDictionary();
		protected var initiated:Boolean;
		protected var game:SuperMarioBrosCrossover;
		protected var gsMngr:GameStateManager;
		protected var grMngr:GraphicsManager;
		protected var btnMngr:ButtonManager;
		protected var statMngr:StatManager;
		protected var scrnMngr:ScreenManager;
		protected var sndMngr:SoundManager;
		protected var eventMngr:EventManager;
		protected var msgBxMngr:MessageBoxManager;
		protected var txtMngr:TextManager;
		protected var tutMngr:TutorialManager;
		protected var level:Level;
		protected var player:Character;
		
		public function initiate():void
		{
			if (initiated)
			{
				throw new InitiateError();
				return;
			}
			initiated = true;
			game = SuperMarioBrosCrossover.game;
			gsMngr = GameStateManager.GS_MNGR;
			btnMngr = ButtonManager.BTN_MNGR;
			statMngr = StatManager.STAT_MNGR;
			scrnMngr = ScreenManager.SCRN_MNGR;
			sndMngr = SoundManager.SND_MNGR;
			eventMngr = EventManager.EVENT_MNGR;
			txtMngr = TextManager.INSTANCE;
			msgBxMngr = MessageBoxManager.INSTANCE;
			tutMngr = TutorialManager.TUT_MNGR;
			grMngr = GraphicsManager.INSTANCE;
		}
		public function clearLevelRefs():void
		{
			level = null;
			player = null;
		}
		public function updateLevelRefs():void
		{
			level = Level.levelInstance;
			player = level.player;
		}

	}
}