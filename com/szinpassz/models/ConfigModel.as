package com.szinpassz.models 
{
	import flash.geom.Point;
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class ConfigModel extends Actor 
	{
		public static const CARD_WIDTH:Number = 90;
		public static const CARD_HEIGHT:Number = 90;
		
		public static const DECK_INSERTSTIO_POINT:Point = new Point(50,385);
		
		public static const BUFFER_INSERTION_POINT:Point = new Point(280, 240);
		public static const BUFFER_PLACING_GAP:Number = 14;
		public static const BUFFER_VERTICAL_PLACE_GAP:Number = 15;
		
		public static const COLLECTOR_INSERTION_POINT:Point = new Point(180, 20);
		public static const COLLECTOR_PLACING_GAP:Number = 14;
		public static const COLLECTOR_VERTICAL_PLACE_GAP:Number = 15;
		
		public static const CARDPLACE_COLOR:uint = 0x999999;
		public static const CARDPLACE_ALPHA:Number = 0.75;
		
		public static const PLACEMENT_X_OFFSET:Number = 30;
		public static const PLACEMENT_Y_OFFSET:Number = 35;
		
		
		public static const WELCOME_SCENE_SHOW_TIME:int = 4000;
		
		public function ConfigModel() 
		{
			
		}
		
	}

}