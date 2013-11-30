package com.szinpassz.views 
{
	import com.szinpassz.models.GameEvent;
	import com.szinpassz.models.GameModel;
	import flash.events.MouseEvent;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class DeckMediator extends Mediator 
	{
		[Inject]
		public var deck:Deck;
		
		[Inject]
		public var gameModel:GameModel;
		
		public function DeckMediator() 
		{
			super();
			
		}
		override public function onRegister():void
		{
			trace("DeckMediator Registered", gameModel);
			
			addContextListener(GameEvent.DECK_CHANGED, onDeckChanged);
			
			addViewListener(MouseEvent.CLICK, placeCardsToBuffer);
			//deck.cardPack.addEventListener(MouseEvent.CLICK, placeCardsToBuffer, false, 0, true) ;
		}
		
		private function placeCardsToBuffer(e:MouseEvent):void 
		{
			trace("placeCardsToBuffer");
			dispatch(new GameEvent(GameEvent.START_DEAL_FROM_DECK));
		}
		
		private function onDeckChanged(e:GameEvent):void 
		{
			trace("DeckMediator::onDeckChanged",deck);
			deck.deckCount = gameModel.deck.length;
		}
	}

}