package com.smbc.ground
{
	import com.smbc.characters.*;
	import com.smbc.characters.base.*;

	public class SpringGreen extends SpringRed
	{
		public function SpringGreen()
		{
			super();
			if (player is MarioBase)
				boostSpringPwr = 2750;
			else if (player is MegaManBase)
				boostSpringPwr = 3000; // perfect
			else if (player is Bill)
				boostSpringPwr = 2150; // perfect
			else if (player is Link)
				boostSpringPwr = 2750; // perfect
			else if (player is Ryu)
				boostSpringPwr = 2750; // perfect
			else if (player is Samus)
				boostSpringPwr = 1750; // perfect
			else if (player is Simon)
				boostSpringPwr = 4250; // perfect
			else if (player is Sophia)
				boostSpringPwr = 3500; // perfect
		}
	}
}