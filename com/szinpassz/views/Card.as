package com.szinpassz.views 
{
	import com.szinpassz.models.ConfigModel;
	import com.szinpassz.models.GameModel;
	import com.szinpassz.models.vo.ColorVO;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class Card extends Sprite 
	{
		
		private var _colorVO:ColorVO;
		
		private var _bufferColl:int;
		private var _bufferRow:int;
		
		private var _collectorColl:int = -1;
		private var _collectorRow:int = -1;
		
		private var _positionFromDragger:Point = new Point(0, 0);
		
		private var upShadowColor = 0xFFFFFF;
		
		//inside vars
		
		public function Card($colorVo:ColorVO) 
		{ 
			colorVO = $colorVo;
			createGFX();
		}
		
		private function createGFX():void 
		{
			graphics.beginFill(colorVO.rgb);
			
			var outlineColor:uint;
			
			/*if (colorVO.rgb == 0x000000) outlineColor = 0xFFFFFF;
			else outlineColor = 0x000000;
			graphics.lineStyle(2, outlineColor, .5);*/
			graphics.drawRoundRect(0, 0, ConfigModel.CARD_WIDTH, ConfigModel.CARD_HEIGHT,10,10);
			graphics.endFill();
			
			if (colorVO.rgb == 0xFFFFFF) upShadowColor = 0x000000;
			
			var downShadow:DropShadowFilter = new DropShadowFilter(6, 45, 0x000000, .3, 6, 6, 1, 1);
			var upShadow:DropShadowFilter = new DropShadowFilter(5, -135, upShadowColor, .05, 12, 12, 1, 1);
			filters = new Array(downShadow,upShadow);
			
		}
		
	///////////////////////////	
		public function get colorVO():ColorVO 
		{
			return _colorVO;
		}
		
		public function set colorVO(value:ColorVO):void 
		{
			_colorVO = value;
		}
		
		public function get bufferColl():int 
		{
			return _bufferColl;
		}
		
		public function set bufferColl(value:int):void 
		{
			_bufferColl = value;
		}
		
		public function get bufferRow():int 
		{
			return _bufferRow;
		}
		
		public function set bufferRow(value:int):void 
		{
			_bufferRow = value;
		}
		
		public function get positionFromDragger():Point 
		{
			return _positionFromDragger;
		}
		
		public function set positionFromDragger(value:Point):void 
		{
			_positionFromDragger = value;
		}
		
		public function get collectorColl():int 
		{
			return _collectorColl;
		}
		
		public function set collectorColl(value:int):void 
		{
			_collectorColl = value;
		}
		
		public function get collectorRow():int 
		{
			return _collectorRow;
		}
		
		public function set collectorRow(value:int):void 
		{
			_collectorRow = value;
		}
		
	}

}