package com.szinpassz.models.vo 
{
	/**
	 * ...
	 * @author Ákos
	 */
	public class ColorVO 
	{
		private var _colorGroup:String;
		private var _colorIndex:int;
		private var _rgb:uint;
		private var _sortIndex:int;
		
		public function ColorVO($colorGroupName:String,$colorIndex:int,$rgb:uint) 
		{
			colorGroup = $colorGroupName;
			colorIndex = $colorIndex;
			rgb = $rgb;
			sortIndex = Math.floor(Math.random()*10000);
		}
		
		public function get colorGroup():String 
		{
			return _colorGroup;
		}
		
		public function set colorGroup(value:String):void 
		{
			_colorGroup = value;
		}
		
		public function get colorIndex():int 
		{
			return _colorIndex;
		}
		
		public function set colorIndex(value:int):void 
		{
			_colorIndex = value;
		}
		
		public function get rgb():uint 
		{
			return _rgb;
		}
		
		public function set rgb(value:uint):void 
		{
			_rgb = value;
		}
		
		public function get sortIndex():int 
		{
			return _sortIndex;
		}
		
		public function set sortIndex(value:int):void 
		{
			_sortIndex = value;
		}
		
	}

}