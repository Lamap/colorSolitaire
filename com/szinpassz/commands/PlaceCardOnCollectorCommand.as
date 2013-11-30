package com.szinpassz.commands 
{
	import com.szinpassz.models.GameEvent;
	import com.szinpassz.models.GameModel;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class PlaceCardOnCollectorCommand extends Command 
	{
		[Inject]
		public var gameModel:GameModel;
		
		public function PlaceCardOnCollectorCommand() 
		{
			
		}
		override public function execute():void
		{
			trace("PlaceCardOnCollectorCommand execute");
			gameModel.placeCardsOnCollector();	
		}
	}

}