package com.szinpassz.views 
{
	import com.szinpassz.models.ConfigModel;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class CardPlace extends Sprite 
	{
		
		public function CardPlace() 
		{
			createGFX();
		}
		
		private function createGFX():void 
		{
			graphics.beginFill(ConfigModel.CARDPLACE_COLOR,ConfigModel.CARDPLACE_ALPHA);
			
			var outlineColor:uint;
			graphics.drawRoundRect(0, 0, ConfigModel.CARD_WIDTH, ConfigModel.CARD_HEIGHT,10,10);
			graphics.endFill();	
		}
	}

}