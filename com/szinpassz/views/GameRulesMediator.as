package com.szinpassz.views 
{
	import flash.events.MouseEvent;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class GameRulesMediator extends Mediator 
	{
		
		[Inject]
		public var rules:GameRules;
		
		public function GameRulesMediator() 
		{
			super();
			
		}
		
		override public function onRegister():void
		{
			trace("gameRulesMed Registered");
			rules.addEventListener(MouseEvent.CLICK, onBack, false, 0, true);
		}
		
		private function onBack(e:MouseEvent):void 
		{
			rules.parent.removeChild(rules);
		}
		
	}

}