package com.szinpassz.models 
{
	import com.szinpassz.models.vo.BufferVO;
	import com.szinpassz.models.vo.CollectorVO;
	import com.szinpassz.models.vo.PlaceMentTargetVO;
	import com.szinpassz.views.Card;
	import flash.sampler.NewObjectSample;
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class GameModel extends Actor 
	{
		
		public static const BUFFER_SIZE:int = 5;//the size of the buffer collums
		public static const WHITE_CARDS_POSITIONS:Array = new Array(0, 2, 4, 6); //in which dealToBuffer contains white cards for sure
		public const USE_WHITE_CARD_POSITIONS:Boolean = true;
		
		public const MOVEABLE_CARDS:int = 5;//the number of draggable cards. 0 means no restriction.
		
		private var _cards:Array;
		private var _deck:Array;

		public var buffer:BufferVO;
		public var moveingCards:Array = new Array();
		public var placementVO:PlaceMentTargetVO;
		
		private var moveableCardsArray:Array = new Array();
		
		public var collector:CollectorVO;
		
		
		
		//inside vars
		var colors:Array;
		[Inject]
		public var colorModel:ColorModel;
		
		public function GameModel() 
		{
			_deck = new Array();
			_cards = new Array();
			
			buffer = new BufferVO(GameModel.BUFFER_SIZE);
			collector = new CollectorVO();
	
		}
		
		public function get deck():Array 
		{
			return _deck;
		}
		
		 public function clean():void
		 {
			 cards.splice(0);
			 deck.splice(0);
			 for(var i:String in buffer.collums)buffer.collums[i].splice(0);
			 for(var j:String in collector.collums)collector.collums[j].splice(0);
		 }
		///
		public function startNewDeck():void
		 {
			 colors = colorModel.colors;
			 
			 for (var i:String in colors) {
				 var card:Card = new Card(colors[i]);
		
				 cards.push(card);
				 deck.push(card);
			 }
			 
			dispatch(new GameEvent(GameEvent.DECK_CHANGED));
			trace("GameEvent.DECK_CHANGED dispatched");
		 };
		 
		
		 
		 ///
		 public function dealToBuffer():void
		 {
			 trace("GameModel.dealToBuffer()");
			 
			 for (var i:int = 0; i < GameModel.BUFFER_SIZE; i++ )
			 {
				 if(deck.length > 0)
				 (buffer.collums[i] as Array).push(deck.shift());
			 }
			dispatch(new GameEvent(GameEvent.DECK_CHANGED));
			trace("GameEvent.DECK_CHANGED dispatched");
			dispatch(new GameEvent(GameEvent.PLACE_CARDS_ON_BUFFER));
		 }
		 
		 ///
		 public function replaceCardsOnBuffer():void
		 {
			
			 trace(" to", placementVO.targetIndex, "from", (moveingCards[0] as Card).bufferColl,"moveingCards",moveingCards.length);
			 var from:int = (moveingCards[0] as Card).bufferColl;
			 var to:int = placementVO.targetIndex;
			 
			 //remove cards
			(buffer.collums[from] as Array).splice((buffer.collums[from] as Array).length - moveingCards.length);
			for (var i:String in moveingCards)(moveingCards[i] as Card).parent.removeChild((moveingCards[i] as Card));
		
			// for (var i:String in (buffer.collums[from] as Array)) trace(((buffer.collums[from] as Array)[i] as Card).colorVO.colorIndex);
			 //put cards
			 buffer.collums[to] = (buffer.collums[to] as Array).concat(moveingCards);
			 
			 dispatch(new GameEvent(GameEvent.BUFFER_CHANGED));
		 }
		 //
		 public function placeCardsOnCollector():void
		 {
			 //change Buffer (remove)
			 var from:int = (moveingCards[0] as Card).bufferColl;
			 (buffer.collums[from] as Array).splice((buffer.collums[from] as Array).length - moveingCards.length);
			 for (var i:String in moveingCards)(moveingCards[i] as Card).parent.removeChild((moveingCards[i] as Card));
 
			 //change Collector (add)
			 trace((moveingCards[0] as Card).colorVO.colorGroup);
			 var to:int = placementVO.targetIndex;
			 collector.collums[to] = (collector.collums[to] as Array).concat(moveingCards);
		
			dispatch(new GameEvent(GameEvent.COLLECTOR_CHANGED)); 
			dispatch(new GameEvent(GameEvent.BUFFER_CHANGED));
		 }
		 
		 public function checkCollectorIfFinished():Boolean 
		 {
			 var finished:Boolean = true;
			 for (var i:String in collector.collums) {
				 if ((collector.collums[i] as Array).length != 8) finished = false;
				 //trace("checkend:",(collector.collums[i] as Array).length);
				 }
			 return finished;
		 }
		 //
		 public function setMoveableCards(card:Card):Boolean
		 {
			// trace(card.bufferColl, card.bufferRow);
			 
			 moveingCards.splice(0);
			 
			 //check if the card is above the draggable card numbers
			 var moveableCardsLength:int = buffer.collums[card.bufferColl].length - card.bufferRow;
			 if (MOVEABLE_CARDS != 0 && MOVEABLE_CARDS < moveableCardsLength) return false;
			 
			 // create the moveing card array
			 for (var i:int = card.bufferRow; i < buffer.collums[card.bufferColl].length; i++)
			 {
				 moveingCards.push(buffer.collums[card.bufferColl][i]);
				 buffer.collums[card.bufferColl][i].parent.setChildIndex(  buffer.collums[card.bufferColl][i],buffer.collums[card.bufferColl][i].parent.numChildren -1);
				(buffer.collums[card.bufferColl][i] as Card).positionFromDragger.x =  (buffer.collums[card.bufferColl][i] as Card).x -  (buffer.collums[card.bufferColl][card.bufferRow] as Card).x;
				(buffer.collums[card.bufferColl][i] as Card).positionFromDragger.y =  (buffer.collums[card.bufferColl][i] as Card).y -  (buffer.collums[card.bufferColl][card.bufferRow] as Card).y;
				}
					
			//check if the cards are fit to the colorlinerules
			 return checkfitToColorRules(moveingCards);	 
		 }
		 
		 public function checkfitToColorRules($cardsToCheck:Array, $isStricktCheck:Boolean = true):Boolean 
		 {
			// trace(" --------- $cardsToCheck.length",$cardsToCheck.length);
			 // if only 1 card. no sense to invastigate
			 if ($cardsToCheck.length == 1) return true;
			  
			 //colorRules
			  var reversedOrder:Boolean
			  var selectedColor:String;
			  
			
			 for(var i:int = 0; i < $cardsToCheck.length - 1; i++)
			 {
				 
				 //decide if 1st or second part
				 if (($cardsToCheck[i] as Card).colorVO.colorIndex < ($cardsToCheck[i + 1] as Card).colorVO.colorIndex) reversedOrder = true;
				 else reversedOrder = false;
				 
			//trace("checkRules: ",i,"reversed:",reversedOrder,"card:",($cardsToCheck[i + 1] as Card).colorVO.colorIndex);
			
				 //set the selected Color
				 if (($cardsToCheck[i] as Card).colorVO.colorGroup == "BLACK" || ($cardsToCheck[i] as Card).colorVO.colorGroup == "WHITE")
				 {
					 if (($cardsToCheck[i] as Card).colorVO.colorIndex != 3) selectedColor = "?"; 
				 }
				 else selectedColor = ($cardsToCheck[i] as Card).colorVO.colorGroup;
				 
				 //check the same color if not white or black
				 if (selectedColor != "?") {
					 if (
						 ($cardsToCheck[i] as Card).colorVO.colorGroup != ($cardsToCheck[i + 1] as Card).colorVO.colorGroup &&
						 ($cardsToCheck[i + 1] as Card).colorVO.colorGroup != "BLACK"
					 ) 
					 return false;
					 }
				 
				 // check the index row
				 if (reversedOrder) {
					  if (($cardsToCheck[i] as Card).colorVO.colorIndex != ($cardsToCheck[i + 1] as Card).colorVO.colorIndex - 1) return false;
				 }
				 else {
					 if (($cardsToCheck[i] as Card).colorVO.colorIndex != ($cardsToCheck[i + 1] as Card).colorVO.colorIndex + 1) return false;
				 }
				
				 //filter the 121,212,232,323,010,101,434 situations
				 if (
					i > 0 &&
					($cardsToCheck[i] as Card).colorVO.colorIndex != 4 &&
					$isStricktCheck
					) 
				 { 
					
					
					 if($cardsToCheck[i].colorVO.colorIndex > $cardsToCheck[i-1].colorVO.colorIndex && $cardsToCheck[i+1].colorVO.colorIndex < $cardsToCheck[i].colorVO.colorIndex) return false;
					 if($cardsToCheck[i].colorVO.colorIndex < $cardsToCheck[i-1].colorVO.colorIndex && $cardsToCheck[i+1].colorVO.colorIndex > $cardsToCheck[i].colorVO.colorIndex) return false;
						
					}
					
				// filter the non complementer pairs around black
				if (
					i > 0 &&
					($cardsToCheck[i] as Card).colorVO.colorIndex == 4 &&
					$isStricktCheck
					) 
				 {  
						//green - magenta
						if ($cardsToCheck[i - 1].colorVO.colorGroup == ColorModel.GREEN && $cardsToCheck[i + 1].colorVO.colorGroup != ColorModel.MAGENTA) return false;
						if ($cardsToCheck[i - 1].colorVO.colorGroup == ColorModel.MAGENTA && $cardsToCheck[i + 1].colorVO.colorGroup != ColorModel.GREEN) return false;
						//yellow - purple
						if ($cardsToCheck[i - 1].colorVO.colorGroup == ColorModel.YELLOW && $cardsToCheck[i + 1].colorVO.colorGroup != ColorModel.PURPLE) return false;
						if ($cardsToCheck[i - 1].colorVO.colorGroup == ColorModel.PURPLE && $cardsToCheck[i + 1].colorVO.colorGroup != ColorModel.YELLOW) return false;
						//blue - orange
						if ($cardsToCheck[i - 1].colorVO.colorGroup == ColorModel.BLUE && $cardsToCheck[i + 1].colorVO.colorGroup != ColorModel.ORANGE) return false;
						if ($cardsToCheck[i - 1].colorVO.colorGroup == ColorModel.ORANGE && $cardsToCheck[i + 1].colorVO.colorGroup != ColorModel.BLUE) return false;
				
				 }
			 }
			 
			 
			 
			 return true;
		 }
		 
		 public function checkIfFirstCardIsWhite($cardsToCheck:Array):Boolean
		 {
			 return (($cardsToCheck[0] as Card).colorVO.colorGroup == "WHITE");
		 }
		 
		 public function isTherePlaceOption():Boolean
		 { 
			 setMoveableBufferCards();
			 trace("\n moveableCardsArray.length",moveableCardsArray.length)

			 for (var i:String in moveableCardsArray) { 
				 //check replace in buffer	 
				 for (var j:String in buffer.collums) {
					 // if there is a free buffer place, for sure there must be some poss
					if (buffer.collums[j] == 0) return true;
					//
					if ((moveableCardsArray[i][0] as Card).bufferColl != j) {
						var topBufferCardArray:Array = new Array((buffer.collums[j] as Array)[(buffer.collums[j] as Array).length -1]);
						// if there is even 1 option there s no need to investigate further
						if (checkfitToColorRules(topBufferCardArray.concat(moveableCardsArray[i]))) {
							trace("buffer case");
							return true;
							}
						}
					}
				//check place to collector
				for (var c:String in collector.collums) {
					var fromCollectorArray:Array;
					if ((collector.collums[c] as Array).length == 0) {
						if ((moveableCardsArray[i][0] as Card).colorVO.colorGroup == "WHITE") return true;
						}
					else {
						if (checkfitToColorRules((collector.collums[c] as Array).concat(moveableCardsArray[i]))) {
							trace("collector case");
							return true;
							}
						}
					}	
				 }
			
			 
			 
			 return false;
		 }
		 
		 private function setMoveableBufferCards():void
		 {
			moveableCardsArray.splice(0);
			 //trace("\n:::: CHECK MOVEABLE CARDS ::::");
			 for (var i:String in buffer.collums)
			 {
				 for (var row:int = (buffer.collums[i] as Array).length -1; row >= 0; row-- )
				 {
					 var possibleMoveableCards:Array = (buffer.collums[i] as Array).slice([row], (buffer.collums[i] as Array).length);
					 
					 if (!checkfitToColorRules(possibleMoveableCards) ) {
						 row = 0;
						 }
					 else {
						 //trace("moveable Array:: coll:", i, "row", row);
						 moveableCardsArray.push(possibleMoveableCards)
						 };
					
				 }
				 
			 }
		 }
		//////////////////////6
		public function set deck(value:Array):void 
		{
			_deck = value;


		}
		
		
		public function get cards():Array 
		{
			return _cards;
		}
		
		public function set cards(value:Array):void 
		{
			_cards = value;
		}
		
	}

}