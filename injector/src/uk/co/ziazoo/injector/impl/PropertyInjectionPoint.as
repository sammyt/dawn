package uk.co.ziazoo.injector.impl
{
	import uk.co.ziazoo.injector.*;
		
	public class PropertyInjectionPoint implements IInjectionPoint
	{
		public function PropertyInjectionPoint( property:Property )
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