package com.smbc.graphics
{
	import com.explodingRabbit.display.CustomMovieClip;
	import com.smbc.characters.Bass;
	import com.smbc.characters.Bill;
	import com.smbc.characters.Link;
	import com.smbc.characters.Luigi;
	import com.smbc.characters.Mario;
	import com.smbc.characters.MegaMan;
	import com.smbc.characters.Pit;
	import com.smbc.characters.ProtoMan;
	import com.smbc.characters.Ryu;
	import com.smbc.characters.Samus;
	import com.smbc.characters.Simon;
	import com.smbc.characters.Sophia;
	import com.smbc.characters.VicViper;
	import com.smbc.characters.WarriorOfLight;
	import com.smbc.data.MovieClipInfo;
	import com.smbc.graphics.BmdSkinCont;
	import com.smbc.projectiles.FireBar;
	import com.smbc.projectiles.SamusBomb;
	
	import flash.display.MovieClip;

	public class MasterObjects
	{
		
		// contains singleton master objects of every object except characters
		public static const TYPE_MAP:int = BmdSkinCont.TYPE_MAP;
		public static const TYPE_CHARACTER:int = BmdSkinCont.TYPE_CHARACTER;
		public static const TYPE_ENEMY:int = BmdSkinCont.TYPE_ENEMY;
		public static const TYPE_INTERFACE:int = BmdSkinCont.TYPE_INTERFACE;
		public static const TYPE_BACKGROUND:int = BmdSkinCont.TYPE_BACKGROUND;
		public static const TYPE_THEME:int = BmdSkinCont.TYPE_THEME;
		public static const TYPE_NEUTRAL:int = BmdSkinCont.TYPE_NEUTRAL;

//		backgrounds and foregrounds
		public static const bg_001_01_02_02Master:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.bg_001_01_02_02(), [ TYPE_BACKGROUND ] );
		public static const bg_001_05_03_00Master:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.bg_001_05_03_00(), [ TYPE_BACKGROUND ] );
		public static const bg_002_01_01_00Master:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.bg_002_01_01_00(), [ TYPE_BACKGROUND ] );
		public static const bg_002_11_01_00Master:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.bg_002_11_01_00(), [ TYPE_BACKGROUND ] );
		public static const bg_004_01_03_01Master:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.bg_004_01_03_01(), [ TYPE_BACKGROUND ] );
		public static const bg_004_03_02_00Master:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.bg_004_03_02_00(), [ TYPE_BACKGROUND ] );
		public static const bg_004_05_01_01Master:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.bg_004_05_01_01(), [ TYPE_BACKGROUND ] );
		public static const bg_004_06_01_00Master:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.bg_004_06_01_00(), [ TYPE_BACKGROUND ] );
		public static const bg_004_10_02_00Master:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.bg_004_10_02_00(), [ TYPE_BACKGROUND ] );
		public static const bg_010_01_05_00Master:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.bg_010_01_05_00(), [ TYPE_BACKGROUND ] );
		public static const bg_010_02_01_00Master:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.bg_010_02_01_00(), [ TYPE_BACKGROUND ] );
		public static const bg_010_02_02_00Master:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.bg_010_02_02_00(), [ TYPE_BACKGROUND ] );
		public static const bg_010_02_03_00Master:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.bg_010_02_03_00(), [ TYPE_BACKGROUND ] );
		public static const bg_010_02_04_00Master:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.bg_010_02_04_00(), [ TYPE_BACKGROUND ] );
		public static const bg_010_04_01_00Master:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.bg_010_04_01_00(), [ TYPE_BACKGROUND ] );
		public static const bg_010_04_02_00Master:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.bg_010_04_02_00(), [ TYPE_BACKGROUND ] );
		public static const bg_010_04_03_00Master:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.bg_010_04_03_00(), [ TYPE_BACKGROUND ] );
		public static const bg_010_05_01_00Master:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.bg_010_05_01_00(), [ TYPE_BACKGROUND ] );
		public static const bg_010_05_04_00Master:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.bg_010_05_04_00(), [ TYPE_BACKGROUND ] );
		public static const bg_010_07_02_00Master:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.bg_010_07_02_00(), [ TYPE_BACKGROUND ] );
		public static const bg_012_01_04_01Master:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.bg_012_01_04_01(), [ TYPE_BACKGROUND ] );
		public static const bg_012_02_02_01Master:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.bg_012_02_02_01(), [ TYPE_BACKGROUND ] );
		public static const bg_013_cave_iceMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.bg_013_cave_ice(), [ TYPE_BACKGROUND ] );
		public static const bg_013_starsMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.bg_013_stars(), [ TYPE_BACKGROUND ] );
		public static const bg_013_waterMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.bg_013_water(), [ TYPE_BACKGROUND ] );

		
		public static const fg_003_05_02_00Master:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.fg_003_05_02_00(), [ TYPE_BACKGROUND ] );
		public static const fg_004_04_01_01Master:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.fg_004_04_01_01(), [ TYPE_BACKGROUND ] );
		public static const fg_004_05_01_01Master:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.fg_004_05_01_01(), [ TYPE_BACKGROUND ] );
		
		// enemies
		public static const BassEnergyBarMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.MegaManEnergyBarMc(), [ TYPE_CHARACTER, Bass.CHAR_NUM ], "BassEnergyBar" );
		public static const BassIconMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.MegaManIconMc(), [ TYPE_CHARACTER, Bass.CHAR_NUM ], "BassIcon" );
		public static const BassPickupMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.MegaManPickupMc(), [ TYPE_CHARACTER, Bass.CHAR_NUM ], "BassPickup" );
		public static const BillBulletMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.BillBulletMc(), [ TYPE_CHARACTER, Bill.CHAR_NUM ] );
		public static const BillIconMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.BillIconMc(), [ TYPE_CHARACTER, Bill.CHAR_NUM ] );
		public static const BillPickupMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.BillPickupMc(), [ TYPE_CHARACTER, Bill.CHAR_NUM ] );
		public static const BeetleMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.BeetleMc(), [ TYPE_ENEMY ] );
		public static const BgNightStarsMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.BgNightStarsMc(), [ TYPE_BACKGROUND ] );
		public static const BgUnderGroundMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.BgUnderGroundMc(), [ TYPE_BACKGROUND ] );
		public static const BarrelMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.BarrelMc(), [ TYPE_ENEMY ] );
		public static const BloopaMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.BloopaMc(), [ TYPE_ENEMY ] );
		public static const BowserMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.BowserMc(), [ TYPE_ENEMY ] );
		public static const BowserFakeMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.BowserFakeMc(), [ TYPE_ENEMY ] );
		public static const BowserAxeMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.BowserAxeMc(), [ TYPE_MAP ] );
		public static const BowserBridgeMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.BowserBridgeMc(), [ TYPE_MAP ] );
		public static const BowserFireBallMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.BowserFireBallMc(), [ TYPE_ENEMY ] );
		public static const BowserFakeFireBallMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.BowserFakeFireBallMc(), [ TYPE_ENEMY ] );
		public static const BrickMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.BrickMc(), [ TYPE_MAP ] );
		public static const BrickPieceMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.BrickPieceMc(), [ TYPE_MAP ] );
		public static const BubbleMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.BubbleMc(), [ TYPE_MAP ] );
		public static const BulletBillMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.BulletBillMc(), [ TYPE_ENEMY ] );
		public static const CanonMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.CanonMc(), [ TYPE_MAP ] );
		public static const CoinMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.CoinMc(), [ TYPE_MAP ] );
		public static const CheepFastMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.CheepFastMc(), [ TYPE_ENEMY ] );
		public static const CheepSlowMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.CheepSlowMc(), [ TYPE_ENEMY ] );
		public static const CheepFlyingMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.CheepFlyingMc(), [ TYPE_ENEMY ] );
		public static const CrabMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.CrabMc(), [ TYPE_ENEMY ] );
		public static const FireBarMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.FireBarMc(), [ TYPE_ENEMY ], null, true );
		public static const FireEnemyMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.FireEnemyMc(), [ TYPE_ENEMY ] );
		public static const FireFlowerMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.FireFlowerMc(), [ TYPE_MAP ] );
		public static const FlagPoleMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.FlagPoleMc(), [ TYPE_MAP ] );
		public static const FlyingCoinMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.FlyingCoinMc(), [ TYPE_MAP ] );
		public static const FlyMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.FlyMc(), [ TYPE_ENEMY ] );
		public static const GoombaMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.GoombaMc(), [ TYPE_ENEMY ] );
		public static const GroundMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.GroundMc(), [ TYPE_MAP ] );
		public static const GroundThemeMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.GroundThemeMc(), [ TYPE_THEME ] );
		public static const HammerMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.HammerMc(), [ TYPE_ENEMY ] );
		public static const HammerBroMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.HammerBroMc(), [ TYPE_ENEMY ] );
		public static const IcicleMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.IcicleMc(), [ TYPE_ENEMY ] );
		public static const ItemBlockMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.ItemBlockMc(), [ TYPE_MAP ] );
		public static const KoopaGreenMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.KoopaGreenMc(), [ TYPE_ENEMY ] );
		public static const KoopaRedMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.KoopaRedMc(), [ TYPE_ENEMY ] );
		public static const LakituMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.LakituMc(), [ TYPE_ENEMY ] );
		public static const LavaFireBallMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.LavaFireBallMc(), [ TYPE_ENEMY ] );
		public static const LevelExitMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.LevelExitMc(), [ TYPE_MAP ] );
		public static const LinkBoomerangMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.LinkBoomerangMc(), [ TYPE_CHARACTER, Link.CHAR_NUM ] );
		public static const LinkProjectileMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.LinkProjectileMc(), [ TYPE_CHARACTER, Link.CHAR_NUM ] );
		public static const LinkIconMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.LinkIconMc(), [ TYPE_CHARACTER, Link.CHAR_NUM ] );
		public static const LinkPickupMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.LinkPickupMc(), [ TYPE_CHARACTER, Link.CHAR_NUM ] );
		public static const LinkSimpleGraphicsMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.LinkSimpleGraphicsMc(), [ TYPE_CHARACTER, Link.CHAR_NUM ] );
		public static const MarioIconMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.MarioBaseIconMc(), [ TYPE_CHARACTER, Mario.CHAR_NUM ], "MarioIcon" );
		public static const MarioFireBallMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.MarioFireBallMc(), [ TYPE_CHARACTER, Mario.CHAR_NUM ] );
		public static const MarioPickupMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.MarioBasePickupMc(), [ TYPE_CHARACTER, Mario.CHAR_NUM ] );
		public static const LuigiIconMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.MarioBaseIconMc(), [ TYPE_CHARACTER, Luigi.CHAR_NUM ], "LuigiIcon" );
		public static const LuigiPickupMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.MarioBasePickupMc(), [ TYPE_CHARACTER, Luigi.CHAR_NUM ] );
		public static const BassProjectileMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.MegaManProjectileMc(), [ TYPE_CHARACTER, Bass.CHAR_NUM ], "BassProjectile" );
		public static const BassParticleMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.MegaManParticleMc(), [ TYPE_CHARACTER, Bass.CHAR_NUM ], "BassParticle" );

		public static const MegaManEnergyBarMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.MegaManEnergyBarMc(), [ TYPE_CHARACTER, MegaMan.CHAR_NUM ], "MegaManEnergyBar" );
		public static const MegaManIconMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.MegaManIconMc(), [ TYPE_CHARACTER, MegaMan.CHAR_NUM ], "MegaManIcon" );
		public static const MegaManParticleMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.MegaManParticleMc(), [ TYPE_CHARACTER, MegaMan.CHAR_NUM ], "MegaManParticle" );
		public static const MegaManPickupMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.MegaManPickupMc(), [ TYPE_CHARACTER, MegaMan.CHAR_NUM ], "MegaManPickup" );
		public static const MegaManProjectileMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.MegaManProjectileMc(), [ TYPE_CHARACTER, MegaMan.CHAR_NUM ] );

