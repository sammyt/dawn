package uk.co.ziazoo.injector.impl
{	
	import uk.co.ziazoo.injector.*;
	
	public class DependencyFactory
	{
		public function DependencyFactory()
		{
		}
		
		public function forMapping( mapping:IMapping, 
			injectionPoint:IInjectionPoint = null ):IDependency
		{
			return new Dependency( mapping, injectionPoint );
		}
	}
}