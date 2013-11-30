package com.szinpassz.commands 
{
	import com.szinpassz.models.ColorModel;
	import com.szinpassz.models.ConfigModel;
	import com.szinpassz.models.GameEvent;
	import com.szinpassz.models.GameModel;
	import com.szinpassz.views.Deck;
	import com.szinpassz.views.Menu;
	import com.szinpassz.views.Table;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class StartUpCommand extends Command 
	{
		
		[Inject]
		public var colorModel:ColorModel;
		
		[Inject]
		public var gameModel:GameModel;
		
		[Inject]
		public var configModel:ConfigModel;
		
		private var table:Table;
		private var deck:Deck;
		private var menu:Menu;
		
		private var welcomeSceneShowTimer:Timer;
		
		public function StartUpCommand() 
		{
			
		}
		override public function execute():void
		{
			
			menu = new Menu();
			contextView.addChild(menu);
			
			table = new Table();
			contextView.addChild(table);
			deck = new Deck();
			deck.x = ConfigModel.DECK_INSERTSTIO_POINT.x;
			deck.y = ConfigModel.DECK_INSERTSTIO_POINT.y;
			contextView.addChild(deck);
			
			if (!gameModel.USE_WHITE_CARD_POSITIONS) colorModel.shuffleSimple();
			else colorModel.shuffleWhiteRestriction();
			
			gameModel.startNewDeck();

			dispatch(new GameEvent(GameEvent.START_DEAL_FROM_DECK));
		}
		
		
	}

}