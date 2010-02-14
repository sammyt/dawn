package uk.co.ziazoo.injector.impl
{
	import uk.co.ziazoo.injector.*;
		
	public class PropertyInjectionPoint implements IInjectionPoint
	{
		private var dependencies:Array;
		
		public function PropertyInjectionPoint( property:Property )
		{
		}
		
		public function getDependencies():Array
		{
			return dependencies;
		}
		
		public function isOptional():Boolean
		{
			return false;
		}
		
		public function setDependency( dependency:IDependency ):void
		{
			dependencies = [ dependency ];
		}
	}
}