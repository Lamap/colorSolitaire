package com.szinpassz.models.vo 
{
	/**
	 * ...
	 * @author Ákos
	 */
	public class CollectorVO 
	{
		private var _collums:Array = new Array();
		private var _collumsCount:int;
		
		public function CollectorVO($size:int = 6) 
		{
			collumsCount = $size;
			
			for (var i:int = 0; i < collumsCount; i++ )
			{
				var collum:Array = new Array();
				collums[i] = collum;
			}
		}
		
		public function get collums():Array 
		{
			return _collums;
		}
		
		public function set collums(value:Array):void 
		{
			_collums = value;
		}
		
		public function get collumsCount():int 
		{
			return _collumsCount;
		}
		
		public function set collumsCount(value:int):void 
		{
			_collumsCount = value;
		}
		
	}

}