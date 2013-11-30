package com.szinpassz.models 
{
	import com.szinpassz.models.vo.ColorVO;
	import com.szinpassz.utils.MyMath;
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ...
	 * @author Ákos
	 */
	public class ColorModel extends Actor 
	{

		private var colorTypes:Array; 
		private var _colors:Array;
		
		public static const BLUE = "blue";
		public static const GREEN = "green";
		public static const MAGENTA = "magenta";
		public static const YELLOW = "yellow";
		public static const ORANGE = "orange";
		public static const PURPLE = "purple";
		public static const BLACK = "BLACK";
		public static const WHITE = "WHITE";


		
		
		public function ColorModel() 
		{
			
			colorTypes = new Array("blue", "green", "magenta", "yellow","orange","purple", "WHITE", "BLACK");
			
			colors = new Array();
			
			resetColors();
		}
		
		
		public function resetColors():void
		{
			colors.splice(0);
			
			//blue
			colors.push(new ColorVO(colorTypes[0], 1, 0x82AADA));
			colors.push(new ColorVO(colorTypes[0], 2, 0x0077BE));
			colors.push(new ColorVO(colorTypes[0], 3, 0x044C77));
			
			colors.push(new ColorVO(colorTypes[0], 1, 0x82AADA));
			colors.push(new ColorVO(colorTypes[0], 2, 0x0077BE));
			colors.push(new ColorVO(colorTypes[0], 3, 0x044C77));
			
			//green
			colors.push(new ColorVO(colorTypes[1], 1, 0x86CB9F));
			colors.push(new ColorVO(colorTypes[1], 2, 0x00A85A));
			colors.push(new ColorVO(colorTypes[1], 3, 0x006C3E));
			
			colors.push(new ColorVO(colorTypes[1], 1, 0x86CB9F));
			colors.push(new ColorVO(colorTypes[1], 2, 0x00A85A));
			colors.push(new ColorVO(colorTypes[1], 3, 0x006C3E));

			//magenta
			colors.push(new ColorVO(colorTypes[2], 1, 0xF69B99));
			colors.push(new ColorVO(colorTypes[2], 2, 0xD82E53));
			colors.push(new ColorVO(colorTypes[2], 3, 0x6A2439));
			
			colors.push(new ColorVO(colorTypes[2], 1, 0xF69B99));
			colors.push(new ColorVO(colorTypes[2], 2, 0xD82E53));
			colors.push(new ColorVO(colorTypes[2], 3, 0x6A2439));
			
			//yellow
			colors.push(new ColorVO(colorTypes[3], 1, 0xFFEC99));
			colors.push(new ColorVO(colorTypes[3], 2, 0xFFE91D));
			colors.push(new ColorVO(colorTypes[3], 3, 0x878024));
			
			colors.push(new ColorVO(colorTypes[3], 1, 0xFFEC99));
			colors.push(new ColorVO(colorTypes[3], 2, 0xFFE91D));
			colors.push(new ColorVO(colorTypes[3], 3, 0x878024));
			
			//orange
			colors.push(new ColorVO(colorTypes[4], 1, 0xFAB587));
			colors.push(new ColorVO(colorTypes[4], 2, 0xF37536));
			colors.push(new ColorVO(colorTypes[4], 3, 0x804327));
			
			colors.push(new ColorVO(colorTypes[4], 1, 0xFAB587));
			colors.push(new ColorVO(colorTypes[4], 2, 0xF37536));
			colors.push(new ColorVO(colorTypes[4], 3, 0x804327));
			
			//purple
			colors.push(new ColorVO(colorTypes[5], 1, 0xA18EC3));
			colors.push(new ColorVO(colorTypes[5], 2, 0x6F59A4));
			colors.push(new ColorVO(colorTypes[5], 3, 0x493A68));
			
			colors.push(new ColorVO(colorTypes[5], 1, 0xA18EC3));
			colors.push(new ColorVO(colorTypes[5], 2, 0x6F59A4));
			colors.push(new ColorVO(colorTypes[5], 3, 0x493A68));
			
			//BLACK
			colors.push(new ColorVO(colorTypes[7], 4, 0x000000));
			colors.push(new ColorVO(colorTypes[7], 4, 0x000000));
			colors.push(new ColorVO(colorTypes[7], 4, 0x000000));
			colors.push(new ColorVO(colorTypes[7], 4, 0x000000));
			colors.push(new ColorVO(colorTypes[7], 4, 0x000000));
			colors.push(new ColorVO(colorTypes[7], 4, 0x000000));
			
			//WHITE
			colors.push(new ColorVO(colorTypes[6], 0, 0xFFFFFF));
			colors.push(new ColorVO(colorTypes[6], 0, 0xFFFFFF));
			colors.push(new ColorVO(colorTypes[6], 0, 0xFFFFFF));
			colors.push(new ColorVO(colorTypes[6], 0, 0xFFFFFF));
			colors.push(new ColorVO(colorTypes[6], 0, 0xFFFFFF));
			colors.push(new ColorVO(colorTypes[6], 0, 0xFFFFFF));
		}
		public function shuffleSimple():void
		{
			
				for (var i:String in colors) {
					(colors[i] as ColorVO).sortIndex = Math.floor(Math.random() * 10000);
					
				}
				colors.sortOn("sortIndex");
		}
		
		public function shuffleWhiteRestriction():void
		{
			var theWhites:Array = colors.splice(colors.length - 4, 4);
			for (var j:String in colors)
				{
					(colors[j] as ColorVO).sortIndex = Math.floor(Math.random() * 10000);
				}
				
			colors.sortOn("sortIndex");
				
			var insertPoint1:int = GameModel.WHITE_CARDS_POSITIONS[0] * GameModel.BUFFER_SIZE + MyMath.rand(GameModel.BUFFER_SIZE - 1);
			var insertPoint2:int = GameModel.WHITE_CARDS_POSITIONS[1] * GameModel.BUFFER_SIZE + MyMath.rand(GameModel.BUFFER_SIZE - 1);
			var insertPoint3:int = GameModel.WHITE_CARDS_POSITIONS[2] * GameModel.BUFFER_SIZE + MyMath.rand(GameModel.BUFFER_SIZE - 1);
			var insertPoint4:int = GameModel.WHITE_CARDS_POSITIONS[3] * GameModel.BUFFER_SIZE + MyMath.rand(GameModel.BUFFER_SIZE - 1);
					
			colors.splice(insertPoint1, 0, theWhites[0]);
			colors.splice(insertPoint2, 0, theWhites[1]);
			colors.splice(insertPoint3, 0, theWhites[2]);
			colors.splice(insertPoint4, 0, theWhites[3]);
				
			for(var k:String in colors)trace(k,(colors[k] as ColorVO).colorGroup)	
		}
		
		public function get colors():Array 
		{
			return _colors;
		}
		
		public function set colors(value:Array):void 
		{
			_colors = value;
		}
	
	}

}