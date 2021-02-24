package com.smbc.text
{
	import flash.text.TextField;
	
	public class CustomTextField extends TextField
	{
		public var container:TextFieldContainer;
		public var partners:Vector.<CustomTextField>;
		
		public function CustomTextField()
		{
			super();
			this.container = container;
			this.partners = Vector.<CustomTextField>(partners);	
		}
	}
}