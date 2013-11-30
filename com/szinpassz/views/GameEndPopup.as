package com.szinpassz.views 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class GameEndPopup extends Sprite 
	{
		private var _message:String;
		private var textField:TextField;
		
		public function GameEndPopup($message:String) 
		{
			textField = messageHolder;
			message = $message;
		}
		
		public function get message():String 
		{
			return _message;
		}
		
		public function set message(value:String):void 
		{
			_message = value;
			textField.text = _message;
		}
		
	}

}