//		public static const PitIconMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.PitIconMc(), [ TYPE_CHARACTER, Pit.CHAR_NUM ] );
//		public static const PitPickupMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.PitPickupMc(), [ TYPE_CHARACTER, Pit.CHAR_NUM ] );
//		public static const PitProjectileMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.PitProjectileMc(), [ TYPE_CHARACTER, Pit.CHAR_NUM ] );
//		public static const PitSimpleGraphicsMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.PitSimpleGraphicsMc(), [ TYPE_CHARACTER, Pit.CHAR_NUM ] );
		
//		public static const VicViperIconMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.VicViperIconMc(), [ TYPE_CHARACTER, VicViper.CHAR_NUM ] );
//		public static const VicViperPickupMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.VicViperPickupMc(), [ TYPE_CHARACTER, VicViper.CHAR_NUM ] );
//		public static const VicViperProjectileMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.VicViperProjectileMc(), [ TYPE_CHARACTER, VicViper.CHAR_NUM ] );
//		public static const VicViperSimpleGraphicsMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.VicViperSimpleGraphicsMc(), [ TYPE_CHARACTER, VicViper.CHAR_NUM ] );
		
		public static const MushroomMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.MushroomMc(), [ TYPE_MAP ] );
		public static const PipeTransporterMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.PipeTransporterMc(), [ TYPE_MAP ] );
		public static const PiranhaGreenMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.PiranhaGreenMc(), [ TYPE_ENEMY ] );
		public static const PiranhaRedMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.PiranhaRedMc(), [ TYPE_ENEMY ] );
		public static const PlatformMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.PlatformMc(), [ TYPE_THEME ] );
		public static const RyuIconMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.RyuIconMc(), [ TYPE_CHARACTER, Ryu.CHAR_NUM ] );
		public static const RyuPickupMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.RyuPickupMc(), [ TYPE_CHARACTER, Ryu.CHAR_NUM ] );
		public static const RyuProjectileMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.RyuProjectileMc(), [ TYPE_CHARACTER, Ryu.CHAR_NUM ] );
		public static const RyuSimpleGraphicsMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.RyuSimpleGraphicsMc(), [ TYPE_CHARACTER, Ryu.CHAR_NUM ] );
		public static const RushMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.RushMc(), [ TYPE_CHARACTER, MegaMan.CHAR_NUM ] );
		
		
		public static const ScrollingIndicatorMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.ScrollingIndicatorMc(), [ TYPE_INTERFACE ] );

		public static const SamusBombMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.SamusBombMc(), [ TYPE_CHARACTER, Samus.CHAR_NUM ] );
		public static const SamusGutsMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.SamusGutsMc(), [ TYPE_CHARACTER, Samus.CHAR_NUM ] );
		public static const SamusIconMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.SamusIconMc(), [ TYPE_CHARACTER, Samus.CHAR_NUM ] );		
		public static const SamusPickupMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.SamusPickupMc(), [ TYPE_CHARACTER, Samus.CHAR_NUM ] );		
		public static const SamusShotMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.SamusShotMc(), [ TYPE_CHARACTER, Samus.CHAR_NUM ] );
		public static const SimonPickupMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.SimonPickupMc(), [ TYPE_CHARACTER, Simon.CHAR_NUM ] );
		public static const SimonIconMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.SimonIconMc(), [ TYPE_CHARACTER, Simon.CHAR_NUM ] );
		public static const SimpleGroundMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.SimpleGroundMc(), [ TYPE_MAP ] );
		public static const SophiaBulletMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.SophiaBulletMc(), [ TYPE_CHARACTER, Sophia.CHAR_NUM ] );
		public static const SophiaIconMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.SophiaIconMc(), [ TYPE_CHARACTER, Sophia.CHAR_NUM ] );
		public static const SophiaHoverBarMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.SophiaHoverBarMc(), [ TYPE_CHARACTER, Sophia.CHAR_NUM ] );
		public static const SophiaPickupMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.SophiaPickupMc(), [ TYPE_CHARACTER, Sophia.CHAR_NUM ] );
		public static const SpineyMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.SpineyMc(), [ TYPE_ENEMY ] );
		public static const SpikeTopMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.SpikeTopMc(), [ TYPE_ENEMY ] );
		public static const SpringRedMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.SpringRedMc(), [ TYPE_MAP ] );
		public static const SpringGreenMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.SpringGreenMc(), [ TYPE_MAP ] );
		public static const StarMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.StarMc(), [ TYPE_MAP ] );
		public static const TeleporterMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.TeleporterMc(), [ TYPE_MAP ] );
		public static const VineMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.VineMc(), [ TYPE_MAP ] );
	
		// smb special pickups
		public static const AtomMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.AtomMc(), [ TYPE_MAP ] );
		public static const ClockMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.ClockMc(), [ TYPE_MAP ] );
		public static const HammerPickupMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.HammerPickupMc(), [ TYPE_MAP ] );
		public static const HudsonBeeMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.HudsonBeeMc(), [ TYPE_MAP ] );
		public static const WingMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.WingMc(), [ TYPE_MAP ] );
		
		public static const ExplodingRabbitPowerupMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.ExplodingRabbitPowerupMc(), [ TYPE_MAP ] );
		public static const HammerWeaponMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.HammerWeaponMc(), [ TYPE_MAP ] );
		// projectiles
