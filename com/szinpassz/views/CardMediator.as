package com.szinpassz.views 
{
	import com.szinpassz.models.GameEvent;
	import com.szinpassz.models.GameModel;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class CardMediator extends Mediator 
	{
		
		[Inject]
		public var card:Card;
		
		[Inject]
		public var gameModel:GameModel;
		
		//
		private var positionBeforeMoveing:Point;
		private var cardIsPickedUp:Boolean = false;
		
		public function CardMediator() 
		{
			
		}
		
		override public function onRegister():void
		{
			addViewListener(MouseEvent.MOUSE_DOWN, mouseDown);
			addViewListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		
		private function mouseUp(e:MouseEvent):void 
		{
			card.stopDrag();
			contextView.removeEventListener(MouseEvent.MOUSE_MOVE, moveCards);   
			
			if (!positionBeforeMoveing) return;
			//trace("Card mouseUp",positionBeforeMoveing,card.x,card.y);
			/*if(positionBeforeMoveing.x != card.x && positionBeforeMoveing.y != card.y )
			{
				dispatch(new GameEvent(GameEvent.CARDS_DROPPED_DOWN, card));
				cardIsPickedUp = false;
			}*/
			dispatch(new GameEvent(GameEvent.CARDS_DROPPED_DOWN, card));
			cardIsPickedUp = false;
		}
		
		private function mouseDown(e:MouseEvent):void 
		{
			if (card.collectorRow != -1) return;
			
			positionBeforeMoveing = new Point(card.x, card.y);
			
			if(gameModel.setMoveableCards(card))
			{
				cardIsPickedUp = true;
				card.startDrag();
				contextView.addEventListener(MouseEvent.MOUSE_MOVE, moveCards, false, 0, true);
			}
		}
		
		private function moveCards(e:MouseEvent):void 
		{
			for (var i:String in gameModel.moveingCards)
			{
				gameModel.moveingCards[i].x = gameModel.moveingCards[0].x + gameModel.moveingCards[i].positionFromDragger.x;
				gameModel.moveingCards[i].y = gameModel.moveingCards[0].y + gameModel.moveingCards[i].positionFromDragger.y;
			}
			e.updateAfterEvent();
		}
	}

}