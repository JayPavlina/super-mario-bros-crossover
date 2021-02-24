package com.smbc.pickups
{

	import com.customClasses.*;
	import com.explodingRabbit.utils.CustomDictionary;
	import com.smbc.characters.*;
	import com.smbc.data.PickupInfo;
	import com.smbc.events.CustomEvents;
	import com.smbc.ground.*;
	import com.smbc.main.AnimatedObject;
	import com.smbc.managers.EventManager;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Teleporter extends Pickup
	{
		protected var teleNum:int;
		protected var teleDest:Teleporter;
		protected var teleStart:Teleporter
		protected var teleEndDist:Number;
		protected var checkPtVec:Vector.<Array>;
		protected var teleType:String;
		protected var numCheckPts:int;
		protected var active:Boolean;
		protected var oneCP:Boolean;
		private var hRectHeight:Number;
		private var hRectOriginalY:Number;

		public function Teleporter(_type:String,_teleNum:int,_teleX:Number,_teleY:Number,_teleHeight:Number):void 
		{
			super(PickupInfo.TELEPORTER);
			teleType = _type;
			if (teleType == "startOne")
			{
				oneCP = true;
				teleType = "start";
			}
			if (teleType != "end")
				hitDistOver = GLOB_STG_BOT/2;
			teleNum = _teleNum;
			this.x = _teleX;
			this.y = _teleY;
			hRectHeight = _teleHeight;
			defyGrav = true;
			stopAnim = true;
			level.addToLevelNow(this);
		}
		
		private function updateHRect():void
		{
			hRect.height = hRectHeight;
			hRect.y = hRectOriginalY - (hRectHeight - TILE_SIZE);
		}
		
		override public function initiate():void
		{
			super.initiate();
			hRectOriginalY = hRect.y;
			updateHRect();
		}
		
		
		
		override public function gotoAndStop(frame:Object, scene:String = null):void
		{
			super.gotoAndStop(frame, scene);
			if ( !isNaN(hRectOriginalY) )
				updateHRect();
		}
		
		public function getRelationships():void
		{
			if (teleType == "start")
			{
				level.teleVec.forEach(function getFriends(elem:Teleporter,ind:int,vec:Vector.<Teleporter>):void
				{
					if (elem.teleType == "end" && elem.teleNum == teleNum) teleDest = elem;
					else if (elem.teleType == "checkPoint" && elem.teleNum == teleNum)
					{
						if (checkPtVec) checkPtVec.push([elem.x,false]);
						else
						{
							checkPtVec = new Vector.<Array>;
							checkPtVec.push([elem.x,false]);
						}
						elem.teleStart = this;
					}
					
				},this);
				if (checkPtVec)
				{
					numCheckPts = checkPtVec.length;
					if (level.checkPtClonesVec) level.checkPtClonesVec.forEach(function updateClones(elem:Teleporter,ind:int,vec:Vector.<Teleporter>):void
					{
						for (var i:int = 0; i < numCheckPts; i++)
						{
							if (elem.teleNum == teleNum && elem.x == checkPtVec[i][0]) elem.teleStart = this;
						}
					},this);
				}
				else
					active = true;
				teleEndDist = teleDest.x - this.x;
			}
		}
		public function hitCheckPt(cpx:Number):void
		{
			for (var i:int = 0; i < numCheckPts ;i++) 
			{
				if (cpx == checkPtVec[i][0])
					checkPtVec[i][1] = true;
			}
		}
		override public function hitCharacter(char:Character,side:String):void 
		{
			var i:int;
			if (teleType == "checkPoint") teleStart.hitCheckPt(this.x);
			else if (teleType == "start")
			{
				if (active)
				{
					player.teleport(teleEndDist);
					level.resetTeleporters();
				}
				else
				{
					if (oneCP)
					{
						for (i = 0; i < numCheckPts ;i++) 
						{
							if (checkPtVec[i][1])
								active = true;
						}
					}
					else
					{
						active = true;
						for (i = 0; i < numCheckPts ;i++) 
						{
							if (!checkPtVec[i][1])
								active = false;
						}
					}
					if (active)
					{
						player.teleport(teleEndDist);
						active = false;
						level.resetTeleporters();
					}
				}
			}
		}
		override public function touchPlayer(char:Character):void
		{
			
		}
		
		public function resetCheckPoints():void
		{
			for (var i:int = 0; i < numCheckPts ;i++) 
			{
				checkPtVec[i][1] = false;
			}
		}
		
	}
}