//		public static const BlackMageSpellMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.BlackMageSpellMc(), [ TYPE_CHARACTER, WarriorOfLight.CHAR_NUM ] );
		
		
		
		public static const LuigiFireBallMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.MarioFireBallMc(), [ TYPE_CHARACTER, Luigi.CHAR_NUM ] );
//		public static const ProtoManBulletMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.MegaManBulletMc(), [ TYPE_CHARACTER, ProtoMan.CHAR_NUM ] );
		public static const SimonProjectileMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.SimonProjectileMc(), [ TYPE_CHARACTER, Simon.CHAR_NUM ] );
//		public static const VicViperProjectileMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.VicViperProjectileMc(), [ TYPE_CHARACTER, VicViper.CHAR_NUM ] );
		
		public static const BillSimpleGraphicsMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.BillSimpleGraphicsMc(), [ TYPE_CHARACTER, Bill.CHAR_NUM ] );
		public static const BowserFireBallSparkMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.BowserFireBallSparkMc(), [ TYPE_ENEMY ] );
		public static const BowserFakeFireBallSparkMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.BowserFakeFireBallSparkMc(), [ TYPE_ENEMY ] );
		public static const CanonSmokeMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.CanonSmokeMc(), [ TYPE_ENEMY ] );
		public static const CastleFlagMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.CastleFlagMc(), [ TYPE_MAP ] );
		public static const CharacterPortraitMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.CharacterPortraitMc(), [ TYPE_NEUTRAL ] );
		public static const CoinExplosionMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.CoinExplosionMc(), [ TYPE_MAP ] );
		public static const CoinSymbolMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.CoinSymbolMc(), [ TYPE_INTERFACE ] );
		public static const ExplodingRabbitLogoMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.ExplodingRabbitLogoMc(), [ TYPE_INTERFACE ] );
		public static const FireworkMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.FireworkMc(), [ TYPE_MAP ] );
		public static const FireBarChildMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.FireBarChildMc(), [ TYPE_ENEMY ] );
		public static const FontCharHudMaster:CustomMovieClip = new CustomMovieClip( null, [ TYPE_INTERFACE ], "FontCharHud" );		
		public static const FontCharLinkMaster:CustomMovieClip = new CustomMovieClip( null, [ TYPE_CHARACTER, Link.CHAR_NUM ], "FontCharLink" );		
		public static const FontCharRyuMaster:CustomMovieClip = new CustomMovieClip( null, [ TYPE_CHARACTER, Ryu.CHAR_NUM ], "FontCharRyu" );		
		public static const FontCharSamusMaster:CustomMovieClip = new CustomMovieClip( null, [ TYPE_CHARACTER, Samus.CHAR_NUM ], "FontCharSamus" );		
		public static const FontCharMenuMaster:CustomMovieClip = new CustomMovieClip( null, [ TYPE_INTERFACE ], "FontCharMenu" );		
		public static const FontCharScoreMaster:CustomMovieClip = new CustomMovieClip( null, [ TYPE_INTERFACE ], "FontCharScore" );		
		public static const FontCharSimonMaster:CustomMovieClip = new CustomMovieClip( null, [ TYPE_CHARACTER, Simon.CHAR_NUM ], "FontCharSimon" );	
		public static const FundingIconMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.FundingIconMc(), [ TYPE_INTERFACE ] );
		public static const JasonMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.JasonMc(), [ TYPE_CHARACTER, Sophia.CHAR_NUM ] );		
		public static const BassSimpleGraphicsMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.MegaManSimpleGraphicsMc(), [ TYPE_CHARACTER, Bass.CHAR_NUM ], "BassSimpleGraphics" );		
		public static const MegaManSimpleGraphicsMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.MegaManSimpleGraphicsMc(), [ TYPE_CHARACTER, MegaMan.CHAR_NUM ], "MegaManSimpleGraphics" );		
		public static const MessageBoxBackgroundMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.MessageBoxBackgroundMc(), [ TYPE_INTERFACE ] );
		public static const MushroomSelectorMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.MushroomSelectorMc(), [ TYPE_INTERFACE ] );		
		public static const OneUpMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.OneUpMc(), [ TYPE_INTERFACE ] );		
		public static const PortraitSelectorMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.PortraitSelectorMc(), [ TYPE_INTERFACE ] );
		public static const PStateIconMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.PStateIconMc(), [ TYPE_INTERFACE ] );
		public static const UpgradeIconMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.UpgradeIconMc(), [ TYPE_INTERFACE ] );
		public static const PullyRopeMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.PullyRopeMc(), [ TYPE_MAP ] );
		public static const PullyRopeEndMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.PullyRopeEndMc(), [ TYPE_MAP ] );
		public static const SamusSimpleGraphicsMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.SamusSimpleGraphicsMc(), [ TYPE_CHARACTER, Samus.CHAR_NUM ] );
		public static const SceneryMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.SceneryMc(), [ TYPE_MAP ] );
		public static const SceneryThemeMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.SceneryThemeMc(), [ TYPE_THEME ] );
		public static const SimonSimpleGraphicsMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.SimonSimpleGraphicsMc(), [ TYPE_CHARACTER, Simon.CHAR_NUM ] );
		public static const SophiaExplosionMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.SophiaExplosionMc(), [ TYPE_CHARACTER, Sophia.CHAR_NUM ] );
		public static const StarBurstMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.StarBurstMc(), [ TYPE_ENEMY ] );
		public static const TitleBmpMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.TitleBmpMc(), [ TYPE_INTERFACE ] );
		public static const TopScreenTextMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.TopScreenTextMc(), [ TYPE_NEUTRAL ] );
		public static const VineSegmentMaster:CustomMovieClip = new CustomMovieClip( new MovieClipInfo.VineSegmentMc(), [ TYPE_MAP ] );

		
		public static function initiate():void // called by game when it starts
		{
			FireBar.getSubCmcs(FireBarMaster);
		}
	}
}