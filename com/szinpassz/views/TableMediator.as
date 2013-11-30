package com.szinpassz.views 
{
	import com.szinpassz.models.ColorModel;
	import com.szinpassz.models.ConfigModel;
	import com.szinpassz.models.GameEvent;
	import com.szinpassz.models.GameModel;
	import com.szinpassz.models.vo.PlaceMentTargetVO;
	import flash.geom.Point;
	import org.robotlegs.mvcs.Mediator;
	/**
	 * ...
	 * @author Ákos
	 */
	public class TableMediator extends Mediator
	{
		[Inject]
		public var table:Table;
		
		[Inject]
		public var colorModel:ColorModel;
		
		[Inject]
		public var gameModel:GameModel;
		
		public function TableMediator() 
		{
			
		}
		override public function onRegister():void
		{
			trace("tableMediator registered", table, colorModel);
			addContextListener(GameEvent.PLACE_CARDS_ON_BUFFER, updateCardsOnBuffer);
			addContextListener(GameEvent.CARDS_DROPPED_WRONG, updateCardsOnBuffer);
			addContextListener(GameEvent.CARDS_DROPPED_DOWN, getPlacementTarget);
			
			addContextListener(GameEvent.COLLECTOR_CHANGED, updateCardsOnCollector);
			addContextListener(GameEvent.BUFFER_CHANGED, updateCardsOnBuffer);
			
			addContextListener(GameEvent.NEEDS_DEAL_FROM_DECK, table.showNewDealWarn);

			addContextListener(GameEvent.CLEAN_TABLE, cleanBufferAndCollector);
		}
		
		
		

		
		private function getPlacementTarget(e:GameEvent):PlaceMentTargetVO 
		{
			var movingCard:Card = (e.paramObject as Card);
			var xDrop:Number = movingCard.x;
			var yDrop:Number = movingCard.y;
			
			var targetHolder:String = "NONE";
			var targetCollumnIndex:int = -1;
			
			// case of Buffer	
			if (yDrop > ConfigModel.BUFFER_INSERTION_POINT.y - ConfigModel.PLACEMENT_Y_OFFSET) {
					targetHolder = "BUFFER";
					for (var i:String in gameModel.buffer.collums)
					{
						var bufferCollumnEndPositionX:Number;
						var bufferCollumnEndPositionY:Number;
						var row:int = (gameModel.buffer.collums[i] as Array).length - 1;
						
						bufferCollumnEndPositionX = ConfigModel.BUFFER_INSERTION_POINT.x + i * (ConfigModel.CARD_WIDTH + ConfigModel.BUFFER_PLACING_GAP);
						bufferCollumnEndPositionY = ConfigModel.BUFFER_INSERTION_POINT.y + row * ConfigModel.BUFFER_VERTICAL_PLACE_GAP;
						
						if (Math.abs(bufferCollumnEndPositionX - xDrop) < ConfigModel.PLACEMENT_X_OFFSET &&
							Math.abs(bufferCollumnEndPositionY - yDrop) < ConfigModel.PLACEMENT_Y_OFFSET
							)
							targetCollumnIndex = i;
					}
					if(movingCard.bufferColl == targetCollumnIndex) targetCollumnIndex = -1;
				}
			// case of collector	
			else {
				targetHolder = "COLLECTOR";
				
				for (var j:String in gameModel.collector.collums)
					{
						var collectorCollumnEndPositionX:Number;
						var collectorCollumnEndPositionY:Number;
						var collectorRow:int = collectorRow = (gameModel.collector.collums[j] as Array).length - 1;
						if (collectorRow == -1) collectorRow = 0;
						
						collectorCollumnEndPositionX = ConfigModel.COLLECTOR_INSERTION_POINT.x + j * (ConfigModel.CARD_WIDTH + ConfigModel.COLLECTOR_PLACING_GAP);
						collectorCollumnEndPositionY = ConfigModel.COLLECTOR_INSERTION_POINT.y + collectorRow * ConfigModel.COLLECTOR_VERTICAL_PLACE_GAP;
					
						if (Math.abs(collectorCollumnEndPositionX - xDrop) < ConfigModel.PLACEMENT_X_OFFSET &&
							Math.abs(collectorCollumnEndPositionY - yDrop) < ConfigModel.PLACEMENT_Y_OFFSET
							)
							targetCollumnIndex = j;
					}
				}
	
			if (targetCollumnIndex != -1) {
				
				var placementVO:PlaceMentTargetVO = new PlaceMentTargetVO();
				placementVO.targetHolder = targetHolder;
				placementVO.targetIndex = targetCollumnIndex;
				gameModel.placementVO = placementVO;
				//trace("\n","targetHolder",targetHolder," targetCollumnIndex",targetCollumnIndex);
				
				if (targetHolder == "BUFFER") {
					//concate the investigate array with the top card of the buffer and the moveing card array
			
					var topCardArray:Array;
					if ((gameModel.buffer.collums[targetCollumnIndex] as Array).length == 0)
						topCardArray = new Array();
					else
						topCardArray = new Array((gameModel.buffer.collums[targetCollumnIndex] as Array)[(gameModel.buffer.collums[targetCollumnIndex] as Array).length -1]);
					
					var concatedCardCollumn:Array = topCardArray.concat(gameModel.moveingCards);

					for (var k:String in concatedCardCollumn) trace((concatedCardCollumn[k] as Card).colorVO.colorGroup);
					
					if (gameModel.checkfitToColorRules(concatedCardCollumn,false)) {
						dispatch(new GameEvent(GameEvent.CARDS_REPLACED_IN_BUFFER));
						}
					else 
						dispatch(new GameEvent(GameEvent.CARDS_DROPPED_WRONG));		
				}
				else if(targetHolder == "COLLECTOR"){
					trace("C", targetCollumnIndex,(gameModel.collector.collums[targetCollumnIndex] as Array).length);
					
					//if collector is empty --> only white
					if ((gameModel.collector.collums[targetCollumnIndex] as Array).length == 0)
					{
						if (gameModel.checkIfFirstCardIsWhite(gameModel.moveingCards)) dispatch(new GameEvent(GameEvent.CARDS_PLACED_ON_COLLECTOR));
						else dispatch(new GameEvent(GameEvent.CARDS_DROPPED_WRONG));
						}
					// if not empty check usual rules
					else {
						//var topCollectorCardArray:Array = new Array((gameModel.collector.collums[targetCollumnIndex] as Array)[(gameModel.collector.collums[targetCollumnIndex] as Array).length -1]);
						var topCollectorCardArray:Array = gameModel.collector.collums[targetCollumnIndex];
						var concatedCollectorCollumn:Array = topCollectorCardArray.concat(gameModel.moveingCards);
						
						if(gameModel.checkfitToColorRules(concatedCollectorCollumn))dispatch(new GameEvent(GameEvent.CARDS_PLACED_ON_COLLECTOR));
						else dispatch(new GameEvent(GameEvent.CARDS_DROPPED_WRONG));
						}
					}
					
				}
			else {
				dispatch(new GameEvent(GameEvent.CARDS_DROPPED_WRONG));
				}
			
			return placementVO;
		}
		
		private function updateCardsOnBuffer(e:GameEvent):void 
		{
			table.drawBuffer(gameModel.buffer);
			dispatch(new GameEvent(GameEvent.TABLE_CHANGE_FINISHED));
		}
		
		private function updateCardsOnCollector(e:GameEvent):void 
		{
			table.drawCollector(gameModel.collector);
		}
		
		private function cleanBufferAndCollector(e:GameEvent):void
		{
			table.cleanBuffer();
			table.cleanCollector();
		}
	}

}