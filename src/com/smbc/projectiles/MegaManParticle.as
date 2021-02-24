package com.smbc.projectiles
{
	import com.smbc.characters.Character;
	import com.smbc.characters.Bass;
	import com.smbc.characters.MegaMan;
	import com.smbc.characters.base.MegaManBase;
	import com.smbc.data.AnimationTimers;
	import com.smbc.data.CharacterInfo;
	
	public class MegaManParticle extends Projectile
	{
		private var inner:Boolean;
		private var dir:String;
		private const DIAGONAL_SPEED_MOD:Number = Math.SQRT1_2;
		public static const PARTICLE_COLOR_SEP_TMR_DEL:int = 200;
		public static const PARTICLE_WHITE_SEP_TMR_DEL:int = 0;
		
		private const INNER_SPEED_COLOR:int = 90;
		private const OUTER_SPEED_COLOR:int = 240;

		private const INNER_SPEED_WHITE:int = 80;
		private const OUTER_SPEED_WHITE:int = 180;

		private const START_POS_OFFSET:int = 10;
		
		public static const MEGA_MAN_COLOR_PARTICLE_SKIN_NUM:Array = [ 0, 1, 10, 13, 14, 15, 16, 17, 18, 21, 24, 25 ];
		public static const MEGA_MAN_WHITE_PARTICLE_SKIN_NUM:Array = [ 2, 3, 4, 5, 6, 7, 8, 9, 11, 12, 19, 20, 22, 23 ]; // Currently unused
		public static const BASS_COLOR_PARTICLE_SKIN_NUM:Array = [ 3, 4, 7, 8 ];
		public static const BASS_WHITE_PARTICLE_SKIN_NUM:Array = [ 0, 1, 2, 5, 6, 9, 10, 11, 12, 13, 14, 15 ]; // Currently unused

		private static const FL_COLOR_START:String = "colorStart";
		private static const FL_COLOR_END:String = "colorEnd";
		private static const FL_WHITE_START:String = "whiteStart";
		private static const FL_WHITE_END:String = "whiteEnd";
		
		public function MegaManParticle(_inner:Boolean,_dir:String,megaMan:MegaManBase)
		{
			inheritedForceShortClassName = CharacterInfo.CHAR_ARR[megaMan.charNum][CharacterInfo.IND_CHAR_NAME_CLASS]+"Particle";
			super(megaMan,SOURCE_TYPE_NEUTRAL);
			
			var skinNum:int = player.skinNum;
			var skinNumColor:Boolean;
			
			if ( ((player is MegaMan) && (MEGA_MAN_COLOR_PARTICLE_SKIN_NUM.indexOf(skinNum) != -1)) || ((player is Bass) && (BASS_COLOR_PARTICLE_SKIN_NUM.indexOf(skinNum) != -1)) )
				skinNumColor = true;
			else
				skinNumColor = false;
			
			if (skinNumColor)
				gotoAndStop(FL_COLOR_START);
			else
				gotoAndStop(FL_WHITE_START);
			
			stopAnim = false;
			mainAnimTmr = AnimationTimers.ANIM_FAST_TMR;
			destroyOffScreen = true;
			inner = _inner;
			dir = _dir;
			defyGrav = true;
			
			if (inner)
			{
				if (skinNumColor)
					speed = INNER_SPEED_COLOR;
				else
					speed = INNER_SPEED_WHITE;
			}
			else
			{
				if (skinNumColor)
					speed = OUTER_SPEED_COLOR;
				else
					speed = OUTER_SPEED_WHITE;
//				alpha = .8;
			}
			x = player.hMidX;
			y = player.hMidY;

			if (dir.indexOf("up") != -1)
				y -= START_POS_OFFSET;
			else if (dir.indexOf("dwn") != -1)
				y += START_POS_OFFSET;
			if (dir.indexOf("lft") != -1)
				x -= START_POS_OFFSET;
			else if (dir.indexOf("rht") != -1)
				x += START_POS_OFFSET;
		}
		public function separate():void
		{
			if (dir.indexOf("up") != -1)
			{
				vy = -speed;
				if (dir.indexOf("up-rht") != -1)
				{
					vy = -speed * DIAGONAL_SPEED_MOD;
					vx = speed * DIAGONAL_SPEED_MOD;
				}
				else if (dir.indexOf("up-lft") != -1)
				{
					vy = -speed * DIAGONAL_SPEED_MOD;
					vx = -speed * DIAGONAL_SPEED_MOD;
				}
			}
			else if (dir.indexOf("dwn") != -1)
			{
				vy = speed;
				if (dir.indexOf("dwn-rht") != -1)
				{
					vy = speed * DIAGONAL_SPEED_MOD;
					vx = speed * DIAGONAL_SPEED_MOD;
				}
				else if (dir.indexOf("dwn-lft") != -1)
				{
					vy = speed * DIAGONAL_SPEED_MOD;
					vx = -speed * DIAGONAL_SPEED_MOD;
				}
			}
			else if (dir.indexOf("lft") != -1)
				vx = -speed;
			else
				vx = speed;
		}
		override public function checkFrame():void
		{
			super.checkFrame();
			var cl:String = currentLabel;
			if (cl == FL_COLOR_END)
				gotoAndStop(FL_COLOR_START);
			if (cl == FL_WHITE_END)
				gotoAndStop(FL_WHITE_START);
		}
	}
}