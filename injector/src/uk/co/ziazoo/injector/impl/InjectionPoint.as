package uk.co.ziazoo.injector.impl 
{
	import uk.co.ziazoo.injector.IInjectionPoint;
	
	public class InjectionPoint implements IInjectionPoint
	{
		public function InjectionPoint()
		{
		}
		
		public function getDependencies():Array
		{
			return [];
		}
		
		public function isOptional():Boolean
		{
			return false;
		}
	}
}
