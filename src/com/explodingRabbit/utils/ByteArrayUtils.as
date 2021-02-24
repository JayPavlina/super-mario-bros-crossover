package com.explodingRabbit.utils
{
	public class ByteArrayUtils
	{
	
		public static const SAMPLE_RATE:int = 44100;
		public static const NUM_BYTES_PER_CHANNEL:int = 4;
		public static const NUM_BYTES_PER_SAMPLE:int = NUM_BYTES_PER_CHANNEL*2; 
		public static const NUM_BYTES_PER_SECOND:int = SAMPLE_RATE * NUM_BYTES_PER_SAMPLE; 
//		private static const NUM_BYTES_PER_READ:int = SoundContainer.NUM_BYTES_PER_CYCLE;
		
		public static function bytesToMs(numBytes:uint):int
		{
			return Math.round( (numBytes/NUM_BYTES_PER_SECOND)*1000 );
		}
		public static function msToBytes(numMs:int,accuracy:int = NUM_BYTES_PER_SAMPLE):uint
		{
			var numBytes:int = Math.round( (numMs/1000)*NUM_BYTES_PER_SECOND );
			var mod:int = numBytes % accuracy;
			if (mod < accuracy/2)
				numBytes -= mod;
			else
				numBytes += accuracy - mod;
			return numBytes;
		}
	}
}