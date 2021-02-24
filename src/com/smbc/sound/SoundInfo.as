package com.smbc.sound
{
	import flash.utils.Dictionary;

	public class SoundInfo
	{
		public static const INFO_DCT:Dictionary = new Dictionary();
		public static const IND_CLASS:int = 0;
		public static const IND_VOLUME:int = 1;
		private static const MUS_REF:int = 80; // 20 is highest number
		private static const SFX_REF:int = 77; // 23 is highest number
		// [ classtype ];
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="BillDieSnd")]
//		public static const BillDieSnd:Class;
//		{ INFO_DCT[BillDieSnd] = [ SoundEffect, 0 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="BillElectrecuteSnd")]
//		public static const BillElectrecuteSnd:Class;
//		{ INFO_DCT[BillElectrecuteSnd] = [ SoundEffect, 0 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="BillLandSnd")]
//		public static const BillLandSnd:Class;
//		{ INFO_DCT[BillLandSnd] = [ SoundEffect, -7 ]; }
		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="BillMachineGunSnd")]
		public static const BillMachineGunSnd:Class;
		{ INFO_DCT[BillMachineGunSnd] = [ SoundEffect, -12 ]; }
		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="BillNormalShotSnd")]
		public static const BillNormalShotSnd:Class;
		{ INFO_DCT[BillNormalShotSnd] = [ SoundEffect, -12 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="BillShotHitSnd")]
//		public static const BillShotHitSnd:Class;
//		{ INFO_DCT[BillShotHitSnd] = [ SoundEffect, -5 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="BillSpreadSnd")]
//		public static const BillSpreadSnd:Class;
//		{ INFO_DCT[BillSpreadSnd] = [ SoundEffect, -12 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="GameBowserFallSnd")]
//		public static const GameBowserFallSnd:Class;
//		{ INFO_DCT[GameBowserFallSnd] = [ SoundEffect, 7 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="GameBowserFireSnd")]
//		public static const GameBowserFireSnd:Class;
//		{ INFO_DCT[GameBowserFireSnd] = [ SoundEffect, 0 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="GameBrickBreakSnd")]
//		public static const GameBrickBreakSnd:Class;
//		{ INFO_DCT[GameBrickBreakSnd] = [ SoundEffect, -10 ]; }
		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="GameBridgeBreakSnd")]
		public static const GameBridgeBreakSnd:Class;
		{ INFO_DCT[GameBridgeBreakSnd] = [ SoundEffect, 0 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="GameCanonSnd")]
//		public static const GameCanonSnd:Class;
//		{ INFO_DCT[GameCanonSnd] = [ SoundEffect, 10 ]; }
		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="GameCharacterSelectCursorSnd")]
		public static const GameCharacterSelectCursorSnd:Class;
		{ INFO_DCT[GameCharacterSelectCursorSnd] = [ SoundEffect, 10 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="GameCoinSnd")]
//		public static const GameCoinSnd:Class;
//		{ INFO_DCT[GameCoinSnd] = [ SoundEffect, -15 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="GameFlagPoleSnd")]
//		public static const GameFlagPoleSnd:Class;
//		{ INFO_DCT[GameFlagPoleSnd] = [ SoundEffect, -5 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="GameHitCeilingSnd")]
//		public static const GameHitCeilingSnd:Class;
//		{ INFO_DCT[GameHitCeilingSnd] = [ SoundEffect, 7 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="GameItemAppearSnd")]
//		public static const GameItemAppearSnd:Class;
//		{ INFO_DCT[GameItemAppearSnd] = [ SoundEffect, 5 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="GameKickShellSnd")]
//		public static const GameKickShellSnd:Class;
//		{ INFO_DCT[GameKickShellSnd] = [ SoundEffect, -5 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="GameNewLifeSnd")]
//		public static const GameNewLifeSnd:Class;
//		{ INFO_DCT[GameNewLifeSnd] = [ SoundEffect, -4 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="GamePauseSnd")]
//		public static const GamePauseSnd:Class;
//		{ INFO_DCT[GamePauseSnd] = [ SoundEffect, -4 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="GamePipeSnd")]
//		public static const GamePipeSnd:Class;
//		{ INFO_DCT[GamePipeSnd] = [ SoundEffect, -4 ]; }
		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="GamePointsSnd")]
		public static const GamePointsSnd:Class;
		{ INFO_DCT[GamePointsSnd] = [ LoopingSoundEffect, -14 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="GamePowerUpSnd")]
