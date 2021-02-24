package com.smbc.managers
{
	import com.explodingRabbit.utils.CustomDictionary;
	import com.smbc.data.GameSettings;
	import com.smbc.errors.SingletonError;
	import com.smbc.main.GlobVars;
	import com.smbc.text.TextFieldContainer;
	
	import flash.display.DisplayObjectContainer;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class TextManager extends MainManager
	{
		private static var instantiated:Boolean;
		public static const INSTANCE:TextManager = new TextManager();
		public const TFC_DCT:CustomDictionary = new CustomDictionary(true);
		private var currentTxtFrm:TextFormat;
		public function TextManager()
		{
			super();
			if (instantiated)
				throw new SingletonError();
			instantiated = true;
		}
		override public function initiate():void
		{
			super.initiate();
			//setUpTxtFrms();
		}
		/*private function setUpTxtFrms():void
		{
			var fontVec:Vector.<Array> = FontInfo.FONT_VEC;
			var indFont:int = FontInfo.IND_FONT;
			var n:int = fontVec.length;
			for (var i:int; i < n; i++)
			{
				var font:Font = fontVec[i][indFont];
				var tf:TextFormat = new TextFormat(font.fontName,16,0xFFFFFF);
				if (i > 0)
					tf.size = 26;
				FONT_VEC[i] = tf;
			}
			FONT_VEC.fixed = true;
		}*/
		public function setUpNewTextField(tfc:TextFieldContainer,xPos:Number = 0,yPos:Number = 0,container:DisplayObjectContainer = null,txtStr:String = ""):void
		{
			//var txtFrm:TextFormat = FONT_VEC[GameSettings.interfaceSkin];
			//tfc.defaultTextFormat = txtFrm;
			//tfc.setTextFormat(txtFrm);
			//tfc.selectable = false;
			//tfc.embedFonts = true;
			//tf.filters = [GlobVars.TXT_DROP_SHADOW];
			TFC_DCT[tfc] = true;
			if (xPos != 0)
				tfc.x = xPos;
			if (yPos != 0)
				tfc.y = yPos;
			if (container != null)
				container.addChild(tfc);
			if (txtStr != "")
				tfc.text = txtStr;
			//tfNew.autoSize = TextFieldAutoSize.LEFT;
		}
		public function replaceStageTextField(tfOld:TextField,tfCont:TextFieldContainer,parentCont:DisplayObjectContainer):void
		{
			tfCont.x = tfOld.x;
			tfCont.y = tfOld.y-1;
			//tfCont.autoSize = TextFieldAutoSize.LEFT;
			//tfCont.selectable = false;
			//tfCont.embedFonts = true;
			tfCont.text = tfOld.text;
			//var txtFrm:TextFormat = FONT_VEC[GameSettings.interfaceSkin];
			//tfCont.defaultTextFormat = txtFrm;
			//tfCont.setTextFormat(txtFrm);
			TFC_DCT[tfCont] = true;
			parentCont.addChildAt(tfCont,parentCont.getChildIndex(tfOld));
			parentCont.removeChild(tfOld);
		}
	}
}