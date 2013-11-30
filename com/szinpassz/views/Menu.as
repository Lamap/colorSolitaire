package com.szinpassz.views 
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class Menu extends Sprite 
	{
		public var newGameButton:SimpleButton;
		public var gameRuleButton:SimpleButton;
		
		public function Menu() 
		{
			newGameButton = new NewGameButton();
			newGameButton.x = 520;
			newGameButton.y = 505;
			addChild(newGameButton);
			
			gameRuleButton = new GameRulesButton();
			gameRuleButton.x = 643;
			gameRuleButton.y = 505
			addChild(gameRuleButton);
		}
		
	}

}