//		public static const GamePowerUpSnd:Class;
//		{ INFO_DCT[GamePowerUpSnd] = [ SoundEffect, -8 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="GameSecondsLeftIntroSnd")]
//		public static const GameSecondsLeftIntroSnd:Class;
//		{ INFO_DCT[GameSecondsLeftIntroSnd] = [ GameSecondsLeftIntroOverrideSnd, -42]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="GameStompSnd")]
//		public static const GameStompSnd:Class;
//		{ INFO_DCT[GameStompSnd] = [ SoundEffect, -4 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="GameVineSnd")]
//		public static const GameVineSnd:Class;
//		{ INFO_DCT[GameVineSnd] = [ SoundEffect, 0 ]; }
		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="LinkBoomerangSnd")]
		public static const LinkBoomerangSnd:Class;
		{ INFO_DCT[LinkBoomerangSnd] = [ LoopingSoundEffect, -4 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="LinkDieSnd")]
//		public static const LinkDieSnd:Class;
//		{ INFO_DCT[LinkDieSnd] = [ SoundEffect, 0 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="LinkGetItemSnd")]
//		public static const LinkGetItemSnd:Class;
//		{ INFO_DCT[LinkGetItemSnd] = [ SoundEffect, 0 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="LinkHitEnemySnd")]
//		public static const LinkHitEnemySnd:Class;
//		{ INFO_DCT[LinkHitEnemySnd] = [ SoundEffect, 11 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="LinkIntroLevelSnd")]
//		public static const LinkIntroLevelSnd:Class;
//		{ INFO_DCT[LinkIntroLevelSnd] = [ MusicEffect, -36 ]; }
		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="LinkJumpSnd")]
		public static const LinkJumpSnd:Class;
		{ INFO_DCT[LinkJumpSnd] = [ SoundEffect, 0 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="LinkShootSwordSnd")]
//		public static const LinkShootSwordSnd:Class;
//		{ INFO_DCT[LinkShootSwordSnd] = [ SoundEffect, 13 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="LinkStabSnd")]
//		public static const LinkStabSnd:Class;
//		{ INFO_DCT[LinkStabSnd] = [ SoundEffect, 0 ]; }  // volume is reference for sfx
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="MarioFireballSnd")]
//		public static const MarioFireballSnd:Class;
//		{ INFO_DCT[MarioFireballSnd] = [ SoundEffect, 10 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="MarioJumpBigSnd")]
//		public static const MarioJumpBigSnd:Class;
////		{ INFO_DCT[MarioJumpBigSnd] = [ SoundEffect, 0 ]; }
//		{ INFO_DCT[MarioJumpBigSnd] = [ SoundEffect, 0 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="MarioJumpSmallSnd")]
//		public static const MarioJumpSmallSnd:Class;
//		{ INFO_DCT[MarioJumpSmallSnd] = [ SoundEffect, -13 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="MegaManChargeLoopSnd")]
//		public static const MegaManChargeLoopSnd:Class;
//		{ INFO_DCT[MegaManChargeLoopSnd] = [ LoopingSoundEffect, -11 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="MegaManChargeShotSnd")]
//		public static const MegaManChargeShotSnd:Class;
//		{ INFO_DCT[MegaManChargeShotSnd] = [ SoundEffect, 0 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="MegaManChargeStartSnd")]
//		public static const MegaManChargeStartSnd:Class;
//		{ INFO_DCT[MegaManChargeStartSnd] = [ MegaManChargeStartSnd, -11 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="MegaManDeflectSnd")]
//		public static const MegaManDeflectSnd:Class;
//		{ INFO_DCT[MegaManDeflectSnd] = [ SoundEffect, -11 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="MegaManFireSnd")]
//		public static const MegaManFireSnd:Class;
//		{ INFO_DCT[MegaManFireSnd] = [ SoundEffect, -5 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="MegaManHitEnemySnd")]
//		public static const MegaManHitEnemySnd:Class;
//		{ INFO_DCT[MegaManHitEnemySnd] = [ SoundEffect, -4 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="MegaManLandSnd")]
//		public static const MegaManLandSnd:Class;
//		{ INFO_DCT[MegaManLandSnd] = [ SoundEffect, -10 ]; }
		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="MegaManScrewCrusherSnd")]
		public static const MegaManScrewCrusherSnd:Class;
		{ INFO_DCT[MegaManScrewCrusherSnd] = [ SoundEffect, -10 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="MegaManShootSnd")]
