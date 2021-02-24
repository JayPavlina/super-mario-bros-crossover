package com.explodingRabbit.cross.games
{
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;
	
	import flash.utils.Dictionary;
	
	public class GameMegaManAndBass extends Game
	{
		private static var instance:Game; 

		public function GameMegaManAndBass(gameNum:int, skinSetNum:int = -1)
		{
			super("Mega Man and Bass", "Capcom", Consoles.superNintendo, gameNum, null, skinSetNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		private const VOLUME:int = 45;
		
		[Embed(source="../../../../../assets/audio/seq/spc/MegaManAndBass/Burnerman.spc", mimeType="application/octet-stream")]
		private const BurnermanData:Class;	public const SngBurnerman:Song = addSong( BurnermanData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/MegaManAndBass/Game Over.spc", mimeType="application/octet-stream")]
		private const GameOverData:Class;	public const SngGameOver:Song = addSong( GameOverData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/MegaManAndBass/Major Boss Battle.spc", mimeType="application/octet-stream")]
		private const MajorBossBattleData:Class;		public const SngMajorBossBattle:Song = addSong( MajorBossBattleData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/MegaManAndBass/Pirateman.spc", mimeType="application/octet-stream")]
		private const PiratemanData:Class;	public const SngPirateman:Song = addSong( PiratemanData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/MegaManAndBass/Tenguman.spc", mimeType="application/octet-stream")]
		private const TengumanData:Class;	public const SngTenguman:Song = addSong( TengumanData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/MegaManAndBass/Museum.spc", mimeType="application/octet-stream")]
		private const MuseumData:Class;	public const SngMuseum:Song = addSong( MuseumData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/MegaManAndBass/Character Select.spc", mimeType="application/octet-stream")]
		private const CharacterSelectData:Class;	public const SngCharacterSelect:Song = addSong( CharacterSelectData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/MegaManAndBass/Stage Selected.spc", mimeType="application/octet-stream")]
		private const StageSelectedData:Class;	public const SngStageSelected:Song = addSong( StageSelectedData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/MegaManAndBass/Boss Battle.spc", mimeType="application/octet-stream")]
		private const BossBattleData:Class;	public const SngBossBattle:Song = addSong( BossBattleData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/MegaManAndBass/Staff Roll.spc", mimeType="application/octet-stream")]
		private const StaffRollData:Class;	public const SngStaffRoll:Song = addSong( StaffRollData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/MegaManAndBass/Victory.spc", mimeType="application/octet-stream")]
		private const VictoryData:Class;	public const SngVictory:Song = addSong( VictoryData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/MegaManAndBass/Auto's Shop.spc", mimeType="application/octet-stream")]
		private const AutosShopData:Class;	public const SngAutosShop:Song = addSong( AutosShopData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/MegaManAndBass/Astroman.spc", mimeType="application/octet-stream")]
		private const AstromanData:Class;	public const SngAstroman:Song = addSong( AstromanData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/MegaManAndBass/King Castle.spc", mimeType="application/octet-stream")]
		private const KingCastleData:Class;	public const SngKingCastle:Song = addSong( KingCastleData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/MegaManAndBass/Wily Castle.spc", mimeType="application/octet-stream")]
		private const WilyCastleData:Class;	public const SngWilyCastle:Song = addSong( WilyCastleData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/MegaManAndBass/Coldman.spc", mimeType="application/octet-stream")]
		private const ColdManData:Class;	public const SngColdMan:Song = addSong( ColdManData, -1, null, VOLUME );
		
//		[Embed(source="../../../../../assets/audio/seq/spc/MegaManAndBass/King Castle Intro.spc", mimeType="application/octet-stream")]
//		private const KingCastleIntroData:Class;	public const SngKingCastleIntro:Song = addSong( KingCastleIntroData, -1, null, VOLUME );
		
		[Embed(source="../../../../../assets/audio/seq/spc/MegaManAndBass/Database.spc", mimeType="application/octet-stream")]
		private const DatabaseData:Class;	public const SngDatabase:Song = addSong( DatabaseData, -1, null, VOLUME );
		
//		[Embed(source="../../../../../assets/audio/seq/spc/MegaManAndBass/Seals.spc", mimeType="application/octet-stream")]
//		private const SealsData:Class;	public const SngSeals:Song = addSong( SealsData, -1, null, VOLUME );
		
		override protected function createPlayList():void
		{
			addOverridableMusicTypes(LT_NORMAL);
			
			addToTypePlayList(LT_CASTLE, SngWilyCastle);
			addToTypePlayList(LT_CHEEP_CHEEP, SngMuseum);
			addToTypePlayList(LT_COIN_HEAVEN, SngTenguman); // SngBurnerman
			addToTypePlayList(LT_INTRO, SngDatabase);
			addToTypePlayList(LT_NORMAL, SngColdMan);
			addToTypePlayList(LT_PIPE_BONUS, SngAutosShop);
			addToTypePlayList(LT_PLATFORM, SngBurnerman); // SngPirateman
			addToTypePlayList(LT_UNDER_GROUND, SngAstroman);
			addToTypePlayList(LT_WATER, SngPirateman); // SngTenguman
			addToTypePlayList(MT_DARK_EPIC, SngKingCastle);
			
			addToTypePlayList(BOSS, SngBossBattle);
			addToTypePlayList(CHAR_SEL, SngCharacterSelect);
			addToTypePlayList(CHOOSE_CHARACTER, SngStageSelected);
			addToTypePlayList(CREDITS, SngStaffRoll);
			addToTypePlayList(DIE, null);
			addToTypePlayList(FINAL_BOSS, SngMajorBossBattle);
			addToTypePlayList(GAME_OVER, SngGameOver);
			addToTypePlayList(HURRY, SngMajorBossBattle);
			addToTypePlayList(STAR, null);
			addToTypePlayList(TITLE_SCREEN, SngColdMan);
			addToTypePlayList(WIN, SngVictory);
			addToTypePlayList(WIN_CASTLE, Games.megaMan7.SngWilyDefeated);
		}
	}
}