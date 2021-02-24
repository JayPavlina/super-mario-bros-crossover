package com.explodingRabbit.cross.gameplay.statusEffects
{
	import com.smbc.characters.base.MegaManBase;
	import com.smbc.data.GameSettings;
	import com.smbc.data.HitTestTypes;
	import com.smbc.data.SoundNames;
	import com.smbc.graphics.Palette;
	import com.smbc.graphics.PaletteSheet;
	import com.smbc.ground.SimpleGround;
	import com.smbc.level.Level;
	import com.smbc.main.GlobVars;
	import com.smbc.main.LevObj;
	import com.smbc.managers.GraphicsManager;
	import com.smbc.managers.SoundManager;
	import com.smbc.managers.StatManager;
	import com.smbc.utils.GameLoopTimer;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.getTimer;
	
	public class StatFxFreeze extends StatusEffect
	{
		private var mainTmr:GameLoopTimer;
		private static const FLASH_TMR_DEL:int = 40;
		private var flashTmr:GameLoopTimer;
		private static const FLASH_START_DEL_FROM_END:int = 1250;
		private var colored:Boolean = true;
		private var duration:int;

		private var fakeGround:SimpleGround;
		public function StatFxFreeze(target:LevObj, duration:int = 0)
		{
			super(TYPE_FREEZE, target);
			this.duration = duration;
			if (duration)
				mainTmr = new GameLoopTimer(duration,1);
		}
		override public function clone(newTarget:LevObj,attacker:LevObj = null):StatusEffect
		{
			return new StatFxFreeze(newTarget,duration);
		}
		override public function apply():void
		{
			super.apply();
			var stopFxDel:int;
			if (mainTmr)
			{
				stopFxDel = mainTmr.delay;
				var flashTmrDel:int = stopFxDel - FLASH_START_DEL_FROM_END;
				if (flashTmrDel < FLASH_START_DEL_FROM_END)
					flashTmrDel = FLASH_START_DEL_FROM_END;
				flashTmr = new GameLoopTimer(flashTmrDel,1);
				flashTmr.addEventListener(TimerEvent.TIMER,flashTmrHandler,false,0,true);
				flashTmr.start();
				mainTmr.addEventListener(TimerEvent.TIMER_COMPLETE,mainTimerHandler,false,0,true);
				mainTmr.start();
			}
			_target.addStatusEffect( new StatFxStop(_target,stopFxDel) );
			if (mainTmr)
			{
				_target.addTmr(mainTmr);
				_target.addTmr(flashTmr);
			}
			_target.removeHitTestableItem(HitTestTypes.CHARACTER);
			fakeGround = new SimpleGround(SimpleGround.BN_BLOCK);
			fakeGround.alpha = 0;
			fakeGround.offGrid = true;
			fakeGround.x = _target.hLft;
			fakeGround.y = _target.hBot - GlobVars.TILE_SIZE; 
			Level.levelInstance.addToLevel(fakeGround);
			fakeGround.removeAllHitTestableItems();
			fakeGround.addHitTestableItem(HitTestTypes.CHARACTER);
			colorFrozen();
			if (Level.levelInstance.player is MegaManBase)
				SoundManager.SND_MNGR.playSound(SoundNames.SFX_MEGA_MAN_ICE_SLASHER_HIT);
		}	
			
		protected function mainTimerHandler(event:Event):void
		{
//			trace("destroy freeze"+mainTmr.delay);
			destroy();
		}
		protected function flashTmrHandler(event:Event):void
		{
			if (flashTmr.numTotalCycles == 1)
			{
				flashTmr.stop();
				flashTmr.numTotalCycles = 0;
				flashTmr.delay = FLASH_TMR_DEL;
				flashTmr.start();
			}
			if (colored)
			{
				_target.resetColor();
				colored = false;
			}
			else
				colorFrozen();
		}
		private function colorFrozen():void
		{
			colored = true;
			var bmpVec:Vector.<Bitmap> = _target.getBmpsFromFrame();
			//			resetColor();
			var GM:GraphicsManager = GraphicsManager.INSTANCE;
			var enemyPalette:int = GameSettings.getEnemyPaletteLimited();
//			var icePalette:Palette = gbPalette.extractRowsAsPalette(14);
//			var gbPalette:Palette = Palette.GBpalette.
			for each (var bmp:Bitmap in bmpVec)
			{
				var bmd:BitmapData = bmp.bitmapData.clone();
				bmp.bitmapData = bmd;
				GM.recolorToStanGbPalette(bmd,bmd.rect);
				GM.recolorStanGbPalToCurGbPalSingle(bmd,_target.masterBmdSkinCont.type,GraphicsManager.GB_PAL_OBJ1,14);
				if (enemyPalette != 0)
				{
					GM.recolorToStanGbPalette(bmd,bmd.rect);
					GM.recolorStanGbPalToCurGbPalSingle(bmd,_target.masterBmdSkinCont.type,GraphicsManager.GB_PAL_OBJ1);
				}
			}
		}
		
		override public function destroy():void
		{
			super.destroy();
			_target.stopHit = false;
			_target.addHitTestableItem(HitTestTypes.CHARACTER);
			_target.resetColor();
			_target.removeStatusEffect(TYPE_STOP);
			fakeGround.destroy();
//			trace("fakeGround: "+fakeGround);
			if (mainTmr)
			{
				mainTmr.stop();
				_target.removeTmr(mainTmr);
				mainTmr.removeEventListener(TimerEvent.TIMER_COMPLETE,mainTimerHandler);
				mainTmr = null;
			}
			if (flashTmr)
			{
				flashTmr.stop();
				_target.removeTmr(flashTmr);
				flashTmr.removeEventListener(TimerEvent.TIMER,flashTmrHandler);
				flashTmr = null;
			}
		}
	}
}