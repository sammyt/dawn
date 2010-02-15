package uk.co.ziazoo.injector.impl
{	
	import uk.co.ziazoo.injector.*;
	
	public class MockDependency implements IDependency
	{
		private var object:Object;
		
		public function MockDependency( object:Object )
		{
			this.object = object;
		}
		
		public function getMapping():IMapping
		{
			return null;
		}
    
		public function getParent():IInjectionPoint
		{
			return null;
		}
    
		public function getInjectionPoints():Array
		{
			return null
		}
    
		public function getObject():Object
		{
			return object;
		}
	}
}