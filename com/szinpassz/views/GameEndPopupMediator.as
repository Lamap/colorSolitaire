package com.szinpassz.views 
{
	import com.szinpassz.models.GameEvent;
	import flash.events.MouseEvent;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class GameEndPopupMediator extends Mediator 
	{
		
		[Inject]
		public var popUp:GameEndPopup;
		
		public function GameEndPopupMediator() 
		{
			
		}
		
		override public function onRegister():void
		{
			popUp.newGameButton.addEventListener(MouseEvent.CLICK, handleNewGame, false, 0, true);
		}
		
		private function handleNewGame(e:MouseEvent):void 
		{
			dispatch(new GameEvent(GameEvent.START_NEW_GAME));
			popUp.parent.removeChild(popUp);
		}
		
	}

}