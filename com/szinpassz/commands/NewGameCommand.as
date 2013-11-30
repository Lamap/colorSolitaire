package com.szinpassz.commands 
{
	import com.szinpassz.models.ColorModel;
	import com.szinpassz.models.GameEvent;
	import com.szinpassz.models.GameModel;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class NewGameCommand extends Command 
	{
		[Inject]
		public var colorModel:ColorModel;
		
		[Inject]
		public var gameModel:GameModel;
		
		public function NewGameCommand() 
		{
			
		}
		
		override public function execute():void
		{
			trace("new Game Command Executed");
			
			colorModel.resetColors();
			if (!gameModel.USE_WHITE_CARD_POSITIONS) colorModel.shuffleSimple();
			else colorModel.shuffleWhiteRestriction();
			
			gameModel.clean();
			dispatch(new GameEvent(GameEvent.CLEAN_TABLE));
			
			gameModel.startNewDeck();

			dispatch(new GameEvent(GameEvent.START_DEAL_FROM_DECK));
		}
		
	}

}