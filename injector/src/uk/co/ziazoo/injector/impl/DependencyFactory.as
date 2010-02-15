package uk.co.ziazoo.injector.impl
{	
	import uk.co.ziazoo.injector.*;
	
	public class DependencyFactory
	{
		private var reflector:Reflector;
		
		public function DependencyFactory( reflector:Reflector )
		{
			this.reflector = reflector;
		}
		
		public function forMapping( mapping:IMapping, 
			injectionPoint:IInjectionPoint = null ):IDependency
		{
			return new Dependency( mapping, 
				reflector.getReflection( mapping.type ), injectionPoint );
		}
	}
}