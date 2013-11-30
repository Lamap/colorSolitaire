package com.szinpassz.views 
{
	import com.szinpassz.models.GameEvent;
	import flash.events.MouseEvent;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class MenuMediator extends Mediator 
	{
		[Inject]
		public var menu:Menu;
		
		private var gameRule:GameRules;
		
		public function MenuMediator() 
		{
			
		}
		override public function onRegister():void
		{
			trace("menuRegistered")
			menu.newGameButton.addEventListener(MouseEvent.CLICK, handleNewGameClick, false, 0, true);
			menu.gameRuleButton.addEventListener(MouseEvent.CLICK, openGameRule, false, 0, true);
			
			gameRule = new GameRules();
		}
		
		private function openGameRule(e:MouseEvent):void 
		{
			contextView.addChild(gameRule);
		}
		
		private function handleNewGameClick(e:MouseEvent):void 
		{
			dispatch(new GameEvent(GameEvent.START_NEW_GAME));
		}
	}

}