package uk.co.ziazoo.injector.impl 
{
	import uk.co.ziazoo.injector.*;
	
	public class MethodInjectionPoint implements IInjectionPoint
	{
		private var method:Method;
		private var dependencies:Array;
		
		public function MethodInjectionPoint( method:Method )
		{
			this.method = method;
			dependencies = [];
		}
		
		public function getDependencies():Array
		{
			return dependencies;
		}

		public function isOptional():Boolean
		{
			return false;
		}
		
		internal function addDependency( dependency:IDependency ):void
		{
			dependencies.push( dependency );
		}
	}
}