package com.szinpassz.models 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class GameEvent extends Event 
	{
		public static const DECK_CHANGED:String = "deckChanged";
		public static const START_DEAL_FROM_DECK:String = "startDealFromDeck";
		public static const PLACE_CARDS_ON_BUFFER:String = "PlaceCardsOnBuffer";
		public static const CARDS_DROPPED_DOWN:String = "cardsDroppedDown";
		public static const CARDS_DROPPED_WRONG:String = "cardsDroppedWrong";
		public static const CARDS_REPLACED_IN_BUFFER:String = "cardsReplacedInBuffer";
		public static const CARDS_PLACED_ON_COLLECTOR:String = "cardsPlacedOnCollector";
		public static const BUFFER_CHANGED:String = "bufferChanged";
		public static const COLLECTOR_CHANGED:String = "collectorChanged";
		
		public static const TABLE_CHANGE_FINISHED:String = "tableChangeFinished";
		
		public static const GAME_WON:String = "gameWon";
		public static const NO_MORE_OPTIONS:String = "noMoreOptions";
		public static const NEEDS_DEAL_FROM_DECK:String = "needsDealFromDeck";
		
		public static const START_NEW_GAME:String = "startNewGame";
		public static const CLEAN_TABLE:String = "cleanTable";
		
		public static const GAME_STARTUP:String = "gameStartUp";
		
		public var paramObject:Object;
		
		public function GameEvent($type:String,$paramObject:Object = null) 
		{
			paramObject = $paramObject;
			super($type);
		}
		
		override public function clone():Event
		{
			return new GameEvent(type,paramObject);
		}
	}

}