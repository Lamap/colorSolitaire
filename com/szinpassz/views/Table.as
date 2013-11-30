package com.szinpassz.views 
{
	import com.szinpassz.models.ConfigModel;
	import com.szinpassz.models.GameEvent;
	import com.szinpassz.models.GameModel;
	import com.szinpassz.models.vo.BufferVO;
	import com.szinpassz.models.vo.CollectorVO;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class Table extends Sprite 
	{
		

		
		private var bufferHolder:Sprite;
		private var collectorHolder:Sprite;
		
		private var dealWarnArrow:MovieClip;
		
		public function Table() 
		{
			drawCollectorPlaces();
			drawBufferPlaces();
			
			collectorHolder = new Sprite();
			addChild(collectorHolder);
			
			bufferHolder = new Sprite();
			addChild(bufferHolder);
			
			dealWarnArrow = new DealWarnArrow();
			dealWarnArrow.x = ConfigModel.DECK_INSERTSTIO_POINT.x + ConfigModel.CARD_WIDTH + 15;
			dealWarnArrow.y = ConfigModel.DECK_INSERTSTIO_POINT.y - 15;
			addChild(dealWarnArrow);
		}
		
		public function placeDealOnBuffer(bufferData:BufferVO):void
		{
			for (var i:String in bufferData.collums)
			{
				trace((bufferData.collums[i] as Array)[(bufferData.collums[i] as Array).length - 1]);
			}
		}
		
		public function drawBuffer(bufferData:BufferVO):void
		{
			cleanBuffer();
			
			for (var coll:String in bufferData.collums)
			{
				for (var row:String in (bufferData.collums[coll] as Array)) {
					
					
					//trace("oszlop", coll, "sor", row, bufferData.collums[coll][row]);
					
					(bufferData.collums[coll][row] as Card).x = ConfigModel.BUFFER_INSERTION_POINT.x + coll * (ConfigModel.CARD_WIDTH + ConfigModel.BUFFER_PLACING_GAP);
					(bufferData.collums[coll][row] as Card).y = ConfigModel.BUFFER_INSERTION_POINT.y + row * ConfigModel.BUFFER_VERTICAL_PLACE_GAP;
					
					(bufferData.collums[coll][row] as Card).bufferColl = coll;
					(bufferData.collums[coll][row] as Card).bufferRow = row;
					
					bufferHolder.addChild(bufferData.collums[coll][row] );
					}
				
				
			}
			removeDealWarn();
		}
		public function cleanBuffer():void
		{
			for (var i:int = bufferHolder.numChildren - 1; i >= 0; i--)
			{
				bufferHolder.removeChild(bufferHolder.getChildAt(i));
			}
		}
		
		
		public function drawCollector(collectorData:CollectorVO):void
		{
			cleanCollector();
			
			for (var coll:String in collectorData.collums) {
				for (var row:String in (collectorData.collums[coll] as Array)) {
					(collectorData.collums[coll][row] as Card).x = ConfigModel.COLLECTOR_INSERTION_POINT.x + coll * (ConfigModel.CARD_WIDTH + ConfigModel.COLLECTOR_PLACING_GAP);
					(collectorData.collums[coll][row] as Card).y = ConfigModel.COLLECTOR_INSERTION_POINT.y + row * ConfigModel.COLLECTOR_VERTICAL_PLACE_GAP;
					
					(collectorData.collums[coll][row] as Card).collectorColl = coll;
					(collectorData.collums[coll][row] as Card).collectorRow = row;
					
					collectorHolder.addChild(collectorData.collums[coll][row]);
					}
				}
			
			
		}
		
		public function cleanCollector():void
		{
			for (var i:int = collectorHolder.numChildren - 1; i >= 0; i--)
			{
				collectorHolder.removeChild(collectorHolder.getChildAt(i));
			}
		}
		
		private function drawCollectorPlaces():void
		{
			for (var i:int = 0; i < 6; i++)
			{
				var cardPlace:CardPlace = new CardPlace();
				
				cardPlace.x = ConfigModel.COLLECTOR_INSERTION_POINT.x + i * (ConfigModel.CARD_WIDTH + ConfigModel.COLLECTOR_PLACING_GAP);
				cardPlace.y = ConfigModel.COLLECTOR_INSERTION_POINT.y;
				
				addChild(cardPlace);
			}
		}
		
		private function drawBufferPlaces():void
		{
			for (var i:int = 0; i < GameModel.BUFFER_SIZE; i++)
			{
				var cardPlace:CardPlace = new CardPlace();
				
				cardPlace.x = ConfigModel.BUFFER_INSERTION_POINT.x + i * (ConfigModel.CARD_WIDTH + ConfigModel.BUFFER_PLACING_GAP);
				cardPlace.y = ConfigModel.BUFFER_INSERTION_POINT.y;
				
				addChild(cardPlace);
			}
		}
		
		public function showNewDealWarn(e:GameEvent):void
		{
			addChild(dealWarnArrow);
		}
		public function removeDealWarn():void
		{
			if (dealWarnArrow.stage) removeChild(dealWarnArrow);
		}
	}

}