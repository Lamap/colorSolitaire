package com.szinpassz.models.vo 
{
	/**
	 * ...
	 * @author Ákos
	 */
	public class PlaceMentTargetVO 
	{
		private var _targetHolder:String;
		private var _targetIndex:int;
		
		public function PlaceMentTargetVO() 
		{
			
		}
		
		public function get targetHolder():String 
		{
			return _targetHolder;
		}
		
		public function set targetHolder(value:String):void 
		{
			_targetHolder = value;
		}
		
		public function get targetIndex():int 
		{
			return _targetIndex;
		}
		
		public function set targetIndex(value:int):void 
		{
			_targetIndex = value;
		}
		
	}

}