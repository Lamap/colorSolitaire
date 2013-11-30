package com.szinpassz.commands 
{
	import com.szinpassz.models.GameModel;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class DealFromDeckToBufferCommand extends Command 
	{
		[Inject]
		public var gameModel:GameModel;
		
		public function DealFromDeckToBufferCommand() 
		{
			super();
			
		}
		override public function execute():void
		{
			trace("DealFromDeckToBufferCommand execute");
			gameModel.dealToBuffer();
		}
	}

}