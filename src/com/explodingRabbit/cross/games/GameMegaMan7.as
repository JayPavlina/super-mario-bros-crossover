package com.explodingRabbit.cross.games
{
	
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameMegaMan7 extends Game
	{
		private static var instance:Game; 
		
		public function GameMegaMan7(gameNum:int, skinSetNum:int = -1)
		{
			super("Mega Man 7",  "Capcom", Consoles.superNintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		private const VOLUME:int = 62;
		
//		[Embed(source="../../../../../assets/audio/seq/spc/MegaMan7/Enter the Graveyard!.spc", mimeType="application/octet-stream")]
//		private const EnterTheGraveyardData:Class;	public const SngEnterTheGraveyard:Song = addSong( EnterTheGraveyardData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/MegaMan7/Stage Clear.spc", mimeType="application/octet-stream")]
		private const StageClearData:Class;	public const SngStageClear:Song = addSong( StageClearData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/MegaMan7/New Weapon.spc", mimeType="application/octet-stream")]
		private const NewWeaponData:Class;	public const SngNewWeapon:Song = addSong( NewWeaponData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/MegaMan7/Robot Museum.spc", mimeType="application/octet-stream")]
		private const RobotMuseumData:Class;		public const SngRobotMuseum:Song = addSong( RobotMuseumData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/MegaMan7/The Eight Robot Masters.spc", mimeType="application/octet-stream")]
		private const TheEightRobotMastersData:Class;	public const SngTheEightRobotMasters:Song = addSong( TheEightRobotMastersData, -1, null, VOLUME );
		
//		[Embed(source="../../../../../assets/audio/seq/spc/MegaMan7/The Haunted Graveyard.spc", mimeType="application/octet-stream")]
//		private const TheHauntedGraveyardData:Class;		public const SngTheHauntedGraveyard:Song = addSong( TheHauntedGraveyardData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/MegaMan7/Shademan.spc", mimeType="application/octet-stream")]
		private const ShademanData:Class;		public const SngShademan:Song = addSong( ShademanData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/MegaMan7/Stage Start.spc", mimeType="application/octet-stream")]
		private const StageStartData:Class;	public const SngStageStart:Song = addSong( StageStartData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/MegaMan7/Remains of the Lab.spc", mimeType="application/octet-stream")]
		private const RemainsOfTheLabData:Class;		public const SngRemainsOfTheLab:Song = addSong( RemainsOfTheLabData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/MegaMan7/Ruined Highway.spc", mimeType="application/octet-stream")]
		private const RuinedHighwayData:Class;		public const SngRuinedHighway:Song = addSong( RuinedHighwayData, -1, null, VOLUME );
									
		[Embed(source="../../../../../assets/audio/seq/spc/MegaMan7/Dr. Wily 4.spc", mimeType="application/octet-stream")]
		private const DrWily4Data:Class;		public const SngDrWily4:Song = addSong( DrWily4Data, -1, null, VOLUME );
									
		[Embed(source="../../../../../assets/audio/seq/spc/MegaMan7/Final Battle with Dr. Wily.spc", mimeType="application/octet-stream")]
		private const FinalBattleWithDrWilyData:Class;		public const SngFinalBattleWithDrWily:Song = addSong( FinalBattleWithDrWilyData, -1, null, VOLUME );
									
		[Embed(source="../../../../../assets/audio/seq/spc/MegaMan7/Wily Defeated!.spc", mimeType="application/octet-stream")]
		private const WilyDefeatedData:Class;		public const SngWilyDefeated:Song = addSong( WilyDefeatedData, -1, null, VOLUME );
									
		[Embed(source="../../../../../assets/audio/seq/spc/MegaMan7/Staff Roll.spc", mimeType="application/octet-stream")]
		private const StaffRollData:Class;		public const SngStaffRoll:Song = addSong( StaffRollData, -1, null, VOLUME );
									
		[Embed(source="../../../../../assets/audio/seq/spc/MegaMan7/Stage Select.spc", mimeType="application/octet-stream")]
		private const StageSelectData:Class;		public const SngStageSelect:Song = addSong( StageSelectData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/MegaMan7/Springman.spc", mimeType="application/octet-stream")]
		private const SpringManData:Class;		public const SngSpringMan:Song = addSong( SpringManData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/MegaMan7/Auto's Shop.spc", mimeType="application/octet-stream")]
		private const AutosShopData:Class;		public const SngAutosShop:Song = addSong( AutosShopData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/MegaMan7/Slashman.spc", mimeType="application/octet-stream")]
		private const SlashManData:Class;		public const SngSlashMan:Song = addSong( SlashManData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/MegaMan7/Burstman.spc", mimeType="application/octet-stream")]
		private const BurstManData:Class;		public const SngBurstMan:Song = addSong( BurstManData, -1, null, VOLUME );

//		[Embed(source="../../../../../assets/audio/seq/spc/MegaMan7/Junkman.spc", mimeType="application/octet-stream")]
//		private const JunkManData:Class;		public const SngJunkMan:Song = addSong( JunkManData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/MegaMan7/Password.spc", mimeType="application/octet-stream")]
		private const PasswordData:Class;		public const SngPassword:Song = addSong( PasswordData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/MegaMan7/Wily's Secret Weapon.spc", mimeType="application/octet-stream")]
		private const WilysSecretWeaponData:Class;		public const SngWilysSecretWeapon:Song = addSong( WilysSecretWeaponData, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/MegaMan7/Dr. Wily 2.spc", mimeType="application/octet-stream")]
		private const DrWily2Data:Class;		public const SngDrWily2:Song = addSong( DrWily2Data, -1, null, VOLUME );

		[Embed(source="../../../../../assets/audio/seq/spc/MegaMan7/Protoman's Whistle.spc", mimeType="application/octet-stream")]
		private const ProtoManWhistleData:Class;		public const SngProtoManWhistle:Song = addSong( ProtoManWhistleData, -1, null, VOLUME );		
									
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
		
			addToTypePlayList(LT_CASTLE, SngDrWily4);
			addToTypePlayList(LT_CHEEP_CHEEP, SngRuinedHighway);
			addToTypePlayList(LT_COIN_HEAVEN, SngAutosShop);
			addToTypePlayList(LT_INTRO, SngRemainsOfTheLab);
			addToTypePlayList(LT_NORMAL, SngSlashMan);
			addToTypePlayList(LT_PIPE_BONUS, SngDrWily2);
			addToTypePlayList(LT_PLATFORM, SngSpringMan);
			addToTypePlayList(LT_UNDER_GROUND, SngShademan);
			addToTypePlayList(LT_WATER, SngBurstMan);
			addToTypePlayList(MT_DARK_EPIC, SngRobotMuseum);
			
			
			addToTypePlayList(BOSS, SngTheEightRobotMasters);
			addToTypePlayList(CHAR_SEL, SngStageSelect);
			addToTypePlayList(CHOOSE_CHARACTER, SngStageStart);
			addToTypePlayList(CREDITS, SngStaffRoll);
			addToTypePlayList(DIE, null);
			addToTypePlayList(FINAL_BOSS, SngFinalBattleWithDrWily);
			addToTypePlayList(GAME_OVER, SngPassword);
			addToTypePlayList(HURRY, SngWilysSecretWeapon);
			addToTypePlayList(STAR, SngNewWeapon);
			addToTypePlayList(TITLE_SCREEN, SngRuinedHighway);
			addToTypePlayList(WIN, SngStageClear);
			addToTypePlayList(WIN_CASTLE, SngWilyDefeated);
			
		}
	}
}