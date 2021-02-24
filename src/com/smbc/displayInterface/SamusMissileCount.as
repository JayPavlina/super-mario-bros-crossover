package com.smbc.displayInterface
{
	import com.smbc.graphics.fontChars.FontCharHud;
	import com.smbc.main.GlobalFunctions;
	import com.smbc.managers.TextManager;
	import com.smbc.text.TextFieldContainer;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	
	[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="SamusMissileCount")]
	public final class SamusMissileCount extends Sprite
	{
		private static const X_POS:int = 30;
		private static const Y_POS:int = 90;
		private static const TXT_X_OFS:int = 30;
		private static const TXT_Y_OFS:int = -4;
		private static const TXT_DEFAULT_STR:String = "00";
		private const TXT:TextFieldContainer = new TextFieldContainer(FontCharHud.FONT_NUM);
		public function SamusMissileCount()
		{
			super();
			x = X_POS;
			y = Y_POS;
			TextManager.INSTANCE.setUpNewTextField(TXT,TXT_X_OFS,TXT_Y_OFS,this,TXT_DEFAULT_STR);
		}
		public function updateDisplay(num:int):void
		{
			var str:String = num.toString();
			if (str.length == 1)
				str = "0" + str;
			TXT.text = str;
		}
	}
}