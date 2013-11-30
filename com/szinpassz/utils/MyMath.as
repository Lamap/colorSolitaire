package com.szinpassz.utils 
{
	/**
	 * ...
	 * @author ...
	 */
	public class MyMath
	{
		
		public function MyMath() 
		{
			
		}
		
		///returns a random integer from an interval
		public static function randNum(st:int,end:int){
			if(st>end){
				var end_temp:int=st
				end=st
				st=end_temp
				}
			var num=new int()
			num=st+Math.round(Math.random()*(end-st))
			return(num)
			}
			
			
		///returns a random integer from 0 to the input parameter
		public static function rand(n:int):int{
			var res:int
			res=Math.round(Math.random()*n)
			
			return res
			}
			
		public static function convertArray2Int(a:Array):Array {
			for(var i in a){a[i] = int(a[i])}
			return a
			}
	}

}