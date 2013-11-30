package com.szinpassz 
{
	import flash.display.Sprite;

	/**
	 * ...
	 * @author Ákos
	 */
	
	public class Main extends Sprite
	{
		var mainContext:MainContext;
		
		
		public function Main() 
		{
			trace("MainView");
			mainContext = new MainContext(this);
			
			
		}
		
	}

}