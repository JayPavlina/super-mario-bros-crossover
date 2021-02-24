package com.smbc.messageBoxes
{
	import com.smbc.data.Cheats;
	import com.smbc.data.GameSettings;
	import com.smbc.main.GlobVars;
	import com.smbc.managers.MessageBoxManager;
	import com.smbc.managers.ScreenManager;
	import com.smbc.managers.SoundManager;
	import com.smbc.managers.TutorialManager;
	import com.smbc.text.TextFieldContainer;
	
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.events.MouseEvent;
	
	public class StartMenu extends MenuBox
	{
		public static var instance:StartMenu;
		public static var lastIndex:int;
		private const END_Y:int = 190;
		private const STAGE:Stage = GlobVars.STAGE;
		
		public function StartMenu(startIndexOverride:int = 0)
		{
			instance = this;
			super(loadItems(), startIndexOverride);
//			endYPos = END_Y;
		}
		private function loadItems():Array
		{
			var arr:Array = [
//				[MenuBoxItems.QUICK_PLAY],
				[MenuBoxItems.NEW_GAME],
				[MenuBoxItems.LOAD_GAME],
				[MenuBoxItems.OPTIONS],
//				[MenuBoxItems.VIEW_WIKI],
//				[MenuBoxItems.SUPER_RETRO_SQUAD],
				[MenuBoxItems.LINKS],
//				[MenuBoxItems.VIEW_STATS],
//				[MenuBoxItems.CHEATS]
			];
		//	if ( !Cheats.getLockStatus(MenuBoxItems.LEVEL_SELECT) )
		//		arr.push([MenuBoxItems.LEVEL_SELECT]);
			return arr;
		}

		override protected function chooseItem(itemName:String, itemValue:String, itemTfc:TextFieldContainer, gsOvRdNum:int):void
		{
			lastIndex = _cSelNum;
			super.chooseItem(itemName, itemValue, itemTfc, gsOvRdNum);
		}
		
		override protected function reachedMaxSize():void
		{
			super.reachedMaxSize();
			STAGE.addEventListener(MouseEvent.CLICK,mouseClickHandler,false,0,true);
		}
		override public function cancel():void
		{
			STAGE.removeEventListener(MouseEvent.CLICK,mouseClickHandler);
			super.cancel();
		}
		private function mouseClickHandler(event:MouseEvent):void
		{
			if (event.stageY > GlobVars.STAGE_HEIGHT - GlobVars.TILE_SIZE*2)
				return;
			nextMsgBxToCreate = new PlainMessageBox(MessageBoxMessages.USE_ARROW_KEYS);
			MessageBoxManager.INSTANCE.writeNextMainMenu(nextMsgBxToCreate);
			cancel();
			SoundManager.SND_MNGR.playSoundNow(MessageBoxSounds.SN_CANCEL_ITEM);
		}
		override protected function destroy():void
		{
			MSG_BX_MNGR.saveLastMenuPosition();
			instance = null;
			super.destroy();
		}

		override public function pressPseBtn():void
		{
			mouseClickHandler( new MouseEvent( MouseEvent.CLICK ) );
		}
		override public function pressAtkBtn():void
		{
			cancel();
		}
	}
}