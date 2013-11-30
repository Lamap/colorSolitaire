package com.szinpassz.views 
{
	import com.szinpassz.models.GameEvent;
	import flash.events.MouseEvent;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class PreSceneMediator extends Mediator 
	{
		[Inject]
		public var preScene:PreScene;
		
		public function PreSceneMediator() 
		{
			
		}
		override public function onRegister():void
		{
			preScene.addEventListener(MouseEvent.CLICK, onClick, false, 0, true);
			trace("preSceneOnreg");
			preScene.useHandCursor = true;
			preScene.buttonMode = true;
		}
		
		private function onClick(e:MouseEvent):void 
		{
			trace("enter dispatch");
			contextView.removeChild(preScene)
			dispatch(new GameEvent(GameEvent.GAME_STARTUP));
			
		}
		
		
	}

}