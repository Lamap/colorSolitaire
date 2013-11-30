package com.szinpassz.commands 
{
	import com.szinpassz.models.GameModel;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class ReplaceCardInBuffer extends Command 
	{
		[Inject]
		public var gameModel:GameModel;
		
		public function ReplaceCardInBuffer() 
		{
			super();
		}
		
		override public function execute():void
		{
			trace("ReplaceCardInBuffer execute");
			gameModel.replaceCardsOnBuffer();
		}
	}

}