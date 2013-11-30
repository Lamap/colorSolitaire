package com.szinpassz.commands 
{
	import com.szinpassz.models.GameEvent;
	import com.szinpassz.models.GameModel;
	import com.szinpassz.views.GameEndPopup;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class CheckGameEndCommand extends Command 
	{
		[Inject]
		public var gameModel:GameModel;
		
		private var gameEndPop:GameEndPopup;
		
		public function CheckGameEndCommand() 
		{
			super();
			
		}
		override public function execute():void
		{
			trace("checkGameEndCommand execute::: more?");
			
			if (gameModel.checkCollectorIfFinished()) {
				gameEndPop = new GameEndPopup("Gratulálunk, nyertél. Még egy játék?");
				contextView.addChild(gameEndPop);	
				return;
				}
			
			else if (!gameModel.isTherePlaceOption() && gameModel.deck.length == 0) {
				dispatch(new GameEvent(GameEvent.NO_MORE_OPTIONS));
				gameEndPop = new GameEndPopup("Sajnáljuk, de végleg elakadtál, nincs több lehetőség. Újra?");
				contextView.addChild(gameEndPop);
			}
			else if (!gameModel.isTherePlaceOption())dispatch(new GameEvent(GameEvent.NEEDS_DEAL_FROM_DECK));
		}
	}

}