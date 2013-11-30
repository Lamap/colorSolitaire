package com.szinpassz.commands 
{
	import com.szinpassz.models.GameEvent;
	import com.szinpassz.models.GameModel;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class CardsDroppedWrongCommand extends Command 
	{
		[Inject]
		public var gameModel:GameModel;
		
		public function CardsDroppedWrongCommand() 
		{
			super();
			
		}
		
		override public function execute():void
		{
			trace("CardsDroppedWrongCommand execute");
			dispatch(new GameEvent(GameEvent.CARDS_DROPPED_WRONG));
		}
	}

}