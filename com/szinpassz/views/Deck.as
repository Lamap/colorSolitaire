package com.szinpassz.views 
{
	import com.szinpassz.MainContext;
	import com.szinpassz.models.ConfigModel;
	import com.szinpassz.models.GameModel;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class Deck extends Sprite 
	{
		private var _deckCount:int;
		
		
		private var oneItem:Sprite;
		private var oneThreeItem:Sprite;
		private var moreThenThreeItem:Sprite;
		
		private var countText:MovieClip;
		
		public var cardPack:Sprite;
		
		private var deckBG:CardPlace;
		
		public function Deck() 
		{
			//deckBG
			deckBG = new CardPlace();
			addChild(deckBG);
			
			//oneItem
			oneItem = new Sprite();
			oneItem.addChild(createItem(0,0));
			
			//oneThreeItem
			oneThreeItem = new Sprite();
			oneThreeItem.addChild(createItem(0,0));
			oneThreeItem.addChild(createItem(5, 5));
			
			//moreThenThreeItem
			moreThenThreeItem = new Sprite();
			moreThenThreeItem.addChild(createItem(0, 0));
			moreThenThreeItem.addChild(createItem(4, 4));
			moreThenThreeItem.addChild(createItem(8, 8));
			moreThenThreeItem.addChild(createItem(12, 12));
			moreThenThreeItem.addChild(createItem(16, 16));
			
			//countText
			countText = new MyTextField();
			countText.x = 10;
			countText.y = ConfigModel.CARD_HEIGHT + 25;
			addChild(countText);
			
		}
		
		private function createItem(x:Number,y:Number):Sprite
		{
			var item:Sprite = new Sprite();
			item.graphics.beginFill(0x515151); 
			item.graphics.lineStyle(1, 0x000000, .1);
			item.graphics.drawRoundRect(x, y, ConfigModel.CARD_WIDTH, ConfigModel.CARD_HEIGHT,10,10);
			item.graphics.endFill();
			
			var downShadow:DropShadowFilter = new DropShadowFilter(6, 45, 0x000000, .5, 6, 6, 1, 1);
			var upShadow:DropShadowFilter = new DropShadowFilter(5, 45, 0xFFFFFF, .1, 12, 12, 1, 1,true);
			filters = new Array(downShadow,upShadow);
			
			return item;
		}
		
		//////////
		public function get deckCount():int 
		{
			return _deckCount;
		}
		
		public function set deckCount(value:int):void 
		{
			_deckCount = value;
			trace("decK",deckCount)
			
			if (cardPack) {
				if(cardPack.stage)removeChild(cardPack);
				}
			countText.txt.text = deckCount;
			
			if (_deckCount == 0) return;
			
			if (_deckCount == 1) {
				cardPack = oneItem;
				}
			else if (_deckCount > 1 && _deckCount < 4) {
				cardPack = oneThreeItem;
				}
			else if (_deckCount >= 4) {
				cardPack = moreThenThreeItem;
				}
			addChild(cardPack);
			countText.txt.text = deckCount;
		}
		
		
		
	}

}