//		public static const MegaManShootSnd:Class;
//		{ INFO_DCT[MegaManShootSnd] = [ SoundEffect, -12 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="MegaManTeleportSnd")]
//		public static const MegaManTeleportSnd:Class;
//		{ INFO_DCT[MegaManTeleportSnd] = [ SoundEffect, 0 ]; }
		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="MegaManWaterShieldSnd")]
		public static const MegaManWaterShieldSnd:Class;
		{ INFO_DCT[MegaManWaterShieldSnd] = [ SoundEffect, -10 ]; }
		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="RepeatingSilenceSnd")]
		public static const RepeatingSilenceSnd:Class;
		{ INFO_DCT[RepeatingSilenceSnd] = [ RepeatingSilenceOverrideSnd, 0]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="RyuAttackSnd")]
//		public static const RyuAttackSnd:Class;
//		{ INFO_DCT[RyuAttackSnd] = [ SoundEffect, 0 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="RyuDamageEnemySnd")]
//		public static const RyuDamageEnemySnd:Class;
//		{ INFO_DCT[RyuDamageEnemySnd] = [ SoundEffect, 10 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="RyuJumpSnd")]
//		public static const RyuJumpSnd:Class;
//		{ INFO_DCT[RyuJumpSnd] = [ SoundEffect, -10 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="RyuTakeDamageSnd")]
//		public static const RyuTakeDamageSnd:Class;
//		{ INFO_DCT[RyuTakeDamageSnd] = [ SoundEffect, 5 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="RyuThrowBigStarSnd")]
//		public static const RyuThrowBigStarSnd:Class;
//		{ INFO_DCT[RyuThrowBigStarSnd] = [ SoundEffect, 0 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="RyuThrowSmallStarSnd")]
//		public static const RyuThrowSmallStarSnd:Class;
//		{ INFO_DCT[RyuThrowSmallStarSnd] = [ SoundEffect, -5 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="SamusBombExplodeSnd")]
//		public static const SamusBombExplodeSnd:Class;
//		{ INFO_DCT[SamusBombExplodeSnd] = [ SoundEffect, 5 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="SamusBombSetSnd")]
//		public static const SamusBombSetSnd:Class;
//		{ INFO_DCT[SamusBombSetSnd] = [ SoundEffect, 10 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="SamusBulletProofSnd")]
//		public static const SamusBulletProofSnd:Class;
//		{ INFO_DCT[SamusBulletProofSnd] = [ SoundEffect, 0 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="SamusDieSnd")]
//		public static const SamusDieSnd:Class;
//		{ INFO_DCT[SamusDieSnd] = [ SoundEffect, 9 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="SamusGetMissileSnd")]
//		public static const SamusGetMissileSnd:Class;
//		{ INFO_DCT[SamusGetMissileSnd] = [ SoundEffect, 0 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="SamusHitEnemySnd")]
//		public static const SamusHitEnemySnd:Class;
//		{ INFO_DCT[SamusHitEnemySnd] = [ SoundEffect, 11 ]; }
		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="SamusIceBeamSnd")]
		public static const SamusIceBeamSnd:Class;
		{ INFO_DCT[SamusIceBeamSnd] = [ SoundEffect, 0 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="SamusJumpSnd")]
//		public static const SamusJumpSnd:Class;
//		{ INFO_DCT[SamusJumpSnd] = [ SoundEffect, 0 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="SamusLandSnd")]
//		public static const SamusLandSnd:Class;
//		{ INFO_DCT[SamusLandSnd] = [ SoundEffect, -5 ]; }
		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="SamusLongBeamSnd")]
		public static const SamusLongBeamSnd:Class;
		{ INFO_DCT[SamusLongBeamSnd] = [ SoundEffect, 0 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="SamusMorphBallSnd")]
//		public static const SamusMorphBallSnd:Class;
//		{ INFO_DCT[SamusMorphBallSnd] = [ SoundEffect, 16 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="SamusShootMissileSnd")]
//		public static const SamusShootMissileSnd:Class;
//		{ INFO_DCT[SamusShootMissileSnd] = [ SoundEffect, 0 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="SamusShortBeamSnd")]
//		public static const SamusShortBeamSnd:Class;
//		{ INFO_DCT[SamusShortBeamSnd] = [ SoundEffect, 10 ]; }
		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="SamusStepSnd")]
		public static const SamusStepSnd:Class;
		{ INFO_DCT[SamusStepSnd] = [ SoundEffect, -5 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="SamusWaveBeamSnd")]
