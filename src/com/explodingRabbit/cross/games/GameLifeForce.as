package com.explodingRabbit.cross.games
{
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.sound.Song;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.ThemeGroup;

	import flash.utils.Dictionary;
	
	public class GameLifeForce extends Game
	{
		private static var instance:Game;
		
		public function GameLifeForce(gameNum:int)
		{
			super("Life Force", "Konami", Consoles.nintendo, gameNum);
			if (instance)
				throw new SingletonError();
			instance = this;
		}
		
		[Embed(source="../../../../../assets/audio/seq/nsf/LifeForce.nsfe", mimeType="application/octet-stream")]
		public const Nsfe:Class;
		
		private const VOLUME:int = 65; 
		
		public const SngStage1LifeForce:Song = addSong( Nsfe, 1, null, VOLUME );
		public const SngStage2Meteorolite:Song = addSong( Nsfe, 2, null, VOLUME );
		public const SngStage3BlazingPhoenixAndDragon:Song = addSong( Nsfe, 3, null, VOLUME );
		public const SngStage4OrganicLifeForms:Song = addSong( Nsfe, 4, null, VOLUME );
		public const SngStage5RoadToMystery:Song = addSong( Nsfe, 5, null, VOLUME );
		public const SngStage5Bonus:Song = addSong( Nsfe, 6, null, VOLUME );
		public const SngStage5Pyramic:Song = addSong( Nsfe, 7, null, VOLUME );
		public const SngStage6StarsAndLight:Song = addSong( Nsfe, 8, null, VOLUME );
		public const SngBoss:Song = addSong( Nsfe, 9, null, VOLUME );
		public const SngEnding:Song = addSong( Nsfe, 10, null, VOLUME );
		
	}
}