//		public static const SamusWaveBeamSnd:Class;
//		{ INFO_DCT[SamusWaveBeamSnd] = [ SoundEffect, 3 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="SimonAxeSnd")]
//		public static const SimonAxeSnd:Class;
//		{ INFO_DCT[SimonAxeSnd] = [ LoopingSoundEffect, -17]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="SimonFlameWhipSnd")]
//		public static const SimonFlameWhipSnd:Class;
//		{ INFO_DCT[SimonFlameWhipSnd] = [ SoundEffect, -3 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="SimonGetBigHeartSnd")]
//		public static const SimonGetBigHeartSnd:Class;
//		{ INFO_DCT[SimonGetBigHeartSnd] = [ SoundEffect, -7 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="SimonHitCandleSnd")]
//		public static const SimonHitCandleSnd:Class;
//		{ INFO_DCT[SimonHitCandleSnd] = [ SoundEffect, -5 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="SimonHitEnemySnd")]
//		public static const SimonHitEnemySnd:Class;
//		{ INFO_DCT[SimonHitEnemySnd] = [ SoundEffect, -12 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="SimonHitSnd")]
//		public static const SimonHitSnd:Class;
//		{ INFO_DCT[SimonHitSnd] = [ SoundEffect, 0 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="SimonWhipSnd")]
//		public static const SimonWhipSnd:Class;
//		{ INFO_DCT[SimonWhipSnd] = [ SoundEffect, -12 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="SophiaBulletExplodeSnd")]
//		public static const SophiaBulletExplodeSnd:Class;
//		{ INFO_DCT[SophiaBulletExplodeSnd] = [ SoundEffect, 15 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="SophiaDieSnd")]
//		public static const SophiaDieSnd:Class;
//		{ INFO_DCT[SophiaDieSnd] = [ SoundEffect, 15 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="SophiaGetPickupSnd")]
//		public static const SophiaGetPickupSnd:Class;
//		{ INFO_DCT[SophiaGetPickupSnd] = [ SoundEffect, 10 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="SophiaHitEnemySnd")]
//		public static const SophiaHitEnemySnd:Class;
//		{ INFO_DCT[SophiaHitEnemySnd] = [ SoundEffect, 23 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="SophiaHoverSnd")]
//		public static const SophiaHoverSnd:Class;
//		{ INFO_DCT[SophiaHoverSnd] = [ LoopingSoundEffect, 10 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="SophiaJumpSnd")]
//		public static const SophiaJumpSnd:Class;
//		{ INFO_DCT[SophiaJumpSnd] = [ SoundEffect, 20 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="SophiaKillEnemySnd")]
//		public static const SophiaKillEnemySnd:Class;
//		{ INFO_DCT[SophiaKillEnemySnd] = [ SoundEffect, 10 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="SophiaLandSnd")]
//		public static const SophiaLandSnd:Class;
//		{ INFO_DCT[SophiaLandSnd] = [ SoundEffect, 20 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="SophiaMissileSnd")]
//		public static const SophiaMissileSnd:Class;
//		{ INFO_DCT[SophiaMissileSnd] = [ SoundEffect, 15 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="SophiaOpenSnd")]
//		public static const SophiaOpenSnd:Class;
//		{ INFO_DCT[SophiaOpenSnd] = [ SoundEffect, 23 ]; }
//		[Embed(source="../assets/swfs/SmbcSounds.swf", symbol="SophiaShootSnd")]
//		public static const SophiaShootSnd:Class;
//		{ INFO_DCT[SophiaShootSnd] = [ SoundEffect, 15 ]; }
		
		{ setUpSoundLevels(); }
		
		private static function setUpSoundLevels():void
		{
			for each (var arr:Array in INFO_DCT)
			{
				var classType:Class = arr[IND_CLASS];
				var num:int = arr[IND_VOLUME];
				if (classType == MusicEffect)
					num += MUS_REF;
				else
					num += SFX_REF;
				arr[IND_VOLUME] = num;
			}
			
		}
	}
}